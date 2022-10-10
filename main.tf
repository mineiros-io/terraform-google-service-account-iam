resource "google_service_account_iam_binding" "binding" {
  count = var.module_enabled && var.policy_bindings == null && var.authoritative ? 1 : 0

  service_account_id = var.service_account_id
  role               = var.role
  members            = [for m in var.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]

  depends_on = [var.module_depends_on]
}

resource "google_service_account_iam_member" "member" {
  for_each = var.module_enabled && var.policy_bindings == null && var.authoritative == false ? var.members : []

  service_account_id = var.service_account_id
  role               = var.role
  member             = try(var.computed_members_map[regex("^computed:(.*)", each.value)[0]], each.value)

  depends_on = [var.module_depends_on]
}

resource "google_service_account_iam_policy" "policy" {
  count = var.module_enabled && var.policy_bindings != null ? 1 : 0

  service_account_id = var.service_account_id
  policy_data        = try(data.google_iam_policy.policy[0].policy_data, null)

  depends_on = [var.module_depends_on]
}

data "google_iam_policy" "policy" {
  count = var.module_enabled && var.policy_bindings != null ? 1 : 0

  dynamic "binding" {
    for_each = var.policy_bindings

    content {
      role    = binding.value.role
      members = [for m in binding.value.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]

      dynamic "condition" {
        for_each = try([binding.value.condition], [])

        content {
          expression  = condition.value.expression
          title       = condition.value.title
          description = try(condition.value.description, null)
        }
      }
    }
  }
}

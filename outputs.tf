locals {
  binding = one(google_service_account_iam_binding.binding)
  member  = google_service_account_iam_member.member
  policy  = one(google_service_account_iam_policy.policy)

  iam_output = [local.binding, local.member, local.policy]

  iam_output_index = var.policy_bindings != null ? 2 : var.authoritative ? 0 : 1
}

output "iam" {
  description = "All attributes of the created 'iam_binding' or 'iam_member' or 'iam_policy' resource according to the mode."
  value       = local.iam_output[local.iam_output_index]
}

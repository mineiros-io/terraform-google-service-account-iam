module "test" {
  source = "../.."

  # add all required arguments

  service_account_id = "unit-minimal-${local.random_suffix}"

  role = "roles/viewer"

  # add all optional arguments that create additional/extended resources

  members = ["user:member@example.com"]

  # add most/all other optional arguments
}

module "test2" {
  source = "../.."

  # add all required arguments

  service_account_id = "unit-minimal-${local.random_suffix}"

  role = "roles/viewer"

  # add all optional arguments that create additional/extended resources

  authoritative = false
  members       = ["user:member@example.com"]

  # add most/all other optional arguments
}

module "test3" {
  source = "../.."

  # add all required arguments

  service_account_id = "unit-minimal-${local.random_suffix}"

  policy_bindings = [
    {
      role    = "roles/viewer"
      members = ["user:member@example.com"]
    }
  ]
  # add all optional arguments that create additional/extended resources

  # add most/all other optional arguments
}

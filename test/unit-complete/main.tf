module "test-sa" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.10"

  account_id = "service-account-id-${local.random_suffix}"
}

module "test" {
  source = "../.."

  # add all required arguments

  service_account_id = module.test-sa.service_account.id

  role = "roles/viewer"

  # add all optional arguments that create additional/extended resources

  members = [
    "user:member@example.com",
    "computed:myserviceaccount",
    "principal:example",
  ]
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }

  # add most/all other optional arguments
}

module "test2" {
  source = "../.."

  # add all required arguments

  service_account_id = module.test-sa.service_account.id

  role = "roles/viewer"

  # add all optional arguments that create additional/extended resources

  authoritative = false
  members = [
    "user:member@example.com",
    "computed:myserviceaccount",
  ]
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }

  # add most/all other optional arguments
}

module "test3" {
  source = "../.."

  # add all required arguments

  service_account_id = module.test-sa.service_account.id

  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "user:member@example.com",
        "computed:myserviceaccount",
      ]
    },
    {
      role = "roles/browser"
      members = [
        "user:member@example.com",
      ]
    }
  ]

  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
  # add all optional arguments that create additional/extended resources

  # add most/all other optional arguments
}

module "test4" {
  source = "../.."

  # add all required arguments

  service_account_id = module.test-sa.service_account.id

  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "user:member@example.com",
        "computed:myserviceaccount",
      ]
    },
  ]

  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.precomputed_email}"
  }
  # add all optional arguments that create additional/extended resources

  # add most/all other optional arguments
}

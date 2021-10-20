[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>][homepage]

[![Terraform Version][badge-terraform]][releases-terraform]
[![Google Provider Version][badge-tf-gcp]][releases-google-provider]
[![Join Slack][badge-slack]][slack]

# terraform-google-service-account-iam

A [Terraform] module for [Google Cloud Platform (GCP)][gcp].

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 3._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.

- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Module Configuration](#module-configuration)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Extended Resource Configuration](#extended-resource-configuration)
- [Module Attributes Reference](#module-attributes-reference)
- [External Documentation](#external-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following terraform resources:

- `google_service_account_iam_binding`
- `google_service_account_iam_member`
- `google_service_account_iam_policy`

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-service-account-iam" {
  source = "github.com/mineiros-io/terraform-google-service-account-iam?ref=v0.1.0"

  service_account_id = "my-service-account-id"
  role               = "roles/iam.serviceAccountUser"
  members            = ["user:member@example.com"]
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Top-level Arguments

#### Module Configuration

- **`module_enabled`**: _(Optional `bool`)_

  Specifies whether resources in the module will be created.

  Default is `true`.

- **`module_depends_on`**: _(Optional `list(dependencies)`)_

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

#### Main Resource Configuration

- **`service_account_id`**: **_(Required `string`)_**

  The fully-qualified name of the service account to apply policy to.

- **`members`**: _(Optional `string`)_

  Identities that will be granted the privilege in role. Each entry can have one of the following values:
  - `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account.
  - `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account.
  - `user:{emailid}`: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
  - `serviceAccount:{emailid}`: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
  - `group:{emailid}`: An email address that represents a Google group. For example, admins@example.com.
  - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.

  Default is `[]`.

- **`role`**: _(Optional `string`)_

  The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`.

- **`project`**: _(Optional `string`)_

  The resource name of the project the policy is attached to. Its format is `projects/{project_id}`.

- **`authoritative`**: _(Optional `bool`)_

  Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.

  Default is `true`.

- **`policy_bindings`**: _(Optional `list(policy_bindings)`)_

  A list of IAM policy bindings.

  Example

  ```hcl
  policy_bindings = [{
    role    = "roles/viewer"
    members = ["user:member@example.com"]
  }]
  ```

  Each `policy_bindings` object accepts the following fields:

  - **`role`**: **_(Required `string`)_**

    The role that should be applied.

  - **`members`**: **_(Required `string`)_**

    Identities that will be granted the privilege in `role`.

    Default is `var.members`.

  - **`condition`**: _(Optional `object(condition)`)_

    An IAM Condition for a given binding.

    Example

    ```hcl
    condition = {
      expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
      title      = "expires_after_2021_12_31"
    }
    ```

    A `condition` object accepts the following fields:

    - **`expression`**: **_(Required `string`)_**

      Textual representation of an expression in Common Expression Language syntax.

    - **`title`**: **_(Required `string`)_**

      A title for the expression, i.e. a short string describing its purpose.

    - **`description`**: _(Optional `string`)_

      An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.

#### Extended Resource Configuration

## Module Attributes Reference

The following attributes are exported in the outputs of the module:

- **`module_enabled`**

  Whether this module is enabled.

- **`iam`**

  All attributes of the created `iam_binding` or `iam_member` or `iam_policy` resource according to the mode.

## External Documentation

### Google Documentation
<!-- markdown-link-check-disable -->

  - https://cloud.google.com/iam/docs/service-accounts

### Terraform Google Provider Documentation:

  - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
<!-- markdown-link-check-disable -->

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2021 [Mineiros GmbH][homepage]

<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-service-account-iam
[hello@mineiros.io]: mailto:hello@mineiros.io

<!-- markdown-link-check-disable -->

[badge-build]: https://github.com/mineiros-io/terraform-google-service-account-iam/workflows/Tests/badge.svg

<!-- markdown-link-check-enable -->

[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-service-account-iam.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack

<!-- markdown-link-check-disable -->

[build-status]: https://github.com/mineiros-io/terraform-google-service-account-iam/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-service-account-iam/releases

<!-- markdown-link-check-enable -->

[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/

<!-- markdown-link-check-disable -->

[variables.tf]: https://github.com/mineiros-io/terraform-google-service-account-iam/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-service-account-iam/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-service-account-iam/issues
[license]: https://github.com/mineiros-io/terraform-google-service-account-iam/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-service-account-iam/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-service-account-iam/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-service-account-iam/blob/main/CONTRIBUTING.md

<!-- markdown-link-check-enable -->

<!--
######################################################################################################
# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# This AWS Content is provided subject to the terms of the AWS Customer Agreement available at
# http://aws.amazon.com/agreement or other written agreement between Customer and either
# Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.
#######################################################################################################
-->

# Change Logs
## v4.1.8

### Non-breaking changes

- Updated EC2 instance module to fix drift caused in volume_tags

## v4.1.7

### Non-breaking changes

- Updated README and precommit

## v4.1.6

### Non-breaking changes

- Updated README
- Added a new submodule called volume-attachment with examples and tests

## v4.1.5

### Non-breaking changes

- Updated README
- Updated examples to include remote source

## v4.1.4

### Non-breaking changes

- Changed back the required Terraform core version to v1.6.0

## v4.1.3

### Non-breaking changes

- Temporarily changed the required Terraform core version down to v1.0.0

## v4.1.2

### Non-breaking changes

- Added tests
- Refactor file paths
- Removed values for tags
- Removed locals

## v4.1.1

### Non-breaking changes

- Added CHANGELOG.md

## v4.1.0

### Breaking changes

- None

### Non-breaking changes

1. Instance

   - Added config files for terraform-docs
   - Added example for single EC2 instance
   - Added example for multiple EC2 instances
   - Formatted and cleaned up .tf files
   - Added versions.tf file
   - Added README.md

2. Key-pair

   - Added config files for terraform-docs
   - Added examples
   - Formatted and cleaned up .tf files
   - Added README.md

3. Security group

   - Added config files for terraform-docs
   - Added examples
   - Formatted and cleaned up .tf files
   - Added README.md

## v4.0.0

### Breaking changes

- None

### Non-breaking changes

- Initial version of the module, source code copied from `PETRONAS_AWS_IAC_LandingZone` ADO project

# Development Roadmap

- None

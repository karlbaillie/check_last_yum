#!/usr/bin/env bats

@test "invoking the check on a machine without yum prints an error" {
  run ./check_last_yum
  [ "$status" -eq 3 ]
  [ "$output" = "UNKNOWN - YUM Command Not Defined" ]
}

#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/common.sh

Describe 'get_lines_between'
  It 'returns start and end of group when no lines in between'
    data() {
      cat <<EOL
group_starts
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
group_ends
EOL
)"
  End
  
  It 'returns start and end of group and lines in between'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
EOL
)"
  End

 It 'group start/end with regex'
    data() {
      cat <<EOL
group_starts
group_ends
EOL
    }
    Data data

    When call get_lines_between "^[a-z]+_starts$" "^[a-z+]+_ends$"
    The output should equal "$(cat <<EOL
group_starts
group_ends
EOL
)"
  End

  It 'opened/not closed group in between'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

  It 'opened/not closed group at start'
    data() {
      cat <<EOL
group_starts
line1
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

  It 'opened/not closed group at end'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
group_starts
line1
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

  It 'not opened/closed group at in between'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

  It 'not opened/closed group at start'
    data() {
      cat <<EOL
line1
line2
group_ends
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

  It 'not opened/closed group at end'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends"
    The output should equal "$(cat <<EOL
group_starts
line1
line2
group_ends
group_starts
line1
line2
group_ends
EOL
)"
  End

 It 'wrong start right end returns nothing'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts2" "group_ends"
    The output should equal ""
  End

 It 'right start wrong end returns nothing'
    data() {
      cat <<EOL
group_starts
line1
line2
group_ends
EOL
    }
    Data data

    When call get_lines_between "group_starts" "group_ends2"
    The output should equal ""
  End
End

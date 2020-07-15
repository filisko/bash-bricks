#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/common.sh

Describe 'bb_mysql_csv'
  It 'adds double commas and commas to separate the values'
    data() {
      cat <<EOL
line1
line2
line3
line4
line5
line1
line2
EOL
    }
    Data data

    When call get_lines_between "line1" "line5"
    The output should equal "$(cat <<EOL
line1
line2
line3
line5
EOL
)"
  End

End

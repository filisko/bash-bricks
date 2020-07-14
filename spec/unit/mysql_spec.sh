#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/databases.sh

Describe 'bb_mysql_csv'
  It 'adds double commas and commas to separate the values'
    bb_mysql_raw() {
      cat <<EOL
1	random text!123 "ñ,.	01234
2	text	56789
EOL
    }

    When call bb_mysql_csv "SELECT * FROM users"
    The output should equal "$(cat <<EOL
"1","random text!123 ""ñ,.","01234"
"2","text","56789"
EOL
)"
  End

End

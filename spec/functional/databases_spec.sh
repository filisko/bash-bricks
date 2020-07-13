#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/databases.sh

Describe 'bb_curl'

  # Context 'returns same curl status and error message when curl fails'
  #   cat() {
  #     echo 'declare -- normal="1"'
  #     echo 'declare -i somenumber="123"'
  #     echo 'declare -a indexed_array=([1]="31" [2]="29" [3]="31")'
  #     echo 'declare -A associate_array=([january]="31" [february]="29" [march]="31" )'
  #   }

  #   It 'calls the date function'
  #     When call var_is_stored var_name db_name
  #     The status should be failure
  #   End
    
  #   It 'calls the date function2'
  #     When call var_is_stored normal db_name
  #     The status should be success
  #   End
  # End

  It 'calls the date functionasd'
    # cat() {
    #   echo ''
    # }
    When call db_exists db_name
    The status should be failure
  End
End

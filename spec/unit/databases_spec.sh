#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/databases.sh

Describe 'before / after hook sample'
  Describe 'store_var'
    cleanup() {
      rm -rf $(get_db_path "db")
    }
    After 'cleanup'


    get_db_path() {
      local db_name="$1"
      printf "%s.vars.sh" "${db_name}"
    }

    # It 'xddd'
    #   db_exists() {
    #     db_exists_called=1
    #     return 1
    #   }

    #   create_db() {
    #     create_db_called=1
    #     return 0
    #   }

    #   bb_log() {
    #     bb_log_called=1
    #     return 0
    #   }

    #   When call store_var "var" "db"
    #   The status should be failure

    #   The variable db_exists_called should eq 1
    #   The variable create_db_called should eq 1
    #   The variable bb_log_called should eq 1
    # End

    It 'adds double commas and commas to separate the values2'
      db_exists() {
        db_exists_called=1
        return 1
      }

      create_db() {
        create_db_called=1
        return 0
      }

      bb_log() {
        bb_log_called=1
        return 0
      }
      
      var_is_stored() {
        var_is_stored_called=1
        return 0
      }
      
      remove_var() {
        remove_var_called=1
        return 0
      }

      var="now is defined :)"

      When call store_var "var" "db"
      The status should be success

      The variable db_exists_called should eq 1
      The variable create_db_called should eq 1
      The variable bb_log_called should eq 1
      The variable var_is_stored_called should eq 1
      The variable remove_var_called should eq 1
    End

  End
  # Describe 'store_var'
  #   cleanup() {
  #     rm -rf $(get_db_path "db")
  #   }
  #   After 'cleanup'


  #   get_db_path() {
  #     local db_name="$1"
  #     printf "%s.vars.sh" "${db_name}"
  #   }

  #   It 'adds double commas and commas to separate the values2'
  #     db_exists() {
  #       db_exists_called=1
  #       return 1
  #     }

  #     create_db() {
  #       create_db_called=1
  #       return 0
  #     }

  #     bb_log() {
  #       bb_log_called=1
  #       return 0
  #     }
      
  #     var_is_stored() {
  #       var_is_stored_called=1
  #       return 0
  #     }
      
  #     remove_var() {
  #       remove_var_called=1
  #       return 0
  #     }

  #     var="now is defined :)"

  #     When call store_var "var" "db"
  #     The status should be success

  #     The variable db_exists_called should eq 1
  #     The variable create_db_called should eq 1
  #     The variable bb_log_called should eq 1
  #     The variable var_is_stored_called should eq 1
  #     The variable remove_var_called should eq 1
  #   End

  # End
End
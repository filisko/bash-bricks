#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/databases.sh

# Describe '1: before hook'
#   get_db_path() {
#     local db_name="$1"
#     printf "%s.vars.sh" "${db_name}"
#   }


#   It 'is called before execute example'
#     setup() {
#       echo "Hola"
#     }
#     Before 'setup'

#     cleanup() {
#       get_db_path ""
#     }
#     After 'cleanup'

#     When call store_var 10
#     The output should eq 20
#   End

# End

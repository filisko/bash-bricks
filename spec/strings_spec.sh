#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/strings.sh

Describe 'variables'
    Example "when variable exists it appears on the output"
        data() {
            set
        }
        Data data

        myvar=test123
        When call variables
        The output should include "myvar"
    End

    Example "when variable does not exist it does not appear on output"
        data() {
            set
        }
        Data data

        When call variables
        The output should not include "nonexistentvar"
    End
End

Describe 'flatten'
    Example "when variable exists gets replaced"
        this=test123
        When call flatten "replace {{this}}"
        The output should equal "replace test123"
    End

    Example "when variable does not exist nothing happens"
        When call flatten "replace {{this}}"
        The output should equal "replace {{this}}"
    End
End

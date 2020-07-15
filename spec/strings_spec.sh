#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/strings.sh

Describe 'variables'
    data() {
      set
    }
    Data data

    Example "default"
        myvar=test123
        When call variables
        The output should include "myvar"
    End
End

Describe 'flatten'
    data() {
      set
    }
    Data data

    Example "default"
        this=test123
        When call flatten "replace {{this}}"
        The output should equal "replace test123"
    End
End

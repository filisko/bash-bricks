#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/strings.sh

Describe 'left trim (ltrim)'
  Parameters
    "no spaces returns same text" "text" "text"
    "spaces on left are removed" "  text" "text"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call ltrim
    The output should equal "$3"
  End
End

Describe 'right trim (rtrim)'
  Parameters
    "no spaces returns same text" "text" "text"
    "spaces on right are removed" "text  " "text"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call rtrim
    The output should equal "$3"
  End
End

Describe 'trim'
  Parameters
    "no spaces returns same text" "text" "text"
    "spaces on left are removed" "  text" "text"
    "spaces on right are removed" "text  " "text"
    "spaces on both sides are removed" "  text  " "text"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call trim
    The output should equal "$3"
  End
End

Describe 'upper'
  Parameters
    "no spaces returns same text" "text" "TEXT"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call upper
    The output should equal "$3"
  End
End

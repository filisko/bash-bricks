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
    "happy" "text one TWO" "TEXT ONE TWO"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call upper
    The output should equal "$3"
  End
End

Describe 'lower'
  Parameters
    "happy" "ONE two" "one two"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call lower
    The output should equal "$3"
  End
End

Describe 'camel'
  Parameters
    "happy" "One two" "OneTwo"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call camel
    The output should equal "$3"
  End
End

Describe 'snake'
  Parameters
    "happy" "One twO" "one_tw_o"
    "happy2" "One twOto" "one_tw_oto"
  End

  Data:expand
    #|$2
  End

  Example "$1"
    When call snake
    The output should equal "$3"
  End
End

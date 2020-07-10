#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/validations.sh

Describe 'valid_date successes'
  Parameters
    "in feb higher than 1" 2019-02-01
    "in feb equal to max (28)" 2019-02-28
    "in feb lower than max" 2019-02-27
  End

  Example "$1"
    When call valid_date $2
    The status should be success
  End
End

Describe 'valid_date failures'
  Parameters
    "empty"
    "wrong format" 2019/01/05
    "month lower than 1" 2019-00-05
    "month higher than 12" 2019-13-05
    "day lower than 1" 2019-02-00
    "day higher than max allowed for Feb" 2019-02-30
  End

  Example "$1"
    When call valid_date $2
    The status should be failure
  End
End

Describe 'valid_number fails when input...'
  Parameters
    "is empty"
    "has minus at front" -1
    "has plus at front" +1
    "contains comma" 10,1
    "contains dot" 10.1
  End

  Example "$1"
    When call valid_number $2
    The status should be failure
  End
End

Describe 'valid_number success when input...'
  Parameters
    "is zero" 0
    "is one" 1
    "multiple" 12345
  End

  Example "$1"
    When call valid_number $2
    The status should be success
  End
End

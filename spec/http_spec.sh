#https://github.com/shellspec/shellspec/blob/master/docs/references.md

Include lib/http.sh

Describe 'bb_curl'
  It 'returns same curl status and error message when curl fails'
    curl() {
      echo "curl error"
      return 5
    }

    When call bb_curl -X POST -F "client_id=123" http://test.com
    The output should equal "curl error"
    The status should equal 5
  End

  It 'returns first number of http status code when doesnt start with 2'
    curl() {
      echo "<html>content</html>HTTPSTATUS:301"
    }

    When call bb_curl -X POST -F "client_id=123" http://test.com
    The status should equal 3
    The output should equal "<html>content</html>"
  End

  It 'returns 0 as status code when http status code starts with 2'
    curl() {
      echo "<html>content</html>HTTPSTATUS:201"
    }

    When call bb_curl -X POST -F "client_id=123" http://test.com
    The status should equal 0
    The output should equal "<html>content</html>"
  End
End

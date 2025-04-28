set_redactor(function(response) {

  httptest::gsub_response(response, 
                          "https://api.hystreet.com/v2/", 
                          "", 
                          fixed = TRUE)

})
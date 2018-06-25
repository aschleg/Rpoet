context('test get.poetry function')

httptest::with_mock_api({
  test_that('get.poetry single input term no search term', {
    skip_on_cran()
    p <- get.poetry('author')

    expect_true(is.vector(p$authors))
    expect_true('Ambrose Bierce' %in% p$authors)
    expect_true(length(p$authors) >= 129)

    expect_error(get.poetry('author', output_format = 'adfj'),
                 "output_format parameter must be one of 'json', 'text', or NULL")




  })
})

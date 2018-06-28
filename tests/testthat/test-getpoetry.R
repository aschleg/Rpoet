context('test get.poetry function')

httptest::with_mock_api({
  test_that('get.poetry returns data correctly', {
    skip_on_cran()
    p <- get.poetry('author')

    expect_true(is.list(p))
    expect_true(is.vector(p$authors))

    expect_true('Ambrose Bierce' %in% p$authors)
    expect_true(length(p$authors) >= 129)

    w_abs <- get.poetry('author', 'William Shakespeare', 'title,linecount', search_type = 'abs')
    w <- get.poetry('author', 'William Shakespeare', 'title,linecount')

    expect_true(nrow(w) == nrow(w_abs))
    expect_true(ncol(w) == ncol(w_abs))

    expect_true(is.data.frame(w))

    expect_error(get.poetry('author', output_format = 'adfj'),
                 "output_format parameter must be one of 'json', 'text', or NULL.")

    expect_error(get.poetry('author', 'William Shakespeare', 'title', search_type = 'ab'),
                 "search_type parameter must be one of 'abs' or 'absolute' for absolute match searches or NULL for broad match searches.")

  })

  test_that('get.poetry combination searches return data appropriately', {
    skip_on_cran()

    w <- get.poetry('author,title', 'William Shakespeare;Spring and Winter ii', 'author,title')

    expect_true(is.data.frame(w))

  })
})


test_that('get.poetry returns text output correctly', {
  skip_on_cran()

  shakespeare_text <- get.poetry('author', 'William Shakespeare', 'title', output_format = 'text')

  expect_true(is.character(shakespeare_text))
})

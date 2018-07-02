
#' Primary function for interfacing with the PoetryDB API.
#'
#' @param input_term The desired input term for searching PoetryDB. Must be one of or any combination of 'author',
#'   'title', 'lines', or 'linecount'.
#' @param search_term Relates to the `input_term`. The search term should be relevant to the given input term. If multiple
#'   `input_term` parameters are given, each must have a corresponding `search_term`.
#' @param output Can be any or a combination of the input terms {'author', 'title', 'lines', 'linecount'}. If NULL, all
#'   the data returned from PoetryDB by the search will be returned. The output can also be a combination of
#'   the terms, for example, an output of 'author,title,lines,linecount', will return the same result as if the
#'   parameter is set to NULL. An output of 'title,lines', will return the poem's title and text.
#' @param output_format If NULL or 'json', the results are returned in JSON format (the PoetryDB API default). If 'text', the
#'   results are returned as a parsed string using the [stringr](https://CRAN.R-project.org/package=stringr) package.
#' @param search_type If NULL (default), the search attempts to match any part of the `input_term`. If 'abs', the search
#'   will attempt to find an exact match when searching for the `input_term`.
#' @return Search result returned by the PoetryDB API interface in either a JSON-like object or text (depending on what is
#'   passed in the `output_format`).
#' @examples
#' \dontrun{
#' # Get all of William Shakespeare's poetry by title and lines
#' shakespeare <- get.poetry('author', 'William Shakespeare', 'title,lines')
#' # Get all ten books of Paradise Lost written by John Milton by linecount and lines
#' paradise_lost <- get.poetry('title', 'Paradise Lost', 'linecount,lines')
#' }
#' @export
get.poetry <- function(input_term, search_term = NULL, output = NULL, output_format = NULL, search_type = NULL) {
  uri <- 'http://poetrydb.org'

  if (!is.null(search_type) & input_term != 'linecount') {
    if (!(search_type %in% c('abs', 'absolute'))) {
      stop("search_type parameter must be one of 'abs' or 'absolute' for absolute match searches or NULL for broad match searches.")
    }
    else {
      search_term <- paste(search_term, ':abs', sep = '')
    }
  }

  if (is.null(output_format)) {
    output_format <- 'json'
  }

  else {
    if (!(output_format %in% c('json', 'text', NULL))) {
      stop("output_format parameter must be one of 'json', 'text', or NULL.")
    }
    else {
      output <- paste(output, '.', output_format, sep = '')
    }
  }

  parameters <- c(input_term, search_term, output)
  remove <- c(NULL, '')

  parameters <- setdiff(parameters, remove)

  parameter_string <- paste('/', parameters, sep = '', collapse = '')

  uri <- paste(uri, parameter_string, sep = '', collapse = '')

  if (stringr::str_sub(uri, start = -2, end = -1) == '//') {
    uri <- stringr::str_sub(uri, start = 1, end = -3)
  }
  else if (stringr::str_sub(uri, start = -2, end = -1) == '/') {
    uri <- stringr::str_sub(uri, start = 1, end = -2)
  }

  uri <- gsub(' ', '%20', uri)

  if (output_format == 'json' | output_format != 'text') {
    result <- jsonlite::fromJSON(uri,
                                 flatten = TRUE,
                                 simplifyVector = TRUE,
                                 simplifyDataFrame = TRUE,
                                 simplifyMatrix = TRUE)
  }
  else {
    uri_get <- httr::GET(uri)

    result <- tryCatch({
      httr::content(uri_get, 'parsed')
    },
    error = function(cond) {
      httr::content(uri_get, 'text')
    })
  }

  return(result)
}

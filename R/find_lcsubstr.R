#' Find the longest common substring between elements of a character vector
#'
#' @param string a character vector.
#' @param n_min integer. Minimum common substring length to find.
#' @param n_max integer. Maximum common substring length to find. Default (\code{NULL}) correspond to the length of the smallest string
#'
#' @return a character vector with the longest common substring(s)
#' 
#' @importFrom tibble tibble
#' @importFrom stringr str_c str_detect str_length coll
#' @importFrom dplyr mutate top_n desc pull filter select
#' @importFrom rlang is_null
#' @importFrom tidytext unnest_tokens
#' @importFrom purrr map map_lgl
#' 
#' @export
#'
#' @examples
#' st1 <- "Here is a first string for the example, how original !"
#' st2 <- "Here a second string for the example too."
#' st3 <- "Here is a third  string for the example, as original as the others."
#' find_lcsubstr(string = c(st1, st2, st3))
find_lcsubstr <- function(string, n_min = 1, n_max = NULL) {
  
 # tibble
  tibtext <- tibble(strid = str_c("st", seq_along(string)),
                    string = string)
  
  # string with minimum word and number of common words boudaries
  nmin <- n_min
  nchr <- tibtext %>%
    mutate(n = str_length(string))
  minword <- nchr %>%
    top_n(n = 1, wt = desc(n)) %>%
    pull(strid)
  nmax <- ifelse(is_null(n_max), min(pull(nchr, n)), n_max)
  # n_max >= n_min
  if (nmin > nmax) stop("Error : n_min should be lower than n_max. Consider reducing n_min !")
  
  lcsubstr = tibtext %>%
    filter(strid == minword) %>%
    unnest_tokens(output = chr, input = string, token = "character_shingles", n = nmax, n_min = nmin, 
                  drop = FALSE, lowercase = FALSE, strip_non_alphanum = FALSE, to_lower = FALSE) %>%
    mutate(nchr = str_length(chr)) %>%
    select(-string, -strid) %>%
    mutate(isIn = map(chr, ~str_detect(pattern = coll(.), string = tibtext$str))) %>%
    mutate(isAllIn = map_lgl(isIn, all)) %>%
    filter(isAllIn) %>%
    top_n(n = 1, wt = nchr) %>%
    pull(chr)
  
  cat("\nLongest Common SubString(s) :\n", str_c(lcsubstr, collapse = "\n"), "\n\n")
  
  return(lcsubstr)
  
}
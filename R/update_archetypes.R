library(lubridate); library(magrittr)

.dates <- data.frame(
  year = c(2019, 2020, 2020, 2020),
  term = c('M', 'H', 'T', 'M'),
  start = c('10-13', '1-19', '4-26', '10-11'),
  stringsAsFactors = FALSE
)

.terms <- c('H', 'H', 'H', 
            'T', 'T', 'T', 
             NA,  NA, 'M',
            'M', 'M', 'M')
.term_names <- c(H = 'Hilary', T = 'Trinity', M = 'Michaelmas')
.term_weights <- c(H = 1, T = 2, M = 3)

TODAY <- today()
YEAR <- year(TODAY)
TERM <- .terms[month(TODAY)]

start <-as_date(paste0(YEAR, '-', .dates[.dates$year==YEAR & .dates$term==TERM, ][['start']]))
year(start) <- YEAR

WEEK <- ceiling(as.period(TODAY-start)/days(7))

fTERM <- paste0(.term_weights[TERM], '-', .term_names[TERM])

replace <- function(file, weekchange=0){
  readr::read_file(file) %>% 
    stringr::str_replace('(?<=term: ).*', fTERM) %>% 
    stringr::str_replace('(?<=week: ).*', as.character(WEEK+weekchange)) %>% 
    write(file)
}

# Main --------------------------------------------------------------------
replace('../archetypes/tutorial.md', 1)
replace('../archetypes/default.md')


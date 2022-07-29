# make sure it's the 'root' dir
while(!('content' %in% dir())){
  setwd('..')
}

# render pdf for new and modified pages



   {new <- tools::md5sum(list.files('content', '^[^_].+md', recursive = TRUE, full.names = TRUE))
   old <- readRDS('R/md5')
   (new_pages <- names(new[!(new %in% old)]))}


#for(page in new_pages){
#     rmarkdown::render(page)
#}
   
mkpdf <- function(numbering_option){
   for(page in new_pages){
      x <-  try(rmarkdown::render(page, bookdown::pdf_document2(latex_engine='xelatex')), silent = TRUE)
      if(class(x) == 'try-error') {
         rmarkdown::render(page, bookdown::pdf_document2(latex_engine='xelatex'))
      }
   }
   
}
mkpdf()


saveRDS(new, 'R/md5')

# To render all pdfs
# lapply(list.files('content', '^[^_].+md', recursive = TRUE, full.names = TRUE),function(page){rmarkdown::render(page, rmarkdown::pdf_document(number_sections = TRUE))})


# rmarkdown::render(new_pages, rmarkdown::word_document())


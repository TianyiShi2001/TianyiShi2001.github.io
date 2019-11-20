library(rmarkdown)

f_s = list.files('.', '^[^_].+md')

for(f in f_s){
  rmarkdown::render(f)
}
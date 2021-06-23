library(tidyverse)

sites_path = 'XXX'
sites <- read_tsv(sites_path)

sites_unique <- sites %>% 
  group_by(gene, sequence) %>% 
  summarize(sites = paste(site, collapse = ' '))

sites_unique_filtered <- sites_unique %>% 
  filter(nchar(sequence) < 10000)

write_tsv(sites_unique_filtered, 'glycosites_unique_filtered.tsv')

library(tidyverse)

pos_path <- 'XXX'
neg_path <- 'XXX'
sites_pos <- read_tsv(pos_path)
sites_neg <- read_tsv(neg_path)

sites_pos_unique <- sites_pos %>% 
  group_by(gene, sequence) %>% 
  summarize(sites = paste(site, collapse = ' ')) %>% 
  mutate(gene = str_c(gene, '_pos'))

sites_neg_unique <- sites_neg %>% 
  group_by(gene, sequence) %>% 
  summarize(sites = paste(site, collapse = ' ')) %>% 
  mutate(gene = str_c(gene, '_neg'))

sites_unique <- bind_rows(sites_pos_unique, sites_neg_unique)

sites_unique_filtered <- sites_unique %>% 
  filter(nchar(sequence) < 10000)

write_tsv(sites_unique_filtered, 'glycosites_combined_unique_filtered.tsv')

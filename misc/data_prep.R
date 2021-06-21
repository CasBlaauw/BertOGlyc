library(tidyverse)

peptides <- read_tsv("C:/Users/sac12/Documents/5-4-BOHTA&Project/NetOGlyc/SimpleCell All Glycopeptides 12_10_26.tsv", col_names = c('gene', 'start', 'end'))
sites <- read_tsv("C:/Users/sac12/Documents/5-4-BOHTA&Project/NetOGlyc/SimpleCell All Glycosites 12_10_26.tsv")

# pep_wide <- peptides %>%
#   group_by(gene) %>% 
#   summarize(first_start = min(start), last_end = max(end), count = n())

sites_unique <- sites %>% 
  group_by(gene, sequence) %>% 
  summarize(sites = paste(site, collapse = ' '))

sites_unique_filtered <- sites_unique %>% 
  filter(nchar(sequence) < 10000)

write_tsv(sites_unique_filtered, 'C:/Users/sac12/Documents/5-4-BOHTA&Project/NetOGlyc/glycosites_unique_filtered.tsv')

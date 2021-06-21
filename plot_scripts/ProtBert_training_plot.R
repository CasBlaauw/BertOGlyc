# Short script to manually generate plots of the progress during model training.
# Uses the printed output of ProtBert-NetOGlyc-classification-training.ipynb's evaluate() function.

library(tidyverse)
library(cowplot)

# Import the data
# cb_weights beta = 0.99999 ([0.03512864 1.96487136]), 1:55.933
# Turn into tribble-friendly by replacing '\s*\, \s*' with ' ,' and adding commas at the end
training <- tribble(
  ~epoch, ~train_loss, ~val_loss, ~val_acc, ~val_site_acc, ~true_pos, ~true_neg,
  1, 0.631109, 0.590762, 99.82, 10.15, 9.63, 99.91, 
  2, 0.574027, 0.562861, 98.58, 75.95, 5.60, 99.98,  
  3, 0.543790, 0.541366, 99.30, 68.79, 9.67, 99.97,  
  4, 0.513176, 0.497464, 99.11, 74.56, 7.66, 99.98,  
  5, 0.481214, 0.464758, 99.11, 76.13, 8.14, 99.98,  
  6, 0.446107, 0.422800, 99.14, 82.48, 9.23, 99.98,  
  7, 0.406868, 0.382631, 99.19, 81.82, 9.55, 99.98,  
  8, 0.361281, 0.337564, 99.18, 82.93, 8.99, 99.98,  
  9, 0.312608, 0.289396, 99.17, 84.12, 9.44, 99.98,  
  10, 0.263413, 0.246042, 99.05, 83.63, 9.01, 99.98,   
  11, 0.218432, 0.208965, 99.33, 81.22, 11.43, 99.98,   
  12, 0.176521, 0.165791, 99.20, 86.23, 9.57, 99.99, 
  13, 0.143374, 0.141976, 99.28, 78.94, 10.65, 99.98,   
  14, 0.115853, 0.118210, 99.17, 84.22, 9.38, 99.98, 
  15, 0.095100, 0.103479, 99.29, 81.45, 11.28, 99.98,   
  16, 0.080048, 0.094119, 99.09, 83.38, 9.17, 99.98, 
  17, 0.067393, 0.088102, 99.23, 80.83, 10.28, 99.98,   
  18, 0.058505, 0.079690, 99.39, 77.78, 11.63, 99.98,  
  19, 0.052315, 0.072386, 99.29, 80.96, 10.07, 99.98,  
  20, 0.046699, 0.064914, 99.19, 85.62, 9.16, 99.99, 
)
# weights 1:30
# training <- tribble(
#   ~epoch, ~train_loss, ~val_loss, ~val_acc, ~val_site_acc, ~true_pos, ~true_neg,
#   1, 0.566444, 0.540094, 99.61, 48.94, 13.28, 99.95,   
#   2, 0.539341, 0.507498, 99.64, 51.24, 15.14, 99.95,   
#   3, 0.507382, 0.480481, 99.62, 48.26, 16.66, 99.93,   
#   4, 0.471302, 0.438059, 99.56, 62.59, 14.13, 99.96,  
#   5, 0.428218, 0.397493, 99.57, 58.05, 13.68, 99.95,  
#   6, 0.380902, 0.347252, 99.55, 62.22, 15.14, 99.96, 
#   7, 0.329864, 0.299259, 99.45, 63.64, 14.90, 99.95,   
#   8, 0.278007, 0.247042, 99.59, 58.12, 13.78, 99.96,  
#   9, 0.230074, 0.209874, 99.53, 60.51, 15.46, 99.95,   
#   10, 0.188096, 0.171375, 99.58, 62.01, 14.94, 99.96,   
#   11, 0.152412, 0.140591, 99.50, 66.06, 13.85, 99.96,   
#   12, 0.123748, 0.116630, 99.51, 66.85, 14.66, 99.96,  
#   13, 0.101858, 0.106605, 99.64, 52.36, 17.14, 99.94,  
#   14, 0.084761, 0.089466, 99.51, 63.18, 13.27, 99.96,  
#   15, 0.072637, 0.074256, 99.38, 76.69, 11.55, 99.98,  
#   16, 0.063268, 0.072782, 99.70, 55.92, 16.67, 99.95,  
#   17, 0.055346, 0.065623, 99.66, 58.80, 15.18, 99.95,  
#   18, 0.050239, 0.059146, 99.39, 77.17, 13.04, 99.97,  
#   19, 0.045521, 0.062839, 99.65, 53.74, 17.05, 99.95,  
#   20, 0.041598, 0.055862, 99.59, 62.48, 16.29, 99.96,  
# )

# Loss plot
loss <- training %>% 
  pivot_longer(c(train_loss, val_loss), names_to = 'loss_type') %>% 
  ggplot(aes(epoch, value, col = loss_type)) + 
  geom_line(lwd = 1) + 
  theme_bw() +
  labs(x = 'Epoch', y = 'Loss', col = 'Loss type') +
  scale_color_discrete(labels = c('Training loss', 'Validation loss'))+
  theme(legend.position = 'bottom', legend.title = element_blank())

# TN/TP plot
true <- training %>% 
  pivot_longer(c(true_pos, true_neg), names_to = 'statistic') %>% 
  ggplot(aes(epoch, value, col = statistic)) + 
  geom_line(lwd = 1) + 
  theme_bw() +
  labs(x = 'Epoch', y = 'Percentage', col = 'Statistic') +
  scale_color_discrete(labels = c('True negative', 'True positive'))+
  theme(legend.position = 'bottom', legend.title = element_blank())

# labels recovered
recovery <- training %>% 
  pivot_longer(c(val_acc, val_site_acc), names_to = 'Type') %>% 
  ggplot(aes(epoch, value, col = Type)) + 
  geom_line(lwd = 1) + 
  theme_bw() +
  labs(x = 'Epoch', y = 'Percentage', col = 'Type') +
  scale_color_discrete(labels = c('Total accuracy', 'Site accuracy')) +
  theme(legend.position = 'bottom', legend.title = element_blank())

plot_row <- plot_grid(loss, true, recovery, labels = c('A', 'B', 'C'), nrow = 1, align = 'h', axis = 'b')

ggsave('fig_training.png', plot_row, path = '5-4-BOHTA&Project/NetOGlyc/', width = 9, height = 3, units = 'in')

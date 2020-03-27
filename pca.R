rm(list=ls())
setwd('~/tb')
df <- read.csv('parsed_data.csv', stringsAsFactors = F, check.names = F)
X <- df[, 2:ncol(df)]
y <- df[, 1]

require(ggplot2)
require(ggsci)
table(df$`New Property`)

test <- data.frame(AA = df$original, drug = df$drug, Property = df$`New Property`)
ggplot(test, aes(x = Property, fill = factor(drug))) +
  geom_bar(position = "fill")

# PCA
pca <- prcomp(X, scale = T, center = F, retx = T)
pc <- pca$x

plot_df1 <- data.frame(X1 = pc[, 1], X2 = pc[, 2], drug = y)
plot_df1$drug <- factor(plot_df1$drug)

ggplot(plot_df1, aes(x = X1, y = X2, color = drug)) +
  geom_count() +
  labs(x = "PC1", y = "PC2", size = "Frequency", color = "Resistance")

ggsave("pca_plot.png", dp = 1200)
loading_df <- data.frame(PC1 = pca$rotation[, 1], 
                         PC2 = pca$rotation[, 2], 
                         variable = colnames(X), 
                         stringsAsFactors = F, 
                         check.names = F)

loading_df$variable <- factor(loading_df$variable, levels=sort(loading_df$variable))

plt1 <- ggplot(loading_df, aes(x = variable, y = PC1)) +
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.x = element_blank(),
        plot.margin = unit(c(0,0,0,0), "cm")) +
  scale_fill_jama()
  
plt2 <- ggplot(loading_df, aes(x = variable, y = PC2)) +
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 30, hjust = 1),
        plot.margin = unit(c(0,0,0,0), "cm")) +
  scale_fill_jama()

require(ggpubr)  
ggarrange(plt1, plt2, ncol=1, nrow=2, align = "hv")

ggsave("PCA_loadings.png", dpi=1200, width = 10, height = 4)

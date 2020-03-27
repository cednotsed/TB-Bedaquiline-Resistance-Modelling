rm(list = ls())
setwd('~/tb')
df <- read.csv('tb_mutations.csv', stringsAsFactors = F, check.names = F)
df <- df[df$drug != "Unknown", ]
df <- df[df$drug != "INFERRED", ]
# ori_ex <- c("Cys", "Trp", "Thr", "Tyr", "Gln")
# new_ex <- c("Asn", "Cys", "Met", "Tyr", "Glu", "His", "Ile", "Phe")
# filt1 <- df[!(df$original %in% ori_ex), ]
# filt2 <- filt1[!(filt1$new %in% new_ex), ]
# filt2$drug[filt2$drug == "Intermediate 0.25"] <- "Resistant"
df <- df[df$drug != "Intermediate 0.25", colnames(df) != "position"]
# Save file
write.csv(df, "filtered.csv", row.names = F)

require("ggplot2")
ggplot(df, aes(x = original, fill = )) +
  geom_bar(stat = "count")

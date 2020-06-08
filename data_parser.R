rm(list = ls())
setwd('~/TB-Bedaquiline-Resistance-Modelling/')
df <- read.csv('raw_tb_mutation_data.csv', stringsAsFactors = F, check.names = F)
to_predict <- df[df$drug %in% c("Unknown", "INFERRED"), ]
df <- df[df$drug != "Unknown", ]
df <- df[df$drug != "INFERRED", ]
df <- df[df$drug != "Intermediate 0.25", ]
# Save file
write.csv(df, "filtered.csv", row.names = F)
write.csv(to_predict, "to_predict_new.csv", row.names = F)

require("ggplot2")
ggplot(df, aes(x = original, fill = )) +
  geom_bar(stat = "count")

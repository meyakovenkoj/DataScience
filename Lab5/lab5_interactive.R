transact_data <- read.transactions(
  file = "https://hyper.mephi.ru/assets/courseware/v1/4528e593d5d574a075e15cab1da2383b/asset-v1:MEPhIx+CS712DS+2020Fall+type@asset+block/AssociationRules.csv",
  format = "basket",
  sep = " "
)

rules_2 <- apriori(transact_data, parameter = list(supp = 0.01, conf = 0.5, target = "rules"))

plot(rules_2, method = "scatterplot", measure = c('support', 'lift'), shading = 'confidence', jitter = 0, interactive = TRUE)

rules_4 <- apriori(transact_data, parameter = list(supp = 0.01, conf = 0.8))
plot(rules_4, shading = c('lift', 'confidence'), method = 'matrix', interactive=TRUE)

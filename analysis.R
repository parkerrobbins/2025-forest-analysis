# Reproducible seed
set.seed(20250417)

# Load libraries
library(conflicted)
library(tidyverse)
library(here)
library(partykit)

# Set working dir to project root (in case it’s run elsewhere)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Preprocess data
data <- readRDS("preprocessed_data.rds") %>%
  mutate(across(
    c(
      gender,
      lemma_category,
      lemma_taxonomy,
      local_zikh,
      match_in_prev_turn,
      match_in_turn,
      possessor_person_category,
      preposition_contracted,
      preposition_is_mit,
      region,
      with_preposition,
      yearofbirth
    ),
    ~ replace_na(.x, "no")
  )) %>%
  mutate(across(where(is.character), as.factor))

data_cf <-  partykit::cforest(
  category ~ gender + lemma_category + possessor_person_category + region +
    with_preposition + yearofbirth,
  data = data,
  ntree = 128
)
saveRDS(data_cf, "./output/data_cf.rds")

# Calculate variable importance (This will take a long time)
imp <- partykit::varimp(object = data_cf, conditional = TRUE)
saveRDS(data_cf, "./output/imp.rds")

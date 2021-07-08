# RIPL serology cleaning script
# Aug 2020



load_and_clean_serology_csvs <- function(all_sera_path, acute_sera_path) {
  require(tidyverse)
all_sera <- read_csv(all_sera_path)
acute_sera <- read_csv(acute_sera_path)

# uggghhhhhhh unpack the serology sheet maaaaaaaan


all_sera %>%
  mutate(
    day_28_chik_IgG = str_match(`Day 28 Chik`, "Pos G........"),
    day_28_chik_IgM = str_match(`Day 28 Chik`, "Pos M........"),
    day_28_den_IgG = str_match(`Day 28 Dengue`, "Pos G........"),
    day_28_den_IgM = str_match(`Day 28 Dengue`, "Pos M........"),
    day_28_chik_IgG_OD =
      str_match(day_28_chik_IgG, "(?<=\\().*(?=\\))")[, 1],
    day_28_chik_IgM_OD = str_match(day_28_chik_IgM, "(?<=\\().*(?=\\))")[, 1],
    day_28_den_IgG_OD = str_match(day_28_den_IgG, "(?<=\\().*(?=\\))")[, 1],
    day_28_den_IgM_OD = str_match(day_28_den_IgM, "(?<=\\().*(?=\\))")[, 1],
    day_28_chik_IgG = case_when(
      str_detect(`Day 28 Chik`, "Pos G") ~ "pos",
      str_detect(`Day 28 Chik`, "Neg") ~ "neg",
      str_detect(`Day 28 Chik`, "Pos M") &
        !str_detect(`Day 28 Chik`, "Pos G")  ~ "neg",
      str_detect(`Day 28 Chik`, "Ind G") |
        str_detect(`Day 28 Chik`, "Indet G") ~ "ind",
      TRUE ~ as.character(NA)
    ),
    day_28_chik_IgM = case_when(
      str_detect(`Day 28 Chik`, "Pos M") ~ "pos",
      str_detect(`Day 28 Chik`, "Neg") ~ "neg",
      str_detect(`Day 28 Chik`, "Pos G") &
        !str_detect(`Day 28 Chik`, "Pos M")  ~ "neg",
      str_detect(`Day 28 Chik`, "Pos M") &
        !str_detect(`Day 28 Chik`, "Pos G")  ~ "neg",
      str_detect(`Day 28 Chik`, "Ind M") |
        str_detect(`Day 28 Chik`, "Indet M") |
        str_detect(`Day 28 Chik`, "IND M") ~ "ind",
      TRUE ~ as.character(NA)
    ),
    day_28_den_IgG = case_when(
      str_detect(`Day 28 Dengue`, "Pos G") ~ "pos",
      str_detect(`Day 28 Dengue`, "Neg") ~ "neg",
      str_detect(`Day 28 Dengue`, "Pos M") &
        !str_detect(`Day 28 Dengue`, "Pos G")  ~ "neg",
      str_detect(`Day 28 Dengue`, "Ind G") |
        str_detect(`Day 28 Dengue`, "Indet G") ~ "ind",
      TRUE ~ as.character(NA)
    ),
    day_28_den_IgM = case_when(
      str_detect(`Day 28 Dengue`, "Pos M") ~ "pos",
      str_detect(`Day 28 Dengue`, "Neg") ~ "neg",
      str_detect(`Day 28 Dengue`, "Pos G") &
        !str_detect(`Day 28 Dengue`, "Pos M")  ~ "neg",
      str_detect(`Day 28 Dengue`, "Pos M") &
        !str_detect(`Day 28 Dengue`, "Pos G")  ~ "neg",
      str_detect(`Day 28 Dengue`, "Ind M") |
        str_detect(`Day 28 Dengue`, "Indet M") |
        str_detect(`Day 28 Chik`, "IND M") ~ "ind",
      TRUE ~ as.character(NA)
    ),
    day_28_lepto_IgM = str_match(`Day 28 Leto`, "Pos........"),
    day_28_lepto_IgM_OD = str_match(day_28_lepto_IgM, "(?<=\\().*(?=\\))")[1],
    day_28_lepto_IgM = case_when(
      str_detect(`Day 28 Leto`, "Pos") ~ "pos",
      str_detect(`Day 28 Leto`, "Neg") ~ "neg",
      TRUE ~ as.character(NA)
    ),
    `Day 28 Ricks` = str_replace(`Day 28 Ricks`, "SG", "SF"),
    `Day 28 Ricks` = str_replace(
      `Day 28 Ricks`, "Rickettsia IgG NS", "<64 (Negative)"),
    day_28_SF_IgG_dilution = case_when(
      str_detect(`Day 28 Ricks`, "SF IgG\\s([^ ]*).*$") ~
        str_match(`Day 28 Ricks`, "SF IgG\\s([^ ]*).*$")[, 2],
      str_detect(`Day 28 Ricks`, "Negative") ~ "neg",
      str_detect(`Day 28 Ricks`, "No Serum") ~ as.character(NA),
      str_detect(`Day 28 Ricks`, "insufficient") ~ as.character(NA),
      TRUE ~ "neg"
    ),
    day_28_SF_IgG_dilution = str_replace(day_28_SF_IgG_dilution, ",", ""),
    day_28_SF_IgM_dilution = case_when(
      str_detect(`Day 28 Ricks`, "SF IgM\\s([^ ]*).*$") ~
        str_match(`Day 28 Ricks`, "SF IgM\\s([^ ]*).*$")[, 2],
      str_detect(`Day 28 Ricks`, "Negative") ~ "neg",
      str_detect(`Day 28 Ricks`, "No Serum") ~ as.character(NA),
      str_detect(`Day 28 Ricks`, "insufficient") ~ as.character(NA),
      TRUE ~ "neg"
    ),
    day_28_SF_IgG_dilution = str_replace(day_28_SF_IgG_dilution, ",", ""),
    day_28_SF_IgM_dilution = str_replace(day_28_SF_IgM_dilution, ",", ""),
    day_28_ET_IgG_dilution = case_when(
      str_detect(`Day 28 Ricks`, "ET IgG\\s([^ ]*).*$") ~
        str_match(`Day 28 Ricks`, "ET IgG\\s([^ ]*).*$")[, 2],
      str_detect(`Day 28 Ricks`, "Negative") ~ "neg",
      str_detect(`Day 28 Ricks`, "No Serum") ~ as.character(NA),
      str_detect(`Day 28 Ricks`, "insufficient") ~ as.character(NA),
      TRUE ~ "neg"
    ),
    day_28_ET_IgG_dilution = str_replace(day_28_ET_IgG_dilution, ",", ""),
    day_28_ET_IgM_dilution = case_when(
      str_detect(`Day 28 Ricks`, "ET IgM\\s([^ ]*).*$") ~
        str_match(`Day 28 Ricks`, "ET IgM\\s([^ ]*).*$")[, 2],
      str_detect(`Day 28 Ricks`, "Negative") ~ "neg",
      str_detect(`Day 28 Ricks`, "No Serum") ~ as.character(NA),
      str_detect(`Day 28 Ricks`, "insufficient") ~ as.character(NA),
      TRUE ~ "neg"
    ),
    day_28_ET_IgG_dilution = str_replace(day_28_ET_IgG_dilution, ",", ""),
    day_28_ET_IgM_dilution = str_replace(day_28_ET_IgM_dilution, ",", ""),
    day_28_SF_IgG = case_when(
      is.na(day_28_SF_IgG_dilution) ~ as.character(NA),
      day_28_SF_IgG_dilution != "neg" ~ "pos",
      day_28_SF_IgG_dilution == "neg" ~ "neg"
    ),
    day_28_SF_IgM = case_when(
      is.na(day_28_SF_IgM_dilution) ~ as.character(NA),
      day_28_SF_IgM_dilution != "neg" ~ "pos",
      day_28_SF_IgM_dilution == "neg" ~ "neg"
    ),
    day_28_ET_IgG = case_when(
      is.na(day_28_ET_IgG_dilution) ~ as.character(NA),
      day_28_ET_IgG_dilution != "neg" ~ "pos",
      day_28_ET_IgG_dilution == "neg" ~ "neg"
    ),
    day_28_ET_IgM = case_when(
      is.na(day_28_ET_IgM_dilution) ~ as.character(NA),
      day_28_ET_IgM_dilution != "neg" ~ "pos",
      day_28_ET_IgM_dilution == "neg" ~ "neg"
    ),
  ) -> all_sera

acute_sera %>%
  mutate(Lepto = str_replace(Lepto, "Indet", "Indet M")) %>%
  pivot_longer(-ID) %>%
  mutate(
    value = str_replace_all(value, "G Pos", "Pos G"),
    IgG = str_match(value,"Pos G........"),
    IgG_OD = str_match(IgG,"(?<=\\().*(?=\\))")[,1],
    IgG = case_when(
      str_detect(value, "Pos G") ~ "pos",
      str_detect(value, "Neg") ~ "neg",
      str_detect(value, "Indet G") ~ "ind",
      str_detect(value, "NT") ~ as.character(NA),
      TRUE ~ "neg"
    ),
      value = str_replace_all(value, "M Pos", "Pos M"),
      IgM = str_match(value,"Pos M........"),
      IgM_OD = str_match(IgM,"(?<=\\().*(?=\\))")[,1],
      IgM = case_when(
        str_detect(value, "Pos M") ~ "pos",
        str_detect(value, "Neg") ~ "neg",
        str_detect(value, "Indet M") ~ "ind",
        str_detect(value, "NT") ~ as.character(NA),
        TRUE ~ "neg"
      ),
      name = case_when(
        name == "Dengue" ~ "den",
        name == "Chik" ~ "chik",
        name == "Lepto" ~ "lepto"
      )
  ) %>%
  select(-value) %>%
  pivot_wider(
    id_cols = ID,
    names_from = name,
    values_from = c(IgG, IgG_OD, IgM, IgM_OD),
    names_glue = "day_0_{name}_{.value}"
  ) %>%
  select(-day_0_lepto_IgG,-day_0_lepto_IgG_OD) -> acute_sera

left_join(all_sera,
          acute_sera,
          by = c(`day 0 serum` = "ID")) %>%
  select(pid.corrected,`day 0 serum`,`day 28 serum`,
         `Array Card Results`,
         starts_with("day_0_den"),
         starts_with("day_0_chi"),
         starts_with("day_0_lep"),
         starts_with("day_28_den"),
         starts_with("day_28_chi"),
         starts_with("day_28_lep"),
         starts_with("day_28_SF"),
         starts_with("day_28_ET")
         )  -> df
 return(df)
}


gimme_array_card_results_one_hot_coding <- function(df) {
  df %>% mutate(
    array_card_CMV = case_when(
      str_detect(`Array Card Results`, "CMV") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_EBV = case_when(
      str_detect(`Array Card Results`, "EBV") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_enterobacter.cloacae = case_when(
      str_detect(`Array Card Results`, "Enterobacter cloacae") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_enterobacteria = case_when(
      str_detect(`Array Card Results`, "Enterobacteria") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_klebsiella.pneumoniae = case_when(
      str_detect(`Array Card Results`, "Klebsiella pneumoniae") |
        str_detect(`Array Card Results`, "Kleb pneumoniae")   ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_dengue = case_when(
      str_detect(`Array Card Results`, "Dengue") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_pan.strep = case_when(
      str_detect(`Array Card Results`, "Pan-Strep") |
        str_detect(`Array Card Results`, "Pan Strep") |
        str_detect(`Array Card Results`, "Pan-strep") |
        str_detect(`Array Card Results`, "Pan strep")   ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_strep.pneumo = case_when(
      str_detect(`Array Card Results`, "Strep pneumoniae") |
        str_detect(`Array Card Results`, "Steptococcus pneumoniae")   ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_pan.borrelia = case_when(
      str_detect(`Array Card Results`, "Pan borrelia")   ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_pseudomonas.aeruginosa = case_when(
      str_detect(`Array Card Results`, "Pseudomonas aeruginosa")   ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_rhinovirus = case_when(
      str_detect(`Array Card Results`, "Rhinovirus") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_RVF = case_when(
      str_detect(`Array Card Results`, "RVF") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_RVF = case_when(
      str_detect(`Array Card Results`, "RVF") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_RVF = case_when(
      str_detect(`Array Card Results`, "RVF") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
    array_card_salmonella.hilA = case_when(
      str_detect(`Array Card Results`, "Salmonella hilA") ~ TRUE,
      `Array Card Results` == "Not tested" ~ NA,
      TRUE ~ FALSE
    ),
  ) -> df
  return(df)
}



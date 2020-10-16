# generate datasets to bundle with blantyreSepsis package for
# publication


library(plyr)
library(reshape2)
library(tidyverse)

thesis_folder <- "~/Documents/PhD/Thesis/bookdown/final_cleaning_scripts/"


# load data -----------------------------------------------------------------
source(paste0(thesis_folder,
              "load_PhD_data.R")
)

# load helper functions -----------------------------------------------------
source(paste0("~/R/scripts/pretty_tbl/", 
              "summary_table_functions.R")
)

# serology data - loads a function ------------------------------------------
source("~/Documents/PhD/serology/clean_serology_data.R")

df.sera <- 
  load_and_clean_serology_csvs(
    all_sera_path =                       
      "/Users/joelewis/Documents/PhD/serology/all_serology.csv",
    acute_sera_path = 
      "/Users/joelewis/Documents/PhD/serology/acute_serology.csv" )

# tidy up, restrict to arm 1 -------------------------------------------------

enroll %>%
  filter(arm == 1) %>% 
  left_join(bloods, by = "pid") %>%
  mutate(
    datefirstunwell = case_when(
      unwelfreq == "Days" ~ datefirstunwell *1,
      unwelfreq == "Weeks" ~ datefirstunwell * 7,
      unwelfreq == "Months" ~ datefirstunwell * 30,
    ),
    art.time = as.numeric((data_date - hivartstart) /(365.25/12)),
    hivart = recode(hivart,"5A" = "5A",
                    .default = "Other")
  ) -> e1

# get the aetiology data in the shape we want --------------------------

df.sera <- gimme_array_card_results_one_hot_coding(df.sera) 

# wide


df.sera %>% 
  mutate(dengue = 
           case_when(day_0_den_IgM  == "pos" & day_0_chik_IgM == "neg" ~ 1,
                     day_0_den_IgM  == "pos" & day_0_chik_IgM == "neg" & 
                       day_0_den_IgG  == "pos" & day_0_chik_IgG == "neg" ~ 1,
                     day_0_den_IgM  == "pos" & day_0_chik_IgM == "neg" & 
                       (
                         (day_0_den_IgG  == "pos" & day_0_chik_IgG == "pos") |
                           day_0_den_IgG  == "neg" & day_0_chik_IgG == "neg"
                       ) & day_0_den_IgM_OD > day_0_chik_IgM_OD ~ 1,
                     day_28_den_IgM  == "pos" & day_28_chik_IgM == "neg" ~ 1,
                     day_28_den_IgM  == "pos" & day_28_chik_IgM == "neg" & 
                       day_28_den_IgG  == "pos" & day_28_chik_IgG == "neg" ~ 1,
                     day_28_den_IgM  == "pos" & day_28_chik_IgM == "neg" & 
                       (
                         (day_28_den_IgG  == "pos" & day_28_chik_IgG == "pos") |
                           day_28_den_IgG  == "neg" & day_28_chik_IgG == "neg"
                       ) & day_28_den_IgM_OD > day_28_chik_IgM_OD ~ 1,
                     is.na(day_28_den_IgM) & is.na(day_0_den_IgM) ~ NA_real_,
                     TRUE ~ 0
           ),
         chik = 
           case_when(day_0_chik_IgM  == "pos" & day_0_den_IgM == "neg" ~ 1,    
                     day_0_chik_IgM  == "pos" & day_0_den_IgM == "neg" & 
                       day_0_chik_IgG  == "pos" & day_0_den_IgG == "neg" ~ 1,
                     day_0_chik_IgM  == "pos" & day_0_den_IgM == "neg" & 
                       (
                         (day_0_chik_IgG  == "pos" & day_0_den_IgG == "pos") |
                           day_0_chik_IgG  == "neg" & day_0_den_IgG == "neg"
                       ) & day_0_chik_IgM_OD > day_0_den_IgM_OD ~ 1,
                     day_28_chik_IgM  == "pos" & day_28_den_IgM == "neg" ~ 1,    
                     day_28_chik_IgM  == "pos" & day_28_den_IgM == "neg" & 
                       day_28_chik_IgG  == "pos" & day_28_den_IgG == "neg" ~ 1,
                     day_28_chik_IgM  == "pos" & day_28_den_IgM == "neg" & 
                       (
                         (day_28_chik_IgG  == "pos" & day_28_den_IgG == "pos") |
                           day_28_chik_IgG  == "neg" & day_28_den_IgG == "neg"
                       ) & day_28_chik_IgM_OD > day_28_den_IgM_OD ~ 1,
                     is.na(day_28_chik_IgM) & is.na(day_0_chik_IgM) ~ NA_real_,
                     TRUE ~ 0
           ),
         bact_target_pcr = case_when(array_card_klebsiella.pneumoniae ~ 1,
                                     array_card_enterobacter.cloacae ~ 1,
                                     array_card_enterobacteria ~ 1,
                                     array_card_pan.strep ~ 1,
                                     array_card_strep.pneumo ~ 1,
                                     array_card_pseudomonas.aeruginosa ~ 1,
                                     array_card_salmonella.hilA ~ 1,
                                     !is.na(array_card_klebsiella.pneumoniae) ~ 0,
                                     TRUE ~ NA_real_
         ),
         lepto = case_when(day_0_lepto_IgM == "pos" ~ 1,
                           day_28_lepto_IgM == "pos" ~ 1,
                           is.na(day_0_lepto_IgM) & is.na(day_28_lepto_IgM) ~ NA_real_,
                           TRUE ~ 0),
         SF = case_when(day_28_SF_IgM == "pos" ~ 1,
                        is.na(day_28_SF_IgM)  ~ NA_real_,
                        TRUE ~ 0),
         ET = case_when(day_28_ET_IgM == "pos" ~ 1,
                        is.na(day_28_SF_IgM)  ~ NA_real_,
                        TRUE ~ 0),
         borrelia = as.numeric(array_card_pan.borrelia),
         rift_valley_fever = as.numeric(array_card_RVF)
  ) %>%
  select(pid.corrected, 
         dengue,
         chik,
         bact_target_pcr,
         lepto,
         SF,
         ET,
         borrelia,
         rift_valley_fever) -> aetiol.sera

# other aetiol data wide - make one big df ----------------------------


left_join(
  (aetiol %>% 
     pivot_wider(id_cols = c(pid, hivstatus),
                 names_from = type,
                 values_from = pathogen)),
  aetiol.sera,
  by = c("pid" = "pid.corrected")) %>% 
  mutate(
    tb = case_when(
      `mtb bsi` ==  1 ~ 1,
      Xpert ==1 ~ 1, 
      uLAM ==1 ~ 1,
      is.na(`mtb bsi`) & is.na(Xpert) & is.na(uLAM) ~ NA_real_,
      TRUE ~ 0),
    bsi = case_when(
      bc == 1 ~ 1,
      bact_target_pcr == 1 ~ 1,
      is.na(bc) & is.na(bact_target_pcr) ~ NA_real_,
      TRUE ~ 0)
  ) -> aetiol.all


left_join(aetiol.all,
          select(bc.full, pid,crne) %>% unique(),
          by = "pid") %>%
  left_join( select(csf.full, pid, CrAg_LFA) %>% unique(),by = "pid") %>%
  mutate(bsi.bacterial = case_when(bsi == 1 & crne == 0 ~ 1,
                                   bsi == 1 & crne == 1 ~ 0,
                                   bsi == 0 ~ 0,
                                   TRUE ~ NA_real_),
         bsi.fungal = case_when(bsi == 1 & crne == 0 ~ 0,
                                bsi == 1 & crne == 1 ~ 1,
                                bsi == 0 ~ 0,
                                TRUE ~ NA_real_),
         csf.fungal = case_when(csf == 1 ~ 1,
                                csf == 0 ~ 0,
                                TRUE ~ NA_real_),
         csf.bacterial = case_when(csf == 0 ~ 0,
                                   csf == 1 ~ 0,
                                   TRUE ~ NA_real_),
         inv.bacterial = case_when(bsi.bacterial == 1 ~ 1,
                                   csf.bacterial == 1 ~ 1,
                                   bsi.bacterial == 0 ~ 0,
                                   csf.bacterial == 0 ~ 0),
         inv.fungal = case_when(bsi.fungal== 1 ~ 1,
                                csf.fungal == 1 ~ 1,
                                bsi.fungal == 0 ~ 0,
                                csf.fungal == 0 ~ 0),
         arbovirus = case_when(chik == 1 ~ 1,
                               dengue == 1 ~ 1,
                               chik == 0 ~ 0,
                               dengue == 0 ~ 0,
                               TRUE ~ NA_real_),
         ricks = case_when(ET == 1 ~ 1,
                           SF == 1 ~ 1,
                           ET == 0 ~ 0,
                           SF == 0 ~ 0,
                           TRUE ~ NA_real_),
         CrAg_LFA = case_when(CrAg_LFA == "POSITIVE" ~ 1,
                              CrAg_LFA == "NEGATIVE" ~ 0,
                              TRUE ~ NA_real_)
  ) -> aetiol.all

# and make the df for modelling



left_join(
  left_join(
    e1 %>% 
      mutate(gcs = t0gcse + t0gcsv + t0gcsm) %>% 
      select(pid, ustand, calc_age, ptsex, hivstatus, CD4_Absolute, Haemoglobin,
             screentemp, t0sbp, t0dbp, t0hr, t0rr, t0spo2,
             gcs, ustand, lactate_value, WCC, Platelets, CO2,
             Urea, Creatinine, NA.),
    aetiol.all %>%
      select(pid, malaria, dengue, chik,arbovirus,bc,
             bact_target_pcr, inv.bacterial, inv.fungal, tb),
    by = "pid"
  ),
  visits %>%
    select(pid, d28_death), 
  by = "pid"
) -> df.mod

# If you wanna rerun mort models and impute missing data, run this script ----
# Takes a while! --

#source("mortmodels_final.R")

# make v1 df for KMs

v1 <- filter(visits, arm == 1)
v1$died <- as.numeric(v1$died)
v1 <- left_join(v1, select(e1, pid, hivstatus))

e1 %>% 
  mutate(
    gcs = t0gcse + t0gcsv + t0gcsm,
    hivstatus = if_else(hivstatus == "Unknown", NA_character_, hivstatus)
  ) %>% 
  select(pid,
    calc_age,ptsex,
    hivstatus,CD4_Absolute, hivonart,  art.time, hivcpt,
    tbstatus, tbongoing,
    screentemp,t0hr,t0rr,t0sbp, t0dbp, t0spo2, gcs, ustand,
    datefirstunwell,
    Haemoglobin,Platelets, WCC, NA.,Potassium, CO2, Urea, Creatinine, lactate_value
  ) %>% 
  left_join(select(v1, pid, d28_death, d90_death, d180_death, t, died)) %>% 
  rename_with( ~tolower(gsub("\\.", "_", .x))) %>% 
  rename("sodium" = "na_",
         "days_unwell" = "datefirstunwell",
         "ever_tb" = "tbstatus",
         "lactate" = "lactate_value"
         )-> dat

BTparticipants <- dat

use_data(BTparticipants, overwrite = TRUE)

### treatments -------------------------------------------------------

df.abs %>% 
  select(pid,time_to_abx, first_ab) %>% 
  mutate(
    first_ab = case_when(
      first_ab == "cipro" ~ "Ciprofloxacin",
      first_ab == "AUGMENTIN" ~ "Co-amoxiclav",
      TRUE ~ first_ab
    ),
    first_ab = str_to_title(first_ab)
  ) %>% 
  rename("which_ab"= "first_ab",
         "timeto_ab" = "time_to_abx") %>% 
  left_join(
    select(df.fung, pid,time_to_fung_rx, first_ab) %>% 
      mutate(
        first_ab = case_when(
          first_ab == "fluco" ~ "Fluconazole",
          TRUE ~ first_ab
        ),
        first_ab = str_to_title(first_ab)
      ) %>% 
      rename("which_antifungal" = "first_ab",
             "timeto_antifungal" = "time_to_fung_rx"), 
    by = "pid"
  ) %>% 
  left_join(
    select(df.mal, pid, time_to_mal_rx, first_ab) %>% 
      mutate(
        first_ab = case_when(
          first_ab == "LA" ~ "Lumefantrine-artemether",
          TRUE ~ first_ab
        ),
        first_ab = str_to_title(first_ab)
        ) %>%
      rename("which_antimalarial" = "first_ab",
             "timeto_antimalarial" = "time_to_mal_rx"),
    by = "pid"
  ) %>% 
  left_join(
    df.tb %>%
      mutate(first_ab = case_when(
        any_tb_rx == "yes" ~ "RHZE",
        TRUE ~ NA_character_
      )) %>%
      filter(!is.na(first_ab)) %>% 
      select(pid, first_ab, time_to_tb_rx) %>% 
      rename("which_antitb" = "first_ab",
             "timeto_antitb" = "time_to_tb_rx"),
    by = "pid"
  ) %>% 
  left_join(
    select(fluid, pid, `6`) %>% 
      rename("iv_fluid_6hr" = `6`),
    by = "pid"
  ) %>% 
  mutate(across(contains("timeto"), as.numeric)) %>% 
  mutate(which_ab = if_else(which_ab == "None", NA_character_, which_ab))->
  BTtreatment
  
use_data(BTtreatment, overwrite = TRUE)

# general aetiology -------------------------------------------------------

aetiol.all %>% 
  select(-c(csf, crne, bc, bsi)) ->
  BTaetiology
 
use_data(BTaetiology, overwrite = TRUE) 

# bloodculture --------------------------------------------------------------

bc.full %>% 
  select(-c(anycontam, n_contam, n_orgs, contam_only)) %>% 
  mutate(pathogen = as.numeric(pathogen),
         bcult = as.numeric(bcult)) %>% 
  rename("bcult_anygrowth" = "bcult") ->
  BTbc

use_data(BTbc)

# sera ---------------------------------------------------------------------

df.sera %>% 
  select(!contains("array_card") & !contains("day ") & !contains("Array ")) %>% 
  rename("pid" = "pid.corrected")->
  BTsera

use_data(BTsera, overwrite = TRUE)

# array card

df.sera %>% 
  select(contains("pid") | contains("array_")) %>% 
  rename("pid" = "pid.corrected")->
  BTarraycard

use_data(BTarraycard)

# 


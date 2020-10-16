
#' BTparticipants
#'
#'  225 adults with sepsis in Blantyre, Malawi
#'
#'  Demographics, vitals, investigations, and outcome for 225 adults with sepsis in Blantrye, Malawi. Missing data given by NA in all cases.
#'

#' @format A data frame with 225 rows and 22 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{calc_age}{Age in years at enrollment}
#'  \item{ptsex}{Gender one of (male,female)}
#'  \item{hivstatus}{HIV status one of (Non reactive, Reactive)}
#'  \item{cd4_absolute}{CD4 cell count in cells per microlitre}
#'  \item{hivonart}{For HIV infected participants, whether currently taking antiretroviral therapy. One of (Yes, No)}
#'  \item{art_time}{Number of months on antiretroviral therapy}
#'  \item{hivcpt}{For HIV infected participants, whether currently taking co-trimoxazole preventative therapy. One of (Yes, No)}
#'  \item{ever_tb}{Ever been treated for TB? One of (Yes, No)}
#'  \item{tbongoing}{Currently being treated for TB? One of (Yes, No)}
#'  \item{screentemp}{Temperature in degrees celsius at recruitment}
#'  \item{t0hr}{Heart rate in beats per minute at recruitment}
#'  \item{t0sbp}{Systolic blood pressure at recruitment in mmHg}
#'  \item{t0dbp}{Diastolic blood pressure at recruitment in mmHg}
#'  \item{gcs}{Glasgow coma score at recruitment}
#'  \item{ustand}{Unable to stand at recruitment}
#'  \item{days_unwell}{Length of current illness in days}
#'  \item{haemoglobin}{Haemoglobin in g/dL at recrutment}
#'  \item{platelets}{Platelet count in cells x 10^9/L at recruitment}
#'  \item{wcc}{White cell count in cells x 10^9/L at recruitment}
#'  \item{sodium}{Serum sodium in mmol/L at recruitment}
#'  \item{potassium}{Serum potassium in mmol/L at recruitment}
#'  \item{co2}{Serum bicarbonate in mmol/L at recruitment}
#'  \item{urea}{Serum urea in mmol/L at recruitment}
#'  \item{creatinine}{Serum creatinine in mmol/L at recruitment}
#'  \item{lactate}{Serum lactate in mmol/L at recruitment}
#'  \item{urea}{Serum urea in mmol/L at recruitment}
#'  \item{dxx_death}{Death by xx days, 1 = died, 0 = survived}
#'  \item{t}{Follow up time in days}
#'  \item{died}{Did participant die (1) or was alive (0) at the end of follow up time}
#' }
"BTparticipants"


#' BTaetiology
#'
#'  Aetiology of sepsis of 225 adults with sepsis in Blantyre, Malawi
#'
#'
#' @format A data frame with 225 rows and 24 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{hivstatus}{HIV status one of (Non reactive, Reactive, Unknown)}
#'  \item{mtb bsi}{M. tuberculosis cultured from blood? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{malaria}{Malaria? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{uLAM}{Positive uLAM result?  (1 = yes, 0 = no, NA = no valid result)}
#'  \item{Xpert}{Positive sputum Xpert? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{dengue}{Dengue diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{chik}{Chikungunya diagnosis as per case definition? Dengue diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{bact_target_pcr}{Pathogenic bacterial target found on PCR array card?  (1 = yes, 0 = no, NA = no valid result)}
#'  \item{lepto}{Leptospirosis diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{SF}{Spotted fever group Rickettsiosis diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{ET}{Epidemic Typhus diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{borrelia}{Borreliosis diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{rift_valley_fever}{Rift Valley fever diagnosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{CrAg_LFA}{Positive cryptococcal antigen lateral flow assay on CSF (1 = yes, 0 = no, NA = no valid result)}
#'  \item{bsi.bacterial}{Bacterial bloodstream infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{bsi.fungal}{Fungal bloodstream infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{csf.fungal}{Fungal meningitis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{csf.bacterial}{Bacterial meningitis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{inv.fungal}{Any invasive fungal infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{inv.bacterial}{Any invasive bacterial infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{tb}{Tuberculosis as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{arbovirus}{Any arboviral infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#'  \item{ricks}{Any rickettsial infection as per case definition? (1 = yes, 0 = no, NA = no valid result)}
#' }
"BTaetiology"

#' BTarraycard
#'
#'  Array card multiplex PCR results for 225 adults with sepsis in Blantyre, Malawi
#'
#'
#' @format A data frame with 225 rows and 12 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{array_card_xxx}{Was the target xxx identfied on array card testing? (TRUE = yes, FALSE = no, NA = no valid result)}

#' }
"BTarraycard"


#' BTbc
#'
#'  Aerobic blood culture results for 225 adults with sepsis in Blantyre, Malawi
#'
#'
#' @format A data frame with 225 rows and 22 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{lims_fe}{Sample identifier}
#'  \item{bcult_anygrowth}{Any growth on aerobic blood culture? (1 = yes, 0 = no)}
#'  \item{typhi}{Growth of Salmonella Typhi (1 = yes, 0 = no)}
#'  \item{saen}{Growth of Salmonella Enteritides (1 = yes, 0 = no)}
#'  \item{saty}{Growth of Salmonella Typhimurium (1 = yes, 0 = no)}
#'  \item{esco}{Growth of E. coli (1 = yes, 0 = no)}
#'  \item{klpn}{Growth of Klebsiella pneumoniae (1 = yes, 0 = no)}
#'  \item{hib}{Growth of Haemophilus influenzae (1 = yes, 0 = no)}
#'  \item{dip}{Growth of Diptheroids (1 = yes, 0 = no)}
#'  \item{bacillus}{Growth of Bacillus spp. (1 = yes, 0 = no)}
#'  \item{esco}{Growth of E. coli (1 = yes, 0 = no)}
#'  \item{stpn}{Growth of Streptococcus pneumoniae (1 = yes, 0 = no)}
#'  \item{crne}{Growth of Cryptococcus neoformans (1 = yes, 0 = no)}
#'  \item{ahaemstrep}{Growth of Alpha-haemolytic Streptococci other than Pneumococcus (1 = yes, 0 = no)}
#'  \item{acba}{Growth of Acinetobacter baumannii (1 = yes, 0 = no)}
#'  \item{enfam}{Growth of Enterococcus faecium (1 = yes, 0 = no)}
#'  \item{enfas}{Growth of Enterococcus faecalis (1 = yes, 0 = no)}
#'  \item{micr}{Growth of Micrococcus spp. (1 = yes, 0 = no)}
#'  \item{cons}{Growth of Coagulase-negative Staphylococcus (1 = yes, 0 = no)}
#'  \item{stau}{Growth of Staphyloccus aureus (1 = yes, 0 = no)}
#'  \item{prot}{Growth of Proteus mirabilis (1 = yes, 0 = no)}
#'  \item{pathogen}{Any pathogen identfied? (1 = yes, 0 = no)}
#'
#' }
"BTbc"


#' BTsera
#'
#'  Serology results for 225 adults with sepsis in Blantyre, Malawi
#'
#' @format A data frame with 224 rows and 29 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{dayxx_yyy_IgM}{Variable describes presence or absence (pos = detected, neg = not detected, NA = no valid result) of IgM for day xx samples for pathogen yyy where xx is (0 = day 0, 28 = day 28) and yyy is (den = Dengue, chick = Chikungunya, lepto = Leptospirosis, SF = Spotted fever group Rickettsioses, ET = Epidemic Typhus group Ricketssioses)}
#'  \item{dayxx_yyy_IgG}{Variable describes presence or absence (pos = detected, neg = not detected, no valid result) of IgM for day xx samples for pathogen yyy where xx is (0 = day 0, 28 = day 28) and yyy is (den = Dengue, chick = Chikungunya, lepto = Leptospirosis, SF = Spotted fever group Rickettsioses, ET = Epidemic Typhus group Ricketssioses)}
#'  \item{suffix_OD}{Numeric value of optical denisty of ELISA measurement}
#'  \item{suffix_dilution}{Dilution of EIA measurement }

#'
#' }
#'
#' Serum was missing for one participant wjo is excluded from these data
"BTsera"

#' BTtreatment
#'
#'  Treatments administered to 225 adults with sepsis in Blantyre, Malawi
#'
#' @format A data frame with 224 rows and 10 variables:
#' \describe{
#'  \item{pid}{Study identifier}
#'  \item{timeto_ab}{Time from ED enrollment to first administration of antibacterial agent in hours}
#'  \item{which_ab}{Name of antibacterial agent administered}
#'  \item{timeto_antifungal}{Time from ED enrollment to first administration of antifungal agent in hours}
#'  \item{which_antifungal}{Name of antifungal agent administered}
#'  \item{timeto_antimalarial}{Time from ED enrollment to first administration of antimalarial agent in hours}
#'  \item{which_antimalarial}{Name of antimalarial agent administered}
#'  \item{timeto_antitb}{Time from ED enrollment to first administration of antituercular  agent in hours}
#'  \item{which_antitb}{Name of antitubercular agent(s) administered}
#'  \item{iv_fluid_6hr}{Volume of intravenous fluid administered in the 6 hours from ED enrollment }
#'
#' }
"BTtreatment"


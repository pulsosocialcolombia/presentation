library(pulsosocialcolombia)
library(here)
library(googlesheets4)
library(tidyverse)

dic_map <-"https://docs.google.com/spreadsheets/d/1ZEqO-bYWPYixr2xI6fNeW4MCEeyZYqFoIRUKllhbeU8/edit?usp=sharing"

#### Get the file
codvars <-  read_sheet(dic_map, sheet = "Vars", col_names = TRUE)

# for (i in c(286)){
for (i in codvars$var_id) {

  # i <- 46
  # graph options
  w <- 7*1.5
  h <- 4*1.5
  dpi <- 300

  d <- codvars[codvars$var_id==i,]
  print(i)

  ### Trend
  if (d$fig_trend==1) {
    fl <- paste0(here(),"/img/","var_",d$var_id,"_trend",".png", sep="")
    try(ggsave(fl,print(pulso_trend(i,"print")),dpi = dpi, width = w, height = h))
  }

  #### Static
  niveles <- c("etnia", "gen", "edad", "grupo", "tipo")
  niv <- gsub(".*_", "", unique(d$id_nivel))
  
  if(str_detect(niv, paste(niveles, collapse = "|"))){
    fl <- paste0(here(),"/img/","var_",d$var_id,"_static",".png", sep="")
    try(ggsave(fl,print(pulso_static(i,"print")), dpi = dpi*1.2, width = w*1.2, height = h*1.3))
  } else {
    fl <- paste0(here(),"/img/","var_",d$var_id,"_static",".png", sep="")
    try(ggsave(fl,print(pulso_static(i,"print")),dpi = dpi, width = w, height = h))
  }

  #### Map
    if (d$fig_map==1) {
      fl <- paste0(here(),"/img/","var_",d$var_id,"_map",".png", sep="")
      try(ggsave(fl,print(pulso_map(i,"print")),dpi = dpi, width = w, height = h))
    }

    #### Map change
    if (d$fig_map==1 & d$fig_trend==1) {
      fl <- paste0(here(),"/img/","var_",d$var_id,"_map_change",".png", sep="")
      try(ggsave(fl,print(pulso_map_change(i,"print")),dpi = dpi, width = w, height = h))
    }

  ### Scatter (level)
    if(d$fig_scatter==1){
      fl <- paste0(here(),"/img/","var_",d$var_id,"_scatter",".png", sep="")
      try(ggsave(fl,print(pulso_scatter(i,"print")),dpi = dpi, width = w, height = h))
    }

  ### Scatter (time)
    if (d$fig_scatter_time==1){
      fl <- paste0(here(),"/img/","var_",d$var_id,"_scatter_time",".png", sep="")
      try(ggsave(fl,print(pulso_scatter_time(i,"print")),dpi = dpi, width = w, height = h))
    }
}


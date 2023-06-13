#### IMPORTING DATASETS ####
### Packages ###
# create notin operator
`%notin%` <- Negate(`%in%`)
# Download packages if not available
pckgs <- c("tidyverse", "data.table", "mgsub")
invisible(sapply(pckgs, FUN = require, character.only = TRUE))

### Import one by one ###
sample_dat_1 <- fread(file = "sample_dat_1.csv")
sample_dat_2 <- fread(file = "sample_dat_2.csv")
sample_dat_3 <- fread(file = "sample_dat_3.csv")
sample_dat_4 <- fread(file = "sample_dat_4.csv")

### Import all together ###
# list files in working directory #
list.files()

# list of csv files #
CSVfiles <- list.files(pattern="\\.csv$", full.names = TRUE)

# list variable names #
dataframe_names <- mgsub(CSVfiles, c("./",".csv"), c("",""))
# or using str_replace_all
# CSVfiles %>% str_replace_all(c(".csv" = "", "./" = ""))

# Option # 1: List + For Loop
dat <- list()
for(x in unique(CSVfiles)){
	dat[[x]] <- fread(x)
}
dat <- dat %>% set_names(dataframe_names)

# Option # 2: lapply
dat <- 
lapply(CSVfiles, FUN = function(x) fread(x))%>% 
set_names(dataframe_names)

# Option # 3: map
dat <- 
CSVfiles %>% 
map(fread) %>% 
set_names(dataframe_names)

### Putting it all together ###
# copy the contents of the list to the environment 
invisible(list2env(dat ,.GlobalEnv))

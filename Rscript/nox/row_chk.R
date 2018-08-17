library(data.table)
library(dplyr)

nox_samp_data <- fread("./data/nox_sample_01.csv", header = F, sep = ",", data.table = F, encoding="UTF-8")
View(nox_samp_data)

lst <- list.files("./data")
lst[1]

charmatch("",nox_samp_data[,1])

col_num <- charmatch("時間",nox_samp_data[3,])

if(is.na(col_num) == F){
  col_01 <- nox_samp_data[5:18885,col_num] %>% sapply(as.numeric) %>% as.vector()
} else {
  col_01 <- c(rep("", 18881))
}

start_row <- charmatch("時間",nox_samp_data[,1]) + 2

end_row <- NULL
for(row in 5:nrow(nox_samp_data)){
  if(nox_samp_data[row,1] != ""){
  } else {
    end_row <- row-1
    break
  }
}
start_row
end_row

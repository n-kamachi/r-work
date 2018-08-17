library(data.table)
library(dplyr)

options(digits = 20)

data_path <- "./data/"
in_path <- "./in/"
out_path <- "./out/"

file_list <- list.files(data_path)

column_list <- fread(paste0(in_path,"uniq_label_list.csv"), header = T, sep = ",", data.table = F, encoding = "UTF-8")
column_vec <- column_list$label %>% as.vector()

length(column_vec)

for(file in 1:length(file_list)){
  tmp_data <- fread(paste0(data_path,file_list[file]), header = F, sep = ",", data.table = F, encoding = "UTF-8")
  tmp_df <- data.frame(file_name=rep(file_list[file],18881))
  
  for(label in 1:length(column_vec)){
    col_position <- charmatch(column_vec[label],tmp_data[3,])
    
    if(is.na(col_position) == F){
      col_val_vec <- tmp_data[5:18885,col_position] %>% sapply(as.numeric) %>% as.vector()
    } 
    else{
      col_val_vec <- rep("",18881)
    }
    tmp_df <- data.frame(tmp_df,col_val_vec)
    
    colnames(tmp_df)[label+1] <- column_vec[label]
    
  }
  write.csv(tmp_df, paste0(out_path, "load_", file_list[file]), row.names = F, quote = F, fileEncoding = "UTF-8")
}

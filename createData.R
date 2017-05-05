library(extrafont)
font_import()
library(selectr)
library(rvest)
library(ggplot2)

url<-"https://namu.wiki/w/%ED%98%84%EB%8C%80%20%ED%95%9C%EA%B8%80%EC%9D%98%20%EB%AA%A8%EB%93%A0%20%EA%B8%80%EC%9E%90"
allt <- read_html(url) %>% html_nodes("div p a") %>% html_text
allt <- allt[55:(length(allt)-7)]


for (i in 1:length(allt)){
  for (j in 1:nrow(fonttable())){
    print(paste0(i ," / ",length(allt),"  --  ",j ," / ",nrow(fonttable())))
    text = allt[i]
    fam = fonttable()[j,5]
    ff = "plain"
    if(fonttable()[j,7]){ff = "bold"}
    if(fonttable()[j,8]){ff = "italic"}
    if(fonttable()[j,7]&fonttable()[j,8]){ff = "bold.italic"}
    ggplot() + 
      annotate("text", x = 0, y = 0, size=8, label = text, family=fam, fontface=ff) + 
      theme_bw() +
      theme_void() +
      theme(panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            legend.position = "none")

    dir.create(sprintf("./data/f%05d",i),showWarnings = F)
    fn<-paste0("./data/f",sprintf("%05d",i),"/t",sprintf("%05d",i),"_",gsub(" ","-",fonttable()[j,4]),".png")
    ggsave(file = fn,width=10,height=10,units="mm")
  }
}


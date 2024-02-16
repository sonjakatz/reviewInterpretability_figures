##### Tutorial: https://krassowski.github.io/complex-upset/articles/Examples_R.html

library(dplyr)
library(tidyverse)
library(ggplot2)
library(ComplexUpset)
#install.packages("ComplexUpset")
#library(UpSetR)


setwd("/home/sonja/PROJECTS/review_interpretability/table")

### Read and prep data
df = read_csv("data/data_types_expanded.csv")
datatypes = colnames(df)[2:length(df)]
df[datatypes] = df[datatypes] == 1

### Basic
(
  upset(
    df, datatypes, name='datatypes', width_ratio=0.1, height_ratio=1,
    set_sizes=(
      upset_set_size()
      + theme(axis.ticks.x=element_line())
    ),
    stripes='white'
  ) + 
    ggtitle('Combination of datatypes')
  & theme(plot.background=element_rect(fill='transparent', color=NA))
)


### Percentage and sorting - v1
#svg(file="figures/upset_datatypes.svg", width=11, height=7) #, unit="in"
(
  upset(
    df, datatypes, name='datatypes', width_ratio=0.1, height_ratio=1,
    sort_intersections_by=c("degree"),
    sort_intersections='ascending',
    set_sizes=(
      upset_set_size()
      + theme(axis.ticks.x=element_line())
    ),
    stripes='white'
  ) + 
    ggtitle('Combination of datatypes')
  & theme(plot.background=element_rect(fill='transparent', color=NA))
)
#dev.off()



###############################################################################################################################################################################
###############################################################################################



### Merging labels - v2
svg(file="figures/upset_datatypes.svg", width=12, height=7) #, unit="in"
(
  upset(
    df, datatypes, name='datatypes', width_ratio=0.1, height_ratio=1,
    #sort_intersections_by=c("degree"),
    sort_intersections='descending',
      encode_sets=FALSE,  # for annotate() to select the set by name disable encoding
    set_sizes=(
      upset_set_size()
      + geom_text(aes(label=..count..), hjust=1.1, stat='count')
      # you can also add annotations on top of bars:
      + annotate(geom='text', label='@', x='', y=80, color='white', size=3)
      #+ expand_limits(y=70)
      + theme(axis.text.x=element_text(angle=90))),
    stripes='white'
  ) + 
    ggtitle('Combination of datatypes')
  & theme(plot.background=element_rect(fill='transparent', color=NA))
)
dev.off()




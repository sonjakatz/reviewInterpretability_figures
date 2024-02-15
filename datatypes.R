##### Tutorial: https://krassowski.github.io/complex-upset/articles/Examples_R.html

library(dplyr)
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


### Percentage and sorting
svg(file="figures/upset_datatypes.svg", width=11, height=7) #, unit="in"
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
dev.off()



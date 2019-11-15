# define a nice ggplot2 theme
theme_nice <- theme_classic() +
  theme(axis.text.x = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title.y = element_text(size = 14))

theme_bottom <- theme_classic() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title.y = element_text(size = 14))

theme_no_legend <- theme_classic() +
  theme(legend.position = "none",
        axis.text.x = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title.y = element_text(size = 14))

# define a nice scale theme
scale_nice <- list(
  scale_x_discrete(labels = c("False", "True", "NA"),
                               breaks = c("FALSE", "TRUE", NA)),
  scale_fill_manual(name = "Victimization",
                    values = c("#F7AE28", "#4A6FA5"),
                    labels = c("False", "True"),
                    na.value = "grey"))

scale_relation <- list(
  scale_x_discrete(labels = c("Single", "In Relation", "NA"),
                   breaks = c("FALSE", "TRUE", NA)),
  scale_fill_manual(name = "Victimization",
                    values = c("#F7AE28", "#4A6FA5"),
                    labels = c("False", "True"),
                    na.value = "grey"))

scale_religion <- list(
  scale_x_discrete(labels = c("No Belief", "Religious", "NA"),
                   breaks = c("FALSE", "TRUE", NA)),
  scale_fill_manual(name = "Victimization",
                    values = c("#F7AE28", "#4A6FA5"),
                    labels = c("False", "True"),
                    na.value = "grey"))

# extract legend
Glegend <- function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}


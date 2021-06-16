########################
## Update Venn diagrams
## Chi-Lam Poon
## June 2021
########################

library(eulerr)

# Figure 2
cvd.venn <- euler(c("Adipose - Visceral" = 95, "Artery - Tibial" = 117, 
                    "Brain - Caudate" = 19, "Brain - Spinal cord" = 485, 
                    "Adipose - Visceral&Artery - Tibial" = 2,
                    "Adipose - Visceral&Brain - Spinal cord" = 3,
                    "Artery - Tibial&Brain - Spinal cord" = 5,
                    "Brain - Caudate&Brain - Spinal cord" = 27,
                    "Brain - Caudate&Artery - Tibial" = 1,
                    "Brain - Caudate&Brain - Spinal cord&Artery - Tibial" = 1), shape = "ellipse")
plot(cvd.venn, quantities = list(fontface = 1),
     fill = RColorBrewer::brewer.pal(4, "Set3"),
     lty=0, alpha=0.6)

md.venn <- euler(c("Brain - Putamen" = 28, "Brain - Hypothalamus" = 53, "Brain - Spinal cord" = 14, 
                    "Brain - Putamen&Brain - Hypothalamus" = 0, "Brain - Putamen&Brain - Spinal cord" = 0,
                    "Brain - Hypothalamus&Brain - Spinal cord" = 0,
                    "Brain - Hypothalamus&Brain - Spinal cord&Brain - Putamen" = 0))
plot(md.venn, quantities = list(fontface = 1),
     fill = c("#E5C494", "#B3B3B3","#FB8072"),
     lty=0, alpha=0.6)


# Supplementary S5
do.up <- euler(c("Adipose - Visceral" = 1, "Artery - Tibial" = 9, 
                 "Brain - Caudate" = 12, "Brain - Spinal cord" = 49, 
                 "Artery - Tibial&Brain - Caudate" = 1,
                 "Artery - Tibial&Brain - Spinal cord" = 20,
                 "Brain - Caudate&Brain - Spinal cord" = 41,
                 "Artery - Tibial&Brain - Caudate&Brain - Spinal cord" = 66,
                 "Adipose - Visceral&Brain - Caudate&Brain - Spinal cord&Artery - Tibial" = 6), shape = "ellipse")
plot(do.up, quantities = list(fontface = 1),
     fill = RColorBrewer::brewer.pal(4, "Set3"),
     lty=0, alpha=0.6)

do.down <- euler(c("Adipose - Visceral" = 7, "Artery - Tibial" = 7, 
                  "Brain - Spinal cord" = 1,
                  "Adipose - Visceral&Brain - Caudate" = 2,
                  "Adipose - Visceral&Brain - Spinal cord" = 1))
plot(do.down, quantities = list(fontface = 1),
     fill = RColorBrewer::brewer.pal(4, "Set3"),
     lty=0, alpha=0.6)

hpo.up <- euler(c("Adipose - Visceral" = 17, "Artery - Tibial" = 16, 
                  "Brain - Caudate" = 208, "Brain - Spinal cord" = 112,
                  "Adipose - Visceral&Artery - Tibial" = 1,
                  "Adipose - Visceral&Brain - Caudate" = 12,
                  "Adipose - Visceral&Brain - Spinal cord" = 1,
                  "Adipose - Visceral&Brain - Caudate&Brain - Spinal cord" = 21,
                  "Adipose - Visceral&Artery - Tibial&Brain - Caudate" = 2,
                  "Artery - Tibial&Brain - Caudate" = 6,
                  "Artery - Tibial&Brain - Spinal cord" = 16,
                  "Brain - Caudate&Brain - Spinal cord" = 133,
                  "Adipose - Visceral&Artery - Tibial&Brain - Spinal cord" = 3,
                  "Artery - Tibial&Brain - Caudate&Brain - Spinal cord" = 103,
                  "Adipose - Visceral&Brain - Caudate&Brain - Spinal cord&Artery - Tibial" = 26), shape = "ellipse")
plot(hpo.up, quantities = list(fontface = 1),
     fill = RColorBrewer::brewer.pal(4, "Set3"),
     lty=0, alpha=0.6)

hpo.down <- euler(c("Adipose - Visceral" = 127, "Artery - Tibial" = 476, 
                   "Adipose - Visceral&Artery - Tibial" = 1,
                   "Adipose - Visceral&Brain - Caudate" = 3))
plot(hpo.down, quantities = list(fontface = 1),
     fill = RColorBrewer::brewer.pal(4, "Set3"),
     lty=0, alpha=0.6)


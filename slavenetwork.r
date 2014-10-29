library(igraph)
library(dplyr)
library(tidyr)
library(stringr)
library(historydata)
library(sna)

slaverel <- read.csv("~//Desktop//slaveRelationships.csv")
str(slaverel)

cleanslaves <- read.csv("~//Desktop/cleanslaves.csv")
slave_census <- cleanslaves %>%
  select(id, Gender, Skill, Farm, Census, Owner)

slave_census_1786 <- slave_census %>%
  filter(Census == "1786")

slave_census_1799 <- slave_census %>%
  filter(Census == "1799")

slave_network <- slaverel %>%
  left_join(slave_census, by = "id")

slave_net_1786 <- slave_network %>%
  filter(Census == "1786") %>%
  select(id, id2, Relationship)

slave_net_1799 <- slave_network %>%
  filter(Census == "1799") %>%
  select(id, id2, Relationship)

slave_graph_1786 <- graph.data.frame(slave_net_1786, directed = "FALSE")

slave_graph_1799 <- graph.data.frame(slave_net_1799, directed = "FALSE")

plot(slave_graph_1786)

#1786
igraph.options(vertex.size=3, vertex.label=NA,
               edge.arrow.size=.5)
plot(slave_graph_1786)
plot(slave_graph_1786, layout=layout.circle)
plot(slave_graph_1786, layout=layout.fruchterman.reingold)

slave_vertex_1786 <- data_frame(name = V(slave_graph_1786)$name)
slave_vertex_1786 <- slave_net_1786 %>%
  left_join(slave_census_1786, by = "id")

V(slave_graph_1786)$shape <- ifelse(slave_vertex_1786$Gender == "Female", "circle", "square")
plot(slave_graph_1786)

E(slave_graph_1786)$color <- ifelse(E(slave_graph_1786)$Relationship == "Child",
                                    "orange", "gray")
plot(slave_graph_1786)

E(slave_graph_1786)$color <- ifelse(E(slave_graph_1786)$Relationship == "Spouse",
                                    "red", "gray")
plot(slave_graph_1786)

V(slave_graph_1786)$color <- ifelse(slave_vertex_1786$Farm) == "Mansion House", "purple" "gray")
plot(slave_graph_1786)

V(slave_graph_1786)$color <- ifelse(slave_vertex_1786$Farm == "Muddy Hole", "blue", "gray")
plot(slave_graph_1786)

V(slave_graph_1786)$color <- ifelse(slave_vertex_1786$Farm == "Dogue Run", "green", "gray")
plot(slave_graph_1786)

V(slave_graph_1786)$color <- ifelse(slave_vertex_1786$Farm == "Ferry Farm", "orange", "gray")
plot(slave_graph_1786)

V(slave_graph_1786)$color <- ifelse(slave_vertex_1786$Farm == "River Farm", "yellow", "gray")
plot(slave_graph_1786)

                                
#1799
igraph.options(vertex.size=3,
               edge.arrow.size=.5)
plot(slave_graph_1799)

slave_vertex_1799 <- data_frame(name = V(slave_graph_1799)$name)
slave_vertex_1799 <- slave_net_1799 %>%
  left_join(slave_census_1799, by = "id")

V(slave_graph_1799)$shape <- ifelse(slave_vertex_1799$Gender == "Female", "circle", "square")
plot(slave_graph_1799)

E(slave_graph_1799)$color <- ifelse(E(slave_graph_1799)$Relationship == "Child",
                                    "orange", "gray")
plot(slave_graph_1799)

E(slave_graph_1799)$color <- ifelse(E(slave_graph_1799)$Relationship == "Spouse",
                                    "red", "gray")
plot(slave_graph_1799)

V(slave_graph_1799)$color <- ifelse(slave_vertex_1799$Farm == "Mansion House", "purple", "gray")
plot(slave_graph_1799)

V(slave_graph_1799)$color <- ifelse(slave_vertex_1799$Farm == "Muddy Hole", "blue", "gray")
plot(slave_graph_1799)

V(slave_graph_1799)$color <- ifelse(slave_vertex_1799$Farm == "Dogue Run", "green", "gray")
plot(slave_graph_1799)

V(slave_graph_1799)$color <- ifelse(slave_vertex_1799$Farm == "Union Farm", "orange", "gray")
plot(slave_graph_1799)

V(slave_graph_1799)$color <- ifelse(slave_vertex_1799$Farm == "River Farm", "yellow", "gray")
plot(slave_graph_1799)









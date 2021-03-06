% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/select_edges_by_node_id.R
\name{select_edges_by_node_id}
\alias{select_edges_by_node_id}
\title{Select edges in a graph using node ID values}
\usage{
select_edges_by_node_id(graph, nodes, set_op = "union")
}
\arguments{
\item{graph}{a graph object of class
\code{dgr_graph} that is created using
\code{create_graph}.}

\item{nodes}{a vector of node IDs for the selection
of nodes present in the graph.}

\item{set_op}{the set operation to perform upon
consecutive selections of graph nodes. This can
either be as a \code{union} (the default), as an
intersection of selections with \code{intersect},
or, as a \code{difference} on the previous
selection, if it exists.}
}
\value{
a graph object of class \code{dgr_graph}.
}
\description{
Select edges in a graph object of class
\code{dgr_graph} using node ID values. All edges
associated with the provided nodes will be included
in the selection. If nodes have IDs that are
monotonically increasing integer values, then
numeric ranges can be provided for the selection.
}
\examples{
\dontrun{
library(magrittr)

# Create a graph with a tree structure that's
# 3 levels deep (begins with node `1`, branching
# by 3 nodes at each level); the resulting graph
# contains 13 nodes, numbered `1` through `13`
graph <-
  create_graph(graph_attrs = 'layout = twopi') \%>\%
  add_node("A") \%>\%
  select_nodes \%>\%
  add_n_nodes_from_selection(3, "B") \%>\%
  clear_selection \%>\%
  select_nodes("type", "B") \%>\%
  add_n_nodes_from_selection(3, "C") \%>\%
  clear_selection

# Create a graph selection by selecting edges
# associated with nodes `1` and `2`
graph \%<>\%
  select_edges_by_node_id(
    nodes = 1:2)

# Get the selection of edges
graph \%>\% get_selection
#> $edges
#> $edges$from
#> [1] "1" "1" "1" "2" "2" "2"
#>
#> $edges$to
#> [1] "2" "3" "4" "5" "6" "7"

# Perform another selection of nodes, this time
# with a neighborhood spanning 2 nodes from node `1`
graph \%<>\%
  clear_selection \%>\%
  select_edges_by_node_id(
    nodes = c(1, 2, 4))

# Get the selection of edges
graph \%>\% get_selection
#> $edges
#> $edges$from
#> [1] "1" "1" "1" "2" "2" "2" "4" "4" "4"
#>
#> $edges$to
#> [1] "2"  "3"  "4"  "5"  "6"  "7"  "11" "12" "13"

# Get a fraction of the edges selected over all
# the edges in the graph
graph \%>\%
{
  l <- get_selection(.) \%>\%
    unlist(.) \%>\%
    length(.) \%>\%
    divide_by_int(2)
  e <- edge_count(.)
  l/e
}
#> [1] 0.75
}
}


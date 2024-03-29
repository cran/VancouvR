% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets.R
\name{list_cov_datasets}
\alias{list_cov_datasets}
\title{Download the CoV open data catalogue}
\usage{
list_cov_datasets(
  trim = TRUE,
  apikey = getOption("VancouverOpenDataApiKey"),
  refresh = FALSE
)
}
\arguments{
\item{trim}{trim all NA columns, optional, defaul `TRUE`}

\item{apikey}{the CoV open data API key, optional}

\item{refresh}{refresh cached data, default `FALSE``}
}
\value{
tibble format data table output
}
\description{
Download the CoV open data catalogue
}
\examples{
# List and search available datasets
\dontrun{
list_cov_datasets()
}

}

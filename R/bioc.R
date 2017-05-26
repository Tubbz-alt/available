#' @rdname available_on_cran
#' @export
available_on_bioc <- function(name, repos = NULL, ...) {
  if (is.null(repos)) {
    if (requireNamespace("BiocInstaller")) {
      repos <- BiocInstaller::biocinstallRepos()
    } else {
      # Search on latest bioc release
      repos <- c(
        BioCsoft = "https://bioconductor.org/packages/release/bioc",
        BioCann = "https://bioconductor.org/packages/release/data/annotation",
        BioCexp = "https://bioconductor.org/packages/release/data/experiment",
        BioCextra = "https://bioconductor.org/packages/release/extra")
    }
  }
  bioc_names <- rownames(available_packages(repos = repos, ...))

  on_bioc <- tolower(name) %in% tolower(bioc_names)

  structure(!on_bioc, class = "available_bioc")
}

print.available_bioc <- function(x) {
  cat(crayon::bold("Available on Bioconductor:"), yes_no(x[[1]]), "\n")
}
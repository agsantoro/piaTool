library(glue)

generateRMD <- function(title, author, intro, outputFormat, plotChunk, tableChunk1, tableChunk2) {
  rmd_content <- glue::glue(
    "
    ---
    title: '{title}'
    author: '{author}'
    output: {outputFormat}
    ---
    
    # Introduction
    
    {intro}
    
    ## Plots
    
    ```{{r, echo = FALSE}}
    {plotChunk}
    ```
    
    ## Summary tables
    ### Inputs
    ```{{r, results='asis', echo = FALSE}}
    library(knitr)
    {tableChunk1}
    ```
    
    ### Outcomes
    ```{{r, results='asis', echo = FALSE}}
    library(knitr)
    {tableChunk2}
    ```
    "
  )
  
  # Write the R Markdown content to a file
  rmd_file <- "scenarioReport.Rmd"
  writeLines(rmd_content, rmd_file)
  
  # Render the R Markdown file
  rmarkdown::render(rmd_file)
  
  # Return the path to the rendered output file
  #return(rmarkdown::output_file(rmd_file))
}

# title <- "Scenario report"
# intro <- "This is a report"
# author <- "Prime tool"
# outputFormat <- "pdf_document"
# plotChunk <- 'plot1;plot2'
# 
# 
# plot1 = ggplot(data = iris, aes(x = Species, y = Petal.Width)) +
#   geom_violin()
# 
# 
# plot2 = ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, color = Species)) +
#   geom_point()
# 
# rendered_file <- generateRMD(title, author, intro, outputFormat, plotChunk)
# 


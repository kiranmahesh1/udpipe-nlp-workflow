#################################################
#         udpipe-nlp-workflow - Group Assignment                       #
#################################################

library("shiny")
library("tidytext")
library("tidyr")
library("dplyr")
library("ggplot2")
library("DT")
library("reshape2")
library("wordcloud")
library("plotly")
library("udpipe")
library("textrank")
library("lattice")
library("igraph")
library("ggraph")
library("ggplot2")
library("wordcloud")
library("stringr")

options(shiny.maxRequestSize=30*1024^2) 

#--------------------------------------------#

shinyServer(function(input, output,session) {
  set.seed=2092014   
  
  dataset <- reactive({
    if (is.null(input$file1)) {return(NULL)}
    else {
      Document = readLines(input$file1$datapath, encoding="UTF-8" ) #UTF-8 for hindi text handling
      Document  =  str_replace_all(Document, "<.*?>", "")
      return(Document)
      #return(head(Document))
      }
  })
  
  dataannotate <- reactive({
    if (is.null(input$file2)) {return(NULL)}
    else {
      Document2 = udpipe_load_model(input$file2$datapath)
      x <- udpipe_annotate(Document2, x = dataset())
      x <- as.data.frame(x)
      return(x)
      #return(head(x))
      }
  })
  
  
  # output$summary1 <- renderPrint({
  #   head(dataset())
  # })
  # 
  # output$summary2 <- renderPrint({
  #   head(dataannotate())
  # })
  
  output$plot1 <- renderPlot({
    upostags <- input$xposval
    sgram <- input$skipgram
    windowsFonts(devanew=windowsFont("Devanagari new normal"))
    data_cooc_skipgm <- cooccurrence(x = dataannotate()$lemma, 
                                     relevant = dataannotate()$upos %in% upostags, 
                                     skipgram = sgram)
    wordnetwork <- head(data_cooc_skipgm, 50)
    wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
    
    ggraph(wordnetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = paste("Cooccurrences within",sgram,"words distance"), subtitle = paste(input$xposval, collapse = ", ")) # To dynamically populate skip grams and XPOS tags
    
    #plotOutput(plotname, height = 800, width = 800)
  })
  
})

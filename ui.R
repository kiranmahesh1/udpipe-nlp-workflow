################################################################
#           udpipe-nlp-workflow - Group Assignment             #
################################################################

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

#--------------------------------------------#

shinyUI(fluidPage(
  
   
  
  titlePanel("UDPipe-NLP-Workflow - Group Assignment"),
  
  # Input in sidepanel:
  sidebarPanel(
    fileInput("file1", "Upload text file for UDPipe NLP workflow"),
    fileInput("file2", "Upload trained UDPile NLP model"),
    checkboxGroupInput("xposval", "XPOS Tags",selected = list("ADJ", "NOUN","PROPN"),
                       choiceNames =
                         list("adjective (ADJ)","noun(NOUN)" ,"proper noun (PROPN)","adverb (ADV)" ,"verb (VERB)"),
                       choiceValues =
                         list("ADJ", "NOUN","PROPN","ADV","VERB")),
    
    sliderInput("skipgram", "Skipgrams to be considered for co-occurrence plot:", min = 0,  max = 5, value = 3)
    
    # submitButton(text = "Apply Changes", icon("refresh"))
    
  ),
  
  # Main Panel:
  mainPanel( 
    
    
    tabsetPanel(type = "tabs",
                #
                tabPanel("Overview",h4(p("How to use this App")),
                         
                         p("This section holds the overview of the app and its usage.", align = "justify"),
                         
                         p("UDPipe provides the standard NLP functionalities of tagging, parsing and dependency evaluations - all within R.", align = "justify"),br(),br(),
                         h4(a(href="https://raw.githubusercontent.com/kiranmahesh1/udpipe-nlp-workflow/master/dependency-udpipe-nlp-workflow.R","Prerequisite packages")),
                         p("Load the prerequisite packages by running the source command and above URI in quotes."),br(),br(),
                        
                         h4(p("In left sidebar panel, upload the text document for UDPipe NLP workflow.")),
                         img(src = "text_file.jpg"),br(),br(),
                         
                         h4(p("Sample english text document below")),
                         downloadButton('downloadData1', 'txt document file'),br(),br(),
                         
                         h4(p("In left sidebar panel, also upload the respective trained UDPile NLP model")),
                         img(src = "udpipe_model.jpg"),br(),br(),
                         
                         p("In the left-side bar panel you can check the POSTags to be inclused in the cooccurances plot. By default selection: ", align = "justify"),
                         p("1. Adjective (ADJ)", align = "justify"),
                         p("2. Noun(NOUN)", align = "justify"),
                         p("3. Proper noun (PROPN)", align = "justify"),br(),br(),
                         
                         p("In the left-side bar panel you can also change the skip grams to be considered for cooccurances plot analysis. Default its set to 3 skip grams.", align = "justify"),
                         img(src = "skipgram.jpg"),br(),br(),
                         
                         h4(p("Note")),
                         p("Note: Plot rendering may take approximately 10 to 15 seconds depending the upload file size.")
                         
                       
                         ),
                
                tabPanel("Co-Occurrences - Plot",h4(),
                         # verbatimTextOutput('chk'),
                         # 
                         #verbatimTextOutput("summary1"),
                         #verbatimTextOutput("summary2"),
                         
                         plotOutput("plot1")
                         
                         # h4("Weights Distribution of Wordcloud"),
                         # verbatimTextOutput("dtmsummary1")
                         )
                
                #                         
                         )
                )
  
)
)

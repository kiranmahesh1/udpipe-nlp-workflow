#################################################
#           udpipe-nlp-workflow - Group Assignment             #
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

#--------------------------------------------#

shinyUI(fluidPage(
  
   
  
  titlePanel("UDPipe-NLP-Workflow - Group Assignment"),
  
  # Input in sidepanel:
  sidebarPanel(
    fileInput("file1", "Upload text file for UDPile NLP workflow"),
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
                         
                         p("This section holds the overview of the app and its usage. Sample code unchanged", align = "justify"),
                         
                         p("You can change the sentiment dictionary in left-sidebar panel. This app supports four inbuilt sentiment dictionaries and one user defined dictionary. If a user selects User Defined dictionary, then a browse file input will appear below sentiment dictionary drop-down in left-side-bar panel and user can upload the user defined dictionary. This user defined dictionary should be in csv format and first column of the dictionary should be word and second column should be score. You can download the sample user defined dictionary below.", align = "justify"),
                         a(href="http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010","1- Afinn"),
                         p("AFINN is a list of English words rated for valence with an integer between minus five (negative) and plus five (positive). The words have been manually labeled by Finn Arup Nielsen in 2009-2011."),
                      
                         a(href="https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html","2- Bing"),
                         p("This sentiment dictionary is created by Bing Liu and collaborators. In this dictionary, words are classified as positive or negative."),
                      
                         a(href="http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm","3- NRC"),
                         p("The NRC Emotion Lexicon is a list of English words and their associations with eight basic emotions (anger, fear, anticipation, trust, surprise, sadness, joy, and disgust) and two sentiments (negative and positive). The annotations were manually done by crowdsourcing."),
                      
                         a(href="http://www3.nd.edu/~mcdonald/Word_Lists.html","4- Loughran"),
                         p("This dictionary is created by Tim Loughran and Bill McDonald. In this dictionary each word is classified in financial context (uncertainty, litigious, constraining, superfluous, positive, negative)"),
                        
                         h4(p("Download Sample user defined dictionary file")),
                         downloadButton('downloadData3', 'Download User Defined Dictionary (works only in browser)'),br(),br(),
                         
                         p("In the left-side bar panel you can change the document index number and accordingly document level analysis will be updated in \"Document level Analysis\" tab", align = "justify"),
                         
                         p("If plots are not working in \"Sentiments - Plot\" tab then please install latest version of ggplot2. You can install ggplot2 by command - install.packages(\"ggplot2\")", align = "justify"),
                         h4(p("Download Sample text file")),
                         downloadButton('downloadData1', 'Download Nokia Lumia reviews txt file (works only in browser)'),br(),br(),
                         
                         p("Please note that download will not work with RStudio interface. Download will work only in web-browsers. So open this app in a web-browser and then download the example file. For opening this app in web-browser click on \"Open in Browser\" as shown below -"),
                         img(src = "example1.png")
                       
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

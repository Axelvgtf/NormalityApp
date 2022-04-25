#Author : NIERDING Axel - Date 20/04/2022
#NormalityApp - The easy way to check Distribution and Normality of your Data
#This Shiny app is designed to provide a quick and simple view of normality distribution of your data
library(rsconnect)
library(shiny)
library(shinythemes)
#This is file of the interface of the  Shiny App

shinyUI <- fluidPage(theme = shinytheme("slate"),#fluidPage corresponding to the structure of the app
                        tags$style(type="text/css",#This CSS code if to avoid the error message in the Shiny just after the upload of your Data file
                                   ".shiny-output-error { visibility: hidden; }",#Found this command on stackoverflow forum 
                                   ".shiny-output-error:before { visibility: hidden; }"#Found this command on stackoverflow forum 
                       ),
                        tags$head(
                            tags$style(HTML("hr {border-top: 3px solid #00f7ff;}"))#Corresponding to the blue line above the shapiro wilk test in CSS/HTML notation
                             
                        ),
                        titlePanel("NormalityApp - The easy way to check Distribution and Normality of your Data"),#Title of the app :)
                        sidebarLayout(#Create a layout with sidebar and main area
                            sidebarPanel(#defines the left part of the interface and containg input controls
                                fileInput("Data", "Choose CSV File",#Show indications 
                                          accept = c(#all files accepted by the app 
                                              "text/csv",
                                              "text/comma-separated-values,text/plain",
                                              ".csv")
                                ),
                                radioButtons('sep', 'Separator:',c(Comma=',',Semicolon=';',Tab='\t'),','),#Radiobuttons to choices the separator in your csv Data -> in comma by default
                                checkboxInput('header', 'Header', TRUE),#Checkbox of logical value such as an header on your data -> it's true by default
                                selectInput("Variable", "Select Variable for Testing",""),#Create a select list input control of your variable with the header of your csv file
                                checkboxInput('gv', 'Use Grouping Variable (Optional) ?', F),#Checkbox of logical value such as grouping variable on your data -> it's false by default
                                selectInput("GroupingVar", "Select Grouping Variable",""), #Create a select list input control of your grouping variable with the header of your csv file
                                
                              
                                hr(),#Call the blue line above Shapiro Wilk test 
                                h3(uiOutput("swpTest")),#h3 is HTML notation for the thickness of text
                               
                            ),
                            mainPanel(#Main Panel defines the right part of the interface and contain outputs
                                plotOutput("qqplot"),#Display the qqplot
                                plotOutput("dist"),#Display hist and density curve
                                
                                #dataTableOutput("DataTable"),# IMO it's not necessary 
                              
                            )
                        )
)

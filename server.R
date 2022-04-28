#Author : NIERDING Axel - Date 20/04/2022
#NormalityApp - The easy way to check Distribution and Normality of your Data

#Update 26/04/22 -> add another tab, change the theme of the app, add interactives plots

#This Shiny app is designed to provide a quick and simple view of normality distribution of your data


library(shiny)#launch Shiny package to launch the app
library(shinythemes)#launch shinythèmes package to input a new theme color in the app
library(tidyverse)#launch tidyverse package for organize your data and have a "pack" of good packages  
library(plotly)

server <- function(input, output, session) {# function to caracterize input and output parameters /  session is an environment that can be used to access information and functionality relating to curent session
    
    inFile <- reactive({#reactive is to focus on one part of the app to update (here is just for Data) and accelerate process by "memorize" input data
        inFile <- input$Data #inFile is stock by input argument of your Data
        req(inFile)#ensure that values are available in your Data
        read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)# Only csv because this is the most common file extension in the world
    })#put some arguments on your csv 
    
    observe({#Automatically re-execute function if you have news parameters
        updateSelectizeInput(#Update the change of variable
            session,#In your current session
            "Variable",#Name of input element of variable
            choices=names(inFile())#The name of your variable from your Data is transcript into application 
        )
    })
    
    observe({# Ibid 19
        updateSelectizeInput(#ibid 20
            session,#Ibid 21
            "GroupingVar",#Name of input element of grouping variable
            choices=names(inFile())# Ibid 23
        )
     }) 
    
    output$DataTable <- renderDataTable({#Output a DataTable with renDataTable function of the variable choosen ---- 
        as.data.frame(inFile(), options = list(autoWidth = T, scrollY = T))#Determine the variable choosen in the head of your csv file ----
        
    })
   
    output$Dist <- renderPlotly({#Output a plot with renderPlot function of the variable choosen
        
        
        if (input$gv) {#If you check grouping variable so the plot is...
                g<-ggplot(inFile(),aes_string(x=input$Variable)) + #aes_string is to output a character type 
                    geom_histogram(aes(y=..density..),color="blue", fill="gray") + #Histogram with superposition of density curve, color of hist is blue with gray into bars
                    geom_density(aes_string(fill=input$GroupingVar, alpha=.02)) +#Density is split into your differents gv, alpha is for transparency of the area under the density curve
                    theme_gray() + #This is the theme of ggplot, if you change it in theme_bw if you want
                    scale_alpha(guide = 'none') + #to delete alpha legend in the plot
                    ggtitle("Histogram and Density Estimation of variable into grouping variable ")
                ggplotly(g)#Title of plot
                #print(g)#Display the plot
                
                
                
                
           #If you don't check grouping variable so the plot is...
        } else {    g<-ggplot(inFile(),aes_string(x=input$Variable)) +#ibid 45
                    geom_histogram(aes(y=..density..), colour="red", fill="gray") + #ibid 46 but with red color
                    geom_density(alpha= .2, fill="blue") +# Density curve with blue shape for the selected variable (blue color and little more thickness than 54)
                    theme_gray() +#Ibid 48
                    ggtitle("Histogram and Density Estimation of variable")#Ibid 50
                    ggplotly(g)
                #print(g)#Ibid 51
                
                }
      
    })
    

   
    #output$downloadDistPlot2 <- downloadHandler( <--- I don't think it's necessary because of interactive plot
      #filename= function(){"Histogram.png"},
      #content = function(file){
        #ggsave(file, plot = last_plot() ,    device = "png")
        
        
        
        
     # })
   
    
    output$swpTest <- renderUI({#Output a plot with renderUI function (which is fast function on Shiny server) of the variable choosen
   
        Var <- inFile()[,input$Variable]#Put in "var" the values of the variable choosen from your Data file
        
        sw<-shapiro.test(Var)# This is a function to make a Shapiro-Wilk test to test the normality of the distribution 
        tags$div(# Tags is to put an HTML text in the app, div is to defines a section in the HTML part
            HTML("<strong>Shapiro-Wilk Test</strong>","<em>p</em>","- value =", format(sw$p.value,digits = 3)) #HTML to assess the result of the Shapiro-Wilk test on screen 
        )
    })
    
    
    
    output$QQplot <- renderPlotly({#Output a plot with renderPlot function of the variable choosen
      
        if (input$gv){#If you check grouping variable so the plot is...
            g<-ggplot(inFile(),aes_string(sample=input$Variable, color=input$GroupingVar)) +#Plot your variable into grouping variable choosen
                stat_qq() +# Produce quantile-quantile plot
                stat_qq_line()+#Compute the slope and intercept of the ligne coonecting the points at specified quartiles of the theoretical and sample distributions
            ggtitle("Normal Quantile-Quantile Plot of variable into grouping variable") +#Title of the plot
                labs(x = "Theoretical Quantiles", y = "Sample Quantiles")#Title of differents axis
                theme_gray() #Theme of the plot
                ggplotly(g) #<- interactive plot
            #print(g)#Display the plot <- not necessary because of interactive plot
            
            
        
    } else {  #If you don't check grouping variable so the plot is...   
             g<-ggplot(inFile(),aes_string(sample=input$Variable)) +#Ibid 81 but without grouping variable
                stat_qq() +#Ibid 82
                stat_qq_line(color="blue")+ #Ibid 83
                ggtitle("Normal Quantile-Quantile Plot of variable") +#Ibid 84
                 labs(x = "Theoritical Quantiles", y = "Sample Quantiles")#Ibid 85
                theme_gray() #Ibid 86
                ggplotly(g)#<- interactive plot
            #print(g)#Ibid 88 <- not necessary because of interactive plot
    
   
            }   
    })
    
    #output$downloadDistPlot <- downloadHandler( <--- I don't think it's necessary because of interactive plot
      #filename= function(){"QQplot.png"},
      #content = function(file){
       #ggsave(file, plot = last_plot(),    device = "png")
        
      #})
    
}


        
    
    

    


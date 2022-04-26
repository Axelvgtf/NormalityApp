# NormalityApp
## check distribution and normality of your data

You can use the application without R, here : https://axelvgtf.shinyapps.io/NormalityApp/

## Usage

This Shiny app is designed to provide a quick view of distribution and normality of your data. Moreover, this Shiny app is very easy to use.
![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/Dahsboard.png)

Simply upload your data (.csv file / text file), select separator, selselect the variable you wish to test, and the app will provide:
```
- The p-value of the Shaprio-Wilk test
- A visualization of the distribution density (`statdensity`)
- A normal quantile-quantile plot (`qqnorm`) with a reference line (`qqline`)
```

![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/View%20without%20gv.png)

If you have a grouping variable, check the box and select the grouping variable, and the app will provide :

```
- The p-value of the Shaprio-Wilk test
- A visualization of the distribution density (`statdensity`) splitted by grouping * variable in color-coded subset distributions
- A normal quantile-quantile plot (`qqnorm`) with a reference line (`qqline`) splitted by grouping variable in color-coded subset qqplot
```

![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/View%20with%20gv.png)


## Second Tab to visualise your data

The second tab is for visualise data and check values 

![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/Data%20Tab.png)


## Notes 

Plots are interactives, so you can save it into a folder as .png picture or check values if you want :

![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/Interactiv%20qqplot.png)

![](https://github.com/Axelvgtf/NormalityApp/blob/main/Pictures/Interactiv%20Hist.png)


Don't hesitate to tell me if you have any issues with the App or if you want help me to make it better 

Enjoy :)

-Axelvgtf

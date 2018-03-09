#https://rpubs.com/skydome20/R-Note4-Plotting_System

require(datasets)
head(airquality)
#
hist(x=airquality$Month,
    main="Histogram of Month",
    xlab="Month",
    ylab="Frequency"
    )

#
plot(x=airquality$Wind,            # X軸的值
     y=airquality$Temp,             # Y軸的值
     main="Month to Temperature",   # 圖片名稱
     xlab="Month(1~12)",            # X軸名稱
     ylab="Temperature(degrees F)") # Y軸名稱  

require(lattice)
head(airquality)
#
airquality$Month <- as.factor(airquality$Month)
#
histogram(x= ~ Ozone | Month,
          data=airquality,
          xlab="Ozone(ppb)",
          layout=c(7,1))

#
bwplot(x = Ozone ~ Month,      # 把Month放在X軸，Ozone放在Y軸
       data = airquality,     
       xlab = "Month"         
)



# 把Ozone放在x的值；當然，可以增加月份的條件( ~ Ozone | Month)
densityplot( ~ Ozone ,      
             data=airquality
)

#
cloud(x=Wind~Temp+Ozone | Month, 
      data=airquality         
)

#
xyplot(x=Wind~Temp,         # Wind放在Y軸，Temp放在X軸
       data=airquality,     
       group = Month,       # 根據Month，把資料點用顏色區分開來  
       
       # auto.key參數，表示設定標籤與其他資訊
       auto.key=list(space="top",          # 位置在上方 
                     columns=5,            # 1x5的方式呈現標籤
                     title="Month Labels", # 標籤名稱
                     cex.title=1)          # 標籤字體大小
)

#
qplot(x=Ozone,                      
      data=airquality,              
      geom="histogram",             # 圖形=histogram
      main = "Histogram of Ozone",  
      xlab="Ozone(ppb)",            
      binwidth = 25,                # 每25單位為一區隔
      fill= Month                   # 以顏色標註月份，複合式的直方圖
)

#
qplot(x=Temp,                               
      y=Ozone,                              
      data=airquality,                      
      geom="point",                         # 圖形=scatter plot
      main = "Scatter Plot of Ozone-Temp",  
      xlab="Temp",                          
      ylab="Ozone(ppb)",                    
      color= Month                          # 以顏色標註月份，複合式的散布圖
)

#
qplot(x=Temp,                             
      data=airquality,                     
      geom="density",        # 圖形=density
      xlab="Temp",                         
      color= Month           # 以顏色標註月份，複合式的機率密度圖
)

#
qplot(x=Month,                               
      y=Ozone,
      data=airquality,                     
      geom="boxplot",       # 圖形=boxplot
      xlab="Temp",                          
      color= Month          # 以顏色標註月份，複合式的合鬚圖
)

#
canvas <- ggplot(data=airquality)

#
canvas +
  # 以直方圖的圖形呈現資料
  geom_histogram(aes(x=Ozone,     # X 放Ozone
                     fill=Month   # 根據月份顯示不同的顏色   
  ) 
  )     

#
canvas +
  # 以直方圖的圖形呈現資料
  geom_histogram(aes(x=Ozone,
                     fill=Month)  # 以粉紅色填滿         
  ) +
  
  # 用facet()，分別各畫一張各月份的直方圖
  facet_grid(.~Month)   # 因為Month放在右邊，故圖片以水平方向呈現


#
# 準備畫布
ggplot(data=airquality) +   
  
  # 散布圖對應的函式是geom_point()
  geom_point(aes(x=Temp,  # 用aes()，描繪散布圖內的各種屬性
                 y=Ozone,
                 main="Scatter Plot of Ozone-Temp",
                 color=Month) 
  ) + 
  # 用geom_smooth()加上趨勢線
  geom_smooth(aes(x=Temp,
                  y=Ozone)) +
  
  # 用labs()，進行文字上的標註(Annotation)
  labs(title="Scatter of Temp-Ozone",
       x="Temp",
       y="Ozone") +
  
  # 用theme_bw(background white)，改變主題背景成白色
  # 更多背景設定： http://docs.ggplot2.org/current/ggtheme.html            
  theme_bw()          



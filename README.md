# Edge-Detection
## 使用方法
1. Sobel edge detection
2. 兩個Threshold: 一個upper_threshold，以及一個lower_threshold。當小於lower時，直接為0; 當大於upper時直接為255; 如果介於兩者之間，且周遭8塊有人是大於upper，則為255，否則為0。
3. Gaussian blur: 去除雜訊，其中使用sigma為模糊程度參數控制
4. histogram equalization: 這方法我覺得在這兩張圖中效果沒有很好，所以我在程式碼中comment掉了，如果需要，就把24行開始的comment拿掉就好。
    * 這部分因為當初研究上時間比較趕，所以沒有太仔細去做，也許做一些調整後效果會變好

* threshold跟sigma會因為每張圖不同，而有不同的配置，如何找到最好的選擇必須花時間下去找

## 程式碼執行方式
(1) 用matlab直接run就好
(2) 在程式碼第一行輸入圖片檔名(程式碼預設為airplane.jpg)

## 成果展示
原圖:  
![](airplane.jpg) ![](/spider.png)  
以下除了histogram equalization以外，上述功能都有用上
1. airplane: Sigma=5,TL=130, TH=150; 
左圖未使用threshold，右圖有使用threshold。可以決定要有雲還是沒有雲

![](https://i.imgur.com/4gBXJF3.png)![](https://i.imgur.com/jwr2ptH.png)

2. spider: Sigma=3,TL=120, TH=150;
左圖未使用threshold，右圖有使用threshold。可以決定有影子還是沒影子
![](https://i.imgur.com/rEQHevg.png)![](https://i.imgur.com/ztRCQWe.png)

# 매수 매도 전략 Ver 0.00
<img src="https://user-images.githubusercontent.com/55151796/111038124-a3890d80-846a-11eb-8bd8-f258c7b339aa.png">

## 매수 전략
5평선이 20평선을 뚫는 순간 그 다음 시간(1분)에 시가로 매수 한다.
매수 시점 : 5평선 뚫는 그 다음 1분
매수가 : 지정가 / 5평선이 20평선을 뚫었던 그 다음 시간(1분)의 시가

### 문제점
1. 20평선을 뚫는 순간 양봉이 나오면서 체결이 되지 않는다.
2. 체결이 되도 이미 높은 가격에 매수를 해서 손실이 발생한다.


## 매도 전략
5평선이 20평선 밑으로 내려가는 순간 그 다음 시간에서 시장가로 매도한다.
매수 시점 : 5평선이 20평선으로 내려가는 순간
매도가 : 지정가 / 5평선이 20평선을 내려가는 순간

### 문제점
다음 시간에서 매도할 시 이미 주가가 내려가 있으면 체결되지 않고 주가가 내려가서 손해가 크다.

## 운영 기간
2021-03-17 ~ 2021-03-18

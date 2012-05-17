= easypay_payment_tool

easypay_payment_tool是一個介接藍新科技(www.newweb.com.tw)金流api的函式庫

目前函式庫中有三個功能

* 向藍新取得虛擬帳號(visualatm)

* 向藍新取得便利超商kiosk繳費代碼(kiosk)

* 藍新發出消費者繳款成功訊息接收(receivedataVerification)


== Installation

  gem "easypay_payment_tool"
  
== Usage

<b>使用前需先向藍新申請帳號、驗證碼、設定回傳訊息網站路徑</b>

user選定付款方式->初始化api->api選擇對應付款方式到藍新->使用者付款->藍新發送訊息->api接收訊息

easypay_payment_tool.init(藍新帳號,藍新驗證碼,藍新金流endpoint網址)

easypay_payment_tool.visualatm(訂單編號,訂單金額,訂單抬頭,訂單備住,付款人,付款人電話)

or

easypay_payment_tool.kiosk(訂單編號,訂單金額,訂單抬頭,訂單備住,付款人,付款人電話)

<b>*訂單編號為唯一</b>

....等待使用者付款.....

使用者付款後，藍新Post訊息至申請時設定的回傳訊息網站路徑

_ordernum=params[:ordernumber]
_amount=params[:amount]
_paytype=params[:paymenttype]
_serialnumber=params[:serialnumber]
_writeoffnumber=params[:writeoffnumber]
_timepaid=params[:timepaid]
_tel=params[:tel]
_hash=params[:hash]	
easypay_payment_tool.receivedataVerification(_ordernum,_amount,_paytype,_serialnumber,_writeoffnumber,_timepaid,_tel,_hash)

結束。


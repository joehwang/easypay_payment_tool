# encoding: utf-8

require "easypay_payment_tool/version"
module EasypayPaymentTool
require 'yaml'
require 'net/http'
require 'digest'
#class EasypayPaymentTool
	attr_accessor  :rc,:virtualaccount,:kioskserial,:amount,:payername,:amount,:ordernumber,:mnumber,:code,:endpoint
	@mnumber=""
	@code=""
	@endpoint=""
	def self.init(_merchantnumber,_code,_endpoint)
		#@conf = YAML::load(File.open("#{Rails.root}/config/bluenew.yml"))		
		#@mnumber=@conf[Rails.env]["merchantnumber"]
		#@code=@conf[Rails.env]["code"]
		#@endpoint="http://maple2.neweb.com.tw/CashSystemFrontEnd/Payment"		
		@mnumber=_merchantnumber
		@code=_code
		@endpoint=_endpoint	
		
	end
=begin	
	def self.symbol_instance_to_static
		_mnumber,_code,_endpoint=""
		ObjectSpace.each_object(EasypayPaymentTool) { |o|
		  _mnumber=o.merchantnumber
		  _code=o.code
		  _endpoint=o.endpoint	
		}
		return _mnumber,_code,_endpoint
	end
=end
	def self.visualatm(_no,_amount,_title,_memo,_payer,_payerphone)
		#@mnumber,@code,@endpoint=symbol_instance_to_static

		uri = URI("#{@endpoint}")
		res = Net::HTTP.post_form(uri,'merchantnumber'=> "#{@mnumber}", 'ordernumber' => "#{_no}",'amount'=>"#{_amount}",'Paymenttype'=>'ATM','paytitle'=>"#{_title}",'paymemo'=>"#{_memo}",'bankid'=>'007','payname'=>"#{_payer}",'payphone'=>"#{_payerphone}",'returnvalue'=>'1','hash'=>Digest::MD5.hexdigest("#{@mnumber}#{@code}#{_amount}#{_no}"))
	
		s=res.body.split("&")
		mychecksum=""
		#拿掉checksum
		for x in 0...s.size-1
			mychecksum<<"#{s[x]}&"
    	end
		mychecksum<<"code=#{@code}"
		#把結果轉hash
		res = Hash[ s.map {|d| [d.split("=")[0],d.split("=")[1]]} ]
		if res["rc"]=="0"			
			if res["checksum"]==Digest::MD5.hexdigest(mychecksum)
				@virtualaccount=res["virtualaccount"]
				@amount=res["amount"]
				@ordernumber=res["ordernumber"]
				return res
			end
			return false
		else
			return false
		end

	end

	def self.kiosk(_no,_amount,_title,_memo,_payer,_payerphone)
		#@mnumber,@code,@endpoint=symbol_instance_to_static
		uri = URI("#{@endpoint}")
		res = Net::HTTP.post_form(uri,'merchantnumber'=> "#{@mnumber}", 'ordernumber' => "#{_no}",'amount'=>"#{_amount}",'Paymenttype'=>'MMK','paytitle'=>"#{_title}",'paymemo'=>"#{_memo}",'bankid'=>'','payname'=>"#{_payer}",'payphone'=>"#{_payerphone}",'id'=>'','returnvalue'=>'1','hash'=>Digest::MD5.hexdigest("#{@mnumber}#{@code}#{_amount}#{_no}"))
	
		s=res.body.split("&")
		mychecksum=""
		#拿掉checksum
		for x in 0...s.size-1
			mychecksum<<"#{s[x]}&"
    	end
		mychecksum<<"code=#{@code}"
		#把結果轉hash
		res = Hash[ s.map {|d| [d.split("=")[0],d.split("=")[1]]} ]
		if res["rc"]=="0"			
			if res["checksum"]==Digest::MD5.hexdigest(mychecksum)
				@kioskserial=res["paycode"]
				@amount=res["amount"]
				@ordernumber=res["ordernumber"]
				return res
			end
			return false
		else
			return false
		end
	end
	#藍新回傳資料驗證
	def self.receivedataVerification(_ordernum,_amount,_paytype,_serialnumber,_writeoffnumber,_timepaid,_tel,_hash)
			mycheck=""
			mycheck<<"merchantnumber=#{@mnumber}"
			mycheck<<"&ordernumber=#{_ordernum}"
			mycheck<<"&serialnumber=#{_serialnumber}"
			mycheck<<"&writeoffnumber=#{_writeoffnumber}"
			mycheck<<"&timepaid=#{_timepaid}"
			mycheck<<"&paymenttype=#{_paytype}"
			mycheck<<"&amount=#{_amount}"
			mycheck<<"&tel=#{_tel}"
			mycheck<<"#{@code}"
					
			if _hash==Digest::MD5.hexdigest(mycheck)
				return true
			else
				return false
			end
	end

end
#EasypayPaymentTool.new("xxxx","xxxxx","http://maple2.neweb.com.tw/CashSystemFrontEnd/Payment")
#res=EasypayPaymentTool.visualatm("atm22536542d","88","gem test","gem memo test","payer","7533967")
#p res.inspect

#end

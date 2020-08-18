class PurchasesController < ApplicationController
  def new
  end

  def index
    creditcard = CreditCard.where(user_id: current_user.id).first
    #テーブルからpayjpの顧客IDを検索
    if creditcard.blank?
      #登録された情報がない場合にカード登録画面に移動する
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = ["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(creditcard.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.crditcard.retrieve(creditcard.card_id)
    end
  end

  def pay
    creditcard = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 13500, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => creditcard.customer_id, #顧客ID
    :currency => 'jpy'
  )
  redirect_to action: 'done' #完了画面に移動
  end

# frozen_string_literal: true

class VendingMachine
  attr_reader :stock, :sales

  def initialize(stock)
    @stock = stock
    @sales = 0
  end

  def restock(juice, count)
    item = find_item(juice)
    item[:count] += count if item
  end

  def process_order(order_juice, order_qty, suica)
    order_item = find_item(order_juice)
    raise '在庫が不足しています' if order_item.count < order_qty
    raise 'チャージ残金が不足しています' if suica.deposit < order_item[:juice].price * order_qty

    order_item[:count] -= order_qty
    update_sales(order_item[:juice].price * order_qty)
    suica.make_payment(order_item[:juice].price * order_qty)
  end

  def find_item(juice)
    @stock.find { |i| i[:juice] == juice }
  end

  private

  def update_sales(cash)
    @sales += cash
  end
end

class Suica
  attr_reader :deposit

  DEFAULT_DEPOSIT = 500

  def initialize
    @deposit = 0
    charge(DEFAULT_DEPOSIT)
  end

  def charge(cash)
    raise '100円以上入金してください' if cash < 100

    @deposit += cash
  end

  def make_payment(cash)
    process_payment(cash)
  end

  private

  def process_payment(cash)
    @deposit -= cash
  end
end

class Juice
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

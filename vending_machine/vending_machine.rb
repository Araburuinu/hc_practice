# frozen_string_literal: true

class VendingMachine
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
    raise '在庫が不足しています' if order_item[:count] < order_qty
    raise 'チャージ残金が不足しています' if suica.deposit < order_item[:price] * order_qty

    order_item[:count] -= order_qty
    update_sales(order_item[:price] * order_qty)
    suica.make_payment(order_item[:price] * order_qty)
  end

  def stock
    @stock
  end

  def sales
    @sales
  end

  def find_item(item)
    @stock.find { |i| i[:name] == item.name }
  end

  private
  def update_sales(cash)
    @sales += cash
  end
end

class Suica
  DEFAULT_DEPOSIT = 500

  def initialize
    @deposit = 0
    charge(DEFAULT_DEPOSIT)
  end

  def charge(cash)
    raise '100円以上入金してください' if cash < 100

    @deposit += cash
  end

  def deposit
    @deposit
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
  def initialize(name, price)
    @name = name
    @price = price
  end

  def name
    @name
  end

  def price
    @price
  end
end

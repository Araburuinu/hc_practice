# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'vending_machine'

PEPSI = Juice.new('ペプシ', 150)
MONSTER = Juice.new('モンスター', 230)
IROHAS = Juice.new('いろはす', 120)

DEFAULT_STOCK = [
  { juice: PEPSI, count: 5 },
  { juice: MONSTER, count: 5 },
  { juice: IROHAS, count: 5 }
].freeze

class VendingMachineTest < Minitest::Test
  def setup
    @vending_machine = VendingMachine.new(DEFAULT_STOCK)
    @suica = Suica.new
  end

  def test_suica_charges_successfully_for_valid_amount
    initial_deposit = @suica.deposit
    @suica.charge(2000)
    assert_equal(initial_deposit + 2000, @suica.deposit)
  end

  def test_suica_charge_fails_for_invalid_amount
    assert_raises(RuntimeError, '100円以上入金してください') do
      @suica.charge(50)
    end
  end

  def test_vending_machine_restocks_items_correctly
    initial_count = @vending_machine.find_item(PEPSI)[:count]
    @vending_machine.restock(PEPSI, 2)
    assert_equal(initial_count + 2, @vending_machine.find_item(PEPSI)[:count])
  end

  def test_vending_machine_processes_orders_correctly
    initial_count = @vending_machine.find_item(PEPSI)[:count]
    initial_deposit = @suica.deposit
    price = @vending_machine.find_item(PEPSI)[:juice].price
    qty = 1
    @vending_machine.process_order(PEPSI, qty, @suica)
    assert_equal(initial_count - qty, @vending_machine.find_item(PEPSI)[:count])
    assert_equal(initial_deposit - price * qty, @suica.deposit)
  end

  def test_vending_machine_processes_order_raises_error_for_insufficient_stock
    assert_raises(RuntimeError, '在庫が不足しています') do
      @vending_machine.process_order(PEPSI, 10, @suica)
    end
  end

  def test_vending_machine_processes_order_raises_error_for_insufficient_funds
    assert_raises(RuntimeError, 'Suicaの残金が不足しています') do
      @vending_machine.process_order(MONSTER, 100, @suica)
    end
  end

  def test_vending_machine_check_sales_for_valid_sales
    initial_sales = @vending_machine.sales
    qty = 2
    @vending_machine.process_order(MONSTER, qty, @suica)
    assert_equal(initial_sales + MONSTER.price * qty, @vending_machine.sales)
  end
end

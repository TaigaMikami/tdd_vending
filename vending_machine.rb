class Drink
  attr_accessor :name, :price

  def initialize(name ,price)
    @name = name
    @price = price
  end

  def self.coke
    self.new(:coke,120)
  end

  def self.redbull
    self.new(:redbull,200)
  end

  def self.water
    self.new(:water,100)
  end

end

class VendingMachine
  AVAILABLE_MONEY = [10,50,100,500,1000]

  attr_accessor :total, :sale_amount
  def initialize
    @total = 0
    @drink_menu = {} #飲み物のハッシュ配列
    @sale_proceeds = 0
    5.times{ store Drink.coke}
  end

  def insert(money)#お金投入
    if AVAILABLE_MONEY.include?(money)
      @total += money
    else
      puts "払い戻し:#{money}円"
      return money
    end
    puts @total
  end

  def store(drink)#飲み物格納
    nil.tap do
      if !(@drink_menu.has_key?(drink.name)) #drink.nameの飲み物がない時格納
        @drink_menu[drink.name] = { price: drink.price, drinks: [] }
      end
      #名前があれば在庫追加
      @drink_menu[drink.name][:drinks].push(drink)
    end
  end

  def stock_info#飲み物格納情報
    puts @drink_menu.map{|name, info|  [name, { price: info[:price], stock: info[:drinks].size }]}
  end

  def available_puchase(drink_name)#購入可能確認
    can_buy = @drink_menu.select{|_, info| total >= info[:price] && info[:drinks].any?}.keys
    puts "購入可能#{can_buy}"
    puts can_buy.include?(drink_name)
    return can_buy.include?(drink_name)
  end

  def purchase(drink_name)
    if available_puchase(drink_name)
      drink = @drink_menu[drink_name][:drinks].pop
      @sale_proceeds += drink.price
      @total -= drink.price
      puts "釣り銭：#{@total}"
      puts "売り上げ金額：#{@sale_proceeds}"
    end
  end
end


#インスタンス作成
machine = VendingMachine.new

money = gets.to_i
machine.insert(money)
money = gets.to_i
machine.insert(money)

machine.store(Drink.water)
machine.store(Drink.redbull)

machine.stock_info
machine.available_puchase(:coke)
machine.purchase(:coke)

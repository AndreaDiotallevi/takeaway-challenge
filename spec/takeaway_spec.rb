require "takeaway"

describe Takeaway do
  let(:dish_1) { double :dish, name: "Carbonara", price: 10 }
  let(:dish_2) { double :dish, name: "Puttanesca", price: 12 }
  let(:menu) { double :menu, list: "Name: Carbonara, Price: 10\nName: Puttanesca, Price: 12" }
  let(:text_provider) { double :text_provider, send_message: "Thank you! Your order was placed and will be delivered before 18:55" }
  let(:takeaway) { Takeaway.new(menu, text_provider) }

  describe "#read_menu" do
    it "should list the menu" do
      expect(takeaway.read_menu).to eq "Name: Carbonara, Price: 10\nName: Puttanesca, Price: 12"
    end
  end

  describe "#order" do
    it "should return a confirmation message that the given item has been added to the basket" do
      expect(takeaway.order(dish_1, 5)).to eq "5x Carbonara(s) added to your basket."
    end
  end

  describe "#basket_summary" do
    it "should return a message with the basket summary" do
      takeaway.order(dish_1, 5)
      takeaway.order(dish_2, 2)
      expect(takeaway.basket_summary).to eq "Carbonara x5 = £50, Puttanesca x2 = £24"
    end
  end

  describe "#total" do
    it "should return the total cost of the takeaway" do
      takeaway.order(dish_1, 5)
      takeaway.order(dish_2, 2)
      expect(takeaway.total).to eq "Total: £74"
    end
  end
end
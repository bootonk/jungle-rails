require 'rails_helper'
require 'product.rb'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    before do
      @category = Category.new(:name => "Sit")
    end

    it 'should save if all four fields are set' do
      product = Product.create(:name => "sofa", :price => 20, :quantity => 30, :category => @category)
      expect(product).to be_valid
    end

    # validates :name, presence: true
    it 'should validate the presence of a name' do
      product = Product.create(:name => nil, :price => 20, :quantity => 30, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    # validates :price, presence: true
    it 'should validate the presence of a price' do
      product = Product.create(:name => "sofa", :price_cents => nil, :quantity => 30, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    # validates :quantity, presence: true
    it 'should validate the presence of a quantity' do
      product = Product.create(:name => "sofa", :price => 20, :quantity => nil, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    # validates :category, presence: true
    it 'should validate the presence of a category' do
      product = Product.create(:name => "sofa", :price => 20, :quantity => 30, :category => nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end

end

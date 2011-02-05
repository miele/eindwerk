require 'spec_helper'

describe ProductsController do
  fixtures :products

  include Devise::TestHelpers

  before(:each) do
    @user = users(:one) # Replace with whatever mock Factory you're using
    sign_in @user
  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      response.should be_success
    end

    it "assigns @product" do
      get :index
      assigns(:products).should_not be_nil
    end

    it "renders index template" do
      get :index
      response.should render_template('index')
    end
  end
  
  describe "GET 'show'" do
    before(:each) do
      # Replace this with your Mock Factory, for ex: Machinist, Fabrication...
      @product = products(:one)
    end

    it 'is successful' do
      get :show, :id => @product.id
      response.should be_success
    end

    it "assigns @product" do
      get :show, :id => @product.id
      assigns(:product).should_not be_nil
    end

    it "renders the 'show' template" do
      get :show, :id => @product.id
      response.should render_template('show')
    end
  end  
  describe "GET 'new'" do
    it 'is successful' do
      get :new
      response.should be_success
    end

    it "assigns @product" do
      get :new
      assigns(:product).should_not be_nil
    end

    it "renders the 'new' template" do
      get :new
      response.should render_template('new')
    end
  end  
  describe "POST 'create'" do
    before(:each) do
      @product = Product.new
      @product.stub(:id).and_return(1)
    end

    context "The save is successful" do
      before(:each) do
        Product.should_receive(:new).and_return(@product)
        @product.should_receive(:save).and_return(true)
      end

      it "redirects to the 'show' action" do
        post :create, :product => @product.attributes
        response.should redirect_to(product_path(@product)) # Put the right show path here
      end

      it "sets a flash message" do
        post :create, :product => @product.attributes
        flash[:notice].should == 'Product was successfully created.'
      end
    end

    context "the save fails" do
      before(:each) do
        @product.should_receive(:save).and_return(false)
        Product.should_receive(:new).and_return(@product)
      end

      it "renders the 'new' action" do
        post :create, :product => @product.attributes
        response.should render_template(:new)
      end

      it "assigns @product" do
        post :create, :product => @product.attributes
        assigns(:product).should_not be_nil
      end
    end
  end  
  describe "GET 'edit'" do
    before(:each) do
      # Replace this with your Mock Factory, for ex: Machinist, Fabrication...
      @product = products(:one)
    end

    it 'is successful' do
      get :edit, :id => @product.id
      response.should be_success
    end

    it "assigns @product" do
      get :edit, :id => @product.id
      assigns(:product).should_not be_nil
    end

    it "renders the 'edit' template" do
      get :edit, :id => @product.id
      response.should render_template('edit')
    end
  end  
  describe "PUT 'update'" do
    before(:each) do
      # Replace this with your Mock Factory, for ex: Machinist, Fabrication...
      @product = products(:one)
    end

    context "the update is successful" do
      before(:each) do
        @product.should_receive(:update_attributes).and_return(true)
        Product.should_receive(:find).with(@product.id).and_return(@product)
      end

      it "redirects to 'show' action" do
        put :update, :id => @product.id, :product => {} # Add here some attributes for the model
        response.should redirect_to(product_path(@product)) # Put the right show path here
      end

      it "sets a flash message" do
        put :update, :id => @product.id, :product => {} # Add here some attributes for the model
        flash[:notice].should == 'Product was successfully updated.' # Your flash message here
      end
    end

    context "the update fails" do
      before(:each) do
        @product.should_receive(:update_attributes).and_return(false)
        Product.should_receive(:find).with(@product.id).and_return(@product)
      end

      it "renders the 'edit' action" do
        put :update, :id => @product.id, :product => {} # Add here some attributes for the model
        response.should render_template(:edit)
      end

      it "assigns @product" do
        put :update, :id => @product.id, :product => {} # Add here some attributes for the model
        assigns(:product).should_not be_nil
      end
    end
  end  
  describe "DELETE 'destroy'" do
    before(:each) do
      # Replace this with your Mock Factory, for ex: Machinist, Fabrication...
      @product = products(:one)
      Product.should_receive(:find).with(@product.id).and_return(@product)
    end

    it "should delete the product" do
      @product.should_receive(:delete).and_return(true)
      delete :destroy, :id => @product.id
    end

    it "should redirect to index page" do
      delete :destroy, :id => @product.id
      response.should redirect_to(:products)
    end

    it "sets a flash message" do
      delete :destroy, :id => @product.id
      flash[:notice].should == 'Product was successfully destroyed.' # Your flash message here
    end
  end
end

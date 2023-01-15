require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { User.create(email: 'test3@example.com', password: 'password')}
  let(:item) { create(:item) }
  before { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
    it "creates a new Record" do
      expect {
        get :index, params: { q: 'test' }
      }.to change(Record, :count).by(1)
    end
    it "search items" do
      get :index
      expect(assigns(:records)).to eq(Record.select("name, count(*) as count")
      .where(user_id: user.id)
      .group("name")
      .order("count DESC")
      .limit(10))
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show
      expect(response).to be_successful
    end
    it "search items" do
      get :show
      expect(assigns(:search)).to eq(search)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
    it "assigns a new item" do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, params: { item: attributes_for(:item) }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post :create, params: { item: attributes_for(:item) }
        expect(response).to redirect_to(items_path)
      end
    end

    context "with invalid params" do
      it "renders a new template" do
        post :create, params: { item: { name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "search" do
    it "search items" do
      query = "test"
      result = [item]
      expect(controller.search).to eq([item])
    end
  end
end

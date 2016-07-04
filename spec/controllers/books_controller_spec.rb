require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  login_user

  let(:valid_attributes) {
    FactoryGirl.build(:book).attributes
  }

  let(:invalid_attributes) {
    { :title => nil, :num_pages => 100 }
  }

  describe "GET #index" do
    it "assigns all books as @books" do
      book = Book.create! valid_attributes
      get :index, {}
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :show, {:id => book.to_param}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "GET #new" do
    it "assigns a new book as @book" do
      get :new, {}
      expect(assigns(:book)).to be_a_new(Book)
    end
  end

  describe "GET #edit" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :edit, {:id => book.to_param}
      expect(assigns(:book)).to eq(book)
    end
  end

  describe "GET #read" do
    before(:each) do
      request.env['HTTP_REFERER'] = root_url
    end

    it "creates a read_book entry for current user" do
      book = FactoryGirl.create(:book)

      expect do
        get :read, {:id => book.id }
      end.to change{ ReadBook.count }.by(1)
    end

    it "redirects to the index page" do
      book = FactoryGirl.create(:book)
      get :read, {:id => book.id }
      
      expect(response).to redirect_to :back
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, {:book => valid_attributes}
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, {:book => valid_attributes}
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end

      it "redirects to the created book" do
        post :create, {:book => valid_attributes}
        expect(response).to redirect_to(Book.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        post :create, {:book => invalid_attributes}
        expect(assigns(:book)).to be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        post :create, {:book => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => new_attributes}
        book.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested book as @book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}
        expect(assigns(:book)).to eq(book)
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => valid_attributes}
        expect(response).to redirect_to(book)
      end
    end

    context "with invalid params" do
      it "assigns the book as @book" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => invalid_attributes}
        expect(assigns(:book)).to eq(book)
      end

      it "re-renders the 'edit' template" do
        book = Book.create! valid_attributes
        put :update, {:id => book.to_param, :book => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET#destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        get :destroy, {:id => book.to_param}
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      book = Book.create! valid_attributes
      get :destroy, {:id => book.to_param}
      expect(response).to redirect_to(books_url)
    end
  end

end

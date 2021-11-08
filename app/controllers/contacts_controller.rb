class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @history = History.new(first_name: @contact.first_name, last_name: @contact.last_name, email: @contact.email, phone: @contact.phone, action: 'Creation')

    respond_to do |format|
      if @contact.save
        @history.save
        format.html { redirect_to @contact, notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    @history = History.new(first_name: @contact.first_name, last_name: @contact.last_name, email: @contact.email, phone: @contact.phone, action: 'Update')

    respond_to do |format|
      if @contact.update(contact_params)
        @history.save
        format.html { redirect_to @contact, notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        puts @contact.errors.inspect
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @history = History.new(first_name: @contact.first_name, last_name: @contact.last_name, email: @contact.email, phone: @contact.phone, action: 'Removal')

    @contact.destroy
    respond_to do |format|
      @history.save
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def history
    @registrations = History.order(created_at: :desc).all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone)
    end

end

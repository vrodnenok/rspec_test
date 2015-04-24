class ContactsController < ApplicationController

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # PUST /contacts, will return filtered table in editable form
  def filter_table
    pref = params[:fltr]
    @contacts = Contact.where("email LIKE ?", '%'+pref.downcase+'%')
    r = "<div class='row'><div class = 'large-12 columns'><table><thead>"
    r += "<th> First Name </th> <th> Last name </th> <th> Email </th> <th> Broker? </th>"
    r += "<th> Chrtr </th><th> Ownr </th> <th> Region </th><th> Size </th> <th> Enabled </th>"
    r += "</thead><tbody>"
    @contacts.each do |c|
      r += "<tr id = '#{c.id}'>"
      r += "<td> #{c.first_name} </td>"
      r += "<td> #{c.last_name} </td>"
      r += "<td> <input value='#{c.email}'></input> </td>"
      r += "<td> <input type = 'checkbox' value='#{c.is_broker}'></input> </td>"
      r += "<td> <input type = 'checkbox' value='#{c.is_charterer}'></input> </td>"
      r += "<td> <input type = 'checkbox' value='#{c.is_owner}'></input> </td>"
      r += "<td>"
      r += "<select value = '#{c.region}'>"
      r += make_regions_select()
      r += "</select>" 
      r += "</td>"
      r += "<td>"
      r += "<select value = '#{c.size}'>"
      r += make_sizes_select()
      r += "</select>" 
      r += "</td>"
      r += "<td> <input type = 'checkbox' value='#{c.enabled}'></input> </td>"
      r += '</tr>'
    end
    r += '</tbody></table></div></div>'
    render text: r
  end

  def import_contacts
    @import = Import.new()
  end

  def do_import
    i = params[:import]
    txt = i[:contacts_to_import]
    @correct, @failed = 0,0
    txt.each_line do |l|
      l.chomp
      c = Contact.find_by email: l
      if !c && l.match(VALID_EMAIL_REGEX) then
        c = Contact.new()
        c.email = l.downcase()
        c.is_broker = i[:is_broker]
        c.is_charterer = i[:is_charterer] 
        c.is_owner = i[:is_owner]
        c.save
        @correct += 1
      else
        @failed += 1
      end
    end
    render 'imported'
  end

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:sex, :first_name, :last_name, 
        :company, :email, :is_broker, :is_charterer, :is_owner, :enabled,
        :region, :size, :comment)
    end

    def make_sizes_select
      sizes = [1000, 5000, 10000, 50000]
      reply = ''
      sizes.each do |r|
        reply += "<option value='#{r}'>#{r}</option>"
      end
      return reply
    end    

    def make_regions_select
      regions = ['Russia', 'Ukraine', 'Greece', 'Turkey', 
        'Asia', 'Continent', 'Other Med', 'Africa', 'America']
      reply = ''
      regions.each do |r|
        reply += "<option value='#{r}'>#{r}</option>"
      end
      return reply
    end    

end
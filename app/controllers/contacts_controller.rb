class ContactsController < ApplicationController

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def send_mail

  end

  def upd_contact
    puts "Params: "
    puts params
    i = params[:contact]
    c = Contact.find(i[:id])
    c.first_name = i[:first_name]
    c.last_name = i[:last_name]
    c.company = i[:company]
    c.email = i[:email]
    c.is_broker = i[:is_broker]
    c.is_charterer = i[:is_charterer]
    c.is_owner = i[:is_owner]
    c.enabled = i[:enabled]
    c.region = i[:region]
    c.size = i[:size]
    puts c.first_name
    c.save()
    render text: "Ok"
  end

  # PUST /contacts, will return filtered table in editable form
  def filter_table
    pref = params[:fltr]
    return unless pref
    @contacts = Contact.where("email LIKE ?", '%'+pref.downcase+'%').order('email')
    r = "<div class='row'><div class = 'lg-5-col'>"
    r += "<table class = 'table-striped table-bordered'><thead>"
    r += "<th> First Name </th> <th> Last name </th> <th> Company </th>"
    r += "<th> Email </th> <th> Broker? </th>"
    r += "<th> Chrtr </th><th> Ownr </th> <th> Region </th><th> Size </th> <th> Enabled </th>"
    r += "</thead><tbody>"
    @contacts.each do |c|
      print c.is_broker?, c.is_charterer?, c.is_owner?, c.enabled?
      puts
      r += "<tr id = '#{c.id}'>"
      r += "<td> <input class ='fn_input' value = #{c.first_name} > </input> </td>"
      r += "<td> <input class ='ln_input' value = #{c.last_name} > </input> </td>"
      r += "<td> <input class ='ln_input' value = #{c.company} > </input> </td>"
      r += "<td> <input value='#{c.email}'></input> </td>"
      r += "<td> <input type = 'checkbox' #{'checked' if c.is_broker}></input> </td>"
      r += "<td> <input type = 'checkbox' #{'checked' if c.is_charterer}></input> </td>"
      r += "<td> <input type = 'checkbox' #{'checked' if c.is_owner}></input> </td>"
      r += "<td>"
      r += "<select value = '#{c.region}'>"
      r += make_regions_select(c.region)
      r += "</select>" 
      r += "</td>"
      r += "<td>"
      r += "<select value = '#{c.size}'>"
      r += make_sizes_select(c.size)
      r += "</select>" 
      r += "</td>"
      r += "<td> <input type = 'checkbox' #{'checked' if c.enabled}></input> </td>" #
      r += "<td> <input type = 'button' class='upd_con' value='Update'></button></td>"
      r += "<td> <input type = 'button' class='edt_con' value='Edit'></button></td>"
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
    puts "Hello" + i[:region]
    txt = i[:contacts_to_import]
    @correct, @failed = 0,0
    txt.each_line do |l|
      l.chomp
      c = Contact.find_by email: l
      if !c && l.match(VALID_EMAIL_REGEX) then
        c = Contact.new()
        c.email = l.downcase()
        c.is_broker = true if i[:is_broker] == 1
        c.is_charterer = true if i[:is_charterer] == 1
        c.is_owner = true if i[:is_owner] == 1
        c.region = i[:region]
        c.size = i[:size].to_i
        c.enabled = true if i[:enabled] == 1
        puts c
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

    def make_sizes_select (size)
      sizes = [1000, 5000, 10000, 50000]
      reply = ''
      sizes.each do |r|
        if size != r
          reply += "<option value='#{r}'>#{r}</option>"
        else
          reply += "<option value='#{r}' selected = '#{r}'>#{r}</option>"
        end
      end
      return reply
    end    

    def make_regions_select (region)
      regions = ['Russia', 'Ukraine', 'Greece', 'Turkey', 
        'Asia', 'Continent', 'Other Med', 'Africa', 'America']
      reply = ''
      regions.each do |r|
        if r != region
          reply += "<option value='#{r}'>#{r}</option>"
        else
          reply += "<option value='#{r}' selected = '#{r}'>#{r}</option>"
        end
      end
      return reply
    end    

end
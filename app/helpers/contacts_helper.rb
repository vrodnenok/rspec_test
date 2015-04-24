module ContactsHelper
  def make_regios_select
    regions = ['Russia', 'Ukraine', 'Greece', 'Turkey', 
      'Asia', 'Continent', 'Other Med', 'Africa', 'America']
    reply = ''
    regions.each do |r|
      reply += '<option value="#{r}">#{r}</option>'
    end
    return reply
  end
end

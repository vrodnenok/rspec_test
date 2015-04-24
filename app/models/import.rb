  class Import 
    include ActiveModel::Model
    
    attr_accessor :contacts_to_import, :sex, :first_name, :last_name, 
        :is_broker, :is_charterer, :is_owner, :region, :size

    def persisted?
      false
    end
  end
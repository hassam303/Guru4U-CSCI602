class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   include SessionsHelper
   
  def self.form_data_accessors(camel_class)
    snake_class = camel_class.underscore
    session_key = ":stored_#{snake_class}_form_data"
    
    class_eval %Q"

    def store_#{snake_class}_form_data(form_data)
      store_form_data(#{session_key},form_data)
    end
    
    def get_new_#{snake_class}_form_data
      get_new_form_data(#{camel_class},#{session_key})
    end
    
    def get_edit_#{snake_class}_form_data(default_form_data)
      get_edit_form_data(#{camel_class},#{session_key},default_form_data)
    end
    
    def forget_#{snake_class}_form_data
      forget_form_data(#{session_key})
    end
    "
  end
end

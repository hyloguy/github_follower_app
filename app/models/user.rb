class User < ActiveRecord::Base

    # Documentation link:
    #
    # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    #
    # This makes the methods in ActiveModel::SecurePassword::InstanceMethodsOnActivation
    # available to instances of User, including authenticate() and password_confirmation=().
    #
    # Without this, there is no way to set the password_confirmation attribute.

    has_secure_password

end

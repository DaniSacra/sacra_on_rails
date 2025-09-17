require_relative 'lib/sacra_on_rails'

class User < SacraOnRails::BaseModel

  attribute :name, :email
  attribute :password

  validates_presence_of :name, :email, :password

  before_save :psw_reverse

  def psw_reverse
    self.password = password.reverse
  end
  
end

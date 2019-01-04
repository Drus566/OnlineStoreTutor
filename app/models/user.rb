class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # That’s exactly what has_secure_password does for you: it tells Rails to
  # validate that the two passwords match
  has_secure_password
  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private 
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end 
    end
end



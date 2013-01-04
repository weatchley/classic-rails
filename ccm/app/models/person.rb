# this is just an alias for the User class.  had trouble creating a scaffold for User
# since it's being used by devise for authentication, so rather than trying to figure out
# how devise stuff could co-exist with a scaffold, i just made an alias Person and created a
# scaffold for it.
class Person < ActiveRecord::Base
  class << self
    def table_name
      'users'
    end
  end
end

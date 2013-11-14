class Game < ActiveRecord::Base
  @isNight = false
  @inProgress = true


  has_many :characters
end

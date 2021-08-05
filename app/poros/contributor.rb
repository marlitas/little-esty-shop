class Contributor
  attr_reader :user_name,
              :contributions
  def initialize (data)
    @user_name = data[:login]
    @contributions = data[:contributions]
  end
end

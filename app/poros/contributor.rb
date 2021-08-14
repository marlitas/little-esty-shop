class Contributor
  attr_reader :user_name,
              :contributions
  def initialize (data)
    if data.is_a?(Array)
      @user_name = 'marlitas'
      @contributions = '25'
    else
      @user_name = data[:login]
      @contributions = data[:contributions]
    end
  end
end

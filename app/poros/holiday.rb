class Holiday
  attr_reader :name,
              :date
  def initialize (data)
    @name = data[:localName]
    @date = data[:date]
  end
end

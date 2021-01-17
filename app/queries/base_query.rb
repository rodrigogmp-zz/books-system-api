class BaseQuery
  def initialize(params:)
    @params = params
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end

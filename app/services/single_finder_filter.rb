class SingleFinderFilter
  def self.call(results, params)
    new(results, params).filter
  end

  attr_reader :results, :params

  def initialize(results, params)
    @results = results
    @params = params
  end

  def filter
    params.each do |param|
      @results = results.where("LOWER(#{param}) LIKE LOWER('%#{params[param.to_sym]}%')")
    end
    results.first
  end
end

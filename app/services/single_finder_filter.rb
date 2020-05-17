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

  # def filter
  #   if params[:name]
  #     @results = results.where("LOWER(name) LIKE LOWER('%#{params[:name]}%')")
  #   end
  #   if params[:created_at]
  #     @results = results.where("LOWER(created_at) LIKE LOWER('%#{params[:created_at]}%')")
  #   end
  #   if params[:updated_at]
  #     @results = results.where("LOWER(updated_at) LIKE LOWER('%#{params[:updated_at]}%')")
  #   end
  #   results.first
  # end
end

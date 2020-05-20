class FinderFilter
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
      if results[0][param].class == String
        @results = results.where("LOWER(#{param}) LIKE LOWER('%#{params[param.to_sym]}%')")
      elsif results[0][param].class == ActiveSupport::TimeWithZone
        @results = results.where(created_at: Date.parse(params[param]).beginning_of_day...Date.parse(params[param]).end_of_day)
      else
        @results = results.where("#{param} = #{params[param.to_sym]}")
      end
    end
    results
  end
end

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
      if results[0][param].class == String
        @results = results.where("LOWER(#{param}) LIKE LOWER('%#{params[param.to_sym]}%')")
      # elsif results[0][param].class == ActiveSupport::TimeWithZone
      #   parsed_param = ActiveSupport::TimeZone['UTC'].parse(params[param.to_sym])
      #   @results = results.where("#{param.time.change(:usec=>0)} = #{parsed_param.change(:usec=>0)}")
      else
        @results = results.where("#{param} = #{params[param.to_sym]}")
      end
    end
    results.first
  end
end

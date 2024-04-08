class SerializerSet
  attr_accessor :object_set, :current_page, :total, :per_page
  def initialize(object_set:, current_page:, total:, per_page:)
    @object_set = object_set
    @current_page = current_page
    @total = total
    @per_page = per_page
  end

  def format_set
    data = object_set.map do |object_serializer|
      object_serializer.serialize
    end
    return {
      "data" => data,
      "pagination" => {
        "current_page" => @current_page,
        "total" => @total,
        "per_page" => @per_page
      }
    }
  end

end

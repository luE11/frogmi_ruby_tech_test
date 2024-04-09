require_relative "../models/comment.model"
require_relative "../serializers/comment.serializer"
require_relative "feature_service"
require_relative "../errors/feature_does_not_exist_error"

include Models
include CustomErrors

module Services
  ##
  # Service class including Comment model operations. This class applies singleton pattern
  class CommentService

    @instance = nil
    private_class_method :new

    def initialize
      @feature_service = FeatureService.instance
    end

    def self.instance
      if @instance.nil?
        @instance = new
      end
      @instance
    end

    def create_comment_serialized(message:, feature_id:)
      comment = create_comment(message: message, feature_id: feature_id)
      return CommentSerializer.new(comment).serialize
    end

    def create_comment(message:, feature_id:)
      if !feature_exists?(feature_id)
        raise FeatureDoesNotExistError.new(
          msg="Feature with id: #{feature_id} does not exist"
        )
      end
      comment = Comment.new(message: message, feature_id: feature_id)
      return comment.save
    end


    def feature_exists?(feature_id)
      return @feature_service.exists_by_id?(feature_id)
    end

  end
end

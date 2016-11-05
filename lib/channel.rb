
class Slack_Channel
  attr_reader :name, :id, :purpose, :is_archived, :members

  def initialize(name, id, options = {} )

    if name == nil || id == nil || name == "" || id == ""
      raise ArgumentError
    end
    
    @name = name
    @id = id

    @purpose = options[:purpose]
    @is_archived = options[:is_archived]
    @is_general = options[:is_archived]
    @members = options[:members]
  end


end

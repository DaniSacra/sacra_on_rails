module SacraOnRails
  class BaseModel

    @@records = Hash.new { |model, key| model[key] = [] }

    class << self

      def all
        @@records[self]
      end

      def count
        @@records[self].size
      end

      def find_by(**conditions)
        all.find do |record|
          conditions.all? do |field, expected|
            actual = record.send(field)
            actual.to_s.strip.downcase == expected.to_s.strip.downcase
          end

        end
      end

      def before_save(*methods)
        @before_callbacks ||= []
        @before_callbacks += methods
      end

      def before_callbacks
        @before_callbacks ||= []
      end

      def validates_presence_of(*fields)
        @presence_validations ||= []
        @presence_validations += fields
      end

      def presence_validations
        @presence_validations ||= []
      end

      def attribute(*fields)

        fields.each do |attr|
          # get
          define_method(attr) { @data[attr] }

          # set
          setter = "#{attr}="
          define_method(setter) do |value|
            @data[attr] = value
          end

        end
      end
    end
      
    def save
      return false unless valid?

      perform_before_callbacks

      self.class.send(:all) << self
    end
    
    def initialize(attrs = {})
      @data ||= {}
      attrs.each do |attr, value|
        setter = "#{attr}="
        send(setter, value)
      end
    end

    private

    def valid?
      validations = self.class.presence_validations

      return true if validations.empty?

      missing_methods = validations.select do |field|
        get_value = send(field) 
        get_value.nil? || get_value.to_s.strip.empty?
      end

      if missing_methods.any?
        false
      else
        true
      end
    end

    def perform_before_callbacks
      self.class.before_callbacks.each do |method|
        send(method)
      end
    end
    
  end
end

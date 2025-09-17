require_relative 'test_helper'

module SacraOnRails

  class TestCase
    extend SacraOnRails::TestHelper

    def self.run
      raise "Needs implement"
    end

    # Método para executar um teste individual
    def self.test(test_name, &block)
      TestHelper.run_test(test_name, &block)
    end
  end
end

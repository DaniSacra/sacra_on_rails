module SacraOnRails

  module TestHelper
    
    def assert(expected, msg = nil)
      raise "Teste de #{expected.inspect} falhou" unless expected
    end

    def assert_equal(expected, actual, msg = nil)
      raise "Esperado que #{expected} fosse igual a #{actual}" unless expected == actual
    end

    def assert_nil(value, msg = nil)
      raise "Esperado que #{value.inspect} fosse nil" unless value.nil?
    end

    # Método para executar um teste individual e mostrar resultado
    def self.run_test(test_name, &block)
      print "#{test_name}... "
      
      begin
        yield
        puts "PASSOU"
        { status: :passed, test_name: test_name, error: nil }
      rescue StandardError => e
        puts "FALHOU"
        puts "   Erro: #{e.message}"
        { status: :failed, test_name: test_name, error: e }
      end
    end

  end

end

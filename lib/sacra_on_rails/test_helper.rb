module SacraOnRails

  module TestHelper
    
    def assert(expected, msg = nil)
      puts msg || "Testando true"
      raise "Teste de #{expected.inspect} falhou" unless expected
    end

    def assert_equal(expected, actual, msg = nil)
      raise "Esperado que #{expected} fosse igual a #{actual}" unless expected == actual
    end

    # Método para executar um teste individual e capturar erros
    def self.run_test(test_name, &block)
      begin
        yield
        { status: :passed, test_name: test_name, error: nil }
      rescue StandardError => e
        { status: :failed, test_name: test_name, error: e }
      end
    end

  end

end

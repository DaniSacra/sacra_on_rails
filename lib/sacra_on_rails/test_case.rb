require_relative 'test_helper'

module SacraOnRails

  class TestCase
    extend SacraOnRails::TestHelper

    @@test_results = []

    def self.run
      raise "Needs implement"
    end

    # Método para executar um teste individual e armazenar o resultado
    def self.test(test_name, &block)
      result = TestHelper.run_test(test_name, &block)
      @@test_results << result
      result
    end

    # Método para obter todos os resultados dos testes
    def self.test_results
      @@test_results
    end

    # Método para limpar os resultados
    def self.clear_results
      @@test_results = []
    end

    # Método para gerar relatório final
    def self.generate_report
      passed_tests = @@test_results.select { |r| r[:status] == :passed }
      failed_tests = @@test_results.select { |r| r[:status] == :failed }

      puts "\n" + "=" * 60
      puts "RELATÓRIO FINAL DOS TESTES"
      puts "=" * 60
      puts "✅ Testes que passaram: #{passed_tests.count}"
      puts "❌ Testes que falharam: #{failed_tests.count}"
      puts "📊 Total de testes: #{@@test_results.count}"
      puts "=" * 60

      if failed_tests.any?
        puts "\n❌ TESTES QUE FALHARAM:"
        puts "-" * 40
        failed_tests.each do |test|
          puts "• #{test[:test_name]}"
          puts "  Erro: #{test[:error].message}"
          puts "  Local: #{test[:error].backtrace.first}"
          puts
        end
      end

      if passed_tests.any?
        puts "\n✅ TESTES QUE PASSARAM:"
        puts "-" * 40
        passed_tests.each do |test|
          puts "• #{test[:test_name]}"
        end
      end

      puts "=" * 60
      puts failed_tests.empty? ? "🎉 TODOS OS TESTES PASSARAM!" : "⚠️  ALGUNS TESTES FALHARAM!"
      puts "=" * 60
    end
  end
end

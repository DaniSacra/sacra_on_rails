require_relative 'specs/user_spec'

class RunTests

  def self.run_tests
    puts "=" * 60
    puts "INICIANDO TESTES DO SACRA ON RAILS FRAMEWORK"
    puts "=" * 60
    
    begin
      UserSpec.run()
    rescue StandardError => e
      puts "=" * 60
      puts "ERRO CRÍTICO NO SISTEMA DE TESTES: #{e.message}"
      puts "=" * 60
      puts e.backtrace.first(5).join("\n")
      puts "=" * 60
    end
  end

end

RunTests.run_tests


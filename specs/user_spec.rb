require_relative '../lib/sacra_on_rails'
require_relative '../user'

class UserSpec < SacraOnRails::TestCase

  def self.run
    puts "\n🧪 INICIANDO TESTES DO MODELO USER"
    puts "-" * 50
    
    # Limpar dados anteriores para testes isolados
    User.class_variable_get(:@@records)[User] = []
    
    # Limpar resultados anteriores
    clear_results
    
    # Teste 1: Validação obrigatória do name
    test "Validação obrigatória do name" do
      user = User.new(email: "test@email.com", password: "123456")
      assert !user.save, "Usuário sem name não deve ser salvo"
      puts "  ✅ Validação do name funcionando"
    end
    
    # Teste 2: Validação obrigatória do email
    test "Validação obrigatória do email" do
      user = User.new(name: "João", password: "123456")
      assert !user.save, "Usuário sem email não deve ser salvo"
      puts "  ✅ Validação do email funcionando"
    end
    
    # Teste 3: Validação obrigatória do password
    test "Validação obrigatória do password" do
      user = User.new(name: "João", email: "test@email.com")
      assert !user.save, "Usuário sem password não deve ser salvo"
      puts "  ✅ Validação do password funcionando"
    end
    
    # Teste 4: Save com todos os atributos obrigatórios
    test "Save com todos os atributos obrigatórios" do
      user = User.new(name: "João Silva", email: "joao@email.com", password: "123456")
      assert user.save, "Usuário com todos os atributos deve ser salvo"
      puts "  ✅ Save com atributos obrigatórios funcionando"
    end
    
    # Teste 5: Método count
    test "Método count" do
      # Adicionar mais usuários para testar count
      user2 = User.new(name: "Maria Silva", email: "maria@email.com", password: "654321")
      user3 = User.new(name: "Pedro Santos", email: "pedro@email.com", password: "789012")
      user2.save
      user3.save
      
      assert_equal 3, User.count, "Count deve retornar 3 usuários"
      puts "  ✅ Método count funcionando"
    end
    
    # Teste 6: Método all
    test "Método all" do
      all_users = User.all
      assert_equal 3, all_users.size, "Método all deve retornar 3 usuários"
      assert all_users.first.is_a?(User), "Método all deve retornar objetos User"
      assert all_users.all? { |user| user.is_a?(User) }, "Todos os itens devem ser objetos User"
      puts "  ✅ Método all funcionando"
    end
    
    # Teste 7: Método find_by por name
    test "Método find_by por name" do
      found_user = User.find_by(name: "João Silva")
      assert found_user, "find_by deve encontrar usuário por name"
      assert_equal "João Silva", found_user.name, "Usuário encontrado deve ter o name correto"
      puts "  ✅ Método find_by por name funcionando"
    end
    
    # Teste 8: Método find_by por email
    test "Método find_by por email" do
      found_user = User.find_by(email: "joao@email.com")
      assert found_user, "find_by deve encontrar usuário por email"
      assert_equal "joao@email.com", found_user.email, "Usuário encontrado deve ter o email correto"
      puts "  ✅ Método find_by por email funcionando"
    end
    
    # Teste 9: Método find_by sem resultado
    test "Método find_by sem resultado" do
      found_user = User.find_by(name: "Inexistente")
      assert_nil found_user, "find_by deve retornar nil quando não encontra"
      puts "  ✅ Método find_by sem resultado funcionando"
    end
    
    # Teste 10: Callback before_save
    test "Callback before_save" do
      user = User.new(name: "Maria", email: "maria@email.com", password: "senha123")
      user.save
      assert_equal "321anres", user.password, "Callback before_save deve inverter o password"
      puts "  ✅ Callback before_save funcionando"
    end
    
    # Gerar relatório final
    generate_report
  end

end

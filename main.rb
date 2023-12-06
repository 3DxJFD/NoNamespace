module NoNamespace
  module IntProcess

    # Método para criar o botão na barra de ferramentas
    def self.create_toolbar_button
      toolbar = UI::Toolbar.new "IntProcess"

      # Adiciona um botão à barra de ferramentas
      cmd = UI::Command.new("Minha Função do Botão") {
        self.my_button_action
      }
      cmd.small_icon = File.join(File.dirname(__FILE__), 'icons', 'icon.png')
      cmd.large_icon = cmd.small_icon
      cmd.tooltip = "Clique para criar seu Módulo"
      cmd.status_bar_text = "Criar Módulo"
      toolbar = toolbar.add_item(cmd)

      # Mostra a barra de ferramentas
      toolbar.show
    end

    # Método chamado quando o botão é clicado
    def self.my_button_action
      novo_modulo
    end

    # Método para agrupar componentes selecionados em um novo componente
    def self.group_selected_components
      model = Sketchup.active_model
      entities = model.active_entities
      selection = model.selection

      temp_group = entities.add_group(selection.to_a)
      new_component = temp_group.to_component

      selection.clear
      selection.add(new_component)

      puts "Componentes agrupados com sucesso!"
    end

    # Método para adicionar um atributo ao componente
    def self.adicionar_atributo(component, value)
      component.set_attribute('dynamic_attributes', 'int_mod', value)
    end

    # Método para renomear o componente com o valor do atributo "int_mod"
    def self.renomear_component(component)
      int_mod_value = component.get_attribute('dynamic_attributes', 'int_mod')
      component.name = int_mod_value.to_s if int_mod_value
    end

    # Método para verificar se um componente está selecionado
    def self.component_selected?
      selection = Sketchup.active_model.selection
      selection.length == 1 && selection.first.is_a?(Sketchup::ComponentInstance)
    end

    # Método para obter o valor do atributo "int_mod" do usuário
    def self.get_int_mod_value_from_user
      input = UI.inputbox(['Digite o nome do Módulo:'], [''], 'Digite o nome do Módulo')
      input ? input[0].to_s : nil
    end

    # Método principal chamado pelo botão
    def self.novo_modulo
      if component_selected?
        component = Sketchup.active_model.selection.first
        int_mod_value = get_int_mod_value_from_user

        if int_mod_value
          adicionar_atributo(component, int_mod_value)
          renomear_component(component)
          puts "Atributo 'int_mod' adicionado e componente renomeado com sucesso!"
        else
          puts "Nenhum valor inserido. Nenhuma ação realizada."
        end
      else
        puts "Selecione exatamente um componente para adicionar o atributo 'int_mod'."
      end

      Sketchup.active_model.selection.grep(Sketchup::ComponentInstance).each do |component|
        $dc_observers.get_latest_class.redraw_with_undo(component)
      end
    end

    # Certifica-se de que o botão da barra de ferramentas seja criado quando o arquivo for carregado
    unless file_loaded?(__FILE__)
      create_toolbar_button
      file_loaded(__FILE__)
    end

  end # module IntProcess
end # module NoNamespace

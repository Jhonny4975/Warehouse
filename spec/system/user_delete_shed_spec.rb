# frozen_string_literal: true

require 'rails_helper'

describe 'User delete a shed' do
  it 'with sucess' do
    registered_shed = create(:shed)

    visit shed_path(registered_shed.id)
    click_on 'Deletar Galpão'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Não há nenhum galpão cadastrado...'
    expect(page).not_to have_content registered_shed.name
  end

  it 'without deleting other sheds' do
    first_shed = create(:shed)
    second_shed = create(:shed)

    visit shed_path(second_shed.id)
    click_on 'Deletar Galpão'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Galpão excluído com sucesso!'
    expect(page).to have_content first_shed.name
  end
end

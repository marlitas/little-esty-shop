require 'rails_helper'

RSpec.describe Repo do
  it 'has attributes' do
    repo = Repo.new(name: 'test repo')
    expect(repo.name).to eq('test repo')
  end
end

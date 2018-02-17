RSpec.shared_examples 'not signed up user' do

  it 'redirects to new session path' do
    should redirect_to(root_path)
  end

end
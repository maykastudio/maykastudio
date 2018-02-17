RSpec.shared_examples 'unauthorized user' do

  it 'redirects to root path' do
    should redirect_to(root_path)
  end

end
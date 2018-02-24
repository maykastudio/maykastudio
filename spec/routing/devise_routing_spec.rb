require 'rails_helper'

describe 'User devise routing' do

  it 'user can not destroy self' do
    expect(delete: 'users').not_to be_routable
  end

  it 'user can not edit self via devise form' do
    expect(patch: 'users').not_to be_routable
  end

  it 'user can not update self via devise form' do
    expect(get: 'users/edit').not_to be_routable
  end

  it 'user can not cancel registration' do
    expect(get: 'users/cancel').not_to be_routable
  end

  it 'user can view sign_in form' do
    expect(get: 'users/sign_in').to be_routable
  end

  it 'user can sign_in' do
    expect(post: 'users/sign_in').to be_routable
  end

  it 'user can sign_out' do
    expect(delete: 'users/sign_out').to be_routable
  end

end
require 'rails_helper'

RSpec.describe Manage::ImagesController, type: :controller do

  let(:project){ create(:project) }

  shared_examples 'not signed up access to images' do
    describe 'GET #index' do
      let(:image_attrs){ attributes_for(:image) }

      before(:each){ process :create, method: :post, params: { project_id: project.id, image: image_attrs } }
      it_behaves_like 'not signed up user'
    end
  end

  shared_examples 'unauthorized access to images' do
    describe 'GET #index' do
      let(:image_attrs){ attributes_for(:image) }

      before(:each){ process :create, method: :post, params: { project_id: project.id, image: image_attrs } }
      it_behaves_like 'unauthorized user'
    end
  end

  context 'when current user not logged in' do
    before(:each){ sign_out(:user) }

    include_examples 'not signed up access to images'
  end

  context 'when current user logged in, but not an admin' do
    before(:each){ sign_in(create(:user)) }

    include_examples 'unauthorized access to images'
  end

  context 'when current user is admin' do
    let(:current_user){ create(:user, :administrator) }
    let!(:project){ create(:project, user: current_user) }

    before(:each){ sign_in(current_user) }

    describe 'POST #create' do
      context 'when attributes invalid' do
        let(:image_attrs){ attributes_for(:image, :invalid) }

        it 'not creates image in database' do
          expect {
            post :create, method: :post, params: { project_id: project.id, image: image_attrs }, format: :json
          }.not_to change(Image, :count)
        end
      end

      context 'when attributes valid' do
        let(:image_attrs){ attributes_for(:image) }

        it 'creates image in database' do
          expect {
            post :create, params: { project_id: project.id, image: image_attrs, file: image_attrs[:file] }, format: :json
          }.to change(Image, :count).by(1)
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:image){ create(:image, project: project) }

      it 'removes image from database' do
        expect{
          delete :destroy, params: { project_id: project.id, id: image.id }
        }.to change(Image, :count).by(-1)

        expect(Image.exists?(id: image.id)).to be_falsey
      end
    end

  end

end
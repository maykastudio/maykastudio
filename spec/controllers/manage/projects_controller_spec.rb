require 'rails_helper'

RSpec.describe Manage::ProjectsController, type: :controller do

  shared_examples 'not signed up access to projects' do
    describe 'GET #index' do
      before(:each){ process :index }
      it_behaves_like 'not signed up user'
    end
  end

  shared_examples 'unauthorized access to projects' do
    describe 'GET #index' do
      before(:each){ process :index }
      it_behaves_like 'unauthorized user'
    end
  end

  context 'when current user not logged in' do
    before(:each){ sign_out(:user) }

    include_examples 'not signed up access to projects'
  end

  context 'when current user logged in, but not an admin' do
    before(:each){ sign_in(create(:user)) }

    include_examples 'unauthorized access to projects'
  end

  context 'when current user is admin' do
    let(:current_user){ create(:user, :administrator) }
    before(:each){ sign_in(current_user) }

    describe 'GET #index' do
      let!(:projects) { 3.times.map{ create(:project, user: current_user) }}

      it 'assigns projects to @projects' do
        process :index
        expect(assigns(:projects)).to match_array(projects)
      end

      it do
        process :index
        should render_template(:index)
      end
    end

    describe 'GET #new' do
      it 'assigns new project instance to @project' do
        process :new, method: :get
        expect(assigns(:project)).to be_a_new(Project)
      end

      it do
        process :new
        should render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'when attributes invalid' do
        let(:project_attrs){ attributes_for(:project, :invalid) }

        it 'not creates project in database' do
          expect {
            process :create, method: :post, params: { project: project_attrs }
          }.not_to change(Project, :count)
        end
      end

      context 'when attributes valid' do
        let(:project_attrs){ attributes_for(:project) }

        it 'creates project in database' do
          expect {
            process :create, method: :post, params: { project: project_attrs }
          }.to change(Project, :count).by(1)
        end
      end
    end

    describe 'GET #edit' do
      let!(:project) { create(:project, user: current_user) }

      it 'assigns project to @project' do
        process :edit, method: :get, params: { id: project.id }
        expect(project).to eq(assigns(:project))
      end

      it do
        process :edit, method: :get, params: { id: project.id }
        should render_template(:edit)
      end
    end

    describe 'PATCH #update' do
      let!(:project) { create(:project, user: current_user) }

      context 'when invalid attributes' do
        let(:project_attrs){ attributes_for(:project, :invalid) }

        it 'does not change project' do
          old_title = project.title
          process :update, method: :patch, params: { id: project.id, project: project_attrs }
          project.reload
          expect(project.title).to eq(old_title)
        end
      end

      context 'when valid attributes' do
        let(:project_attrs){ attributes_for(:project) }

        it 'should not update project' do
          process :update, method: :patch, params: { id: project.id, project: project_attrs }
          project.reload
          expect(project.title).to eq(project_attrs[:title])
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:project) { create(:project, user: current_user) }

      it 'removes project from database' do
        expect{
          delete :destroy, params: { id: project.id }
        }.to change(Project, :count).by(-1)

        expect(Project.exists?(id: project.id)).to be_falsey
      end
    end

  end

end
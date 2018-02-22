require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #show" do
    context "when project is not published" do
      let(:project){ create(:project, :hidden) }
      
      it "should not assigns project to @project" do
        process :show, method: :get, params: { id: project.code }
        expect(assigns(:project)).to eq(nil)
      end

      it do
        process :show, method: :get, params: { id: project.code }
        should render_template(:show)
      end
    end
    
    context "when project is published" do
      let(:project){ create(:project, :published) }

      it "assigns project to @project" do
        process :show, method: :get, params: { id: project.code }
        expect(assigns(:project)).to eq(project)
      end
      
      it do
        process :show, method: :get, params: { id: project.code }
        should render_template(:show)
      end
    end
  end

  describe "#select" do

    context "when project not published" do
      let(:project){ create(:project, :hidden, download_count: 5) }
      let(:image){ create(:image, project: project) }

      it "should mark image as selected" do
        process :select, method: :post, params: { id: project.code, project: { images: [image.id] } }, format: :json
        image.reload

        expect(image.selected).to be_falsey
      end
    end

    context "when project not allow download images" do
      let(:project){ create(:project, :published, download_count: 0) }
      let(:image){ create(:image, project: project) }

      it "should mark image as selected" do
        process :select, method: :post, params: { id: project.code, project: { images: [image.id] } }, format: :json
        image.reload

        expect(image.selected).to be_falsey
      end
    end

    context "when project published" do
      let(:project){ create(:project, :published, download_count: 5) }
      let(:image){ create(:image, project: project) }

      it "should mark image as selected" do
        process :select, method: :post, params: { id: project.code, project: { images: [image.id] } }, format: :json
        image.reload

        expect(image.selected).to be_truthy
      end
    end
  end

end
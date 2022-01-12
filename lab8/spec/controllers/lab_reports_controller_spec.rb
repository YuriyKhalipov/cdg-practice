require 'rails_helper'

RSpec.describe LabReportsController, :type => :controller do
  let(:user) { create(:user) }
  let(:params) { { user_id: user } }

  before { sign_in user }

  describe '#index' do
    subject { get :index, params: params }

    let!(:lab_report) { create :lab_report, user: user }

    it 'assigns @lab_report' do
      subject
      expect(assigns(:lab_reports)).to eq([lab_report])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#new' do
    subject { get :new, params: params }
    
    context 'when user signed_in' do
      it { is_expected.to render_template(:new) }

      it 'assigns new lab' do
        subject
        expect(assigns(:lab_report)).to be_a_new LabReport
      end
    end
  end

  describe '#create' do
    let(:params) do
      {
        user_id: user.id,
        lab_report: attributes_for(:lab_report) 
      }
    end

    subject { post :create, params: params }

    it 'create lab_report' do
      expect { subject }.to change { LabReport.count }.by(1)
      is_expected.to redirect_to(lab_reports_path)
    end

    context 'when params are invalid' do
      let(:params) do
        { user_id: user.id, lab_report: { title: nil } }
      end

      it { is_expected.to render_template(:new) }
      it { expect { subject }.not_to change { LabReport.count } }
    end
  end

  describe '#edit' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :edit, method: :get, params: params }

    it { is_expected.to render_template(:edit) }

    it 'assigns server policy' do
      subject
      expect(assigns(:lab_report)).to eq lab_report
    end
  end

  describe '#update' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user, lab_report: { title: 'New title', description: 'New description' } } }

    subject { process :update, method: :put, params: params }
    
    it { is_expected.to redirect_to(lab_reports_path) }

    it 'updates title' do
      expect { subject }.to change { lab_report.reload.title }.to('New title')
    end

    it 'updates description' do
      expect { subject }.to change { lab_report.reload.description }.to('New description')
    end

    context 'with bad params' do
      let(:params) { { id: lab_report, user_id: user, lab_report: { title: '', description: '' } } }

      it 'should not update lab_report' do
        expect { subject }.not_to change { lab_report.reload.title }
        expect { subject }.not_to change { lab_report.reload.description }
      end
    end
  end

   describe '#destroy' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :destroy, method: :delete, params: params }

    it 'deletes lab_report' do
      expect { subject }.to change { LabReport.count }.by(-1)
    end
  end

  describe '#mark' do
    let!(:lab_report) { create :lab_report, user: user }
    let(:params) { { id: lab_report, user_id: user } }

    subject { process :edit, method: :get, params: params }

    it { is_expected.to render_template(:edit) }

    it 'assigns server policy' do
      subject
      expect(assigns(:lab_report)).to eq lab_report
    end
  end
end
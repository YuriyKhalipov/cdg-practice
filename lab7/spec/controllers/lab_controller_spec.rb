require 'rails_helper'

# Тесты контроллера "Лабораторных работ"
RSpec.describe LaboratoryWorksController, type: :controller do
  let(:user) { create :user }
  let(:params) { { user_id: user } }

  describe '#index' do
    subject { get :index, params: params }

    let!(:lab) { create :laboratory_work, user: user }

    it 'assigns @lab' do
      subject
      expect(assigns(:labs)).to eq([lab])
    end

    it { is_expected.to render_template('index') }
  end

  describe '#new' do
    subject { get :new, params: params }

    it 'assigns new lab' do
      subject
      expect(assigns(:lab)).to be_a_new LaboratoryWork
    end

    it { is_expected.to render_template(:new) }
  end

  describe '#edit' do
    let!(:laboratory_work) { create :laboratory_work, user: user }
    let(:params) { { id: laboratory_work, user_id: user } }

    subject { process :edit, method: :get, params: params }

    it 'assigns @lab needed laboratory_work' do
      subject
      expect(assigns(:lab)).to eq laboratory_work
    end

    it { is_expected.to render_template(:edit) }
  end

  describe '#update' do
    let!(:lab) { create :laboratory_work, user: user }
    let(:params) { { id: lab, user_id: user, laboratory_work: { title: 'Новое название', text: 'Новый текст' } } }

    subject { process :update, method: :put, params: params }

    it 'updates title' do
      expect { subject }.to change { lab.reload.title }.to('Новое название')
    end

    it 'updates text' do
      expect { subject }.to change { lab.reload.text }.to('Новый текст')
    end

    context 'with bad params' do
      let(:params) { { id: lab, user_id: user, laboratory_work: { title: '', text: '' } } }

      it 'should not update lab' do
        expect { subject }.not_to change { lab.reload.title }
      end
    end
  end

  describe '#show' do
    let(:params) { { user_id: user.id, id: laboratory_work } }

    subject { get :show, params: params }

    let!(:laboratory_work) { create :laboratory_work, user: user }

    it 'assigns @lab' do
      subject
      expect(assigns(:lab)).to eq(laboratory_work)
    end

    it { is_expected.to render_template(:show) }
  end

  describe '#destroy' do
    let!(:laboratory_work) { create :laboratory_work, user: user }
    let(:params) { { id: laboratory_work, user_id: user } }

    subject { process :destroy, method: :delete, params: params }

    it 'delete laboratory_work' do
      expect { subject }.to change { LaboratoryWork.count }.by(-1)
    end

  end

  describe '#mark' do
    let!(:laboratory_work) { create :laboratory_work, user: user }
    let(:params) { { id: laboratory_work, user_id: user } }

    subject { process :mark, method: :get, params: params }

    it { is_expected.to render_template(:mark) }

    it 'assigns @lab needed laboratory_work' do
      subject
      expect(assigns(:lab)).to eq laboratory_work
    end

    it { is_expected.to render_template('mark') }
  end
end

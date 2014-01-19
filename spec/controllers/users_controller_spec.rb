# -*- coding: utf-8 -*-
require 'spec_helper'

describe UsersController do
  let!(:user) { create :user }
  before { session[:user_id] = user.id }

  describe 'GET #retire' do
    it '200を返すこと' do
      get :retire
      expect(response.status).to eq(200)
    end

    it 'retire を render していること' do
      get :retire
      expect(response).to render_template('retire')
    end
  end

  describe 'DELETE #destroy' do
    context 'current_user.destroy が true を返すとき' do
      before do
        allow(controller).to receive(:current_user) { double('current_user', destroy: true) }
      end

      it 'session[:user_id] がnilであること' do
        delete :destroy
        expect(session[:user_id]).to be_nil
      end

      it 'トップページにリダイレクトされること' do
        delete :destroy
        expect(response).to redirect_to(root_path)
      end
    end

    context 'current_user.destroy が false を返すとき' do
      before do
        allow(controller).to receive(:current_user) { double('current_user', destroy: false) }
      end

      it 'retire を render していること' do
        delete :destroy
        expect(response).to render_template('retire')
      end
    end
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'

    @report = reports(:report_by_alice)
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_path
    click_link '日報の新規作成'

    fill_in 'タイトル', with: 'I mentioned Bob\'s report.'
    fill_in '内容', with: 'http://localhost:3000/reports/2'
    click_button '登録する'

    assert_text '日報が作成されました。'
    assert_text 'I mentioned Bob\'s report.'
    assert_text 'http://localhost:3000/reports/2'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '更新しました'
    fill_in '内容', with: '更新完了！'
    click_button '更新する'

    assert_text '日報が更新されました。'
    assert_text '更新しました'
    assert_text '更新完了！'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_selector 'h1', text: '日報の一覧'
    assert_no_text 'I mentioned Bob\'s report.'
    assert_no_text 'http://localhost:3000/reports/2'
  end
end

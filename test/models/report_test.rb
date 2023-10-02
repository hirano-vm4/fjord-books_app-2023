# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
    @report_by_alice = reports(:report_by_alice)
    @report_by_bob = reports(:report_by_bob)
  end

  test 'editable?' do
    assert @report_by_alice.editable?(@alice)
    assert_not @report_by_alice.editable?(@bob)
  end

  test 'create_on' do
    @report_by_alice.created_at = Time.parse('Sat, 23 Sep 2023 15:33:00.000000000 JST +09:00')
    assert_equal '2023/9/23'.to_date, @report_by_alice.created_on
  end
end

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
    @report_by_alice.created_at = '2023-09-23 15:33'.in_time_zone
    assert_equal '2023/9/23'.to_date, @report_by_alice.created_on
  end
end

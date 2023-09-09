# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention', foreign_key: :mentioning_report_id, inverse_of: :mentioning_report, dependent: :destroy
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report

  has_many :passive_mentions, class_name: 'Mention', foreign_key: :mentioned_report_id, inverse_of: :mentioned_report, dependent: :destroy
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_report_and_mentions
    ActiveRecord::Base.transaction do
      save!
      save_mentions
    end
  end

  def update_report_and_mentions(params)
    ActiveRecord::Base.transaction do
      update!(params)
      save_mentions
    end
  end

  def save_mentions
    new_mention_ids = scan_mentions
    old_mention_ids = mentioning_reports.ids

    added_mentions = new_mention_ids - old_mention_ids

    added_mentions.each do |added_mention|
      mention = Mention.new(mentioning_report_id: id, mentioned_report_id: added_mention)
      mention.save!
    end

    deleted_mentions = old_mention_ids - new_mention_ids
    Mention.where(mentioning_report_id: id, mentioned_report_id: deleted_mentions).destroy_all
  end

  def scan_mentions
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.uniq.map(&:to_i)
  end
end

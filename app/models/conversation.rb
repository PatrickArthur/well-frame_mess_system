class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  has_many :participants
  has_many :users, :through => :participants
  has_many :messages, dependent: :destroy
  validates_presence_of :subject, :sender_id
  validate :has_recipients

  def has_recipients
    errors.add(:base, 'must add at least one Recipient') if self.users.blank?
  end

  def recipients
    self.users.select {|user| user.id != self.sender.id}.map {|rec| rec.email}
  end
end

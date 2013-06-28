class UserGroup < ActiveRecord::Base
  attr_accessible :name, :user_group_members_attributes

  has_many :user_group_members, :dependent => :destroy
  has_many :users, :through => :user_group_members

  belongs_to :container, :polymorphic => true
  
  accepts_nested_attributes_for :user_group_members, :allow_destroy => true

  validates_presence_of :name

  def managers
    return [] if !container.nil?
    UserGroupMember.find_all_by_user_group_id_and_is_manager(id, true)
  end

  def full_name
    container.nil? ? name : "#{container.name} #{name}"
  end
  
  def add_member(user, manager = false)
    return false if user.nil?
    ugm = UserGroupMember.new(:is_manager => (container.nil? && manager))
    ugm.user_group = self
    ugm.user = user
    return false unless ugm.save
    ugm
  end

  def remove_member(user)
    return false if user.nil?
    ugm = UserGroupMember.find_by_user_group_id_and_user_id(id, user.id)
    return false if ugm.nil?
    ugm.destroy
  end
  
  def is_member?(user)
    return false if user.nil?
    !UserGroupMember.find_by_user_group_id_and_user_id(id, user.id).nil?
  end

  def is_manager?(user)
    return false if (user.nil? || !container.nil?)
    user_group_member = UserGroupMember.find_by_user_group_id_and_user_id(id, user.id)
    return false if user_group_member.nil?
    user_group_member.is_manager
  end

  def update_callback
    user_group_members.first.update_attribute(:is_manager, true) if (container.nil? && managers.empty?)
  end

  def destroy_callback
    destroy if (container.nil? && user_group_members.empty?)
  end
  
  ##########################
  # Access control methods #
  ##########################

  def can_be_read_by?(user)
    is_member?(user)
  end
    
  def can_be_created_by?(user)
    !user.nil?
  end
  
  def can_be_updated_by?(user)
    is_manager?(user)
  end
  
  def can_be_destroyed_by?(user)
    can_be_updated_by?(user)
  end
end

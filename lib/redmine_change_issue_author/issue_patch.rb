require_dependency 'issue'

module RedmineChangeIssueAuthor
  module IssuePatch
    def self.included(base)
      base.class_eval do

        before_create :set_author_journal
        safe_attributes 'author_id',
          :if => lambda {|issue, user| (user.allowed_to?(:edit_issue_author, issue.project))}

        def set_author_journal
          return unless new_record?
          return unless self.author.present? && User.current.present? && self.author != User.current
      
          self.init_journal(User.current)
          self.current_journal.__send__(:add_attribute_detail, 'author_id', User.current.id, self.author.id)
        end

      end
    end
  end
end
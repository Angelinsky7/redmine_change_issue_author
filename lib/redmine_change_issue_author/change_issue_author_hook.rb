module RedmineChangeIssueAuthor
    module ChangeIssueAuthorHook
        class Hooks < Redmine::Hook::ViewListener
          render_on :view_issues_form_details_top, :partial => 'issues/change_issue_author'
          render_on :view_issues_bulk_edit_details_bottom, :partial => 'issues/bulk_edit_issue_author'
        end
    end
end
require_dependency 'issues_helper'

module RedmineChangeIssueAuthor
  module IssuesHelperPatch
    def self.included(base)
      base.class_eval do

        def show_detail_with_author(detail, no_html=false, options={})
          if detail.property == 'attr' && detail.prop_key == 'author_id' && detail.value =~ /^[0-9]+$/ && detail.old_value =~ /^[0-9]+$/
  
            field = detail.prop_key.to_s.gsub(/\_id$/, "")
  
            detail[:value] = find_name_by_reflection(field, detail.value)
            detail[:old_value] = find_name_by_reflection(field, detail.old_value)
          end
  
          return show_detail_without_author(detail, no_html, options)
        end
        alias_method :show_detail_without_author, :show_detail
        alias_method :show_detail, :show_detail_with_author

        def author_options_for_select(issue, project)
          users = project.users.select {|m| m.is_a?(User) && m.allowed_to?(:add_issues, project) }
      
          if issue.new_record?
            if users.include?(User.current)
              principals_options_for_select(users, issue.author)
            else
              principals_options_for_select([User.current] + users)
            end
          elsif issue.persisted?
            if users.include?(issue.author)
              principals_options_for_select(users, issue.author)
            else
              author_principal = Principal.find(issue.author_id)
              principals_options_for_select([author_principal] + users, author_principal)
            end
          end
        end

      end
    end
  end
end
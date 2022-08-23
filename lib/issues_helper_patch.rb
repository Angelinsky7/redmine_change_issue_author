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

      end
    end
  end
end
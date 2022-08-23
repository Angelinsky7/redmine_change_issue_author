require_dependency 'redmine_change_issue_author/change_issue_author_hook'

Issue.send(:include, RedmineChangeIssueAuthor::IssuePatch)
IssuesHelper.send(:include, RedmineChangeIssueAuthor::IssuesHelperPatch)

Redmine::Plugin.register :redmine_change_issue_author do
  name 'Change issue author plugin'
  author 'Frederik Jung'
  description 'This plugin provides the ability to change the issue author'
  version '0.0.2'
  url 'http://mcl.de'
  author_url 'mailto:frederik.jung@mcl.de'
  requires_redmine :version_or_higher => '2.0.0'
  
  project_module :issue_tracking do
    permission :edit_issue_author, {}
  end
end
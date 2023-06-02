require 'redmine'

Redmine::Plugin.register :calculating_hours do
  name 'Calculating Hours'
  author 'Слепченко Николай'
  description 'При создания задачи добавлен чекбокс "Автоматический расчет срока исполнения".'
  version '0.0.2'
  url 'http://example.com/path/to/plugin'
  author_url 'https://github.com/SKOLIA0'

  # Переопределение контроллера и модели.
  require_dependency File.expand_path('../app/controllers/calculating_hours/issues_controller_calculating_hours_patch', __FILE__)
  require_dependency File.expand_path('../app/models/calculating_hours/issue_calculating_hours_patch', __FILE__)
end

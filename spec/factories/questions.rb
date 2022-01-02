FactoryBot.define do
  factory :question do
    title { 'Railsアプリの開発方法' }
    content { 'Railsアプリの開発は何のコマンドから始めるべきですか？' }
    user
  end
end

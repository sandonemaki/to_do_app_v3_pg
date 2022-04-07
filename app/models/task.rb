class Task < ApplicationRecord
  validates :content, presence: {message: "タスクの内容を入力して下さい"}
  validates :content, length: {maximum: 20, message: "タスクの内容は20文字までです"}
  validates :image_status, presence: {message: "もう一度保存して下さい"}
end

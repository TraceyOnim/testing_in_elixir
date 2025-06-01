defmodule CreateArticleController do
  def create_article(connection, params) do
    article = %Article{
      title: params["title"],
      body: params["body"],
      author_email: params["author_email"]
    }

    article_id = Database.create(article)
    send_response(connection, _status_code = 200, %{article_id: article_id})
  end
end

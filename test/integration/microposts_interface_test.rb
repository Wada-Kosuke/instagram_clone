require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user1)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_url
    # 無効な送信（画像未選択）
    content = "This micropost really ties the room together"
    picture = fixture_file_upload('test/fixtures/test.jpg', 'image/jpg')
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: content } }
    end
    follow_redirect!
    assert_select 'div.alert', text: "画像を選択してください"
    # 無効な送信（コメントが長過ぎる）
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { picture: picture, content: "a" * 141 } }
    end
    follow_redirect!
    assert_select 'div.alert', text: "コメントは140文字以内です"
    # 有効な送信
    picture = fixture_file_upload('test/fixtures/test.jpg', 'image/jpg')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { picture: picture, content: content } }
    end
    assert assigns(:micropost).picture?
    follow_redirect!
    # 投稿を削除する
    assert_select "a", text: '削除する'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # 違うユーザーのプロフィールにアクセス(削除リンクがないことを確認)
    get user_path(users(:user2))
    assert_select 'a', text: "delete", count: 0
  end
end

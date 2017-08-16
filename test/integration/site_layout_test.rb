require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
    test "layout links" do
        get root_path
        assert_template 'static_pages/home' # 检查首页是否使用正确的视图渲染
        # 检查改页面下a标签是否为指定的链接，count：指同一个链接的个数
        assert_select "a[href=?]", root_path,count:2
        assert_select "a[href=?]", help_path
        assert_select "a[href=?]", about_path
        assert_select "a[href=?]", contact_path
    end
end

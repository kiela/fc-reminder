require 'fakeweb'

FakeWeb.allow_net_connect = false

def fake_page_without_match(url)
  fake_html_page url, ""
end

def fake_page_with_match(url)
  file = File.join(GEM_ROOT, "spec", "support", "fakeweb", "fake_page_with_match.html")
  fake_html_page url, File.read(file)
end

def fake_html_page(url, body)
  FakeWeb.register_uri(:get, url, body: body, content_type: "text/html")
end

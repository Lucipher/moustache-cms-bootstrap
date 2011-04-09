
Factory.define :user do |user|
  user.sequence(:puid) { |n| "foobar_#{n}"}
  user.firstname "foobar" 
  user.lastname  "baz" 
  user.sequence(:email) { |n| "fbaz_#{n}@example.com" }
  user.role "admin" 
end

Factory.define :admin, :parent => :user do |admin|
  admin.role "admin" 
end

Factory.define :editor, :parent => :user do |editor|
  editor.role "editor"
end

Factory.define :filter do |filter|
  filter.name "filter"
end

Factory.define :site do |site|
  site.sequence(:name) { |n| "name_#{n}" }
  site.subdomain "foobar"
  site.default_domain  "example.com" 
  site.domains  { [] }
  site.meta_keywords "meta_keywords"
  site.meta_description "meta_description"
end

Factory.define :layout do |layout|
  layout.site_id { Factory(:site).id }
  layout.sequence(:name) { |n| "layout_#{n}" }
  layout.content "Hello, World!"
  layout.filter { Factory.build(:filter) }
  layout.created_by Factory.build(:user)
  layout.updated_by Factory.build(:user)
end

Factory.define :current_state do |cs|
  cs.name "published"
  cs.time DateTime.new
end

Factory.define :page_type do |page_type|
  page_type.name "page_type"
end

Factory.define :page_part do |pp|
  pp.sequence(:name) { |n| "page_part_#{n}" }
  pp.content "Hello, World!"
  pp.filter { Factory.build(:filter) }
end

Factory.define :page do |page|
  page.site_id { Factory(:site).id }
  page.parent_id { Factory(:root_page).id }
  page.sequence(:title) { |n| "title_#{n}" }
  page.sequence(:slug) { |n| "slug_#{n}" }
  page.sequence(:full_path) { |n| "full_path_#{n}" }
  page.sequence(:breadcrumb) { |n| "breadcrumb_#{n}" }
  page.layout { Factory.build(:layout) }
  page.current_state { Factory.build(:current_state) }
  page.editors {[ Factory.build(:user) ]}
  page.tags 
  page.page_parts {[ Factory.build(:page_part) ]}
  page.page_type { Factory.build(:page_type) }
  page.created_by { Factory.build(:user) }
  page.updated_by { Factory.build(:user) }
end

Factory.define :root_page, :parent => :page do |pp|
  pp.site_id { Factory(:site).id }
  pp.parent_id 
  pp.sequence(:title) { |n| "parent_title_#{n}" }
  pp.slug 
  pp.sequence(:full_path) { |n| "parent_full_path_#{n}" }
  pp.sequence(:breadcrumb) { |n| "parent_breadcrumb_#{n}" }
  pp.sequence(:meta_title) { |n| "parent_meta_title_#{n}"}
  pp.meta_keywords "parent_meta_keywords"
  pp.meta_description "parent_meta_description"
  pp.layout { Factory.build(:layout) }
  pp.current_state { Factory.build(:current_state) }
  pp.editors {[ Factory.build(:user) ]}
  pp.tags 
  pp.page_parts {[ Factory.build(:page_part) ]}
  pp.page_type { Factory.build(:page_type) }
  pp.created_by { Factory.build(:user) }
  pp.updated_by { Factory.build(:user) }
end

Factory.define :no_root_page, :parent => :page do |pp|
  pp.site_id { Factory(:site).id }
  pp.parent_id 
  pp.sequence(:title) { |n| "page_#{n}" }
  pp.slug 
  pp.sequence(:full_path) { |n| "page_full_path_#{n}" }
  pp.sequence(:breadcrumb) { |n| "page_breadcrumb_#{n}" }
  pp.sequence(:meta_title) { |n| "page_meta_title_#{n}"}
  pp.meta_keywords "page_meta_keywords"
  pp.meta_description "page_meta_description"
  pp.layout { Factory.build(:layout) }
  pp.current_state { Factory.build(:current_state) }
  pp.editors {[ Factory.build(:user) ]}
  pp.tags 
  pp.page_parts {[ Factory.build(:page_part) ]}
  pp.page_type { Factory.build(:page_type) }
  pp.created_by { Factory.build(:user) }
  pp.updated_by { Factory.build(:user) }
end

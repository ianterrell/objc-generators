//
//  <%= object.name %>.h
//  <%= @project_name %>
//
//  Generated by <%= @author %> on <%= Date.today.strftime("%m/%d/%Y") %>.
//  Copyright <%= Date.today.strftime("%Y") %> <%= @author %>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrankObject.h"

<% object.class_references.each do |clazz| -%>
@class <%= clazz %>;
<% end -%>

@interface <%= object.name %> : FrankObject {
<% object.fields.each do |field| -%>
  <%= field[:type] %><%= field[:name] %>;
<% end -%>

<% object.belongs_tos.each do |field| -%>
  <%= field[:type] %>_<%= field[:name] %>;
<% end -%>
<% object.has_manies.each do |field| -%>
  NSArray *_<%= field[:name] %>;
<% end -%>
}

<% object.fields.each do |field| -%>
@property(nonatomic,retain) <%= field[:type] %><%= field[:name] %>;
<% end -%>

<% object.belongs_tos.each do |field| -%>
@property(nonatomic,retain) <%= field[:type] %>_<%= field[:name] %>;
-(<%= field[:type] %>)<%= field[:name] %>;
-(<%= field[:type] %>)<%= field[:name] %>WithReload;
-(void)set<%= field[:name].camelize %>:(<%= field[:type] %>)obj;
<% end -%>

<% object.has_manies.each do |field| -%>
@property(nonatomic,retain) NSArray *_<%= field[:name] %>;
-(NSArray *)<%= field[:name] %>;
-(NSArray *)<%= field[:name] %>WithReload;
-(int)<%= field[:name] %>Count;
<% end -%>

<% object.methods.each do |method| -%>
<%= method[:signature] %>;
<% end -%>

@end

//
//  <%= object.name %>.h
//  <%= @project_name %>
//
//  Generated by <%= @author %> on <%= Date.today.strftime("%m/%d/%Y") %>.
//  Copyright <%= Date.today.strftime("%Y") %> <%= @author %>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface <%= object.name %> : SQLitePersistentObject {
<% object.fields.each do |field| -%>
  <%= field[:type] %><%= field[:name] %>;
<% end -%>
}

<% object.fields.each do |field| -%>
@property (nonatomic,readwrite<%= ",retain" if field[:type].ends_with?("*") %>) <%= field[:type] %><%= field[:name] %>;
<% end -%>

@end

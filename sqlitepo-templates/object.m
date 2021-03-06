//
//  <%= object.name %>.m
//  <%= @project_name %>
//
//  Generated by <%= @author %> on <%= Date.today.strftime("%m/%d/%Y") %>.
//  Copyright <%= Date.today.strftime("%Y") %> <%= @author %>. All rights reserved.
//

#import "<%= object.name %>.h"
#import "SQLiteInstanceManager.h"

@implementation <%= object.name %>

@synthesize <%= object.field_names.join(', ') %>;

DECLARE_PROPERTIES(
<% object.fields.each_with_index do |field, i| -%>
  DECLARE_PROPERTY(@"<%= field[:name] %>", @"@\"<%= field[:type].gsub(' ','').gsub('*','')%>\"")<%= "," unless i == object.fields.size-1 %>
<% end -%>
)

<% object.methods.each do |method| -%>
<%= method[:signature] %> {
<%= method[:code] %>
}
<% end -%>

+(void)deleteAll {
	NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@;", [<%= object.name %> tableName]];
  NSLog([NSString stringWithFormat:@"Executing SQL:  DELETE FROM %@;", [<%= object.name %> tableName]]);
  SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
  [manager executeUpdateSQL:sql];
  [manager vacuum];
  [<%= object.name %> clearCache];
}

- (void)dealloc
{
<% object.fields.select{|field|field[:type].ends_with?("*")}.each do |field| -%>
  [<%= field[:name] %> release];
<% end -%>
	[super dealloc];
}

@end

package pf::Authentication::Source::ADSource;

=head1 NAME

pf::Authentication::Source::ADSource

=head1 DESCRIPTION

=cut

use pf::Authentication::constants;
use pf::constants::authentication::messages;
use pf::Authentication::Source::LDAPSource;

use Moose;
extends 'pf::Authentication::Source::LDAPSource';

has '+type' => ( default => 'AD' );

=head2 available_attributes

Available ldap search attributes for Active Directory
memberOf:1.2.840.113556.1.4.1941: attribute is for nested group, see https://msdn.microsoft.com/en-us/library/aa746475%28v=vs.85%29.aspx

=cut

sub available_attributes {
  my $self = shift;
  my $super_attributes = $self->SUPER::available_attributes;
  my $ad_attributes =
    [
     { value => "sAMAccountName", type => $Conditions::SUBSTRING },
     { value => "sAMAccountType", type => $Conditions::SUBSTRING },
     { value => "userAccountControl", type => $Conditions::SUBSTRING },
     { value => "memberOf:1.2.840.113556.1.4.1941:", type => $Conditions::SUBSTRING },
    ];
  
  return [@$super_attributes, @$ad_attributes];
}

=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2016 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

__PACKAGE__->meta->make_immutable;
1;

# vim: set shiftwidth=4:
# vim: set expandtab:
# vim: set backspace=indent,eol,start:

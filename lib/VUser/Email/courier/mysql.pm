package VUser::Email::courier::mysql;

use warnings;
use strict;
use Pod::Usage;
use VUser::ExtLib qw( mkdir_p );

use vars qw(@ISA);

our $REVISION = (split (' ', '$Revision: 1.1 $'))[1];
our $VERSION = "0.2.0";

use VUser::Email::authlib;
push @ISA, 'VUser::Email::authlib';

sub new
{
    my $class = shift;
    my %cfg = @_;
    my $self = VUser::Email::authlib::new( $class, $cfg{Extension_courier_mysql} );

    return $self;
}

sub add_domain
{
    my $self = shift;
    my $domain = shift;
}

sub domain_exists
{
    my $self = shift;
    my $domain = shift;
}


sub list_domains
{
    my $self = shift;

    my $sql = "select " . $self->cfg( "domain_field" ) . " from ". $self->cfg('transport_table');
    my $sth = $self->{_dbh}->prepare($sql) or die "Can't list domains: ".$self->{_dbh}->errstr()."\n";
    $sth->execute( ) or die "Can't list domains: ".$self->{_dbh}->errstr()."\n";

    my @result;

    while( my $row = $sth->fetchrow_hashref() )
    {
	push( @result, $row->{ $self->cfg( "domain_field" )  } );
    }
    
    return @result;
}

1;

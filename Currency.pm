package Mo::utils::Currency;

use base qw(Exporter);
use strict;
use warnings;

use Error::Pure qw(err);
use Locale::Currency;
use Readonly;

Readonly::Array our @EXPORT_OK => qw(check_currency_code);

our $VERSION = 0.01;

my %codes;

sub check_currency_code {
	my ($self, $key) = @_;

	_check_key($self, $key) && return;

	if (! keys %codes) {
		%codes = map { $_ => 1 } Locale::Currency::all_currency_codes();
	}

	if (! exists $codes{$self->{$key}}) {
		err "Parameter '$key' must be a valid currency code.",
			'Value', $self->{$key},
		;
	}

	return;
}

sub _check_key {
	my ($self, $key) = @_;

	if (! exists $self->{$key} || ! defined $self->{$key}) {
		return 1;
	}

	return 0;
}

1;

__END__

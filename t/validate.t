use v6;
use Text::Twitter::Validator;
use YAMLish;
use Test;
plan 16;

my $t = load-yaml(slurp 't/data/validate.yaml')<tests>;
my $v = Text::Twitter::Validator.new;

for $t<lengths>.list {
    is $v.get-tweet-length(.<text>), .<expected>, .<description>;
}

for $t<tweets>.list {
    is $v.is-valid-tweet(.<text>), .<expected>, .<description>;
}

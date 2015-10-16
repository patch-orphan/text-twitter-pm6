use v6;
use Text::Twitter::Extractor;

# class for validating Tweet texts
class Text::Twitter::Validator {
    constant $max-tweet-length = 140;

    has Text::Twitter::Extractor $!extractor = Text::Twitter::Extractor.new;

    has Int $.short-url-length       = 23;
    has Int $.short-url-length-https = 23;

    method get-tweet-length (Str $text) {
        my $length = $text.codes;

        for $!extractor.extract-urls-with-indices($text) -> $url-entity {
            $length += $url-entity.start - $url-entity.end + (
                $url-entity.value ~~ m:i{ ^ 'https://' }
                    ?? $.short-url-length-https
                    !! $.short-url-length
            );
        }

        return $length;
    }

    method is-valid-tweet (Stringy $text) {
        # BOM: U+FFFE, U+FEFF
        # Special: U+FFFF
        # Direction change: U+202A..U+202E
        return
            so $text.defined
            && $text.chars
            && $text !~~ m{ <[
                \x[FFFE] \x[FEFF] \x[FFFF]
                \x[202A]..\x[202E]
            ]> }
            && $.get-tweet-length($text) <= $max-tweet-length;
    }
}
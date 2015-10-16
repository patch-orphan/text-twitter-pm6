use v6;
use Text::Twitter::Extractor::Entity;

class Text::Twitter::Extractor {
    method extract-urls-with-indices (Str $text) {
        my Text::Twitter::Extractor::Entity @urls;

        return @urls;
    }
}
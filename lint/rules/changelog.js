"use strict";

module.exports = [{
    names: ["CHANGELOG-RULE-001"],
    description: "Version header format",
    tags: ["headings", "headers", "changelog"],
    function: (params, onError) => {
        params.tokens.filter(function filterToken(token) {
            return token.type === "heading_open";
        }).forEach(function forToken(token) {
            if (token.tag === "h2") {
                if (/^## [vV]?\d+\.\d+\.\d+(-[0-9A-Za-z-.]+|)$/m.test(token.line)) {
                    return;
                }

                if (/^## [vV]?\d+\.\d+\.\d+(-[0-9A-Za-z-.]+|) - 20[12][0-9]-[01][0-9]-[0-3][0-9]$/m.test(token.line)) {
                    return;
                }

                if (/^## unreleased$/mi.test(token.line)) {
                    return;
                }

                return onError({
                    lineNumber: token.lineNumber,
                    detail: "Allowed formats: 'vX.X.X(-pre.release)' or 'vX.X.X(-pre.release) - YYYY-MM-DD' or 'UNRELEASED'",
                    context: token.line
                });
            }
        });
    }
}, {
    names: ["CHANGELOG-RULE-002"],
    description: "Type of changes format",
    tags: ["headings", "headers", "changelog"],
    function: (params, onError) => {
        params.tokens.filter(function filterToken(token) {
            return token.type === "heading_open";
        }).forEach(function forToken(token) {
            if (token.tag === "h3") {
                if (/^### (Added|Changed|Deprecated|Removed|Fixed|Security)$/m.test(token.line)) {
                    return;
                }

                return onError({
                    lineNumber: token.lineNumber,
                    detail: "Allowed types is: Added, Changed, Deprecated, Removed, Fixed or Security",
                    context: token.line
                });
            }
        });
    }
}, {
    names: ["CHANGELOG-RULE-003"],
    description: "Lists items without punctuation at the end",
    tags: ["lists", "changelog"],
    function: (params, onError) => {
        params.tokens.filter(function filterToken(token) {
            return token.type === "list_item_open";
        }).forEach(function forToken(token) {
            if (token.tag === "li") {
                if (/[;,\.]$/m.test(token.line)) {
                    return onError({
                        lineNumber: token.lineNumber,
                        detail: "'.', ';' or ',' at the end of list entry",
                        context: token.line
                    });
                }
            }
        });
    }
}, {
    names: ["CHANGELOG-RULE-004"],
    description: "Only one 'unreleased' version header allowed",
    tags: ["headings", "headers", "changelog"],
    function: (params, onError) => {
        let headers_count = 0;

        params.tokens.filter(function filterToken(token) {
            return token.type === "heading_open";
        }).forEach(function forToken(token) {
            if (token.tag === "h2") {
                if (/^## unreleased$/mi.test(token.line)) {
                    headers_count++;
                }

                if (headers_count >= 2) {
                    return onError({
                        lineNumber: token.lineNumber,
                        detail: "Remove duplicated header",
                        context: token.line
                    });
                }
            }
        });
    }
}, {
    names: ["CHANGELOG-RULE-005"],
    description: "Punctuation problem, do not use space before, only space after",
    tags: ["space", "punctuation", "changelog"],
    function: (params, onError) => {

        params.tokens.filter(function filterToken(token) {
            return ['heading_open', 'paragraph_open', 'list_item_open'].indexOf(token.type) !== -1;
        }).forEach(function forToken(token) {
            if (/\s+[,.;:]/mi.test(token.line)) {
                return onError({
                    lineNumber: token.lineNumber,
                    detail: "Remove space before punctuation",
                    context: token.line
                });
            }

            if ((/[,.;:]\s/mi.test(token.line)) === false) {
                return onError({
                    lineNumber: token.lineNumber,
                    detail: "Add space after punctuation",
                    context: token.line
                });
            }
        });
    }
}];

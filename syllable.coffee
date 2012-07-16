syllables = (word) ->
    word = word.toLowerCase().replace(/[^a-z]/g, '')
    problemWords = {
        simile: 3,
        forever: 3,
        shoreline: 2
    }
    return problemWords[word] if word of problemWords

    prefixSuffix = [
        /^un/,
        /^fore/,
        /ly$/,
        /less$/,
        /ful$/,
        /ers?$/,
        /ings?$/
    ]

    count = 0
    for fix in prefixSuffix
        tmp = word.replace(fix, '') 
        count++ if tmp != word
        word = tmp

    subSyllables = [
        /cial/,
        /tia/,
        /cius/,
        /cious/,
        /giu/,
        /ion/,
        /iou/,
        /sia$/,
        /[^aeiuoyt]{2,}ed$/,
        /.ely$/,
        /[cg]h?e[rsd]?$/,
        /rved?$/,
        /[aeiouy][dt]es?$/,
        /[aeiouy][^aeiouydt]e[rsd]?$/,
        /^[dr]e[aeiou][^aeiou]+$/,
        /[aeiouy]rse$/
    ]
    addSyllables = [
        /ia/,
        /riet/,
        /dien/,
        /iu/,
        /io/,
        /ii/,
        /[aeiouym]bl$/,
        /[aeiou]{3}/,
        /^mc/,
        /ism$/,
        /([^aeiouy])\1l$/,
        /[^l]lien/,
        /^coa[dglx]./,
        /[^gq]ua[^auieo]/,
        /dnt$/,
        /uity$/,
        /ie(r|st)$/
    ]

    for part in word.split(/[^aeiouy]+/)
        count++ if part isnt ''

    for sub in subSyllables
        count -= word.split(sub).length - 1

    for add in addSyllables
        count += word.split(add).length - 1

    return Math.max(1, count)

syllables2 = (word) ->
    processed = word.toLowerCase()
    suffix_bonus = 0
    if processed.match(/ly$/)
      suffix_bonus = 1
      processed = processed.replace(/ly$/, "")
    if processed.match(/[a-z]ed$/)
      suffix_bonus = 0 
      processed = processed.replace(/ed$/, "")
    processed = processed.replace(/iou|eau|ai|au|ay|ea|ee|ei|oa|oi|oo|ou|ui|oy/g, "@")
    processed = processed.replace(/qu|ng|ch|rt|[bcdfghjklmnpqrstvwxzh]/g, "=") 
    processed = processed.replace(/[aeiouy@][bcdfghjklmnpqrstvwxz=]e$/g, "@|") 
    processed = processed.replace(/[aeiouy]/g, "@")
    console.log processed
    return processed.split("@").length - 1 + suffix_bonus
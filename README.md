<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

> A plugin for [Oh My Fish][omf-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v3.0.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>
<br/>

This plugin uses your [`ALPHAVANTAGE_API_KEY`][av] to download the prices of
your [hledger][hledger] stock holdings and print them in a journal-friendly
format. This means you can have something like an [anacron][cron] job
periodically append the output to your active journal.

[av]: https://www.alphavantage.co
[hledger]: https://hledger.org
[cron]: https://linux.die.net/man/8/anacron

## Install

```fish
$ omf install stocks2ledger
```

## Usage

```fish
$ stocks2ledger
```

# License

[MIT][mit] © [Will Badart][author] et [al][contributors]


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/wbadart
[contributors]:   https://github.com/wbadart/plugin-stocks2ledger/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square

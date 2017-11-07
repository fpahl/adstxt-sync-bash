# adstxt-sync-bash

> Merge [ads.txt](https://iabtechlab.com/ads-txt/) entries from trusted sources.

## Configuration

Edit SOURCES and ADSTXT in [adstxt-sync.bash](adstxt-sync.bash):

```bash
SOURCES=(
    "/path/to/ads-local.txt"
    "https://tag.md-nx.com/config/site/<siteid>/ads.txt"
)
ADSTXT="/path/to/ads.txt"
```

## Manual Execution / Testing

Execute the bash script directly from command line:

```console
$> ./adstxt-sync.bash
```

## Cronjob Installation

Edit crontab:

```console
$> crontab -e
```

Install the following crontab to execute every two hours:

```text
# MIN HOUR DAY MONTH DAYOFWEEK COMMAND
0 */2 * * * /path/to/adstxt-sync.bash
```

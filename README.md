# tmobile_plot

Simple *nix shell script to plot the signal statistics for the T-Mobile Home Internet Nokia router. Many thanks to [u/estebond15](https://www.reddit.com/user/estebond15/) at Reddit for the code to grab the data from the router.

[Original Reddit Thread](https://www.reddit.com/r/tmobileisp/comments/msr2b0/bash_script_to_run_while_running_speed_tests_or/?utm_source=share&utm_medium=web2x&context=3)

## Dependancies

- GNUPLOT
- jq

## Usage

First, download the file and put it somewhere in your PATH. This is a simple shell script so make sure the executable bit is set using `chmod +x tmobile_plot.sh` or invoke directly with `sh tmobile_plot.sh`.

```sh
> ./tmobile_plot.sh -h
tmobile_plot [options]
  -h        Show help
  -l        Only log the data. Do not plot
  -d file   Set datafile to 'file'. Default is '/tmp/.data.cvs'
  -o file   Set graph output to 'file'. Default is 'datafile'.pdf with any 
            extensions removed
```

The script can be used in two ways. To simply pull the signal statistics from the router and stash it in a log file or it can additionally plot a graph of the data. 

For example, to log the statistics once a second:

```sh
> while true; do ./tmobile_plot.sh -d data.csv -l; sleep 1; done
```

To log the statistics once a second and produce a plot named 'data.pdf'

```sh
> while true; do ./tmobile_plot.sh -d data.csv ; sleep 1; done
```


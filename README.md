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

Which produces the sample graph.

![Sample Grpah](/data.png)

## Comments/Limitations/Todos

I found this generally helpful in troubleshooting my installation. I haven't been able to get onto the 5G band yet so I didn't do much testing with the associated plots.

There is a lot of thngs that could be done to make this better. Specifically with the plots and how they are laid out. If there is interest, I could massage this some more. I am not a web developer but I could see the appropriate person breaking this up into a daemon along with a simple http server (perhaps on a Raspberry Pi).

## License

BSD 3-Clause

Copyright (c) 2012-2018, Mike Tegtmeyer All rights reserved. Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of the author nor the names of its contributors may
  be used to endorse or promote products derived from this software
  without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#!/usr/bin/bash


while getopts d:lho: flag
do
    case "${flag}" in
        d) _datafile=${OPTARG};;
        o) _outfile=${OPTARG};;
        l) log_only="yes";;
        h) echo "tmobile_plot [options]"
            echo "  -h        Show help"
            echo "  -l        Only log the data. Do not plot"
            echo "  -d file   Set datafile to 'file'. Default is '/tmp/.data.csv'"
            echo "  -o file   Set graph output to 'file'. Default is datafile with any "
            echo "            extensions replaced with the current output type (default pdf)"
            exit 0;;
    esac
done

if [[ $_datafile == "" ]]; then
  datafile=/tmp/data.csv
else
  datafile=$_datafile
fi

if [[ $_outfile == "" ]]; then
  _outfile=$(echo "$datafile" | cut -f 1 -d '.')
  outfile=${_outfile}
else
  outfile=${_outfile}
fi

echo "$(date '+%Y%m%d-%H%M%S'),$(curl -s http://192.168.12.1/fastmile_radio_status_web_app.cgi | jq -r '. | [.cell_LTE_stats_cfg[0].stat.Band,.cell_LTE_stats_cfg[0].stat.RSRPCurrent,.cell_LTE_stats_cfg[0].stat.SNRCurrent,.cell_5G_stats_cfg[0].stat.Band,.cell_5G_stats_cfg[0].stat.RSRPCurrent,.cell_5G_stats_cfg[0].stat.SNRCurrent] | @csv')" >> $datafile

echo "$(tail -n 86400 $datafile)" > $datafile

if [[ $log_only == "yes" ]]; then
  exit 0;
fi


gnuplot -p <<-END
  set terminal pdfcairo enhanced color font ",10";
  set output '${outfile}.pdf';

  #set terminal pngcairo enhanced size 1024,768
  #set output '${outfile}.png';

  set grid xtics back lc rgb '#808080' lt 0 lw 1
  set grid ytics back lc rgb '#808080' lt 0 lw 1

  set border 1+2 front lc rgb '#808080' lt 1 lw 1
  set xtics nomirror out scale 0.75
  set ytics nomirror out scale 0.75
  unset x2tics
  unset y2tics


  set timefmt "%Y%m%d-%H%M%S"
  set xdata time
  set xtics rotate
  set format x "%H:%M"

  set ylabel "decibels (db)"

  set key below


  set datafile separator comma;
  set datafile missing

  # map bands to colors
  bands_to_color(val) = ( \
    val eq 'B2'   ? 0x0072bd : \
    val eq 'B12'  ? 0xa2142f : \
    val eq 'B66'  ? 0x77ac30 : \
    0x000000)

  validate(val) = ( \
    val < -120  ? "" : \
    val > 25    ? "" : \
    val)

  plot '$datafile' \
      u 1:(validate(column(3))):(bands_to_color(stringcolumn(2))) with lines \
      lt 1 lw 2 lc rgbcolor variable \
      title "LTE RSRP", \
    '' \
      u 1:(validate(column(4))) with lines \
      lt 1 lw 2 lc rgb "grey80" \
      title "LTE SNR", \
    '' \
      u 1:(validate(column(6))):(bands_to_color(stringcolumn(5))) with lines \
      lt 1 lw 2 lc rgbcolor variable \
      title "5G RSRP", \
    '' \
      u 1:(validate(column(7))) with lines \
      dt 2 lt 1 lw 2 lc rgb "grey80" \
      title "5G SNR"
END

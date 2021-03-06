# Simple PERL script that takes a directory as argument, and then tries to plot data from multi-objective experiments
# by Alberto Tonda, 2013 <alberto.tonda@gmail.com>

use strict;

my $programName = "display-results.pl";
my $opOutput = "--output";
my $defaultOutput = "output.ps";
my $gnuplotScript = "gnuplot-script.tmp";
my $ugpDataFile = "ugp3data.tmp";
my $nsgaDataFile = "nsga2data.tmp";

if( $#ARGV < 0 )
{
	print "\nUsage: perl $programName [$opOutput <output.pdf>] <directory1> <...> <directoryN>\n";
	print " -- output filename is optional, default is output.ps\n";
	exit(0);
}


# directory name
my $directory = $ARGV[0];

# get list of interesting files in the directory
my @ugpFiles; 
my @nsgaFiles;

# this will be used to store the number of points generated by each algorithm
my $ugpNumberOfPoints = 0;
my $nsgaNumberOfPoints = 0;

# last lines
my @gnuplotScriptLastLines;

foreach my $directory (@ARGV)
{
	my @tmpUgpFiles = `ls $directory/fitness-* 2> /dev/null`;
	my @tmpNsgaFiles = `ls $directory/nsga2-* 2> /dev/null`; 
	
	push(@ugpFiles, @tmpUgpFiles);
	push(@nsgaFiles, @tmpNsgaFiles);
}

# now, depending on the files I got, I try to write a GNUPLOT script to plot them
if( $#ugpFiles >= 0 )
{
	print "I found a total of ", ($#ugpFiles+1), " ugp3 files, containing ";
	
	# so, every file is in the form "fitness1 fitness2"
	my @points;
	foreach my $ugpFile (@ugpFiles)
	{
		open INFILE, "$ugpFile" or die "Cannot open file \"$ugpFile\". Aborting...\n $!";
		my @fileContent = <INFILE>;
		close INFILE;
		
		# collect the two fitness values
		my @values = split(' ', $fileContent[0]);
		push(@points, [ @values ]);
	}
	
	# debug
	#print "Points (hopefully on the Pareto front) collected so far:\n";
	#for(my $i = 0; $i <= $#points; $i++){ print "I am a point:", $points[$i][0], " ", $points[$i][1], "\n"; }
	
	# create temporary data file
	open OUTFILE, ">$ugpDataFile" or die "Cannot write on file \"$ugpDataFile\". Aborting...\n $!";
	for(my $i = 0; $i <= $#points; $i++){ print OUTFILE $points[$i][0], " ", $points[$i][1], "\n"; }
	close OUTFILE;

	# store number of points found, for later
	$ugpNumberOfPoints = $#points + 1;
	print "$ugpNumberOfPoints points.\n";

	# add line to the gnuplot file 
	push(@gnuplotScriptLastLines, ",\"$ugpDataFile\" using 1:2 lt rgb \"red\" title 'ugp3 (over 5 runs)' with points");
	
}

if( $#nsgaFiles >= 0 )
{
	print "I found a total of ", ($#nsgaFiles+1), " NSGA-II files, containing ";
	
	# nsga data files are already in a gnuplot-friendly format, we just have to merge them in a single file
	foreach my $nsgaFile (@nsgaFiles)
	{
		chomp($nsgaFile);
		system("cat $nsgaFile >> $nsgaDataFile");
	}
	
	# count the number of points in the final file
	my @numberOfLines = `cat $nsgaDataFile | wc -l`;
	$nsgaNumberOfPoints = $numberOfLines[0];
	chomp($nsgaNumberOfPoints);
	print "$nsgaNumberOfPoints points.\n";
	
	# add line to the gnuplot file
	push(@gnuplotScriptLastLines, ",\"$nsgaDataFile\" using 1:2 lt rgb \"green\" title 'nsga2 (over 5 runs)' with points");
}

if( $#nsgaFiles == 0 && $#ugpFiles == 0 )
{
	print "No useful files found.\n";
	exit(0);
}

# gnuplot script
my @gnuplotScriptContent;
push(@gnuplotScriptContent, "unset log\n");
push(@gnuplotScriptContent, "unset label\n");
push(@gnuplotScriptContent, "set xtic auto\n");
push(@gnuplotScriptContent, "set ytic auto\n");
#push(@gnuplotScriptContent, "set title \"ugp3 ($ugpNumberOfPoints points) vs nsga2 ($nsgaNumberOfPoints points) on test function ZDT3 (10k evaluations, mu=100)\n");
push(@gnuplotScriptContent, "set title \"ugp3 ($ugpNumberOfPoints points) vs nsga2 ($nsgaNumberOfPoints points) on test function ZDT2 (10k evaluations, mu=40)\n");
push(@gnuplotScriptContent, "set xlabel \"Objective 1\"\n");
push(@gnuplotScriptContent, "set ylabel \"Objective 2\"\n");
push(@gnuplotScriptContent, "set term post\n");
push(@gnuplotScriptContent, "set output \"$defaultOutput\"\n");

# theoretical Pareto front
push(@gnuplotScriptContent, "plot 1 - x**2 title 'True Pareto Front' with line"); # for zdt2
#push(@gnuplotScriptContent, "plot (1 - sqrt(x) - x * sin(10 * pi * x)) title 'True Pareto Front' with line"); # for zdt3

# add last lines to the file
push(@gnuplotScriptContent, @gnuplotScriptLastLines);
push(@gnuplotScriptContent, "\n");

# execute gnuplot script
open OUTFILE, ">$gnuplotScript" or die "Cannot write on file \"$gnuplotScript\". Aborting...\n $!";
foreach(@gnuplotScriptContent){ print OUTFILE $_; }
close OUTFILE;

system("gnuplot $gnuplotScript");
system("ps2pdf $defaultOutput");

# remove temporary files
system("rm $defaultOutput $gnuplotScript $ugpDataFile $nsgaDataFile");

print "Program end.\n";


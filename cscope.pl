#!/usr/bin/env perl
# (C) 2020 Gerhard Gappmeier
# Usage: ~/bin/cscope.pl [<compilation database>]
# Example ~/bin/cscope.pl bld/compile_commands.json
#
# About: You can generate cscope.files manually by specifying paths, files
# or using find. But the problem is that often you include files this way
# that are actually not used in building your software (e.g. other platform's code).
#
# When using CMake to build software you can also generate a compilation database
# using the option -DCMAKE_EXPORT_COMPILE_COMMAND=ON. This file contains only
# the source files used for building your project.
#
# This script generates cscope.files from the files listed in compile_commands.json
# and invokes cscope to build the cscope database. All on one single command.
# It also adds the header files with the same basename as the C file if it exists.
# This is necessary because compile_commands.json does not contain header files.
#
# When running the script without argument it will search for compile_commands.json
# in the current working dir. Also the generated cscope file are written to the
# current directory, which normally should be you project root.
#
use 5.020; use warnings; use autodie;
use File::Slurp;
use JSON;
use Smart::Comments;

my $compile_commands_file = $ARGV[0] // "compile_commands.json";

my $json = read_file($compile_commands_file);
my $db = decode_json($json);

# create cscope.files
my $f;
open($f, ">cscope.files");
for my $entry (@{$db}) {
    my $source = $entry->{file};
    # source file
    ### adding source: $source
    print $f "$source\n";
    # try to find header file with same basename
    $source =~ s/\.(c|cpp|cxx)$/.h/;
    if (-f $source) {
        ### adding header: $source
        print $f "$source\n" if (-f $source);
    } else {
        $source .= "pp"; # some people use hpp files for C++ headers
        if (-f $source) {
            ### adding C++ header: $source
            print $f "$source\n" if (-f $source);
        }
    }
}
close($f);

# run cscope to generate DB
# -b            Build the cross-reference only.
# -q            Build an inverted index for quick symbol searching.
system("/usr/bin/cscope -bq");


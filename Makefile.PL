use inc::Module::Install;
name 'Amon2-Config-Yaml';
all_from 'lib/Amon2/Config/Yaml.pm';

requires 'Amon2';
requires 'YAML::Syck;';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;

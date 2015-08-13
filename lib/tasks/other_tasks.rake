
task :hard_reset_db do
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  puts "Hard Reset Performed"
end

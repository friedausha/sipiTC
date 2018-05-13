# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ncc = Laboratory.create(name: 'NCC', email: 'ncc@if.its.ac.id', password: 'ncc')
Laboratory.create(name: 'KCV', email: 'kcv@if.its.ac.id', password: 'kcv')
Laboratory.create(name: 'RPL', email: 'rpl@if.its.ac.id', password: 'rpl')
Computer.create(laboratory: ncc, name: 'computer 021', status: 0, id: 1)


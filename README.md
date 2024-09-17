## Vehicle coding challenge
Project demonstrating generation of vehicle registration numbers using fictional rules.

---
### Specification
The fictional requirements that were used here to implement generating a registration number.
#### Vehicle Registration Number
The format of a vehicle's registration number is:\
`area code` + `whitespace` + `age identifier` + `whitespace` + `random letters`

Examples:\
CA 12 ABC, BC 73 NLP, CT 66 WLH

#### Area Code
The two letter area code is determined from a vehicle's registration area as stated below.

| Registration area | First letter | Second letter | Example |
|-------------------|--------------|---------------|---------|
| Swansea           | C            | A - K         | CB      |
| Cardiff           | C            | L - Z         | CM      |
| Birmingham        | B            | A B C         | BB      |

#### Age Identifier
The two digit age identifier is determined from a vehicle's date of manufacture.

| Date range  | Rule                      | Example         |
|-------------|---------------------------|-----------------|
| March - Aug | Year without century      | 01-05-2024 = 24 |
| Sep - Feb   | Year without century + 50 | 01-09-2024 = 74 |

#### Random Letters
Three random letters are used but the following letters cannot appear: (I, K, M, Y).

Examples:\
**Valid** - ABC, FGH, etc\
**Invalid** - ABI, YDF, etc

---
### Output
This project takes in a .csv file of vehicle data and generates vehicle registration numbers (VRNs) using the rules as 
defined in the specification above. It then displays the following:
- Total number of VRNs successfully generated
- Number of VRNs generated per registration area
- Number of VRNs that could not be generated

---
### Project setup
**Prerequisites:** A recent version of Ruby (see [here](https://www.ruby-lang.org/en/documentation/installation/) if need to install)
1. Clone repository
```shell
git clone https://github.com/Meteorstrike1/vehicle-coding-challenge.git
```
2. Change to directory and install gems
```shell
cd ./vehicle-coding-challenge
bundle install
```

---
### Run main tasks
Version which doesn't handle duplicates
```shell
rake registration_numbers:generate
```
Version which removes duplicates
```shell
rake registration_numbers:reject_duplicates
```

### Run tests
Can run the unit tests either with rspec command or the rake task as below.
```shell
rspec
```
```shell
rake tests
```
### Run linting
Can lint using rubocop command or the task as below.
```shell
bundle exec rubocop
```
```shell
rake lint
```


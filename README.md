## Vehicle coding challenge
Project demonstrating generation of car registration numbers using fictional rules


### Specification
*Note: Rules are fictional*
#### Vehicle Registration Number
The format of a vehicle's registration number is: <br>
`area code` + `whitespace` + `age identifier` + `whitespace` + `random letters`

Examples:<br>
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

Examples: <br>
**Valid** - ABC, FGH, etc <br>
**Invalid** - ABI, YDF, etc


### Project setup
```shell
bundle install
```

### Requirements

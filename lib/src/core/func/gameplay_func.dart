List<String> marks = [
  ",",
  ".",
  "!",
  "?",
  ";",
  ":",
  "@",
  "#",
  "%",
  "&",
  "*",
  "(",
  ")",
  "-",
  "_",
  "+",
  "=",
  "<",
  ">",
];

class GameplayFunc {
  static List<String> separateAnswer(String answer) {
    List<String> words = answer.split(" ");
    print(words);
    return words;
  }
}

<template>
  <div class="card">
    <div v-for="q in questions[currLocale]" :key="q.quizzes[0].id">
      <div v-for="quiz in q.quizzes" :key="quiz.id">

        <div v-if="route == quiz.id">
          <div aria-live="polite">
            <h3 v-if="complete" class="message complete">{{ q.complete }}</h3>
            <div v-else>
              <h3 v-if="error" class="error">{{ q.error }}</h3>
            </div>
          </div>

          <h1>{{ quiz.title }}</h1>

          <div v-if="!complete">
            <p class="progress" aria-label="Quiz progress">
              Question {{ currentQuestion + 1 }} of {{ quiz.quiz.length }}
            </p>

            <h2>
              {{ quiz.quiz[currentQuestion].questionText }}
            </h2>
            <div role="group" aria-label="Answer options">
              <button
                :key="index"
                v-for="(option, index) in quiz.quiz[currentQuestion]
                  .answerOptions"
                @click="handleAnswerClick(option.isCorrect, quiz.quiz.length)"
                class="btn ans-btn"
              >
                {{ option.answerText }}
              </button>
            </div>
          </div>
          <div v-else class="message">
            <button @click="resetQuiz" class="btn reset-btn">Try Again</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import messages from "@/assets/translations";

export default {
  name: "Quiz",
  data() {
    return {
      currentQuestion: 0,
      complete: false,
      error: false,
      route: "",
    };
  },
  computed: {
    questions() {
      return messages;
    },
    currLocale() {
      return this.$root.$i18n.locale;
    },
  },

  i18n: {
    messages,
  },

  methods: {
    handleAnswerClick(isCorrect, totalQuestions) {
      this.error = false;
      let nextQuestion = this.currentQuestion + 1;
      if (isCorrect) {
        if (nextQuestion < totalQuestions) {
          this.currentQuestion = nextQuestion;
        } else {
          this.complete = true;
        }
      } else {
        this.error = true;
      }
    },
    resetQuiz() {
      this.currentQuestion = 0;
      this.complete = false;
      this.error = false;
    },
  },
  created() {
    this.route = this.$route.params.id;
  },
};
</script>

<style scoped>
.progress {
  text-align: center;
  font-size: 14px;
  color: #666;
  margin-bottom: 0.5em;
}
.reset-btn {
  margin-top: 1em;
  max-width: 200px;
}
</style>

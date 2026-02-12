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
            <div class="progress-bar-container">
              <div
                class="progress-bar-fill"
                :style="{ width: ((currentQuestion) / quiz.quiz.length) * 100 + '%' }"
              ></div>
            </div>
            <p class="progress-text" aria-label="Quiz progress">
              Question {{ currentQuestion + 1 }} of {{ quiz.quiz.length }}
            </p>

            <h2>
              {{ quiz.quiz[currentQuestion].questionText }}
            </h2>
            <div role="group" aria-label="Answer options" class="answer-group">
              <button
                :key="index"
                v-for="(option, index) in quiz.quiz[currentQuestion]
                  .answerOptions"
                @click="handleAnswerClick(option.isCorrect, quiz.quiz.length)"
                class="btn ans-btn"
              >
                <span class="answer-letter">{{ String.fromCharCode(65 + index) }}</span>
                {{ option.answerText }}
              </button>
            </div>
          </div>
          <div v-else class="complete-actions">
            <button @click="resetQuiz" class="btn reset-btn">Try Again</button>
            <router-link to="/" class="btn home-btn">All Quizzes</router-link>
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
.progress-bar-container {
  width: 100%;
  max-width: 500px;
  height: 6px;
  background: #e2e8f0;
  border-radius: 3px;
  margin: 1rem auto 0.5rem;
  overflow: hidden;
}

.progress-bar-fill {
  height: 100%;
  background: linear-gradient(90deg, #4f46e5, #7c3aed);
  border-radius: 3px;
  transition: width 0.4s ease;
}

.progress-text {
  text-align: center;
  font-size: 0.8rem;
  color: #94a3b8;
  font-weight: 500;
  letter-spacing: 0.03em;
  margin-bottom: 1.5rem;
}

.answer-group {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.ans-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-align: left;
}

.answer-letter {
  flex-shrink: 0;
  width: 28px;
  height: 28px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: rgba(79, 70, 229, 0.1);
  color: #4f46e5;
  font-weight: 700;
  font-size: 0.8rem;
  border-radius: 8px;
  transition: all 0.2s;
}

.ans-btn:hover .answer-letter {
  background: rgba(255, 255, 255, 0.25);
  color: white;
}

.complete-actions {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  margin-top: 1.5rem;
}

.reset-btn {
  max-width: 240px;
  background: linear-gradient(135deg, #4f46e5, #7c3aed);
  color: white;
  border-color: transparent;
  font-weight: 600;
}

.reset-btn:hover {
  background: linear-gradient(135deg, #4338ca, #6d28d9);
  box-shadow: 0 4px 16px rgba(79, 70, 229, 0.4);
}

.home-btn {
  max-width: 240px;
}
</style>

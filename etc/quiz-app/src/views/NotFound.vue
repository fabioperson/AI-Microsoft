<template>
  <div class="card not-found">
    <div class="not-found-code">404</div>
    <h1>Page Not Found</h1>
    <p class="not-found-text">The page you're looking for doesn't exist or has been moved.</p>
    <router-link to="/" class="btn">Back to Quizzes</router-link>
  </div>
</template>

<style scoped>
.not-found {
  text-align: center;
  padding: 3rem 2rem;
}

.not-found-code {
  font-size: 4rem;
  font-weight: 800;
  background: linear-gradient(135deg, #4f46e5, #7c3aed);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
  margin-bottom: 0.5rem;
}

.not-found-text {
  color: #64748b;
  margin-bottom: 2rem;
  font-size: 1rem;
}

.not-found .btn {
  display: inline-block;
  width: auto;
  max-width: none;
  padding: 0.75rem 2rem;
}
</style>

library(ggplot2)
library(patchwork)

# Displays Safety Score by position
p1 <- ggplot(
  omega_scores,
  aes(x = reorder(position, - omega_ratio), y = omega_ratio)
) +
  geom_col(aes(fill = omega_ratio)) +
  scale_fill_gradient2(mid = "grey90", high = "steelblue") +
  labs(title = "Omega Ratio by Position",
    subtitle = "Above 1 = more upside than downside",
    x = "Position", y = "Omega Score") +
  theme_minimal() + 
  theme(legend.position = "none") +
  geom_hline(yintercept = 1)

# Expected BPM by pick range
p2 <- ggplot(
  pick_range_stats,
  aes(x = pick_range, y = expected_BPM, group = 1)
) + 
  geom_point(color = "steelblue") +
  geom_line(color = "steelblue", linewidth = 1) + 
  geom_ribbon(aes(ymin = expected_BPM - downside_dev,
    ymax = expected_BPM + upside_dev),
    alpha = 0.2, fill = "steelblue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  labs(title = "Expected BPM by Pick Range",
    subtitle = "Shaded band shows upside/downside deviation",
    x = "Pick Range", y = "Expected BPM") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p1 / p2


# Calculate expected BPM + other data by pick range
pick_range_stats <- player_avg_bpms |>
  group_by(player, pick, draft_year) |>
  summarise(avg_BPM = mean(avg_BPM), .groups = "drop") |>
  mutate(pick_range = cut(pick, breaks = seq(0, 60, by = 2),
                          labels = paste(seq(1, 56, by = 2), seq(2, 60, by = 2), sep = "-"))) |>
  filter(!is.na(pick_range)) |>
  group_by(pick_range) |>
  summarise(
    expected_BPM     = mean(avg_BPM),
    std_deviation    = sd(avg_BPM),
    downside_dev     = sqrt(mean(pmin(avg_BPM - mean(avg_BPM), 0)^2)),
    upside_dev      = sqrt(mean(pmax(avg_BPM - mean(avg_BPM), 0)^2)),
    n                = n()
  )

# Sort all players by pick range
player_bpm_by_pick_range <- player_avg_bpms |>
  group_by(player, pick, draft_year, position) |>
  summarise(avg_BPM = mean(avg_BPM), .groups = "drop") |>
  mutate(pick_range = cut(pick, breaks = seq(0, 60, by = 2),
                          labels = paste(seq(1, 56, by = 2), seq(2, 60, by = 2), sep = "-"))) |>
  filter(!is.na(pick_range))

# Compute omega score by position,
# using residuals when compared to expected value
omega_scores <- player_bpm_by_pick_range |>
  filter(!is.na(position)) |>
  left_join(pick_range_stats, by = "pick_range") |>
  mutate(residual = avg_BPM - expected_BPM) |>
  group_by(position) |>
  summarise(
    upside_sum   = sum(pmax(residual, 0)),
    downside_sum = abs(sum(pmin(residual, 0))),
    omega_ratio  = if_else(downside_sum == 0, NA_real_, upside_sum / downside_sum),
    n            = n()
  ) |>
  arrange(desc(omega_ratio))
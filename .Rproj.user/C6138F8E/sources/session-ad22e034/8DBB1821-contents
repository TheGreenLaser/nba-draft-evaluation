# Find out what position a player actually is
player_positions <- advanced_raw |> 
  filter(Player != "Player", Player != "") |>
  filter(!duplicated(paste(Player, season))) |>
  select(player = Player, season, pos = Pos) |>
  mutate(season = as.integer(season)) |>
  filter(season >= 2011, season <= 2026) |>
  inner_join(draft_clean, by = "player") |>
  group_by(player) |>
  summarise(position = names(sort(table(pos), decreasing = TRUE))[1])

#These players never played and must have their positions filled manually
manual_positions <- tribble(
  ~player, ~position,
  "Jon Diebler", "SG",
  "Milan Mačvan", "PF",
  "Chukwudiebere Maduabum", "C",
  "Tanguy Ngombo", "C",
  "Ater Majok", "C",
  "Ádám Hanga", "SG",
  "İzzet Türkyılmaz", "PF",
  "Tomislav Zubčić", "SF",
  "İlkan Karaman", "PF",
  "Marcus Denmon", "SG",
  "Livio Jean-Charles", "PF",
  "Marko Todorović", "C",
  "Romero Osby", "PF",
  "Colton Iverson", "C",
  "Arsalan Kazemi", "PF",
  "Alex Oriakhi", "PF",
  "Deshaun Thomas", "SF",
  "Bojan Dubljević", "C",
  "Jānis Timma", "SF",
  "DeAndre Daniels", "SF",
  "Alec Brown", "C",
  "Alessandro Gentile", "SG",
  "Nemanja Dangubić", "SG",
  "Louis Labeyrie", "PF",
  "Xavier Thames", "PG",
  "Nikola Milutinov", "C",
  "Juan Pablo Vaulet", "SG",
  "Olivier Hanlan", "PG",
  "Artūras Gudaitis", "C",
  "Aaron White", "PF",
  "Marcus Eriksson", "SG",
  "Tyler Harvey", "SG",
  "Satnam Singh", "C",
  "Sir'Dominic Pointer", "SF",
  "Dani Díez", "SG",
  "Cady Lalanne", "C",
  "Nikola Radičević", "PG",
  "J.P. Tokoto", "SF",
  "Dimitrios Agravanis", "PF",
  "Luka Mitrović", "PF",
  "Rade Zagorac", "SF",
  "David Michineau", "PG",
  "Isaïa Cordinier", "SG",
  "Wang Zhelin", "C",
  "Isaiah Cousins", "SG",
  "Mathias Lessort", "PF",
  "Ognjen Jaramaz", "PG",
  "Alpha Kaba", "C",
  "Issuf Sanon", "PG",
  "Tony Carr", "PG",
  "Jaylen Hands", "PG",
  "Vanja Marinković", "SG",
  "Yam Madar", "PG",
  "Justinian Jessup", "SG",
  "Rokas Jokubaitis", "PG",
  "Juhann Begarin", "SG",
  "Marcus Zegarowski", "PG",
  "Balša Koprivica", "C"
)

# Gets players' 3rd to 5th seasons,
# and connects them to their corresponding year
player_avg_bpms <- draft_clean |>
  mutate(
    season_3 = draft_year + 3,
    season_4 = draft_year + 4,
    season_5 = draft_year + 5
  ) |>
  pivot_longer(cols = c(season_3, season_4, season_5),
               names_to = "season_number",
               values_to = "season_year") |>
  # Join player position to data
  left_join(player_positions, by = "player") |>
  left_join(manual_positions |> rename(manual_position = position), by = "player") |>
  mutate(position = coalesce(position, manual_position)) |>
  select(-manual_position) |>
  # ONLY look at lottery picks
  filter(pick <= 14) |>
  # Join to advanced stats
  left_join(advanced_clean, by = c("player" = "player", "season_year" = "season")) |>
  # If the player didn't play, they are considered "worthless" (BPM = -5)
  # Players cannot be less than "worthless" (BPM < -5)
  mutate(BPM = if_else(is.na(BPM), -5, BPM),
         BPM = if_else(BPM < -5, -5, BPM)) |>
  # Compute average BPM across three year window
  group_by(player, pick, draft_year, position) |>
  summarise(avg_BPM = mean(BPM), .groups = "drop")

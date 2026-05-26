import SwiftUI

struct StoneforgeView: View {
    @EnvironmentObject private var store: VarpaStore
    @AppStorage("settings.language") private var languageRawValue = AppLanguage.english.rawValue
    private var language: AppLanguage {
        AppLanguage(rawValue: languageRawValue) ?? .english
    }

    var body: some View {
        AppScreen {
            VStack(alignment: .leading, spacing: 16) {
                SectionKick(title: L.text(.kitTitle, language), subtitle: L.text(.kitSubtitle, language))

                RainCard {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .top, spacing: 14) {
                            LogoMark(size: 74)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(localizedGearText(store.favoriteGear.name))
                                    .font(.title2.weight(.black))
                                    .foregroundStyle(BrandPalette.white)
                                Text(L.text(.favoriteMatchVarpa, language))
                                    .font(.caption.weight(.heavy))
                                    .foregroundStyle(BrandPalette.gold)
                                Text(localizedGearText(store.favoriteGear.notes))
                                    .font(.subheadline)
                                    .foregroundStyle(BrandPalette.textSoft)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }

                        HStack(spacing: 10) {
                            StatPill(value: String(format: "%.2f kg", store.favoriteGear.weight), label: L.text(.weight, language), color: BrandPalette.gold)
                            StatPill(value: String(format: "%.1f cm", store.favoriteGear.diameter), label: L.text(.diameter, language), color: BrandPalette.rainBlue)
                            StatPill(value: localizedGearText(store.favoriteGear.material), label: L.text(.material, language), color: BrandPalette.mint)
                        }
                    }
                }

                ForEach(store.gear) { item in
                    Button {
                        store.toggleFavorite(item)
                    } label: {
                        RainCard {
                            HStack(alignment: .top, spacing: 14) {
                                VarpaStone(color: item.favorite ? BrandPalette.gold : BrandPalette.rainBlue)
                                    .frame(width: 58, height: 38)
                                    .frame(width: 70, height: 54)
                                    .background(Circle().fill((item.favorite ? BrandPalette.gold : BrandPalette.rainBlue).opacity(0.15)))
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(localizedGearText(item.name))
                                        .font(.headline.weight(.black))
                                        .foregroundStyle(BrandPalette.white)
                                    Text("\(localizedGearText(item.material)) - \(String(format: "%.2f kg", item.weight)) - \(String(format: "%.1f cm", item.diameter))")
                                        .font(.caption.weight(.heavy))
                                        .foregroundStyle(BrandPalette.textSoft)
                                    Text(localizedGearText(item.notes))
                                        .font(.subheadline)
                                        .foregroundStyle(BrandPalette.textSoft)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer()
                                Image(systemName: item.favorite ? "star.fill" : "star")
                                    .foregroundStyle(item.favorite ? BrandPalette.gold : BrandPalette.textMuted)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func localizedGearText(_ value: String) -> String {
        guard language == .swedish else { return value }
        return switch value {
        case "Stone": "Sten"
        case "Metal": "Metall"
        case "Composite": "Komposit"
        case "Gotland Limestone": "Gotländsk kalksten"
        case "Iron Training Varpa": "Järnvarpa för träning"
        case "Light Practice Varpa": "Lätt träningsvarpa"
        case "Balanced training varpa for damp grass.": "Balanserad träningsvarpa för fuktigt gräs."
        case "Stable in crosswind and on gravel.": "Stabil i sidvind och på grus."
        case "Good for juniors and short drills.": "Bra för juniorer och korta drillar."
        default: value
        }
    }
}

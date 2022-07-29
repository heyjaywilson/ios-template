import Foundation
import Danger

let danger = Danger()
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles

let changelogChanged = allSourceFiles.contains("CHANGELOG.md")
let sourceChanges = allSourceFiles.first(where: { $0.hasPrefix("Sources") })

if !changelogChanged && sourceChanges != nil && !github.pr.body.contains("#trivial") {
  warn("No CHANGELOG entry added.")
}

// Check pr has description

let github = danger.github

if github.pr.body.length < 10 {
    warn("Include a description of PR changes")
}

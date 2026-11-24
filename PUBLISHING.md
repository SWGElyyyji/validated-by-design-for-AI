# Publishing Guide

## Validated-by-Design for AI

This document describes the controlled publication
process for the whitepaper series.

## 1. Publication Principles

Every public release must be:

- Reviewed
- Approved for external publication
- Versioned
- Traceable
- Reproducible
- Verified before publication

Published PDF files must not be silently replaced.

## 2. Repository Structure

Each publication version has a dedicated directory.

Example:

releases/v1.0.0/

The directory contains:

- Canonical PDF
- RELEASE-NOTES.md
- SHA256SUMS.txt

## 3. Naming Convention

The canonical filename follows:

validated-by-design-for-ai-book-N-vX.Y.Z.pdf

Example:

validated-by-design-for-ai-book-1-v1.0.0.pdf

N identifies the book.

X.Y.Z identifies the publication version.

## 4. Prepare a Publication

Before publication:

1. Complete editorial review.
2. Confirm all authors.
3. Confirm external publication approval.
4. Check regulatory references.
5. Confirm the final PDF.
6. Remove internal comments and draft material.
7. Confirm license and disclaimer.
8. Assign the release version.
9. Copy the final PDF into its release directory.
10. Create release notes.
11. Generate the SHA-256 checksum.
12. Update citation metadata.
13. Update Zenodo metadata if applicable.
14. Update the README and landing page.
15. Run release verification.

## 5. Verify the Publication

Run from the repository root:

    ./scripts/verify-release.ps1

The verification must succeed before publication.

## 6. GitHub Workflow

After successful local verification:

1. Review Git changes.
2. Commit the publication package.
3. Push to GitHub.
4. Check the GitHub Actions verification result.
5. Confirm all public links.
6. Create the GitHub release.

## 7. GitHub Release

Create a release using the matching version tag.

Example:

v1.0.0

Use the content of RELEASE-NOTES.md as the
release description.

Attach the canonical PDF as a release asset.

Verify that the attached PDF matches the
recorded SHA-256 checksum.

Publish only after all checks have passed.

## 8. Zenodo

If Zenodo archival is required:

1. Connect the repository to Zenodo.
2. Confirm publication metadata.
3. Publish the GitHub release.
4. Confirm successful Zenodo archival.
5. Record the assigned DOI.
6. Update citation metadata.
7. Update public links where appropriate.

Do not invent or reuse DOI values.

## 9. Corrections

If a published PDF requires correction:

1. Prepare a corrected PDF.
2. Assign a new version.
3. Create a new release directory.
4. Generate a new checksum.
5. Document the changes.
6. Publish a new release.
7. Preserve the previous release.

## 10. Publication Gate

A release must not be published when:

- The PDF is missing
- The checksum is invalid
- The release notes are missing
- Verification fails
- Author information is incorrect
- Publication approval is outstanding
- Licensing is unresolved
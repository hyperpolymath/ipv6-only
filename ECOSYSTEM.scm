;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — ipv6-only

(ecosystem
  (version "1.0.0")
  (name "ipv6-only")
  (type "project")
  (purpose "A comprehensive toolkit for IPv6-only networking, featuring utilities for address manipulation, network analysis, diagnostics, and testing.")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "A comprehensive toolkit for IPv6-only networking, featuring utilities for address manipulation, network analysis, diagnostics, and testing.")
  (what-this-is-not "- NOT exempt from RSR compliance"))

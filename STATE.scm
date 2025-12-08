;;; STATE.scm - AI Conversation Checkpoint System
;;; Project: ipv6-only
;;; A comprehensive toolkit for IPv6-only networking
;;;
;;; Usage: Download at end of session, upload at start of next session
;;; to maintain context continuity across AI conversations.

(define state
  '(
    ;; =========================================================================
    ;; METADATA
    ;; =========================================================================
    (metadata
      (format-version "1.0")
      (schema-date "2025-12-08")
      (last-updated "2025-12-08")
      (generator "claude-opus-4")
      (project-name "ipv6-only")
      (repository "https://github.com/Hyperpolymath/ipv6-only"))

    ;; =========================================================================
    ;; USER CONTEXT
    ;; =========================================================================
    (user-context
      (name "hyperpolymath")
      (roles ("maintainer" "developer"))
      (preferences
        (languages ("Python" "Go" "TypeScript" "Scheme"))
        (tools ("Nix" "Podman" "Just" "GitHub Actions"))
        (values
          ("reproducible-builds" "FOSS" "security-first" "IPv6-native"))))

    ;; =========================================================================
    ;; SESSION CONTEXT
    ;; =========================================================================
    (session-context
      (conversation-id "create-state-scm-01BPeWXZvkfbYEWLuiBv4Gnb")
      (started "2025-12-08")
      (message-count 1)
      (purpose "Create STATE.scm for project tracking"))

    ;; =========================================================================
    ;; CURRENT FOCUS
    ;; =========================================================================
    (focus
      (current-project "ipv6-only")
      (phase "pre-mvp")
      (version-current "0.1.0-alpha")
      (version-target "1.0.0")
      (blocking-dependencies
        ("pypi-publishing" "go-module-release" "documentation-gaps")))

    ;; =========================================================================
    ;; CURRENT POSITION ASSESSMENT
    ;; =========================================================================
    (current-position
      (summary "Comprehensive IPv6 toolkit with solid foundation but pre-release")
      (strengths
        ("Complete Python library with 100+ tests"
         "Multi-language: Python, Go, TypeScript, Bash"
         "Modern web interface with 5 tools"
         "CI/CD with multi-version testing"
         "RSR Platinum compliance achieved"
         "Supply-chain secure containerization (Wolfi)"
         "Comprehensive automation via Justfile"))
      (components-status
        (python-library
          (status in-progress)
          (completion 85)
          (notes "Core functionality complete, needs polish"))
        (go-tools
          (status in-progress)
          (completion 70)
          (notes "ipv6-ping, ipv6-scan, ipv6-trace, ipv6-lookup exist"))
        (web-application
          (status in-progress)
          (completion 75)
          (notes "Functional but needs UX refinement"))
        (cli-tools
          (status in-progress)
          (completion 80)
          (notes "4 CLI tools, missing ipv6-convert"))
        (shell-scripts
          (status complete)
          (completion 95)
          (notes "Diagnostic and config scripts ready"))
        (documentation
          (status in-progress)
          (completion 70)
          (notes "README, TUTORIAL, PRIMER exist; API docs needed"))
        (testing
          (status in-progress)
          (completion 80)
          (notes "Python tests good; Go tests sparse"))
        (ci-cd
          (status complete)
          (completion 95)
          (notes "GitHub Actions, CodeQL, Dependabot configured"))
        (packaging
          (status blocked)
          (completion 40)
          (notes "Not yet published to PyPI or Go modules"))))

    ;; =========================================================================
    ;; ROUTE TO MVP v1.0
    ;; =========================================================================
    (mvp-roadmap
      (milestone "v0.2.0 - Beta Release"
        (priority high)
        (tasks
          ("Publish to PyPI"
           "Fix remaining test failures"
           "Add type hints to all public APIs"
           "Generate API documentation with Sphinx"
           "Improve CLI error messages")))

      (milestone "v0.3.0 - Go Tools Stable"
        (priority high)
        (tasks
          ("Add Go tests for all commands"
           "Release Go module to pkg.go.dev"
           "Add IPv6 traceroute improvements"
           "Performance benchmarking for scanner")))

      (milestone "v0.4.0 - Web Enhancement"
        (priority medium)
        (tasks
          ("Add input validation feedback"
           "Improve mobile responsiveness"
           "Add dark mode toggle"
           "PWA support for offline use")))

      (milestone "v0.5.0 - Integration Features"
        (priority medium)
        (tasks
          ("Add Ansible module for ipv6tools"
           "Terraform provider skeleton"
           "CLI JSON output mode"
           "Prometheus metrics endpoint")))

      (milestone "v1.0.0 - MVP Release"
        (priority critical)
        (requirements
          ("All tests passing"
           "Published to PyPI and Go modules"
           "Complete API documentation"
           "Security audit completed"
           "Performance benchmarks documented"
           "Breaking changes finalized"))))

    ;; =========================================================================
    ;; KNOWN ISSUES
    ;; =========================================================================
    (issues
      (critical ())
      (high
        (("id" "ISS-001")
         ("title" "PyPI package not published")
         ("impact" "Users cannot pip install"))
        (("id" "ISS-002")
         ("title" "Go module not released")
         ("impact" "Users cannot go get")))
      (medium
        (("id" "ISS-003")
         ("title" "Missing ipv6-convert CLI tool")
         ("impact" "Feature gap from README promise"))
        (("id" "ISS-004")
         ("title" "Sparse Go test coverage")
         ("impact" "Risk of regressions"))
        (("id" "ISS-005")
         ("title" "No API documentation")
         ("impact" "Poor developer experience")))
      (low
        (("id" "ISS-006")
         ("title" "Web UI not mobile optimized")
         ("impact" "Poor mobile UX"))
        (("id" "ISS-007")
         ("title" "No changelog automation")
         ("impact" "Manual release work"))))

    ;; =========================================================================
    ;; QUESTIONS FOR MAINTAINER
    ;; =========================================================================
    (questions
      (blocking
        ("What PyPI username/org should the package be published under?"
         "Should Go tools be a separate module or stay in-repo?"
         "Is Hurricane Electric tunnel integration a core feature or optional?"))
      (clarification
        ("Target audience: sysadmins, developers, or both?"
         "Should web app support internationalization?"
         "Preferred versioning for Go: match Python or independent?"
         "Priority: new features vs. stability for v1.0?"))
      (architectural
        ("Should we add async support to Python library?"
         "Consider adding gRPC API for programmatic access?"
         "Integrate with existing tools (iproute2) or stay standalone?")))

    ;; =========================================================================
    ;; LONG-TERM ROADMAP (Post v1.0)
    ;; =========================================================================
    (long-term-roadmap
      (phase "v1.x - Stability & Ecosystem"
        (timeframe "post-mvp")
        (goals
          ("Bug fixes and stability improvements"
           "Community feedback integration"
           "Plugin architecture for extensibility"
           "IDE integrations (VSCode, JetBrains)")))

      (phase "v2.0 - Enterprise Features"
        (timeframe "future")
        (goals
          ("Multi-tenant support"
           "RBAC for web interface"
           "Audit logging"
           "LDAP/SSO integration"
           "High-availability deployment guide")))

      (phase "v3.0 - Advanced Networking"
        (timeframe "future")
        (goals
          ("SRv6 segment routing support"
           "Network topology visualization"
           "Integration with SDN controllers"
           "IPv6 flow analysis"
           "Real-time network monitoring")))

      (phase "Community & Ecosystem"
        (timeframe "ongoing")
        (goals
          ("Build contributor community"
           "Conference talks and workshops"
           "Educational certifications"
           "Partnerships with IPv6 advocacy groups"
           "Integration with cloud providers (AWS, GCP, Azure)"))))

    ;; =========================================================================
    ;; CRITICAL NEXT ACTIONS (Top 5)
    ;; =========================================================================
    (critical-next-actions
      (action-1
        (task "Publish Python package to PyPI")
        (project "ipv6-only")
        (priority "P0")
        (blocked-by "PyPI credentials configuration")
        (context "Required for users to pip install"))

      (action-2
        (task "Add missing ipv6-convert CLI command")
        (project "ipv6-only")
        (priority "P1")
        (blocked-by #f)
        (context "README promises this feature"))

      (action-3
        (task "Generate Sphinx API documentation")
        (project "ipv6-only")
        (priority "P1")
        (blocked-by #f)
        (context "Developer experience improvement"))

      (action-4
        (task "Add comprehensive Go tests")
        (project "ipv6-only")
        (priority "P1")
        (blocked-by #f)
        (context "Reduce regression risk"))

      (action-5
        (task "Perform security audit of network tools")
        (project "ipv6-only")
        (priority "P1")
        (blocked-by #f)
        (context "Required before v1.0 release")))

    ;; =========================================================================
    ;; HISTORY (Velocity Tracking)
    ;; =========================================================================
    (history
      (snapshot
        (date "2024-11-22")
        (version "0.1.0")
        (milestone "Initial Release")
        (notes "First public alpha with core functionality"))
      (snapshot
        (date "2025-12-08")
        (version "0.1.0+")
        (milestone "RSR Compliance & Automation")
        (notes "Added Justfile, Podman/Wolfi, HE tunnel, Nix flake")))

    ;; =========================================================================
    ;; PROJECT DEPENDENCIES
    ;; =========================================================================
    (dependencies
      (external
        ("Python >= 3.7"
         "Go >= 1.19"
         "Deno (optional, for web server)"
         "Nix (optional, for reproducible builds)"
         "Podman/Docker (optional, for containers)"))
      (python-packages
        ("click >= 8.0.0 (CLI)"
         "rich >= 12.0.0 (CLI formatting)"
         "dnspython >= 2.0.0 (DNS operations)"
         "pytest >= 7.0.0 (testing)"))
      (go-modules
        ("golang.org/x/net (networking)")))

    ;; =========================================================================
    ;; NOTES
    ;; =========================================================================
    (notes
      ("Project follows semantic versioning"
       "All IPv6 address handling uses stdlib ipaddress module"
       "Go tools designed for high performance scanning"
       "Web app is pure client-side, no backend required"
       "CI runs on Python 3.8-3.11 matrix"
       "Security scanning via Bandit (Python) and gosec (Go)"))))

;;; =========================================================================
;;; QUERY FUNCTIONS
;;; =========================================================================

;; Get current focus
(define (get-focus)
  (assoc 'focus state))

;; Get all blocked items
(define (get-blocked)
  (filter
    (lambda (component)
      (eq? (cadr (assoc 'status (cdr component))) 'blocked))
    (cdr (assoc 'components-status (assoc 'current-position state)))))

;; Get critical actions
(define (get-priority-actions)
  (assoc 'critical-next-actions state))

;; Get issues by severity
(define (get-issues severity)
  (assoc severity (assoc 'issues state)))

;;; =========================================================================
;;; END OF STATE
;;; =========================================================================

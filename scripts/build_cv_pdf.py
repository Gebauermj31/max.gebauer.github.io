#!/usr/bin/env python3
"""Build the public, privacy-reviewed curriculum vitae PDF."""

from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT, TA_RIGHT
from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.pdfbase.pdfmetrics import stringWidth
from reportlab.platypus import (
    HRFlowable,
    KeepTogether,
    ListFlowable,
    ListItem,
    Paragraph,
    PageBreak,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "files" / "maximilian-gebauer-cv.pdf"
BLUE = colors.HexColor("#075FD8")
TEXT = colors.HexColor("#171A21")
MUTED = colors.HexColor("#566174")
LINE = colors.HexColor("#D9E0EB")


styles = getSampleStyleSheet()
name_style = ParagraphStyle(
    "Name",
    parent=styles["Title"],
    fontName="Helvetica-Bold",
    fontSize=22,
    leading=24,
    textColor=TEXT,
    alignment=TA_LEFT,
    spaceAfter=3,
)
contact_style = ParagraphStyle(
    "Contact",
    parent=styles["Normal"],
    fontName="Helvetica",
    fontSize=9,
    leading=11,
    textColor=MUTED,
    spaceAfter=7,
)
section_style = ParagraphStyle(
    "Section",
    parent=styles["Heading2"],
    fontName="Helvetica-Bold",
    fontSize=9.5,
    leading=11,
    textColor=TEXT,
    spaceBefore=8,
    spaceAfter=3,
    uppercase=True,
)
entry_title_style = ParagraphStyle(
    "EntryTitle",
    parent=styles["Normal"],
    fontName="Helvetica-Bold",
    fontSize=9.3,
    leading=11.4,
    textColor=TEXT,
    spaceAfter=1,
)
body_style = ParagraphStyle(
    "Body",
    parent=styles["Normal"],
    fontName="Helvetica",
    fontSize=8.7,
    leading=11.2,
    textColor=TEXT,
    spaceAfter=1.5,
)
date_style = ParagraphStyle(
    "Date",
    parent=body_style,
    fontName="Helvetica",
    fontSize=8.2,
    leading=10.4,
    textColor=MUTED,
    alignment=TA_RIGHT,
)
bullet_style = ParagraphStyle(
    "Bullet",
    parent=body_style,
    leftIndent=0,
    firstLineIndent=0,
)
link_style = ParagraphStyle(
    "Links",
    parent=body_style,
    fontSize=8.3,
    textColor=BLUE,
)


def section(title):
    heading = Paragraph(title.upper(), section_style)
    rule = HRFlowable(width="100%", thickness=0.8, color=TEXT, spaceBefore=0, spaceAfter=4)
    heading.keepWithNext = True
    rule.keepWithNext = True
    return [heading, rule]


def entry(title, date, *lines):
    left = [Paragraph(title, entry_title_style)]
    for line in lines:
        style = link_style if "<a href=" in line else body_style
        left.append(Paragraph(line, style))
    table = Table([[left, Paragraph(date, date_style)]], colWidths=[5.98 * inch, 1.18 * inch])
    table.setStyle(
        TableStyle(
            [
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("LEFTPADDING", (0, 0), (-1, -1), 0),
                ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                ("TOPPADDING", (0, 0), (-1, -1), 1.5),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 3.5),
            ]
        )
    )
    return KeepTogether(table)


def bullets(items):
    return ListFlowable(
        [ListItem(Paragraph(item, bullet_style), leftIndent=9) for item in items],
        bulletType="bullet",
        start="circle",
        leftIndent=11,
        bulletFontName="Helvetica",
        bulletFontSize=5.5,
        bulletOffsetY=2.2,
        spaceAfter=2,
    )


def footer(canvas, document):
    canvas.saveState()
    canvas.setStrokeColor(LINE)
    canvas.setLineWidth(0.5)
    canvas.line(document.leftMargin, 0.43 * inch, letter[0] - document.rightMargin, 0.43 * inch)
    canvas.setFont("Helvetica", 7.5)
    canvas.setFillColor(MUTED)
    footer_text = "Maximilian (Max) J. Gebauer | Curriculum vitae | Updated August 5, 2026"
    canvas.drawString(document.leftMargin, 0.28 * inch, footer_text)
    page_text = str(document.page)
    canvas.drawString(letter[0] - document.rightMargin - stringWidth(page_text, "Helvetica", 7.5), 0.28 * inch, page_text)
    canvas.restoreState()


def build():
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    document = SimpleDocTemplate(
        str(OUTPUT),
        pagesize=letter,
        rightMargin=0.58 * inch,
        leftMargin=0.58 * inch,
        topMargin=0.48 * inch,
        bottomMargin=0.55 * inch,
        title="Maximilian (Max) J. Gebauer - Curriculum Vitae",
        author="Maximilian J. Gebauer",
        subject="Academic curriculum vitae",
    )

    story = [
        Paragraph("Maximilian (Max) J. Gebauer", name_style),
        Paragraph(
            'Philadelphia, Pennsylvania &nbsp;&nbsp;|&nbsp;&nbsp; '
            '<a href="mailto:gebauerm@sas.upenn.edu" color="#075FD8">gebauerm@sas.upenn.edu</a> &nbsp;&nbsp;|&nbsp;&nbsp; '
            '<a href="https://github.com/Max-Gebauer" color="#075FD8">github.com/Max-Gebauer</a>',
            contact_style,
        ),
        HRFlowable(width="100%", thickness=1.2, color=TEXT, spaceBefore=0, spaceAfter=3),
    ]

    story += section("Education")
    story += [
        entry(
            "University of Pennsylvania",
            "Aug. 2022 - expected Spring 2027",
            "Ph.D. Candidate, Philosophy",
            "Areas of specialization: Philosophy of Science; Bayesianism. Areas of competence: Political Philosophy; Environmental Philosophy.",
        ),
        entry(
            "The Wharton School, University of Pennsylvania",
            "May 2026",
            "M.A., Statistics &amp; Data Science",
            "Thesis: <i>Sparse Control Selection For Spatial Epidemiological Data: Double Lasso And County COVID-19 Mortality</i>.",
        ),
        entry(
            "Washington and Lee University",
            "May 2022",
            "B.A., Philosophy &amp; Poverty and Human Capability Studies, <i>magna cum laude</i>; Honors in Philosophy",
        ),
        entry("University of Oxford, Mansfield College", "Fall 2020 - Summer 2021", "Visiting Student Programme"),
    ]

    story += section("Forthcoming publication")
    story.append(
        entry(
            '"Bayesian Practice and the Persistence of Inductive Risk"',
            "Forthcoming",
            "<i>Philosophy of Science</i>, forthcoming.",
        )
    )

    story += section("Working papers")
    story += [
        entry(
            '"Opponent-Adjusted Evaluation of NFL Pass Blocking and Pass Rushing Performance"',
            "Revisions",
            "Jonathan Pipping-Gamón, Maximilian J. Gebauer, Victoria Lee, Kenny Watts, and Abraham J. Wyner.",
            "Interpretable ridge-regularized Bradley-Terry models for player-level pass-blocking and pass-rushing evaluation using opponent-dependent tracking interactions.",
            '<a href="https://arxiv.org/abs/2604.01491">arXiv preprint</a> | <a href="https://github.com/WhartonSABI/nfl-elo">Repository</a>',
        ),
        entry(
            "FAIR xwOBA",
            "Public release, Aug. 2026",
            "Maximilian J. Gebauer.",
            "A player-trait-free model of expected weighted on-base average in Major League Baseball that outperformed the declared Statcast comparators across six rolling held-out development seasons and supports new analysis of the game value associated with Sprint Speed.",
            '<a href="https://max-gebauer.github.io/fair-xwoba/">Published article and results</a> | <a href="https://github.com/Max-Gebauer/fair-xwoba">Repository</a>',
        ),
    ]

    story += section("Research & professional experience")
    story += [
        entry(
            "Technical Lead, Wharton Analytics Fellows",
            "Dec. 2025 - May 2026",
            "Built reproducible data-processing and predictive-modeling workflows for confidential applied research.",
        ),
        entry(
            "Summer Lab Associate, Wharton Sports Analytics and Business Initiative",
            "Summer 2025",
            "Developed dynamic sports-performance models, advised student research projects, and taught R programming.",
        ),
        entry(
            "Graduate Mentor, Perry World House",
            "Sept. 2024 - Feb. 2025",
            "Mentored an undergraduate research team on quantitative approaches in climate governance.",
        ),
        entry(
            "Intern, Center for Ethics and the Rule of Law",
            "June - Aug. 2023",
            "Coauthored white papers combining quantitative and qualitative analysis of proposed FISA Section 702 reforms.",
        ),
        entry(
            "Intern, U.S. Federal District Court",
            "May - Oct. 2020",
            "Produced analytical research for legal-academic partnerships.",
        ),
    ]

    story.append(PageBreak())
    story += section("Teaching experience")
    story += [
        entry(
            "Instructor and Teaching Assistant, University of Pennsylvania",
            "2023 - present",
            "Instructor of record for Philosophy of Science and Introductory Statistics. Teaching-assistant portfolio: Philosophy of Science, Introduction to Logic, Bioethics, Saving the Planet: Tools for the Climate Emergency, Modern Data Mining, Applied Bayesian Modeling, Applied Regression Analysis for Health Policy Research, and Introduction to Statistics for Health Policy.",
        ),
        entry(
            "Teaching Fellow, Wharton Data Science Academy",
            "Summer 2026",
            "Taught high school students in an intensive summer program; delivered lectures on neural networks and ensemble methods, advised student projects, and supported assignments.",
        ),
        entry(
            "Teaching Assistant, Wharton Moneyball Academy",
            "Summer 2025",
            "Advised high school student projects in sports statistics and provided coding and analytical support in the Philadelphia and San Francisco programs.",
        ),
    ]

    story += section("Talks, Presentations, and Invited Lectures")
    story += [
        entry('"Approximating Posterior Distributions with Variational Bayes"', "2025", "Applied Bayesian Modeling."),
        entry(
            '"A Dynamic Rating Scheme for NFL Pass Rushers"',
            "2025",
            "New England Symposium for Statistics in Sports; Wharton Sport Analytics and Business Summit.",
        ),
        entry(
            '"Judgment and Decision-making under Uncertainty"',
            "2025",
            "Repairing the Planet: Tools for the Climate Emergency.",
        ),
        entry(
            '"Expected Utility Maximization and Environmental Decision-making"',
            "2025",
            "Repairing the Planet: Tools for the Climate Emergency.",
        ),
    ]

    story += section("Academic leadership")
    story.append(
        bullets(
            [
                'Chair, "AI as Method" symposium, 29th Biennial Meeting of the Philosophy of Science Association, 2024.',
                'Chair, "Applied Ethics" colloquium, 119th Annual Meeting of the Eastern Division of the American Philosophical Association, 2023.',
                "Co-developed a new introductory logic course at the University of Pennsylvania, 2024.",
            ]
        )
    )

    story += section("Selected coursework & research")
    story += [
        entry(
            "Statistics &amp; Data Science",
            "Graduate coursework",
            "Applied Regression; Bayesian Modeling; Data Mining; Observational Studies; Probability; Statistical Computing; Forecasting &amp; Time Series; Non-parametric Methods.",
        ),
        entry(
            "Philosophy",
            "Graduate coursework",
            "Philosophy of Science; Mathematical Logic; Logic; Political Philosophy; Metaethics; Contemporary Ethical Theory; Proseminar; Kant and the a priori; Modern Political Philosophy; Epistemology and Perception.",
        ),
        entry(
            "Sparse Control Selection For Spatial Epidemiological Data",
            "M.A. thesis",
            "Applied post-double-selection LASSO with a negative-binomial regression model and Markov random field spatial controls to investigate the association between U.S. county-level partisanship and COVID-19 mortality.",
        ),
    ]

    story += section("Awards & fellowships")
    story.append(
        bullets(
            [
                "Perry World House Graduate Fellow, 2025-26.",
                "Fishman Fellowship, University of Pennsylvania, 2022-present.",
                "Benjamin Franklin Fellowship, University of Pennsylvania, 2022-present.",
                "Fontaine Graduate Fellowship, University of Pennsylvania, 2022-present.",
                "Dissertation Research Award, University of Pennsylvania, 2025.",
                "Edward Dodd Award; Charles Thomas Boggs Prize; The Young Scholarship; William Wells Chaffin Memorial Scholarship, Washington and Lee University, 2022.",
                "The Grenader Family Prize, Mansfield College, University of Oxford, 2020.",
            ]
        )
    )

    story += section("Methods & software")
    story.append(
        Paragraph(
            "Proficient in R, Stan, and LaTeX; familiar with Python, Excel, and Stata. Methods include regression analysis, Bayesian modeling, nonparametric methods, stochastic simulation, and machine learning. Software includes RStudio, VS Code, Jupyter, GitHub, and Overleaf.",
            body_style,
        )
    )

    document.build(story, onFirstPage=footer, onLaterPages=footer)
    print(f"Wrote {OUTPUT}")


if __name__ == "__main__":
    build()

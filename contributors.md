---
layout: page
title: Contributors

# In the list below, all three entries, `affiliation`, `email`, and
# `website` are optional. If you provide an `email` and a `website`, the
# name will link to the website.

contributors:
  - name: John Abbott
    affiliation: University of Kaiserslautern-Landau
    website: https://math.rptu.de/ags/agag/personen/mitglieder
    github: JohnAAbbott

  - name: Martin Bies
    affiliation: University of Kaiserslautern-Landau
    website: https://martinbies.github.io
    github: HereAround

  - name: Simon Brandhorst
    affiliation: Saarland University
    website: https://www.math.uni-sb.de/ag/brandhorst/index.php
    github: simonbrandhorst

  - name: Thomas Breuer
    affiliation: RWTH Aachen University
    website: http://www.math.rwth-aachen.de/~Thomas.Breuer/
    github: ThomasBreuer
    email: thomas.breuer@math.rwth-aachen.de
    
  - name: Taylor Brysiewicz
    affiliation: Max Planck Institute for Mathematics in the Sciences
    website: https://sites.google.com/view/taylorbrysiewicz/home
    github: tbrysiewicz
    email: Taylor.Brysiewicz@mis.mpg.de

  - name: Janko Böhm
    affiliation: University of Kaiserslautern-Landau
    website: https://agag-jboehm.math.rptu.de/~boehm/
    github: jankoboehm

  - name: Wolfram Decker
    affiliation: University of Kaiserslautern-Landau
    website: https://math.rptu.de/en/wgs/agag/people/head/decker
    github: wdecker
    is_editor: true

  - name: Christian Eder
    affiliation: University of Kaiserslautern-Landau
    website: https://www.mathematik.uni-kl.de/~ederc/index.html
    github: ederc
    is_editor: true

  - name: Claus Fieker
    affiliation: University of Kaiserslautern-Landau
    website: https://math.rptu.de/en/wgs/agag/people/head/fieker
    github: fieker
    is_editor: true

  - name: Tommy Hofmann
    affiliation: University of Siegen
    website: https://www.thofma.com
    github: thofma

  - name: Max Horn
    affiliation: University of Kaiserslautern-Landau
    website: https://www.quendi.de/math
    github: fingolfin
    is_editor: true

  - name: Michael Joswig
    affiliation: TU Berlin
    website: https://page.math.tu-berlin.de/~joswig/
    github: micjoswig
    is_editor: true

  - name: Lars Kastner
    affiliation: TU Berlin
    website: https://page.math.tu-berlin.de/~kastner/
    github: lkastner

  - name: Lukas Kühne  # works on matroids with Benjamin Schröter
    affiliation: Bielefeld University
    website: https://www.math.uni-bielefeld.de/~lkuehne/
    github: LukasKuehne

  - name: Benjamin Lorenz
    affiliation: TU Berlin
    website: https://www.math.tu-berlin.de/fachgebiete_ag_diskalg/fg_diskrete_mathematik_geometrie/v_menue/mitarbeiter/benjamin_lorenz/v_menue/home/
    github: benlorenz

  - name: Yue Ren
    affiliation: Durham University
    github: YueRen
    website: https://www.yueren.de/

  - name: Johannes Schmitt  # former PhD student of Ulrich Thiel
    affiliation: University of Siegen
    website: https://joschmitt.eu
    github: joschmitt

  - name: Benjamin Schröter  # works on matroids with Lukas Kühne
    affiliation: KTH Stochkholm
    website: https://people.kth.se/~schrot
    github: bschroter

  - name: Matthias Zach  # algebraic geometry
    affiliation: University of Kaiserslautern-Landau
    website: https://math.rptu.de/ags/agag/personen/mitglieder
    github: HechtiDerLachs

---

## Editors

<ul>
{% for p in page.contributors %}
{% if p.is_editor == true %}
  <li>
    <a href="{{ p.website }}"><strong>{{ p.name }}</strong></a>, {{ p.affiliation }}
    {%- if p.github != null %}
        — <a href="https://github.com/{{ p.github }}">{{ p.github }} on GitHub</a>
    {%- endif -%}
  </li>
{% endif %}
{% endfor %}
</ul>

## Authors

<ul>
{% for p in page.contributors %}
{% if p.is_editor != true %}
  <li>
    {% if p.website != null %}
        <a href="{{ p.website }}">
        {% assign link_open = true %}
    {% elsif p.email != null %}
        <a href="mailto:{{ p.email }}">
        {% assign link_open = true %}
    {% endif %}
    <strong>{{ p.name }}</strong>{% if link_open %}</a>{% assign link_open = false %}{% endif %}
    {%- if p.affiliation != null or p.paid_by_dfg == true -%}
    <em>
        {%- if p.affiliation != null -%}
            , {{ p.affiliation }}{% if p.retired == true %} (formerly){% endif %}
        {%- endif -%}
        {%- if p.paid_by_dfg == true -%}
            {%- if p.affiliation != null -%},{% endif %}
            financed by the <a href="https://www.computeralgebra.de/sfb/">SFB-TRR 195</a>
        {%- endif -%}
        {%- if p.github != null %}
            — <a href="https://github.com/{{ p.github }}">{{ p.github }} on GitHub</a>
        {%- endif -%}
    </em>
    {% endif %}
 </li>
{% endif %}
{% endfor %}
</ul>

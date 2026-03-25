---
layout: page
title: Contributors
---

## Editors

<ul>
{% for p in site.data.contributors %}
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
{% for p in site.data.contributors %}
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

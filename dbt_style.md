# DBT Style Guide

## Model File Template

General template for model file:

```
{{
    config(
        ...
    )
}}

{% set jinja_parameter = 'configurable value' %}

with
  
    dependency_1 as (select * from {{ source('sources', 'dependency_1') }}),    
    dependency_2 as (select * from {{ ref('ref_dependency_2') }})

    intermediate_cte_1 as (
        ...
    ),

    intermediate_cte_2 as (
        ...
    ),

    model_name as (
        ...
    )

select * from model_name

{{ limit_if_dev() }}

```

### Rules:
#### Config at top

#### 1. Declare Jinja prep

#### 2. Declare all `{{ source() }}` and `{{ ref() }}` dependencies as CTEs at top of query
This makes it easier to trace dependencies. CTEs should be named exactly the same as the source table or the referenced model, and should be sorted alphabetically.

In the interest of readability, declare each CTE on a single line, and do not insert line breaks between the CTEs. Sort CTEs alphabetically. After the final dependency CTE, insert a blank line.

#### 3. Define intermediate CTEs
For readability, add a blank line between CTEs. CTE names can be a noun describing the entity, or a verb phrase describing a transformation.

#### 4. Use final CTE to define the model
This is intended to make it easier to identify the model output. Define the final model in the final CTE, and name the CTE the same as the model. Then `select * from [model_name]`

#### 5. Apply LIMIT if in dev mode
This reduces build time when testing models during development. Use the `{{ limit_if_dev() }}` macro.

## Basic SQL Query Formats



```
select
    relation_1.first_field,
    relation_2.second_field

from relation_1
    left join relation_2
        on relation_1.key = relation_2.key
        and relation_1.second_condition = relation_2.second_condition

where
    relation_1.filter_field = 'some value'
```
Insert a blank line before each clause. When referencing fields, always specify the source table unless there are no joins (and all fields come from the same table). Except for `from` and `join`, all clause headers (`select`, `where`, `group by`, `order by`) should be on their own line, unless the entire clause can fit on a single line.

```
select
    grouped_field_1,
    grouped_field_2,

    sum(fact_1) as aggregated_field_1

from some_table

group by 1,2

having sum(fact_1) > 0
```

Insert a blank line after the `group by` fields. The `group by` clause can be defined on a single line, and should use numeric references. Too many `group by` fields is a code smell.


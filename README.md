# Tech Training Platform Database Analytics

A complete data analyst project demonstrating end-to-end skills from messy data to business insights.

## 📖 Project Overview

This project showcases a realistic data analytics workflow for a corporate tech training platform. It demonstrates systematic data quality assessment, comprehensive cleaning procedures, database design, and strategic business analytics.

**Key Achievement:** Transformed messy, inconsistent data across 5 tables into clean, reliable datasets that enabled actionable business insights.

## 🗄️ Database Schema

**Entity Relationship Diagram:**
![Database ERD](https://github.com/user-attachments/assets/fd779ad6-2fd0-44fd-be5f-c13bd8285794)

**5 Core Tables:**
- **Instructors** (7 records) - Teacher profiles and specializations
- **Students** (25 records) - Student demographics and subscription tiers
- **Courses** (9 records) - Course catalog with pricing and difficulty
- **Enrollments** (30 records) - Student course registrations and outcomes
- **Learning Sessions** (55 records) - Detailed learning activity tracking

## 🔧 Technical Skills Demonstrated

### Database Design
- Normalized relational database structure
- Foreign key constraints and referential integrity
- Realistic business entity modeling

### Data Quality & Cleaning
- Systematic data quality assessment
- Standardized data formats and conventions
- Comprehensive cleaning procedures with validation

### Business Analytics
- Strategic KPI identification
- Revenue and performance analysis
- Student engagement and retention insights

## 📊 Key Business Insights

### Financial Performance
- **Total Revenue:** $11,199.76
- **Completion Rate:** 85.7%
- **Average Student Score:** 87.30

### Top Performers
- **Highest Revenue Course:** Ethical Hacking ($2,399.97)
- **Most Popular Instructor:** Sarah Chen (Python Development)
- **Most Valuable Tier:** Corporate subscriptions(11)

### Strategic Findings
- Advanced courses generate 2x higher revenue per student
- Desktop learning sessions show highest completion rates
- Corporate clients demonstrate strongest engagement patterns

## 📁 Project Structure

```
tech-training-analytics/
├── README.md                             # Main project overview
├── database/
│   ├── 01_schema_creation.sql            # Database and table creation
│   ├── 02_data_quality_assessment.sql    # Problem identification
│   ├── 03_data_cleaning_procedures.sql   # Systematic cleaning
│   └── erd_diagram.png                   # Visual database schema
├── analytics/
    ├── 04_business_analytics.sql         # Strategic insights queries
    └── business_insights_summary.md      # Key analytical findings

```

## 🚀 Quick Start

1. **Set up database:**
   ```sql
   source database/01_schema_creation.sql
   ```

2. **Assess data quality:**
   ```sql
   source database/02_data_quality_assessment.sql
   ```

3. **Clean the data:**
   ```sql
   source database/03_data_cleaning_procedures.sql
   ```

4. **Generate insights:**
   ```sql
   source analytics/04_business_analytics_queries.sql
   ```

## 🎯 Data Quality Results

### Before Cleaning
| Table | Total Records | Quality Issues | Issue Rate |
|-------|---------------|----------------|------------|
| Instructors | 7 | 2 | 28.6% |
| Students | 25 | 12 | 48.0% |
| Courses | 9 | 4 | 44.4% |
| Enrollments | 30 | 6 | 20.0% |
| Learning Sessions | 55 | 15 | 27.3% |

### After Cleaning
**Result: 0% data quality issues across all tables**

Common issues resolved:
- Case inconsistencies (`individual` → `Individual`)
- Format variations (`90 mins` → `90 minutes`)
- Invalid data markers (`null`, `N/A` → proper NULL values)
- Incomplete entries (missing email domains, company names)

## 🛠 Technologies Used

- **Database:** MySQL 8.0
- **Design:** MySQL Workbench (ERD generation)
- **Analysis:** SQL (complex joins, aggregations, window functions)
- **Documentation:** Markdown, SQL comments

## 📈 Sample Business Questions Answered

1. Which instructors drive the highest completion rates?
2. What subscription tier generates the most revenue?
3. How does device type impact learning outcomes?
4. Which courses should we prioritize for development?
5. What are our peak learning times for resource planning?

## 🎓 Portfolio Impact

This project demonstrates:
- **End-to-end data analyst workflow** from messy data to business recommendations
- **Technical proficiency** in SQL, database design, and data cleaning
- **Business acumen** through strategic KPI identification and insight generation
- **Communication skills** via clear documentation and actionable recommendations

---

**Contact:** adescofaj@gmail.com 
**Portfolio:** https://github.com/adescofaj
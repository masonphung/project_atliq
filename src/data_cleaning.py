import pandas as pd
from sqlalchemy import create_engine

def main():
    engine = create_engine("mysql+mysqlconnector://root:tttn0711@localhost:3306/sales")

    # Define tables to be imported
    tables = ['transactions', 'products', 'markets', 'customers', 'date']

    # Import the tables from SQL server to Python environment
    for table in tables:
        try:
            globals()[table] = pd.read_sql_table(table, con=engine)
            print(f'{table} table imported')
        except Exception as e:
            print(f'Failed to import {table}: {e}')

    # Replace '\r' characters with a space
    products['product_type'] = products['product_type'].str.replace('\r', ' ')
    date['date_yy_mmm'] = date['date_yy_mmm'].str.replace('\r', ' ')

    # Replace any `sales_amount` value with `currency = USD` with the sum of `profit_margin` and `cost_price`
    transactions.loc[transactions['currency'] == 'USD', 'sales_amount'] = (
        transactions['profit_margin'] + transactions['cost_price']
    )
    # Replace any currency = `USD` with `INR`
    transactions['currency'] = transactions['currency'].replace(['USD'], 'INR')

    # Apply ~ as the logical negation, to keep the rows that do not match the criteria
    markets = markets[~markets['markets_code'].isin(['Mark097', 'Mark999'])]

    # Write the records in each DataFrame to the SQL server, replace if exists
    dfs = {
        'transactions': transactions,
        'markets': markets,
        'products': products,
        'customers': customers,
        'date': date,
    }

    for name, df in dfs.items():
        try:
            df.to_sql(name=name, con=engine, if_exists='replace', index=False)
            print(f'{name} table exported')
        except Exception as e:
            print(f'Failed to export {name}: {e}')


if __name__ == "__main__":
    main()
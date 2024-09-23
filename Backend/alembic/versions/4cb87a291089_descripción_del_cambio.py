"""Descripción del cambio

Revision ID: 4cb87a291089
Revises: 
Create Date: 2024-09-20 22:23:46.641294

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = '4cb87a291089'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_schedules_id', table_name='schedules')
    op.drop_table('schedules')
    op.drop_index('ix_users_codigo', table_name='users')
    op.drop_index('ix_users_email', table_name='users')
    op.drop_table('users')
    op.drop_index('ix_courses_id', table_name='courses')
    op.drop_table('courses')
    op.drop_index('ix_faculties_id', table_name='faculties')
    op.drop_table('faculties')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('faculties',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('faculties_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('name', sa.VARCHAR(length=100), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('id', name='faculties_pkey'),
    sa.UniqueConstraint('name', name='faculties_name_key'),
    postgresql_ignore_search_path=False
    )
    op.create_index('ix_faculties_id', 'faculties', ['id'], unique=False)
    op.create_table('courses',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('courses_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('name', sa.VARCHAR(length=50), autoincrement=False, nullable=False),
    sa.Column('course_number', sa.VARCHAR(length=50), autoincrement=False, nullable=False),
    sa.Column('faculty_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['faculty_id'], ['faculties.id'], name='courses_faculty_id_fkey'),
    sa.PrimaryKeyConstraint('id', name='courses_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_index('ix_courses_id', 'courses', ['id'], unique=False)
    op.create_table('users',
    sa.Column('codigo', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('first_name', sa.VARCHAR(length=50), autoincrement=False, nullable=False),
    sa.Column('last_name', sa.VARCHAR(length=50), autoincrement=False, nullable=False),
    sa.Column('email', sa.VARCHAR(length=100), autoincrement=False, nullable=False),
    sa.Column('password', sa.VARCHAR(length=255), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('codigo', name='users_pkey')
    )
    op.create_index('ix_users_email', 'users', ['email'], unique=True)
    op.create_index('ix_users_codigo', 'users', ['codigo'], unique=False)
    op.create_table('schedules',
    sa.Column('id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('course_id', sa.INTEGER(), autoincrement=False, nullable=True),
    sa.Column('day_of_week', sa.VARCHAR(length=10), autoincrement=False, nullable=True),
    sa.Column('start_time', postgresql.TIME(), autoincrement=False, nullable=True),
    sa.Column('end_time', postgresql.TIME(), autoincrement=False, nullable=True),
    sa.Column('start_date', sa.DATE(), autoincrement=False, nullable=True),
    sa.Column('end_date', sa.DATE(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['course_id'], ['courses.id'], name='schedules_course_id_fkey'),
    sa.PrimaryKeyConstraint('id', name='schedules_pkey')
    )
    op.create_index('ix_schedules_id', 'schedules', ['id'], unique=False)
    # ### end Alembic commands ###

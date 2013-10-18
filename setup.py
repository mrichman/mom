#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup, find_packages

setup(
    name='mom',
    version='1.0.0',
    packages=find_packages(exclude='tests'),
    scripts=[],
    url='http://github.com/mrichman/mom',
    license='LICENSE.txt',
    author='Mark Richman',
    author_email='mark@markrichman.com',
    description='Dydacomp MOM SQL Server Client',
    long_description=open('README.txt').read(),
    install_requires=['pymssql>=2.0.0b1-dev-20130403']
)

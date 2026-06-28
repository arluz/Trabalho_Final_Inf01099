from flask import Flask, Blueprint, request, render_template, redirect, url_for, abort, flash
from sqlalchemy.exc import IntegrityError
import models

turmas_bp = Blueprint('turmas', __name__)
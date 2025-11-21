import os
from flask import Flask, render_template, redirect, url_for, request, jsonify, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from dotenv import load_dotenv
from sqlalchemy import text

# 1. Setup Application
load_dotenv()  # Load environment variables from .env

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'default_secret_key')

# Fix for some database URLs (Postgres requires 'postgresql://')
uri = os.getenv('DATABASE_URL')
if uri and uri.startswith("postgres://"):
    uri = uri.replace("postgres://", "postgresql://", 1)
app.config['SQLALCHEMY_DATABASE_URI'] = uri

db = SQLAlchemy(app)

# 2. Login Manager Setup
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

# 3. User Model (Must match your SQL Table)
class User(UserMixin, db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100), unique=True)
    password_hash = db.Column(db.String(100))
    role = db.Column(db.String(50))

    def get_id(self):
        return str(self.id)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

# --- ROUTES ---

# Login Route
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        # Note: For this school demo, we skip password hashing verification
        user = User.query.filter_by(email=email).first()
        if user:
            login_user(user)
            return redirect(url_for('dashboard'))
        flash('User not found. Try: alice@example.com')
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

# Dashboard Route (Read & Create)
@app.route('/dashboard')
@login_required
def dashboard():
    # 1. Get all available grants (Read Grants Table)
    # Using raw SQL to ensure it works with your manual schema
    grants_query = text("SELECT g.id, g.title, s.name as source_name, g.amount_max FROM grants g JOIN grant_sources s ON g.source_id = s.id")
    all_grants = db.session.execute(grants_query).fetchall()

    # 2. Get My Saved Grants (Read User_Grant_Matches Table)
    saved_query = text("""
        SELECT m.id, g.title, m.status 
        FROM user_grant_matches m 
        JOIN grants g ON m.grant_id = g.id 
        WHERE m.user_id = :uid
    """)
    my_grants = db.session.execute(saved_query, {'uid': current_user.id}).fetchall()
    
    return render_template('dashboard.html', user=current_user, grants=all_grants, saved_grants=my_grants)

# Save Grant Route (Create)
@app.route('/save_grant/<int:grant_id>')
@login_required
def save_grant(grant_id):
    sql = text("INSERT INTO user_grant_matches (user_id, grant_id, status) VALUES (:uid, :gid, 'saved')")
    try:
        db.session.execute(sql, {'uid': current_user.id, 'gid': grant_id})
        db.session.commit()
    except:
        db.session.rollback() # Prevent error if already saved
    return redirect(url_for('dashboard'))

# Delete Grant Route (Delete)
@app.route('/delete_grant/<int:match_id>')
@login_required
def delete_grant(match_id):
    sql = text("DELETE FROM user_grant_matches WHERE id = :mid")
    db.session.execute(sql, {'mid': match_id})
    db.session.commit()
    return redirect(url_for('dashboard'))

# Chart Data Endpoint (For Visualization)
@app.route('/chart-data')
@login_required
def chart_data():
    # Aggregates grants by source type
    sql = text("""
        SELECT s.source_type, COUNT(g.id) as count 
        FROM grants g 
        JOIN grant_sources s ON g.source_id = s.id 
        GROUP BY s.source_type
    """)
    results = db.session.execute(sql).fetchall()
    
    labels = [row[0] for row in results]
    data = [row[1] for row in results]
    return jsonify({'labels': labels, 'data': data})

if __name__ == '__main__':
    app.run(debug=True)
#include "gamewindow.hh"

GameWindow::GameWindow(void)
{
  m_game = new Game;
  ui.setupUi(this);
  m_content = new Content(m_game);
  setCentralWidget(m_content);
  connect(ui.actionNewGame, SIGNAL(activated()), this, SLOT(restart()));
  connect(ui.actionQuit, SIGNAL(activated()), this, SLOT(close()));
  connect(m_content, SIGNAL(message(QString)), this, SLOT(status(QString)));
  connect(m_content->humanBoard(), SIGNAL(message(QString)), this, SLOT(status(QString)));
}

GameWindow::~GameWindow(void)
{
  delete m_game;
}

void GameWindow::restart(void)
{
  delete m_game;
  m_game = new Game;
  m_content->setGame(m_game);
}

void GameWindow::status(QString text)
{
  statusBar()->showMessage(text, DELAY);
}


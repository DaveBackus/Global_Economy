



<!DOCTYPE html>
<html lang="en" class="">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>Global_Economy/wb_expenditure_shares.py at master · DaveBackus/Global_Economy</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="DaveBackus/Global_Economy" name="twitter:title" /><meta content="Global_Economy - Materials for NYU Global Economy course" name="twitter:description" /><meta content="https://avatars1.githubusercontent.com/u/7989289?v=2&amp;s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars1.githubusercontent.com/u/7989289?v=2&amp;s=400" property="og:image" /><meta content="DaveBackus/Global_Economy" property="og:title" /><meta content="https://github.com/DaveBackus/Global_Economy" property="og:url" /><meta content="Global_Economy - Materials for NYU Global Economy course" property="og:description" />

      <meta name="browser-stats-url" content="/_stats">
    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    <link rel="xhr-socket" href="/_sockets">

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="807AB8B4:76F9:6EE43D2:5418A1E1" name="octolytics-dimension-request_id" /><meta content="7989289" name="octolytics-actor-id" /><meta content="DaveBackus" name="octolytics-actor-login" /><meta content="16d79863614ab3ce09aa07c82163e591797c5fbfd5e6f2580b471a15e5f59f92" name="octolytics-actor-hash" />
    <meta content="Rails, view, blob#show" name="analytics-event" />

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="yh36hju+WkyCI54mzmLdPzj74xn96BTEUcs8EuC5MLOJQexcsm3/qwNM3zec1kuaVQ5cgm7Ey4Aag6x3IW+XMg==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-afb3bfc1eb4eece441856e100e7b0a566f9d2c4b.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-f6fbb85fa702ec56c88489fd2170fddd6c9096df.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="fc4fe28c49d50301a4f104be9c102aac">

      
  <meta name="description" content="Global_Economy - Materials for NYU Global Economy course">
  <meta name="go-import" content="github.com/DaveBackus/Global_Economy git https://github.com/DaveBackus/Global_Economy.git">

  <meta content="7989289" name="octolytics-dimension-user_id" /><meta content="DaveBackus" name="octolytics-dimension-user_login" /><meta content="22357773" name="octolytics-dimension-repository_id" /><meta content="DaveBackus/Global_Economy" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="22357773" name="octolytics-dimension-repository_network_root_id" /><meta content="DaveBackus/Global_Economy" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/DaveBackus/Global_Economy/commits/master.atom" rel="alternate" title="Recent Commits to Global_Economy:master" type="application/atom+xml">

  </head>


  <body class="logged_in  env-production windows vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      <div class="header header-logged-in true">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/" aria-label="Homepage" ga-data-click="Header, go to dashboard, icon:logo">
  <span class="mega-octicon octicon-mark-github"></span>
</a>


      <div class="site-search repo-scope js-site-search">
          <form accept-charset="UTF-8" action="/DaveBackus/Global_Economy/search" class="js-site-search-form" data-global-search-url="/search" data-repo-search-url="/DaveBackus/Global_Economy/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <input type="text"
    class="js-site-search-field is-clearable"
    data-hotkey="s"
    name="q"
    placeholder="Search"
    data-global-scope-placeholder="Search GitHub"
    data-repo-scope-placeholder="Search"
    tabindex="1"
    autocapitalize="off">
  <div class="scope-badge">This repository</div>
</form>
      </div>
      <ul class="header-nav left">
        <li class="header-nav-item explore">
          <a class="header-nav-link" href="/explore" data-ga-click="Header, go to explore, text:explore">Explore</a>
        </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="https://gist.github.com" data-ga-click="Header, go to gist, text:gist">Gist</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/blog" data-ga-click="Header, go to blog, text:blog">Blog</a>
          </li>
        <li class="header-nav-item">
          <a class="header-nav-link" href="https://help.github.com" data-ga-click="Header, go to help, text:help">Help</a>
        </li>
      </ul>

    
<ul class="header-nav user-nav right" id="user-links">
  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link name" href="/DaveBackus" data-ga-click="Header, go to profile, text:username">
      <img alt="Dave Backus" class="avatar" data-user="7989289" height="20" src="https://avatars2.githubusercontent.com/u/7989289?v=2&amp;s=40" width="20" />
      <span class="css-truncate">
        <span class="css-truncate-target">DaveBackus</span>
      </span>
    </a>
  </li>

  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link js-menu-target tooltipped tooltipped-s" href="#" aria-label="Create new..." data-ga-click="Header, create new, icon:add">
      <span class="octicon octicon-plus"></span>
      <span class="dropdown-caret"></span>
    </a>

    <div class="dropdown-menu-content js-menu-content">
      
<ul class="dropdown-menu">
  <li>
    <a href="/new"><span class="octicon octicon-repo"></span> New repository</a>
  </li>
  <li>
    <a href="/organizations/new"><span class="octicon octicon-organization"></span> New organization</a>
  </li>


    <li class="dropdown-divider"></li>
    <li class="dropdown-header">
      <span title="DaveBackus/Global_Economy">This repository</span>
    </li>
      <li>
        <a href="/DaveBackus/Global_Economy/issues/new"><span class="octicon octicon-issue-opened"></span> New issue</a>
      </li>
      <li>
        <a href="/DaveBackus/Global_Economy/settings/collaboration"><span class="octicon octicon-person"></span> New collaborator</a>
      </li>
</ul>

    </div>
  </li>

  <li class="header-nav-item">
        <a href="/notifications" aria-label="You have no unread notifications" class="header-nav-link notification-indicator tooltipped tooltipped-s" data-ga-click="Header, go to notifications, icon:read" data-hotkey="g n">
        <span class="mail-status all-read"></span>
        <span class="octicon octicon-inbox"></span>
</a>
  </li>

  <li class="header-nav-item">
    <a class="header-nav-link tooltipped tooltipped-s" href="/settings/profile" id="account_settings" aria-label="Settings" data-ga-click="Header, go to settings, icon:settings">
      <span class="octicon octicon-gear"></span>
    </a>
  </li>

  <li class="header-nav-item">
    <form accept-charset="UTF-8" action="/logout" class="logout-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="IupT/BUNfl9L+RNLUEJGXS9A8Ja+Wub/z1M4o5QnYOsEzmRgnuba6sQWxLqNIDk1YLDkIjKx0Wq0qh7I2qYjBA==" /></div>
      <button class="header-nav-link sign-out-button tooltipped tooltipped-s" aria-label="Sign out" data-ga-click="Header, sign out, icon:logout">
        <span class="octicon octicon-sign-out"></span>
      </button>
</form>  </li>

</ul>


    
  </div>
</div>

      

        


      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">

    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="RRroRQ6jzdimIs8PTGr9h3euOuFFaacuQHAGBCrmGYkH561bNgPp5mZBvz2K4ncXnIBMpbgiquc81R9W0v4XeA==" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="22357773" />

    <div class="select-menu js-menu-container js-select-menu">
      <a class="social-count js-social-count" href="/DaveBackus/Global_Economy/watchers">
        1
      </a>
      <a href="/DaveBackus/Global_Economy/subscription"
        class="minibutton select-menu-button with-count js-menu-target" role="button" tabindex="0" aria-haspopup="true">
        <span class="js-select-button">
          <span class="octicon octicon-eye"></span>
          Unwatch
        </span>
      </a>

      <div class="select-menu-modal-holder">
        <div class="select-menu-modal subscription-menu-modal js-menu-content" aria-hidden="true">
          <div class="select-menu-header">
            <span class="select-menu-title">Notifications</span>
            <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container" role="menu">

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">Be notified when participating or @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">Be notified of all conversations.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">Never be notified.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

  <li>
    
  <div class="js-toggler-container js-social-container starring-container ">

    <form accept-charset="UTF-8" action="/DaveBackus/Global_Economy/unstar" class="js-toggler-form starred js-unstar-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="1Jg0wD+BJdcI+rDAF5Mh4k6g6aoy1c2I3HsJqx4p8bHwXb2H1rsKhKMx5yoX8mihHxltPWvpDrVMMTq830FtcA==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Unstar this repository" title="Unstar DaveBackus/Global_Economy">
        <span class="octicon octicon-star"></span>
        Unstar
      </button>
        <a class="social-count js-social-count" href="/DaveBackus/Global_Economy/stargazers">
          0
        </a>
</form>
    <form accept-charset="UTF-8" action="/DaveBackus/Global_Economy/star" class="js-toggler-form unstarred js-star-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="OfjRYLewSrNkTxv8kbSYaJTVmHEhvx72gxie2h4FY0cXdv/3XVciti9ZzA+8nLydbRoKXMCQmROVEmtp6EM66w==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Star this repository" title="Star DaveBackus/Global_Economy">
        <span class="octicon octicon-star"></span>
        Star
      </button>
        <a class="social-count js-social-count" href="/DaveBackus/Global_Economy/stargazers">
          0
        </a>
</form>  </div>

  </li>


        <li>
          <a href="/DaveBackus/Global_Economy/fork" class="minibutton with-count js-toggler-target fork-button tooltipped-n" title="Fork your own copy of DaveBackus/Global_Economy to your account" aria-label="Fork your own copy of DaveBackus/Global_Economy to your account" rel="nofollow" data-method="post">
            <span class="octicon octicon-repo-forked"></span>
            Fork
          </a>
          <a href="/DaveBackus/Global_Economy/network" class="social-count">0</a>
        </li>

</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/DaveBackus" class="url fn" itemprop="url" rel="author"><span itemprop="title">DaveBackus</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/DaveBackus/Global_Economy" class="js-current-repository js-repo-home-link">Global_Economy</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders" data-issue-count-url="/DaveBackus/Global_Economy/issues/counts">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/DaveBackus/Global_Economy" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /DaveBackus/Global_Economy">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/DaveBackus/Global_Economy/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /DaveBackus/Global_Economy/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class="js-issue-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/DaveBackus/Global_Economy/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /DaveBackus/Global_Economy/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class="js-pull-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


        <li class="tooltipped tooltipped-w" aria-label="Wiki">
          <a href="/DaveBackus/Global_Economy/wiki" aria-label="Wiki" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g w" data-selected-links="repo_wiki /DaveBackus/Global_Economy/wiki">
            <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>
    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/DaveBackus/Global_Economy/pulse/weekly" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /DaveBackus/Global_Economy/pulse/weekly">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/DaveBackus/Global_Economy/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /DaveBackus/Global_Economy/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


      <div class="sunken-menu-separator"></div>
      <ul class="sunken-menu-group">
        <li class="tooltipped tooltipped-w" aria-label="Settings">
          <a href="/DaveBackus/Global_Economy/settings" aria-label="Settings" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_settings /DaveBackus/Global_Economy/settings">
            <span class="octicon octicon-tools"></span> <span class="full-word">Settings</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>
      </ul>
  </div>
</div>

              <div class="only-with-full-nav">
                
  
<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=push">
  <h3><span class="text-emphasized">HTTPS</span> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/DaveBackus/Global_Economy.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/DaveBackus/Global_Economy.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=push">
  <h3><span class="text-emphasized">SSH</span> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="git@github.com:DaveBackus/Global_Economy.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="git@github.com:DaveBackus/Global_Economy.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=push">
  <h3><span class="text-emphasized">Subversion</span> checkout URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/DaveBackus/Global_Economy" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/DaveBackus/Global_Economy" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
      <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>,
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>


  <a href="github-windows://openRepo/https://github.com/DaveBackus/Global_Economy" class="minibutton sidebar-button" title="Save DaveBackus/Global_Economy to your computer and use it in GitHub Desktop." aria-label="Save DaveBackus/Global_Economy to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>

                <a href="/DaveBackus/Global_Economy/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download the contents of DaveBackus/Global_Economy as a zip file"
                   title="Download the contents of DaveBackus/Global_Economy as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/DaveBackus/Global_Economy/blob/d4fdb5dbc67f9039dfce7be1a97df008d93f9688/Code/Python/wb_expenditure_shares.py" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:a4b7140363cf71116484ce55c041256a -->

<div class="file-navigation">
  
<div class="select-menu js-menu-container js-select-menu left">
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Find or create a branch…" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Find or create a branch…">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/DaveBackus/Global_Economy/blob/master/Code/Python/wb_expenditure_shares.py"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <form accept-charset="UTF-8" action="/DaveBackus/Global_Economy/branches" class="js-create-branch select-menu-item select-menu-new-item-form js-navigation-item js-new-item-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="VVHlGmc4SFtm+ngNC8TtuiR6IqnycPZBCiOTmI82/JKn/UfDsSy/0GVmZETQZdWKuMhA9cTIu0rumRcVgZRSag==" /></div>
            <span class="octicon octicon-git-branch select-menu-item-icon"></span>
            <div class="select-menu-item-text">
              <h4>Create branch: <span class="js-new-item-name"></span></h4>
              <span class="description">from ‘master’</span>
            </div>
            <input type="hidden" name="name" id="name" class="js-new-item-value">
            <input type="hidden" name="branch" id="branch" value="master">
            <input type="hidden" name="path" id="path" value="Code/Python/wb_expenditure_shares.py">
          </form> <!-- /.select-menu-item -->

      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/DaveBackus/Global_Economy/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="Code/Python/wb_expenditure_shares.py"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/DaveBackus/Global_Economy" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">Global_Economy</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/DaveBackus/Global_Economy/tree/master/Code" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">Code</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/DaveBackus/Global_Economy/tree/master/Code/Python" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">Python</span></a></span><span class="separator"> / </span><strong class="final-path">wb_expenditure_shares.py</strong>
  </div>
</div>


  <div class="commit commit-loader file-history-tease js-deferred-content" data-url="/DaveBackus/Global_Economy/contributors/master/Code/Python/wb_expenditure_shares.py">
    <div class="file-history-tease-header">
      Fetching contributors&hellip;
    </div>

    <div class="participation">
      <p class="loader-loading"><img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32-EAF2F5.gif" width="16" /></p>
      <p class="loader-error">Cannot retrieve contributors at this time</p>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
          <span>229 lines (189 sloc)</span>
          <span class="meta-divider"></span>
        <span>8.175 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
          <a href="/DaveBackus/Global_Economy/raw/master/Code/Python/wb_expenditure_shares.py" class="minibutton " id="raw-url">Raw</a>
            <a href="/DaveBackus/Global_Economy/blame/master/Code/Python/wb_expenditure_shares.py" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/DaveBackus/Global_Economy/commits/master/Code/Python/wb_expenditure_shares.py" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->

          <a class="octicon-button tooltipped tooltipped-nw"
             href="github-windows://openRepo/https://github.com/DaveBackus/Global_Economy?branch=master&amp;filepath=Code%2FPython%2Fwb_expenditure_shares.py" aria-label="Open this file in GitHub for Windows">
              <span class="octicon octicon-device-desktop"></span>
          </a>

              <a class="octicon-button js-update-url-with-hash"
                 href="/DaveBackus/Global_Economy/edit/master/Code/Python/wb_expenditure_shares.py"
                 data-method="post" rel="nofollow" data-hotkey="e"><span class="octicon octicon-pencil"></span></a>

            <a class="octicon-button danger"
               href="/DaveBackus/Global_Economy/delete/master/Code/Python/wb_expenditure_shares.py"
               data-method="post" data-test-id="delete-blob-file" rel="nofollow">
          <span class="octicon octicon-trashcan"></span>
        </a>
      </div><!-- /.actions -->
    </div>
    
  <div class="blob-wrapper data type-python">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code js-file-line"><span class="sd">Expdenditure shares of GDP from the World Bank dataset (the NIPA part of </span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code js-file-line"><span class="sd">World Development Indicators).  This works for any country, just enter the </span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code js-file-line"><span class="sd">2-digit country code.  I access country and variable codes by downloading </span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code js-file-line"><span class="sd">the whole dataset as csv and skimming through the csv&#39;s for countries</span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code js-file-line"><span class="sd">and variables.  </span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code js-file-line"><span class="sd">World Bank data codes </span></td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code js-file-line"><span class="sd">General government final consumption expenditure (current LCU)	NE.CON.GOVT.CN</span></td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code js-file-line"><span class="sd">Household final consumption expenditure, etc. (current LCU)	NE.CON.PETC.CN</span></td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code js-file-line"><span class="sd">Household final consumption expenditure (current LCU)	NE.CON.PRVT.CN</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code js-file-line"><span class="sd">Final consumption expenditure, etc. (current LCU)	NE.CON.TETC.CN</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code js-file-line"><span class="sd">Final consumption expenditure (current LCU)	NE.CON.TOTL.CN</span></td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code js-file-line"><span class="sd">Gross national expenditure (current LCU)	NE.DAB.TOTL.CN</span></td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code js-file-line"><span class="sd">Exports of goods and services (current LCU)	NE.EXP.GNFS.CN</span></td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code js-file-line"><span class="sd">Gross fixed capital formation, private sector (current LCU)	NE.GDI.FPRV.CN</span></td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code js-file-line"><span class="sd">Gross fixed capital formation (current LCU)	NE.GDI.FTOT.CN</span></td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code js-file-line"><span class="sd">Changes in inventories (current LCU)	NE.GDI.STKB.CN</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code js-file-line"><span class="sd">Gross capital formation (current LCU)	NE.GDI.TOTL.CN</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code js-file-line"><span class="sd">Imports of goods and services (current LCU)	NE.IMP.GNFS.CN</span></td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code js-file-line"><span class="sd">External balance on goods and services (current LCU)	NE.RSB.GNFS.CN</span></td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code js-file-line"><span class="sd">GDP (current LCU)	NY.GDP.MKTP.CN</span></td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code js-file-line"><span class="sd">Discrepancy in expenditure estimate of GDP (current LCU)	NY.GDP.DISC.CN</span></td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code js-file-line"><span class="sd">http://web.worldbank.org/WBSITE/EXTERNAL/DATASTATISTICS/0,,contentMDK:20451590~isCURL:Y~menuPK:64133156~pagePK:64133150~piPK:64133175~theSitePK:239419~isCURL:Y~isCURL:Y,00.html</span></td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code js-file-line"><span class="sd">References </span></td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code js-file-line"><span class="sd">* http://data.worldbank.org/</span></td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code js-file-line"><span class="sd">* </span></td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code js-file-line"><span class="sd">* http://pandas.pydata.org/pandas-docs/stable/remote_data.html#world-bank</span></td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code js-file-line"><span class="sd">* http://quant-econ.net/pandas.html#data-from-the-world-bank</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code js-file-line"><span class="sd">Prepared for the NYU Course &quot;Global Economy&quot; </span></td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code js-file-line"><span class="sd">* https://sites.google.com/site/nyusternglobal/home </span></td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code js-file-line"><span class="sd">* https://github.com/DaveBackus/Global_Economy </span></td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code js-file-line"><span class="sd">Written by Dave Backus @ NYU, September 2014  </span></td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code js-file-line"><span class="sd">Created with Python 3.4 </span></td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code js-file-line"><span class="kn">from</span> <span class="nn">pandas.io</span> <span class="kn">import</span> <span class="n">wb</span></td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code js-file-line"><span class="kn">import</span> <span class="nn">matplotlib</span> <span class="kn">as</span> <span class="nn">mpl</span></td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code js-file-line"><span class="kn">import</span> <span class="nn">matplotlib.pylab</span> <span class="kn">as</span> <span class="nn">plt</span></td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code js-file-line"><span class="c"># set plot parameters </span></td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code js-file-line"><span class="n">mpl</span><span class="o">.</span><span class="n">rcParams</span><span class="p">[</span><span class="s">&#39;figure.figsize&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="mi">6</span><span class="p">,</span> <span class="mf">4.5</span>  <span class="c"># default is 6, 4</span></td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code js-file-line"><span class="n">mpl</span><span class="o">.</span><span class="n">rcParams</span><span class="p">[</span><span class="s">&#39;legend.fontsize&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="mi">10</span>  </td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code js-file-line"><span class="n">mpl</span><span class="o">.</span><span class="n">rcParams</span><span class="p">[</span><span class="s">&#39;legend.labelspacing&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="mf">0.25</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code js-file-line"><span class="n">mpl</span><span class="o">.</span><span class="n">rcParams</span><span class="p">[</span><span class="s">&#39;legend.handlelength&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="mi">3</span></td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code js-file-line"><span class="sd">1. Read in GDP and expenditure components from World Bank  </span></td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L54" class="blob-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-code js-file-line"><span class="n">country_list</span>  <span class="o">=</span> <span class="p">[</span><span class="s">&#39;FR&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L55" class="blob-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-code js-file-line"><span class="n">variable_list</span> <span class="o">=</span> <span class="p">[</span><span class="s">&#39;NE.CON.GOVT.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.CON.PETC.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.CON.PRVT.CN&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L56" class="blob-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-code js-file-line">                 <span class="s">&#39;NE.CON.TETC.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.CON.TOTL.CN&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L57" class="blob-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-code js-file-line">                 <span class="s">&#39;NE.DAB.TOTL.CN&#39;</span><span class="p">,</span>                 </td>
      </tr>
      <tr>
        <td id="L58" class="blob-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-code js-file-line">                 <span class="s">&#39;NE.EXP.GNFS.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.GDI.FTOT.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.GDI.STKB.CN&#39;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L59" class="blob-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-code js-file-line">                 <span class="s">&#39;NE.GDI.TOTL.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.IMP.GNFS.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NE.RSB.GNFS.CN&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L60" class="blob-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-code js-file-line">                 <span class="s">&#39;NY.GDP.MKTP.CN&#39;</span><span class="p">,</span> <span class="s">&#39;NY.GDP.DISC.CN&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L61" class="blob-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-code js-file-line"><span class="n">df</span> <span class="o">=</span> <span class="n">wb</span><span class="o">.</span><span class="n">download</span><span class="p">(</span><span class="n">indicator</span><span class="o">=</span><span class="n">variable_list</span><span class="p">,</span> <span class="n">country</span><span class="o">=</span><span class="n">country_list</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L62" class="blob-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-code js-file-line">                 <span class="n">start</span><span class="o">=</span><span class="mi">1990</span><span class="p">,</span> <span class="n">end</span><span class="o">=</span><span class="mi">2014</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L63" class="blob-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L64" class="blob-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-code js-file-line"><span class="c"># simplify variable names </span></td>
      </tr>
      <tr>
        <td id="L65" class="blob-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-code js-file-line"><span class="c"># http://stackoverflow.com/questions/11346283/renaming-columns-in-pandas</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-code js-file-line"><span class="n">nicknames</span> <span class="o">=</span> <span class="p">{</span><span class="s">&#39;NE.CON.GOVT.CN&#39;</span><span class="p">:</span> <span class="s">&#39;g&#39;</span><span class="p">,</span> <span class="s">&#39;NE.CON.PETC.CN&#39;</span><span class="p">:</span> <span class="s">&#39;c1&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L67" class="blob-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-code js-file-line">             <span class="s">&#39;NE.CON.PRVT.CN&#39;</span><span class="p">:</span> <span class="s">&#39;c2&#39;</span><span class="p">,</span> <span class="s">&#39;NE.CON.TETC.CN&#39;</span><span class="p">:</span> <span class="s">&#39;c3&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L68" class="blob-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-code js-file-line">             <span class="s">&#39;NE.CON.TOTL.CN&#39;</span><span class="p">:</span> <span class="s">&#39;c4&#39;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L69" class="blob-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-code js-file-line">             <span class="s">&#39;NE.DAB.TOTL.CN&#39;</span><span class="p">:</span> <span class="s">&#39;a&#39;</span><span class="p">,</span> <span class="s">&#39;NE.EXP.GNFS.CN&#39;</span><span class="p">:</span> <span class="s">&#39;x&#39;</span><span class="p">,</span>  </td>
      </tr>
      <tr>
        <td id="L70" class="blob-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-code js-file-line">             <span class="s">&#39;NE.GDI.FTOT.CN&#39;</span><span class="p">:</span> <span class="s">&#39;i&#39;</span><span class="p">,</span> <span class="s">&#39;NE.GDI.STKB.CN&#39;</span><span class="p">:</span> <span class="s">&#39;v&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L71" class="blob-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-code js-file-line">             <span class="s">&#39;NE.GDI.TOTL.CN&#39;</span><span class="p">:</span> <span class="s">&#39;gcf&#39;</span><span class="p">,</span> <span class="s">&#39;NE.IMP.GNFS.CN&#39;</span><span class="p">:</span> <span class="s">&#39;m&#39;</span><span class="p">,</span>  </td>
      </tr>
      <tr>
        <td id="L72" class="blob-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-code js-file-line">             <span class="s">&#39;NE.RSB.GNFS.CN&#39;</span><span class="p">:</span> <span class="s">&#39;nx&#39;</span><span class="p">,</span> </td>
      </tr>
      <tr>
        <td id="L73" class="blob-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-code js-file-line">             <span class="s">&#39;NY.GDP.MKTP.CN&#39;</span><span class="p">:</span> <span class="s">&#39;y&#39;</span><span class="p">,</span> <span class="s">&#39;NY.GDP.DISC.CN&#39;</span><span class="p">:</span> <span class="s">&#39;disc&#39;</span><span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L74" class="blob-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-code js-file-line"><span class="n">df</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">rename</span><span class="p">(</span><span class="n">columns</span><span class="o">=</span><span class="n">nicknames</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L75" class="blob-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L76" class="blob-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-code js-file-line"><span class="c"># note:  this sets up a hierarchical index over country and date</span></td>
      </tr>
      <tr>
        <td id="L77" class="blob-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-code js-file-line"><span class="n">df</span><span class="o">.</span><span class="n">index</span></td>
      </tr>
      <tr>
        <td id="L78" class="blob-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L79" class="blob-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-code js-file-line"><span class="c">#%%</span></td>
      </tr>
      <tr>
        <td id="L80" class="blob-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L81" class="blob-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-code js-file-line"><span class="sd">2. Check that things add up </span></td>
      </tr>
      <tr>
        <td id="L82" class="blob-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-code js-file-line"><span class="sd">All set as long as we include the statistical discrepancy </span></td>
      </tr>
      <tr>
        <td id="L83" class="blob-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L84" class="blob-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L85" class="blob-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-code js-file-line"><span class="n">check_iv</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;i&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;v&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span>            <span class="c"># ok </span></td>
      </tr>
      <tr>
        <td id="L86" class="blob-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-code js-file-line"><span class="n">check_nx</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;x&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;m&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;nx&#39;</span><span class="p">]</span>             <span class="c"># ok</span></td>
      </tr>
      <tr>
        <td id="L87" class="blob-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L88" class="blob-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-code js-file-line"><span class="n">check_c1</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c1&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c4&#39;</span><span class="p">]</span>            <span class="c"># ok</span></td>
      </tr>
      <tr>
        <td id="L89" class="blob-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-code js-file-line"><span class="n">check_c2</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c4&#39;</span><span class="p">]</span>            <span class="c"># exact </span></td>
      </tr>
      <tr>
        <td id="L90" class="blob-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L91" class="blob-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-code js-file-line"><span class="n">check_a1</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c4&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;a&#39;</span><span class="p">]</span>           <span class="c"># ok</span></td>
      </tr>
      <tr>
        <td id="L92" class="blob-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-code js-file-line"><span class="n">check_a2</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;a&#39;</span><span class="p">]</span> <span class="c"># ok</span></td>
      </tr>
      <tr>
        <td id="L93" class="blob-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L94" class="blob-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-code js-file-line"><span class="n">check_y1</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;nx&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span>  <span class="c"># ok</span></td>
      </tr>
      <tr>
        <td id="L95" class="blob-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-code js-file-line"><span class="n">check_y2</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;nx&#39;</span><span class="p">]</span> <span class="o">+</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;disc&#39;</span><span class="p">]</span> <span class="o">-</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span> </td>
      </tr>
      <tr>
        <td id="L96" class="blob-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L97" class="blob-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-code js-file-line"><span class="c">#%%</span></td>
      </tr>
      <tr>
        <td id="L98" class="blob-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L99" class="blob-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-code js-file-line"><span class="sd">3. Plot expenditure shares, saving and investment </span></td>
      </tr>
      <tr>
        <td id="L100" class="blob-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L101" class="blob-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-code js-file-line"><span class="c"># this creates new series -- ok or better way?  </span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-code js-file-line"><span class="n">cy</span>  <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L103" class="blob-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-code js-file-line"><span class="n">iy</span>  <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L104" class="blob-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-code js-file-line"><span class="n">gy</span>  <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-code js-file-line"><span class="n">nxy</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;nx&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L106" class="blob-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-code js-file-line"><span class="n">sy</span>  <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span><span class="o">-</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span><span class="o">-</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">])</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L107" class="blob-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L108" class="blob-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-code js-file-line"><span class="c"># WE NEED TO GET &#39;year&#39; OUT OF THE INDEX </span></td>
      </tr>
      <tr>
        <td id="L109" class="blob-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-code js-file-line"><span class="c"># this works, but looks clunky to me </span></td>
      </tr>
      <tr>
        <td id="L110" class="blob-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-code js-file-line"><span class="n">df</span><span class="o">.</span><span class="n">index</span></td>
      </tr>
      <tr>
        <td id="L111" class="blob-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-code js-file-line"><span class="n">df</span><span class="o">.</span><span class="n">index</span><span class="o">.</span><span class="n">names</span> </td>
      </tr>
      <tr>
        <td id="L112" class="blob-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-code js-file-line"><span class="n">year</span>    <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">index</span><span class="o">.</span><span class="n">get_level_values</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L113" class="blob-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-code js-file-line"><span class="n">country</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">index</span><span class="o">.</span><span class="n">get_level_values</span><span class="p">(</span><span class="mi">0</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L115" class="blob-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-code js-file-line"><span class="c"># make a picture </span></td>
      </tr>
      <tr>
        <td id="L116" class="blob-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">()</span> </td>
      </tr>
      <tr>
        <td id="L117" class="blob-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">nxy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Net Exports&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L118" class="blob-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">iy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Investment&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L119" class="blob-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">cy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Consumption&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L120" class="blob-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">gy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Government&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L121" class="blob-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s">&#39;Share of GDP&#39;</span><span class="p">)</span> </td>
      </tr>
      <tr>
        <td id="L122" class="blob-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-code js-file-line"><span class="c">#plt.axis([1990, 2015, -0.1, 0.6])</span></td>
      </tr>
      <tr>
        <td id="L123" class="blob-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">axhline</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&#39;k&#39;</span><span class="p">,</span> <span class="n">linestyle</span><span class="o">=</span><span class="s">&#39;-&#39;</span><span class="p">,</span> <span class="n">linewidth</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>   </td>
      </tr>
      <tr>
        <td id="L124" class="blob-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">(</span><span class="n">loc</span><span class="o">=</span><span class="s">&#39;best&#39;</span><span class="p">)</span> </td>
      </tr>
      <tr>
        <td id="L125" class="blob-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="n">country</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">+</span> <span class="s">&#39;:  Expenditure Shares of GDP&#39;</span><span class="p">,</span> <span class="n">loc</span><span class="o">=</span><span class="s">&#39;left&#39;</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">14</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L126" class="blob-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">savefig</span><span class="p">(</span><span class="s">&#39;shares_exp_&#39;</span><span class="o">+</span> <span class="n">country_list</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">+</span><span class="s">&#39;.pdf&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L127" class="blob-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L128" class="blob-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-code js-file-line"><span class="c"># another one  </span></td>
      </tr>
      <tr>
        <td id="L129" class="blob-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">figure</span><span class="p">()</span> </td>
      </tr>
      <tr>
        <td id="L130" class="blob-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">nxy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Net Exports&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L131" class="blob-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">iy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Investment&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L132" class="blob-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">plot</span><span class="p">(</span><span class="n">year</span><span class="p">,</span> <span class="n">sy</span><span class="p">,</span> <span class="n">label</span><span class="o">=</span><span class="s">&#39;Saving&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L133" class="blob-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">ylabel</span><span class="p">(</span><span class="s">&#39;Share of GDP&#39;</span><span class="p">)</span> </td>
      </tr>
      <tr>
        <td id="L134" class="blob-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-code js-file-line"><span class="c">#plt.axis([1990, 2015, -0.1, 0.6])</span></td>
      </tr>
      <tr>
        <td id="L135" class="blob-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">axhline</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&#39;k&#39;</span><span class="p">,</span> <span class="n">linestyle</span><span class="o">=</span><span class="s">&#39;-&#39;</span><span class="p">,</span> <span class="n">linewidth</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span>   </td>
      </tr>
      <tr>
        <td id="L136" class="blob-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">legend</span><span class="p">(</span><span class="n">loc</span><span class="o">=</span><span class="s">&#39;best&#39;</span><span class="p">)</span> </td>
      </tr>
      <tr>
        <td id="L137" class="blob-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">title</span><span class="p">(</span><span class="n">country</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">+</span> <span class="s">&#39;:  Saving and Investment&#39;</span><span class="p">,</span> <span class="n">loc</span><span class="o">=</span><span class="s">&#39;left&#39;</span><span class="p">,</span> <span class="n">fontsize</span><span class="o">=</span><span class="mi">14</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L138" class="blob-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-code js-file-line"><span class="n">plt</span><span class="o">.</span><span class="n">savefig</span><span class="p">(</span><span class="s">&#39;shares_sav_&#39;</span><span class="o">+</span> <span class="n">country_list</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">+</span><span class="s">&#39;.pdf&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L139" class="blob-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L140" class="blob-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-code js-file-line"><span class="c">#%%</span></td>
      </tr>
      <tr>
        <td id="L141" class="blob-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L142" class="blob-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-code js-file-line"><span class="sd">4. Spencer&#39;s version </span></td>
      </tr>
      <tr>
        <td id="L143" class="blob-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-code js-file-line"><span class="sd">Works great but (a) has to be changed if not France and (b) plots backwards</span></td>
      </tr>
      <tr>
        <td id="L144" class="blob-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-code js-file-line"><span class="sd">Also kill the x axis label, add y axis label  </span></td>
      </tr>
      <tr>
        <td id="L145" class="blob-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L146" class="blob-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-code js-file-line"><span class="c"># add series to df </span></td>
      </tr>
      <tr>
        <td id="L147" class="blob-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-code js-file-line"><span class="n">df</span><span class="p">[</span><span class="s">&#39;Consumption&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L148" class="blob-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-code js-file-line"><span class="n">df</span><span class="p">[</span><span class="s">&#39;Investment&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;gcf&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L149" class="blob-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-code js-file-line"><span class="n">df</span><span class="p">[</span><span class="s">&#39;Government&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L150" class="blob-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-code js-file-line"><span class="n">df</span><span class="p">[</span><span class="s">&#39;Net Exports&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="n">nxy</span> <span class="o">=</span> <span class="n">df</span><span class="p">[</span><span class="s">&#39;nx&#39;</span><span class="p">]</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L151" class="blob-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-code js-file-line"><span class="n">df</span><span class="p">[</span><span class="s">&#39;Saving&#39;</span><span class="p">]</span> <span class="o">=</span> <span class="p">(</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span><span class="o">-</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;c2&#39;</span><span class="p">]</span><span class="o">-</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;g&#39;</span><span class="p">])</span><span class="o">/</span><span class="n">df</span><span class="p">[</span><span class="s">&#39;y&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-code js-file-line"><span class="c">#df[&#39;year&#39;] = df.index.get_level_index(&#39;year&#39;)</span></td>
      </tr>
      <tr>
        <td id="L153" class="blob-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L154" class="blob-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L155" class="blob-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-code js-file-line"><span class="c">#%%</span></td>
      </tr>
      <tr>
        <td id="L156" class="blob-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-code js-file-line"><span class="c"># define a resuseable plotting function</span></td>
      </tr>
      <tr>
        <td id="L157" class="blob-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-code js-file-line"><span class="c"># by keeping the numbers in a df, the plot takes the df&#39;s parameters</span></td>
      </tr>
      <tr>
        <td id="L158" class="blob-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-code js-file-line"><span class="k">def</span> <span class="nf">wb_plot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span> <span class="n">country</span><span class="p">,</span> <span class="n">cols</span><span class="p">,</span> <span class="n">title_str</span><span class="o">=</span><span class="bp">None</span><span class="p">,</span> <span class="n">save_str</span><span class="o">=</span><span class="bp">None</span><span class="p">,</span> <span class="o">**</span><span class="n">kwargs</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L159" class="blob-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-code js-file-line">    <span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L160" class="blob-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-code js-file-line"><span class="sd">    Quick function to plot specific columns for a particular country</span></td>
      </tr>
      <tr>
        <td id="L161" class="blob-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-code js-file-line"><span class="sd">    in the DataFrame obtained from the world bank</span></td>
      </tr>
      <tr>
        <td id="L162" class="blob-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L163" class="blob-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-code js-file-line"><span class="sd">    Any additional keyword arguments are passed directly to the</span></td>
      </tr>
      <tr>
        <td id="L164" class="blob-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-code js-file-line"><span class="sd">    DataFrame.plot method</span></td>
      </tr>
      <tr>
        <td id="L165" class="blob-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L166" class="blob-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-code js-file-line"><span class="sd">    Parameters</span></td>
      </tr>
      <tr>
        <td id="L167" class="blob-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-code js-file-line"><span class="sd">    ----------</span></td>
      </tr>
      <tr>
        <td id="L168" class="blob-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-code js-file-line"><span class="sd">    df : DataFrame</span></td>
      </tr>
      <tr>
        <td id="L169" class="blob-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-code js-file-line"><span class="sd">        The DataFrame that contains the data</span></td>
      </tr>
      <tr>
        <td id="L170" class="blob-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L171" class="blob-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-code js-file-line"><span class="sd">    country : string</span></td>
      </tr>
      <tr>
        <td id="L172" class="blob-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-code js-file-line"><span class="sd">        A string specifying the name of the country. This must also be</span></td>
      </tr>
      <tr>
        <td id="L173" class="blob-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-code js-file-line"><span class="sd">        the entry on the outer level of the hierarchical index</span></td>
      </tr>
      <tr>
        <td id="L174" class="blob-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L175" class="blob-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-code js-file-line"><span class="sd">    cols : list</span></td>
      </tr>
      <tr>
        <td id="L176" class="blob-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-code js-file-line"><span class="sd">        A list of column names to be plotted.</span></td>
      </tr>
      <tr>
        <td id="L177" class="blob-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L178" class="blob-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-code js-file-line"><span class="sd">    title_str : optional(default=None)</span></td>
      </tr>
      <tr>
        <td id="L179" class="blob-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-code js-file-line"><span class="sd">        An optional title to be added to the plot. Note that you can</span></td>
      </tr>
      <tr>
        <td id="L180" class="blob-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-code js-file-line"><span class="sd">        leave a placeholder for country and it will automatically</span></td>
      </tr>
      <tr>
        <td id="L181" class="blob-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-code js-file-line"><span class="sd">        be filled for you with the country argument. An example of how</span></td>
      </tr>
      <tr>
        <td id="L182" class="blob-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-code js-file-line"><span class="sd">        this can be done is the following:</span></td>
      </tr>
      <tr>
        <td id="L183" class="blob-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L184" class="blob-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-code js-file-line"><span class="sd">            title_str = &#39;{country}: Expenditure Shares of GDP&#39;</span></td>
      </tr>
      <tr>
        <td id="L185" class="blob-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L186" class="blob-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-code js-file-line"><span class="sd">    save_str : optional (default=None)</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-code js-file-line"><span class="sd">        Similar to title_str, but provides the name the figure should be</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-code js-file-line"><span class="sd">        saved under. If none is given, then the figure is not saved. </span></td>
      </tr>
      <tr>
        <td id="L189" class="blob-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L190" class="blob-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-code js-file-line"><span class="sd">    Returns</span></td>
      </tr>
      <tr>
        <td id="L191" class="blob-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-code js-file-line"><span class="sd">    -------</span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-code js-file-line"><span class="sd">    ax : matplotlib.pyplot.Axes</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-code js-file-line"><span class="sd">        The axes containing the plot</span></td>
      </tr>
      <tr>
        <td id="L194" class="blob-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L195" class="blob-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-code js-file-line"><span class="sd">    &quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L196" class="blob-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-code js-file-line">    <span class="c"># return flat (non hierarchical-indexed) dataframe for a single country</span></td>
      </tr>
      <tr>
        <td id="L197" class="blob-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-code js-file-line">    <span class="n">new_df</span> <span class="o">=</span> <span class="n">df</span><span class="o">.</span><span class="n">loc</span><span class="p">[</span><span class="n">country</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L198" class="blob-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-code js-file-line">    <span class="n">new_df</span> <span class="o">=</span> <span class="n">new_df</span><span class="o">.</span><span class="n">sort</span><span class="p">()</span>  <span class="c"># this corrects the order of dates </span></td>
      </tr>
      <tr>
        <td id="L199" class="blob-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-code js-file-line">    <span class="n">ax</span> <span class="o">=</span> <span class="n">new_df</span><span class="p">[</span><span class="n">cols</span><span class="p">]</span><span class="o">.</span><span class="n">plot</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L200" class="blob-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-code js-file-line">    <span class="n">ax</span><span class="o">.</span><span class="n">axhline</span><span class="p">(</span><span class="n">y</span><span class="o">=</span><span class="mi">0</span><span class="p">,</span> <span class="n">color</span><span class="o">=</span><span class="s">&#39;k&#39;</span><span class="p">,</span> <span class="n">linestyle</span><span class="o">=</span><span class="s">&#39;-&#39;</span><span class="p">,</span> <span class="n">linewidth</span><span class="o">=</span><span class="mi">1</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-code js-file-line">    <span class="n">ax</span><span class="o">.</span><span class="n">legend</span><span class="p">(</span><span class="n">loc</span><span class="o">=</span><span class="s">&#39;best&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L202" class="blob-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L203" class="blob-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-code js-file-line">    <span class="k">if</span> <span class="n">title_str</span> <span class="ow">is</span> <span class="ow">not</span> <span class="bp">None</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L204" class="blob-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-code js-file-line">        <span class="n">ax</span><span class="o">.</span><span class="n">set_title</span><span class="p">(</span><span class="n">title_str</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="o">**</span><span class="p">{</span><span class="s">&#39;country&#39;</span><span class="p">:</span> <span class="n">country</span><span class="p">}))</span></td>
      </tr>
      <tr>
        <td id="L205" class="blob-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L206" class="blob-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-code js-file-line">    <span class="k">if</span> <span class="n">save_str</span> <span class="ow">is</span> <span class="ow">not</span> <span class="bp">None</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L207" class="blob-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-code js-file-line">        <span class="n">ax</span><span class="o">.</span><span class="n">get_figure</span><span class="p">()</span><span class="o">.</span><span class="n">savefig</span><span class="p">(</span><span class="n">save_str</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="o">**</span><span class="p">{</span><span class="s">&#39;country&#39;</span><span class="p">:</span> <span class="n">country</span><span class="p">}))</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L209" class="blob-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-code js-file-line">    <span class="k">return</span> <span class="n">ax</span></td>
      </tr>
      <tr>
        <td id="L210" class="blob-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L211" class="blob-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L212" class="blob-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-code js-file-line"><span class="c"># Now generate the first figure</span></td>
      </tr>
      <tr>
        <td id="L213" class="blob-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-code js-file-line"><span class="n">countryname</span> <span class="o">=</span> <span class="n">country</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> </td>
      </tr>
      <tr>
        <td id="L214" class="blob-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L215" class="blob-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-code js-file-line"><span class="n">ax1</span> <span class="o">=</span> <span class="n">wb_plot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L216" class="blob-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-code js-file-line">                <span class="n">country</span><span class="o">=</span><span class="n">countryname</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L217" class="blob-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-code js-file-line">                <span class="n">cols</span><span class="o">=</span><span class="p">[</span><span class="s">&#39;Net Exports&#39;</span><span class="p">,</span> <span class="s">&#39;Investment&#39;</span><span class="p">,</span> <span class="s">&#39;Consumption&#39;</span><span class="p">,</span> <span class="s">&#39;Government&#39;</span><span class="p">],</span></td>
      </tr>
      <tr>
        <td id="L218" class="blob-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-code js-file-line">                <span class="n">title_str</span><span class="o">=</span><span class="s">&#39;{country}:  Expenditure Shares of GDP&#39;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-code js-file-line"><span class="c">#                save_str=&quot;shares_sav_%s.pdf&quot; % country_list[0]</span></td>
      </tr>
      <tr>
        <td id="L220" class="blob-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-code js-file-line">                <span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L221" class="blob-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L222" class="blob-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L223" class="blob-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-code js-file-line"><span class="n">ax2</span> <span class="o">=</span> <span class="n">wb_plot</span><span class="p">(</span><span class="n">df</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L224" class="blob-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-code js-file-line">                <span class="n">country</span><span class="o">=</span><span class="n">countryname</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L225" class="blob-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-code js-file-line">                <span class="n">cols</span><span class="o">=</span><span class="p">[</span><span class="s">&#39;Net Exports&#39;</span><span class="p">,</span> <span class="s">&#39;Investment&#39;</span><span class="p">,</span> <span class="s">&#39;Saving&#39;</span><span class="p">],</span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-code js-file-line">                <span class="n">title_str</span><span class="o">=</span><span class="s">&#39;{country}:  Saving and Investment&#39;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L227" class="blob-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-code js-file-line"><span class="c">#                save_str=&quot;shares_exp_%s.pdf&quot; % country_list[0]</span></td>
      </tr>
      <tr>
        <td id="L228" class="blob-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-code js-file-line">                <span class="p">)</span></td>
      </tr>
</table>

  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.07481s from github-fe121-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents js-suggester-field" placeholder=""></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x flash-close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-0c1b00f7935ae85624f5fc5d40d52d60febf92b4.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-cfe587869551916e745decce50cc5ec895df6a28.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>


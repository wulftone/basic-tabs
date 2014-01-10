import 'dart:html' as dom;


class BasicTabs {


  var wrapper,
      tabs,
      tabContainers,
      currentTab,
      currentTabContainer;

  final selectedTabClassName = 'selected',
      tabsContainerClassName = 'basic-tabs-ul';


  BasicTabs( String container ) {
    this.wrapper       = dom.querySelector( container );
    this.tabContainers = this.wrapper.querySelectorAll(':scope > div');
    this.tabs          = createTabsForContainer( this.wrapper );

    this.wrapper.insertBefore( this.tabs, this.tabContainers.first );

    focusTab(this.tabs.children.first);

    this.wrapper.style.display = 'initial';
  }


  createTabsForContainer( container ) {
    var tabContainers = container.children,
        ul = new dom.UListElement();

    this.tabContainers.forEach( ( el ) {
      var li = new dom.LIElement(),
          a  = new dom.AnchorElement();

      a.attributes['href'] = '#' + el.id;
      a.text = el.attributes['title'];

      li.append( a );

      li.style.display = 'inline-block';

      li.onClick.listen( handleClickEvent );

      ul.append( li );
    });

    ul.classes.add(this.tabsContainerClassName);

    ul.style.listStyle = 'none';
    ul.style.margin = '0';
    ul.style.padding = '0';

    return ul;
  }

  handleClickEvent( e ) {
    focusTab( e.currentTarget );
  }


  focusTab( tabEl ) {
    this.currentTab = tabEl;
    var id = tabEl.children.first.attributes['href'];
    unhighlightTabs(this.tabs.children);
    highlightTab(tabEl);
    showCurrentTabContainer( dom.querySelector( id ) );
    print( this.currentTabContainer.id );
  }


  unhighlightTabs(tabEls) {
    tabEls.forEach( ( el ) {
      el.classes.remove(this.selectedTabClassName);
    });
  }


  highlightTab(tabEl) {
    tabEl.classes.add(this.selectedTabClassName);
  }


  showCurrentTabContainer( containerEl ) {
    this.currentTabContainer = containerEl;

    this.tabContainers.forEach( ( el ) {
      print( el );

      if ( el == containerEl ) {

        el.style.display = 'block';

      } else {

        el.style.display = 'none';

      }
    });
  }
}


main() {
  var t = new BasicTabs( '.basic-tabs' );
}

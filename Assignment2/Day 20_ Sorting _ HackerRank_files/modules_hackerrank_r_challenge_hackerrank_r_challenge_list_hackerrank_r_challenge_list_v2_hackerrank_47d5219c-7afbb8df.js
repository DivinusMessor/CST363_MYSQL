(window.webpackJsonp=window.webpackJsonp||[]).push([[9],{"+KS9":function(e,t,a){"use strict";var n=a("lSNA"),s=a.n(n),i=a("cDcd"),c=a.n(i),r=a("17x9"),l=a.n(r),o=a("wd/R"),m=a.n(o),d=a("xNbf"),u=a("eOGF");class p extends c.a.Component{constructor(e){super(e),s()(this,"state",void 0),s()(this,"intervalObject",void 0),s()(this,"onTimerEnd",()=>{this.props.onTimerEnd()}),this.state={timeRemaining:""},this.intervalObject=null}componentDidMount(){this.setNewTimeDiff(),this.intervalObject=setInterval(()=>{this.setNewTimeDiff()},1e3)}componentWillUnmount(){this.clearIntervalObj()}clearIntervalObj(){this.intervalObject&&clearInterval(this.intervalObject)}setNewTimeDiff(){const e=this.props.finishTimeMs-(new Date).getTime();if(e<=0)return this.clearIntervalObj(),void this.onTimerEnd();const t=m.a.duration(e);if(t.days()>0)this.setState({timeRemaining:c.a.createElement("span",{className:"countdowntimer-days"},`${t.days()} ${t.days()>1?"days":"day"}`)});else{const e=Object(u.p)(t.hours()),a=Object(u.p)(t.minutes()),n=Object(u.p)(t.seconds()),s=c.a.createElement("span",{className:"countdowntimer-clock"},c.a.createElement("span",{className:"countdowntimer-hours"},e),":",c.a.createElement("span",{className:"countdowntimer-minutes"},a),":",c.a.createElement("span",{className:"countdowntimer-seconds"},n));this.setState({timeRemaining:s})}}render(){const e=this.state.timeRemaining,t=this.props.className;return""===e?c.a.createElement(d.a,{className:"countdowntimer-loader",diameter:16}):c.a.createElement("span",{className:t},this.state.timeRemaining)}}s()(p,"propTypes",{finishTimeMs:l.a.number.isRequired,onTimerEnd:l.a.func}),s()(p,"defaultProps",{onTimerEnd:function(){}}),t.a=p},"5VZm":function(e,t,a){"use strict";var n=a("cDcd"),s=a.n(n),i=a("17x9"),c=a.n(i),r=a("O766"),l=a("eOGF");a("UTUX");function o(e){const t=e.open,a=e.onClose,n=e.title,i=e.youtubeId,c=e.className;return s.a.createElement(r.a,{open:t,onClose:a,title:n,theme:"theme-m",modalClass:"video-modal",className:c},s.a.createElement("div",{className:"frame-wrapper"},s.a.createElement("iframe",{id:"player-"+i,className:"youtube-frame block-center",type:"text/html",src:`https://www.youtube.com/embed/${i}?${Object(l.W)({enablejsapi:1,version:3,autoplay:1,rel:0,origin:"https://www.hackerrank.com"})}`,frameBorder:"0",allowFullScreen:!0})))}o.propTypes={open:c.a.bool,onClose:c.a.func,title:c.a.string.isRequired,youtubeId:c.a.string.isRequired},t.a=o},"6l/H":function(e,t,a){},ACly:function(e,t,a){"use strict";var n=a("lSNA"),s=a.n(n),i=a("cDcd"),c=a.n(i),r=a("17x9"),l=a.n(r),o=a("2VWb"),m=a("TSYQ"),d=a.n(m),u=a("EfbJ"),p=a("ZaSc"),h=a("eOGF");a("6l/H");Object(h.O)(["feedback/feedback.*.svg"]);const b=[{text:"Awesome, tell us more!",rating:1,icon:"like",title:"Like it"},{text:"Tell us more",rating:2,icon:"cantsay",title:"Maybe"},{text:"Tell us what went wrong",rating:3,icon:"no",title:"No"}],f=e=>{const t=e.selected,a=(e.clickHandler,e.title),n=e.icon,s=e.assetPath;return c.a.createElement("li",{className:d()("rating",{selected:t},n),onClick:()=>{e.clickHandler(e.idxVal)}},c.a.createElement("div",{className:"feedback-img"},c.a.createElement("span",{className:"overlay"}),c.a.createElement("img",{src:s(`feedback/feedback-${n}.svg`),className:"feedback-icon"})),c.a.createElement("div",{className:"feedback-title"},a))};class v extends c.a.Component{constructor(e){super(e),s()(this,"state",void 0),s()(this,"updateSelection",e=>{this.setState({selectedRating:e},()=>{this.submitForm()})}),s()(this,"updateComment",e=>{this.setState({comment:e.target.value})}),s()(this,"submitForm",e=>{e&&this.setState({submitting:!0});const t=this.state,a=t.selectedRating,n=t.comment,s=this.props,i=s.postUrl,c=s.onSubmit,r=s.featureId,l=s.appUtil.location.pathname;Object(p.g)({url:i,data:{rating:a+1,description:n,path:l},loadingMessage:!1,success:()=>{e&&(this.setState({submitted:!0}),c&&c(r))},error:()=>{this.setState({submitting:!1})}})}),s()(this,"renderFeedbackContainer",()=>{const e=this.props,t=e.className,a=e.theme,n=this.state.submitted;return c.a.createElement("div",{className:d()("feedback-modal",t,a)},n?this.renderThanks():this.renderFeedBack())}),this.state={selectedRating:"",comment:"",submitted:!1,submitting:!1}}componentDidMount(){const e=this.props,t=e.featureId,a=e.onSeen;a&&a(t)}renderFeedBack(){const e=this.props,t=e.appUtil.assetPath,a=e.title,n=e.name,s=e.desc,i=e.onClose,r=e.theme,l=this.state,o=l.selectedRating,m=l.comment,u=(l.submitted,l.submitting),p="theme-m"===r?"ui-btn ui-btn-primary":d()("btn btn-primary btn-flat",{disabled:u}),h="theme-m"===r?"ui-icon-cross":"icon-cancel-small";return c.a.createElement("div",null,c.a.createElement("div",{className:"cancel-icon",onClick:i},c.a.createElement("i",{className:h})),c.a.createElement("div",{className:"banner-img"},c.a.createElement("img",{src:t(`feedback/feedback-banner-${n}.svg`),className:"feedback-banner"})),c.a.createElement("h1",{className:"feedback-main-title mdT mdB"},a),s&&c.a.createElement("div",{className:"msT msB feedback-description-light"},s),c.a.createElement("div",{className:"ratings"},c.a.createElement("ul",null,b.map((e,a)=>c.a.createElement(f,{onClick:this.updateSelection,title:e.title,className:b[o],icon:e.icon,key:a,idxVal:a,clickHandler:this.updateSelection,assetPath:t,selected:e.rating===o+1})))),c.a.createElement("div",{className:"selected-rating"},b[o]&&b[o].text),"number"==typeof o&&c.a.createElement("div",{className:"submit-form"},c.a.createElement("div",{className:"input-area"},c.a.createElement("textarea",{className:"txt-area",placeholder:"Write a comment (optional)",onChange:this.updateComment,value:m})),c.a.createElement("button",{className:p,onClick:this.submitForm.bind(null,!0)},u?"Submitting..":"Submit")))}renderThanks(){return c.a.createElement("div",{className:"feedback-thanks"},c.a.createElement("div",{className:"thanks-icon"},c.a.createElement("i",{className:"icon-thumbs-up"})),c.a.createElement("div",{className:"thanks-title"},"Thanks for your feedback!"))}render(){const e=this.props,t=e.onClose,a=e.isStandalone;return c.a.createElement("div",null,a?this.renderFeedbackContainer():c.a.createElement(o.a,{open:!0,onClose:t,modalClass:"feedback-modal-wrapper"},this.renderFeedbackContainer()))}}s()(v,"defaultProps",{title:"Love our new upgrade?",name:"default"}),s()(v,"propTypes",{onClose:l.a.func,featureId:l.a.number.isRequired,postUrl:l.a.string.isRequired,theme:l.a.string}),t.a=Object(u.b)(v)},F39y:function(e,t,a){},H4Rz:function(e,t,a){},UTUX:function(e,t,a){},nB3z:function(e,t,a){"use strict";var n=a("lSNA"),s=a.n(n),i=a("cDcd"),c=a("vN+2"),r=a.n(c);class l extends i.Component{constructor(){super(...arguments),s()(this,"currentPromise",null),s()(this,"failedCount",0),s()(this,"state",{optimisticState:this.props.initialValue}),s()(this,"handleToggle",e=>{const t=!this.state.optimisticState;this.setState({optimisticState:t});const a=this.props.action(t,e);this.currentPromise=a,a.catch(e=>{this.failedCount++,this.currentPromise===a&&this.setState(e=>({optimisticState:this.failedCount%2==0?e.optimisticState:!e.optimisticState}),()=>{this.failedCount=0})})})}render(){return this.props.children(this.state.optimisticState,this.handleToggle)}}s()(l,"defaultProps",{initialValue:!1,action:r.a}),t.a=l},oOaF:function(e,t,a){"use strict";var n=a("pVnL"),s=a.n(n),i=a("QILm"),c=a.n(i),r=a("cDcd"),l=a.n(r),o=a("TSYQ"),m=a.n(o),d=a("37OS"),u=a.n(d),p=a("nB3z"),h=a("OEX3");a("F39y");const b=["initialValue","className","label","onClick"];function f(e){const t=e.initialValue,a=e.className,n=e.label,i=e.onClick,r=c()(e,b);return l.a.createElement(p.a,{initialValue:t,action:i},(e,t)=>{const i=e?"star-icon-filled":"",c=e?"ui-icon-star-filled":"ui-icon-star";return l.a.createElement(h.c,s()({"aria-label":n(e),className:"star-button",onClick:t},r),l.a.createElement("i",{className:m()(a,"star-icon",c,i)}))})}f.defaultProps={initialValue:!1,label:e=>e?"Unstar":"Star",onClick:u.a},t.a=f},ve2B:function(e,t,a){"use strict";var n=a("lSNA"),s=a.n(n),i=a("cDcd"),c=a.n(i),r=a("TSYQ"),l=a.n(r),o=a("OEX3"),m=a("3N0A"),d=a("Q9J+");a("H4Rz");class u extends i.PureComponent{componentDidUpdate(){this.shouldHideScrollBar()?d.a.hideScrollBars():d.a.showScrollBars()}componentWillUnmount(){d.a.showScrollBars()}shouldShowOverlay(){const e=this.props,t=e.open,a=e.overlay;return t&&a}shouldHideScrollBar(){const e=this.props,t=e.open,a=e.type,n=e.popupTarget;return(this.shouldShowOverlay()||t&&"full-screen"===a)&&!n}renderPopup(){const e=this.props,t=e.children,a=e.type,n=e.handleClose,s=e.className,i=e.popupTarget,r=this.shouldShowOverlay();return c.a.createElement(m.a,{target:i},c.a.createElement("div",{className:l()("fab-popup",s)},r&&c.a.createElement("div",{className:"fab-popup-overlay",onClick:n}),c.a.createElement("div",{className:l()("fab-popup-content","fab-popup-"+a)},t)))}renderPopupHandle(){const e=this.props,t=e.icon,a=e.handleOpen,n=e.active;return c.a.createElement(o.d,{className:l()("fab-popup-handle",n?"active":"default"),onClick:a},c.a.createElement("i",{className:l()(t,"fab-popup-icon")}))}render(){return this.props.open?this.renderPopup():this.renderPopupHandle()}}s()(u,"defaultProps",{type:"menu",overlay:!0,active:!1}),t.a=u}}]);
//# sourceMappingURL=https://hrcdn.net/community-frontend/assets/sourcemaps/modules~hackerrank_r_challenge~hackerrank_r_challenge_list~hackerrank_r_challenge_list_v2~hackerrank~47d5219c-7afbb8df.js.map
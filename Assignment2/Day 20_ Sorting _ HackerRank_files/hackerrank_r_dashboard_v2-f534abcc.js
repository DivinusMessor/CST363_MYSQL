(window.webpackJsonp=window.webpackJsonp||[]).push([[124],{AsEK:function(e,t,a){},IlOe:function(e,t,a){"use strict";a.r(t);var n=a("cDcd"),r=a.n(n),c=a("ANjH"),l=a("/MKj"),i=a("peh1"),s=a("pVnL"),o=a.n(s),m=a("jx0p"),d=a("9t4x"),p=a("v2uj"),u=a("L5Qz"),v=a("MTUB"),h=a("wEfs"),E=a("TSYQ"),f=a.n(E);a("tVud");var g=function(e){const t=e.children,a=e.title,n=e.headerChildren,c=e.className;return r.a.createElement("section",{className:f()("dashboard-section",c)},r.a.createElement("div",{className:"dashboard-section-header"},r.a.createElement("h2",{className:"text-para-headline bold dashboard-section-title"},a),n),r.a.createElement("div",{className:"dashboard-section-grid"},t))};a("XQ2d");var b=Object(m.a)((function(e){let t=e.profile,a=e.data,n=void 0===a?[]:a;const c=t.confirmed,l=t.username,i=!c;let s=Number(i);const m=4-s;return r.a.createElement(g,{className:"dashboard-my-tracks",title:"Your Preparation"},i&&r.a.createElement(h.a,null,e=>r.a.createElement(u.a,o()({},e,{className:"card-box",position:0,profile:t}))),!Boolean(l)&&r.a.createElement(v.a,{className:"card-box",profile:t}),n.slice(0,m).map((e,t)=>r.a.createElement(d.a,{primary:0===t,className:"card-box",key:e.badge_type||e.slug,track:e,position:s++,buttonText:"Continue Preparation"})),0===n.length&&r.a.createElement(p.a,{text:"New Skill",className:"card-box",hasRecent:n.length>0,animateToSkills:()=>{const e=document.querySelector("#topics");e&&e.scrollIntoView({behavior:"smooth",block:"center"})},position:s}))})),k=a("MGin"),N=a("YZNL");a("gKLV");var y=Object(m.a)((function(e){let t=e.data,a=void 0===t?[]:t,n=e.profile;const c=n.show_recommended_prep_kit?"Or select a Topic":"Prepare By Topics";return r.a.createElement("div",{className:"dashboard-topics",id:"topics"},r.a.createElement(g,{title:c},r.a.createElement(N.a,{className:"dashboard-topics-card"},r.a.createElement("ul",{className:"topics-list"},a.map(e=>{let t=e.slug,a=e.name,c=e.get_preview_image;return r.a.createElement("li",{className:"topic-card",key:a},r.a.createElement(k.Link,{to:"/domains/"+t,"data-analytics":"SelectTopic","data-event-label":"SelectTopic","data-event-category":"HRC Interview Prep","data-attr1":t,"data-attr11":n.show_recommended_prep_kit,"data-cd-topic-slug":t,className:"topic-link"},r.a.createElement("div",{className:"topic-item bold"},r.a.createElement("img",{src:c,alt:"",height:"24"}),r.a.createElement("div",{className:"topic-name","data-automation":t},a))))})))))})),w=a("DNJ5");var S=function(e){let t=e.data,a=void 0===t?[]:t;return a.length>0?r.a.createElement(g,{title:"Mock Tests"},a.map((e,t)=>r.a.createElement(w.b,{position:t,mockTest:e,key:e.unique_id})),r.a.createElement(w.a,null)):null},_=a("OEX3"),P=a("EfbJ"),O=a("lqfM"),V=a("tWBh");a("tR65");var j=Object(P.b)((function(e){const t=e.playlist,a=e.appUtil,n=t.name,c=t.slug,l=t.description,i=t.skills,s=t.challenges_count,o=t.attempts_count,m=t.parent,d=t.mockTestIds,p=m.slug,u=(null==d?void 0:d.length)||0;return Object(O.a)(t),r.a.createElement(N.a,{layer:1,className:"recommended-prep-kit-card"},r.a.createElement("div",{className:"recommended-prep-kit-card-row"},r.a.createElement("img",{className:"recommended-prep-kit-card-illustration",src:a.assetPath("dashboard/lady_practicing.svg"),alt:""}),r.a.createElement("div",{className:"recommended-prep-kit-card-details"},r.a.createElement("h3",{className:"prep-kit-name"},n),r.a.createElement("div",{className:"prep-kit-stats"},r.a.createElement("div",null,r.a.createElement("span",null,"Challenges: "),r.a.createElement("span",{className:"prep-kit-stat-value"},s)),", ",r.a.createElement("div",null,r.a.createElement("span",null,"Mock Tests: "),r.a.createElement("span",{className:"prep-kit-stat-value"},u)),", ",r.a.createElement("div",null,r.a.createElement("span",null,"Attempts: "),r.a.createElement("span",{className:"prep-kit-stat-value"},o))),i&&r.a.createElement(V.a,{skills:i}),r.a.createElement("p",{className:"prep-kit-description"},l)),r.a.createElement(_.d,{role:"link",className:"recommended-prep-kit-card-cta",to:`/interview/${p}/${c}`,"data-event-category":"HRC Interview Prep","data-analytics":"StartPreparation","data-event-label":"StartPreparation","data-attr1":c,"data-cd-interview-time":c},"Start Preparation")),r.a.createElement("div",{className:"recommended-prep-kit-card-strip"}))}));a("QDlR");var T=function(e){const t=e.data;return r.a.createElement(g,{className:"dashboard-recommended-prep-kit",title:"We recommend"},r.a.createElement(j,{playlist:t}))},C=a("rWpX");a("RHNV");var x=function(e){let t=e.data;const a=r.a.createElement(k.Link,{className:"text-link text-content",to:"/interview","data-analytics":"ViewAllKits","data-event-label":"ViewAllKits","data-event-category":"HRC Interview Prep"},"View All Kits");return r.a.createElement(g,{className:"dashboard-prep-kits",title:"Preparation Kits",headerChildren:a},t.map(e=>r.a.createElement(C.a,{key:e.slug,playlist:e})))},K=a("1nVV");var L=function(e){let t=e.data,a=void 0===t?[]:t;return a.length?r.a.createElement(g,{title:"Certification"},a.map(e=>r.a.createElement(K.b,o()({},e,{key:e.slug}))),r.a.createElement(K.a,null)):null},M=a("/D9Q"),R=(a("rGqo"),a("MVZn")),H=a.n(R),A=a("Wwog"),I=a("Y+p1"),Q=a.n(I),B=a("lHYu"),D=a("zUH+"),U=a("vKMH"),Y=a("Z/B0");const q=Object(i.createSelectorCreator)(i.defaultMemoize,Q.a),z=e=>e.community.profile,G=q(e=>Object(B.c)(e,{profile:z(e)}),e=>e),J=Object(A.a)(e=>[...e].sort((e,t)=>parseInt(null==t?void 0:t.popularity_index,10)-parseInt(null==e?void 0:e.popularity_index,10)).slice(0,2)),X=Object(i.createSelector)([e=>e.community.dashboardV2.myTracks,D.a],(e,t)=>e.map(e=>{var a;"milestone"===e.type&&(e=H()({},e,{mockTestsProgress:null===(a=t[e.slug])||void 0===a?void 0:a.mockTestsProgress}));return e})),Z=Object(i.createSelector)([X,e=>e.community.dashboardV2.topics,D.c],(e,t,a)=>({myTracks:e,topics:t,prepKits:null==a?void 0:a.slice(0,2)})),W=Object(i.createSelector)([G,U.c,Z],(e,t,a)=>{const n=J(e);return H()({mockTests:t,verifiableSkills:n},a)}),F=Object(i.createSelector)([D.d,Z],(e,t)=>H()({recommendedPrepKit:e},t)),$=Object(i.createSelector)(D.c,e=>e.slice(0,2).map(e=>e.slug)),ee=Object(i.createSelector)(X,e=>e.filter(e=>"milestone"===e.type).map(e=>e.slug)),te=Object(i.createSelector)([ee,$],(e,t)=>Array.from(new Set([...e,...t])));function ae(e){const t=e.dashboardMapping,a=e.prepKitSlugs;return Object(M.a)(a),r.a.createElement("div",{className:"dashboard-v2 container"},t.map((e,t)=>{let a=e.data,n=e.Component;return r.a.createElement(n,{data:a,key:t})}))}a.d(t,"PureDashboard",(function(){return ae})),a.d(t,"mapStateToProps",(function(){return re}));const ne=Object(i.createSelector)([e=>e.community.profile.signup_intent===Y.k.PREPARE?F(e):W(e),z],(e,t)=>{const a=t.show_prep_kits,n=t.username,r=t.show_recommended_prep_kit,c=t.show_mock_tests,l=t.show_certificates,i=t.signup_intent,s={data:e.myTracks,flag:!r,Component:b},o={data:e.topics,flag:!0,Component:y},m={data:e.verifiableSkills,flag:!Boolean(n)||l,Component:L},d={data:e.mockTests,flag:c,Component:S},p={data:e.prepKits,flag:!Boolean(n)||a,Component:x},u=[s,m,o,d,p],v=[{data:e.recommendedPrepKit,flag:r,Component:T},s,p,o];return(i===Y.k.PREPARE?v:u).filter(e=>e.flag)}),re=e=>({dashboardMapping:ne(e),prepKitSlugs:te(e)});t.default=Object(c.c)(Object(l.c)(re))(ae)},OGtf:function(e,t,a){var n=a("XKFU"),r=a("eeVq"),c=a("vhPU"),l=/"/g,i=function(e,t,a,n){var r=String(c(e)),i="<"+t;return""!==a&&(i+=" "+a+'="'+String(n).replace(l,"&quot;")+'"'),i+">"+r+"</"+t+">"};e.exports=function(e,t){var a={};a[e]=t(i),n(n.P+n.F*r((function(){var t=""[e]('"');return t!==t.toLowerCase()||t.split('"').length>3})),"String",a)}},QDlR:function(e,t,a){},RHNV:function(e,t,a){},XQ2d:function(e,t,a){},YZNL:function(e,t,a){"use strict";var n=a("pVnL"),r=a.n(n),c=a("QILm"),l=a.n(c),i=a("cDcd"),s=a.n(i),o=a("TSYQ"),m=a.n(o);a("AsEK");const d=["title","layer","active","className","children","headingLevel"];function p(e){const t=e.title,a=e.layer,n=e.active,c=e.className,i=e.children,o=e.headingLevel,p=l()(e,d),u="h"+o;return s.a.createElement("div",r()({className:m()(c,"ui-card","ui-layer-"+a,{"active-card":n})},p),t&&s.a.createElement(u,{className:"ui-title text-sec-headline-xs"},t),s.a.createElement("div",{className:"card-content"},i))}p.defaultProps={title:"",layer:2,active:!1,headingLevel:2},t.a=p},gKLV:function(e,t,a){},tR65:function(e,t,a){},tUrg:function(e,t,a){"use strict";a("OGtf")("link",(function(e){return function(t){return e(this,"a","href",t)}}))},tVud:function(e,t,a){},veGU:function(e,t,a){"use strict";var n=a("pVnL"),r=a.n(n),c=a("MVZn"),l=a.n(c),i=a("QILm"),s=a.n(i),o=a("cDcd"),m=a.n(o);a("Jkfs");t.a=e=>{let t=e.className,a=void 0===t?"":t,n=s()(e,["className"]);return n=l()({},n,{className:a+" ui-svg-icon"}),m.a.createElement("svg",r()({viewBox:"0 0 24 24",width:"1em",height:"1em"},n,{fill:"currentColor"}),m.a.createElement("path",{d:"M18 3h-1c0-1.1-.9-2-2-2H9c-1.1 0-2 .9-2 2H6C4.3 3 3 4.3 3 6v14c0 1.7 1.3 3 3 3h12c1.7 0 3-1.3 3-3V6c0-1.7-1.3-3-3-3zM9 3h6v2H9V3zm10 17c0 .6-.4 1-1 1H6c-.6 0-1-.4-1-1V6c0-.6.4-1 1-1h1c0 1.1.9 2 2 2h6c1.1 0 2-.9 2-2h1c.6 0 1 .4 1 1v14z"}))}}}]);
//# sourceMappingURL=https://hrcdn.net/community-frontend/assets/sourcemaps/hackerrank_r_dashboard_v2-f534abcc.js.map
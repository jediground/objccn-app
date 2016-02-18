var SQUARE_CORRELATION_INTERACTIVE=function(){function t(t){return Math.sin(t)+.3*Math.sin(3*t)}function r(){if(SQUARE_CORRELATION_OFFSET!=u||SQUARE_CORRELATION_FREQ!=f){u=SQUARE_CORRELATION_OFFSET,f=SQUARE_CORRELATION_FREQ,document.getElementById("squareShift").innerHTML="Phase Shift: &nbsp; <b>"+(180*u/Math.PI).toFixed(2)+"ﾂｰ</b>",O.data(b).attr("cx",function(t){return c(t)}).attr("cy",function(r){return s(t(r+u))}),T.data(b).attr("fill",Q(f)).attr("cx",function(t){return c(t)}).attr("cy",function(t){return l(Math.sin(t*f))}),w.data(b).attr("cx",function(t){return c(t)}).attr("cy",function(r){return d(t(r+u)*Math.sin(r*f))}),_.data(b).attr("x1",function(t){return c(t)}).attr("y1",function(r){return s(t(r+u))}).attr("x2",function(t){return c(t)}).attr("y2",function(r){return d(t(r+u)*Math.sin(r*f))}),m.attr("d",R(I)),S.attr("stroke",Q(f)).attr("d",A(I)),M.attr("d",E(I));var r=0;for(i=0;i<b.length;i++){var a=b[i];r+=t(a)*Math.sin(a*f+u)}P.text("Dot Product: "+r.toFixed(2)),C.attr("x2",z(r)),L.attr("cx",z(r))}}var a=590,e=250,n={top:0,right:0,bottom:0,left:0};plotWidth=a-n.left-n.right,plotHeight=e-n.top-n.bottom;var o=plotHeight/3,c=d3.scale.linear().range([n.left,plotWidth]),s=d3.scale.linear().range([o,n.top]),l=d3.scale.linear().range([2*o+20,o+20]),d=d3.scale.linear().range([3*o+40,2*o+40]);c.domain([0,4*Math.PI]),s.domain([-1.25,1.25]),l.domain([-1.25,1.25]),d.domain([-1.25,1.25]);var u=-1,f=1,p=d3.svg.axis().scale(c).tickSize(0).ticks(0).tickSubdivide(!0),x=d3.svg.axis().scale(c).tickSize(0).ticks(0).tickSubdivide(!0),g=d3.svg.axis().scale(c).tickSize(0).ticks(0).tickSubdivide(!0),h=d3.select("#sigCorrelationInteractive");h.append("svg:g").attr("class","x axis").attr("transform","translate(0,"+s(0)+")").style("opacity",.25).call(p),h.append("svg:g").attr("class","x axis").attr("transform","translate(0,"+l(0)+")").style("opacity",.25).call(x),h.append("svg:g").attr("class","x axis").attr("transform","translate(0,"+d(0)+")").style("opacity",.25).call(g);var y="black",k="green",v="rgb(86, 60, 50)",m=h.append("svg:path").attr("stroke-width",2).attr("stroke",y).attr("fill","none").attr("opacity",.4),S=h.append("svg:path").attr("stroke-width",2).attr("stroke",k).attr("fill","none").attr("opacity",.3),M=h.append("svg:path").attr("stroke-width",2).attr("stroke",v).attr("fill",v).attr("fill-opacity",.2).attr("opacity",.5),R=d3.svg.line().x(function(t){return c(t)}).y(function(r){return s(t(r+u))}),A=d3.svg.line().x(function(t){return c(t)}).y(function(t){return l(Math.sin(t*f))}),E=d3.svg.line().x(function(t){return c(t)}).y(function(r){return d(t(r+u)*Math.sin(r*f))}),I=d3.range(0,4*Math.PI,.05);m.attr("d",R(I)),S.attr("d",A(I)),M.attr("d",E(I));var b=d3.range(0,4*Math.PI,4*Math.PI/30),O=h.selectAll(".point1").data(b).enter().append("svg:circle").attr("stroke","none").attr("fill",y).attr("cx",function(t){return c(t)}).attr("cy",function(r){return s(t(r+u))}).attr("r",function(){return 2}),T=h.selectAll(".point2").data(b).enter().append("svg:circle").attr("stroke","none").attr("fill",k).attr("cx",function(t){return c(t)}).attr("cy",function(t){return l(Math.sin(t*f))}).attr("r",function(){return 2}),_=h.selectAll(".connectors").data(b).enter().append("line").attr("x1",function(t){return c(t)}).attr("y1",function(r){return s(t(r))}).attr("x2",function(t){return c(t)}).attr("y2",function(r){return d(t(r+u)*Math.sin(r*f))}).attr("stroke-width",1).attr("stroke","grey").style("opacity",.2).style("stroke-dasharray","3, 3"),w=h.selectAll(".point3").data(b).enter().append("svg:circle").attr("stroke","none").attr("fill",v).attr("cx",function(t){return c(t)}).attr("cy",function(r){return d(t(r+u)*Math.sin(r*f))}).attr("r",function(){return 2}),z=d3.scale.linear().range([140,470]);z.domain([-20,20]);var F=d3.svg.axis().scale(z).tickSize(4).ticks(10).tickSubdivide(!0);h.append("svg:g").attr("class","x axis").attr("transform","translate(0,"+(d(0)+60)+")").style("opacity",.45).call(F);var P=h.append("text").attr("text-anchor","middle").attr("x",z(0)).attr("y",d(0)+90).attr("stroke","none").attr("fill","#555").attr("font-size",12).attr("font-weight","bold").text("Dot Product: ");h.append("defs").append("marker").attr("id","arrowhead").attr("refX",5).attr("refY",2).attr("markerWidth",10).attr("markerHeight",10).attr("orient","auto").attr("fill",v).append("path").attr("d","M 0,0 V 4 L6,2 Z");var C=h.append("line").attr("x1",z(0)).attr("y1",d(0)+60).attr("x2",z(0)).attr("y2",d(0)+60).attr("stroke-width",2).attr("stroke",v),L=h.append("svg:circle").attr("cx",z(0)).attr("cy",d(0)+60).attr("stroke","#eee").attr("stroke-width",1.5).attr("fill",v).attr("r",3);h.append("text").attr("text-anchor","left").attr("x",0).attr("y",s(0)+13).attr("stroke","none").attr("fill","grey").attr("font-size",11).text("Signal A"),h.append("text").attr("text-anchor","left").attr("x",0).attr("y",l(0)+13).attr("stroke","none").attr("fill","grey").attr("font-size",11).text("Signal B"),h.append("text").attr("text-anchor","left").attr("x",0).attr("y",210).attr("stroke","none").attr("fill","grey").attr("font-size",11).text("A x B");var Q=d3.scale.category10();Q.domain[d3.range(0,10,1)],d3.timer(r,100)}();
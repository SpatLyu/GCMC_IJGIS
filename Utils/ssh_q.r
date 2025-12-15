ssh_q = \(data,cause,effect,discnum = 5,discmethod = "natural"){
  x = data[,cause,drop = TRUE]
  y = data[,effect,drop = TRUE]
  xh = sdsfun::discretize_vector(x,n = discnum,method = discmethod)
  yh = sdsfun::discretize_vector(y,n = discnum,method = discmethod)
  q1 = as.data.frame(gdverse::factor_detector(y,xh))
  q2 = as.data.frame(gdverse::factor_detector(x,yh))
  qv = rbind(q1,q2)
  colnames(qv) = c("qv","sig")
  qv$x = c(cause,effect)
  qv$y = c(effect,cause)
  qv$direction = c(paste0(cause," -> ",effect),
                   paste0(effect," -> ",cause))
  return(dplyr::select(qv,x,y,direction,qv,sig))
} 

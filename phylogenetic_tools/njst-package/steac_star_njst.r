library(phybase)

#NJST functions
nancdist<-function(tree, taxaname)
{
	ntaxa<-length(taxaname)
	nodematrix<-read.tree.nodes(tree,taxaname)$nodes
	if(is.rootedtree(nodematrix)) nodematrix<-unroottree(nodematrix)
	dist<-matrix(0, ntaxa,ntaxa)
	for(i in 1:(ntaxa-1))
		for(j in (i+1):ntaxa)
		{
		anc1<-ancestor(i,nodematrix)
		anc2<-ancestor(j,nodematrix)
		n<-sum(which(t(matrix(rep(anc1,length(anc2)),ncol=length(anc2)))-anc2==0, arr.ind=TRUE)[1,])-3
		if(n==-1) n<-0
		dist[i,j]<-n
		}
	dist<-dist+t(dist)
	z<-list(dist=as.matrix, taxaname=as.vector)
	z$dist<-dist
	z$taxaname<-taxaname
	z
}

njst.sptree<-function(genetrees, spname, taxaname, species.structure)
{

	ntree<-length(genetrees) #gets number of trees
	ntaxa<-length(taxaname) #gets number of tips
	dist <- matrix(0, nrow = ntree, ncol = ntaxa * ntaxa) #distance matrix
	
	for(i in 1:ntree) #gtrees' loop
	{
		genetree1 <- read.tree.nodes(genetrees[i]) #tree object
        	thistreetaxa <- genetree1$names #tip's labels, ordered like in sort(as.character(leaves))
        	ntaxaofthistree <- length(thistreetaxa) #number of leaves
        	thistreenode <- rep(-1, ntaxaofthistree) # vector of n_tips times -1
		dist1<-matrix(0,ntaxa,ntaxa)#distance matrix for this tree
        	for (j in 1:ntaxaofthistree) 
		{ 
            		thistreenode[j] <- which(taxaname == thistreetaxa[j]) #fills the vector thistreenode[j] with the position of each node name in the general taxaname vector (leaveset)
            		if (length(thistreenode[j]) == 0) 
			{
                		print(paste("wrong taxaname", thistreetaxa[j],"in gene", i))
                		return(0)
            		}
        	}
		dist1[thistreenode, thistreenode]<-nancdist(genetrees[i],thistreetaxa)$dist
		dist[i,]<-as.numeric(dist1)
	}

	dist[dist == 0] <- NA
    	dist2 <- matrix(apply(dist, 2, mean, na.rm = TRUE), ntaxa, ntaxa)
    	diag(dist2) <- 0
        print(dist2)
    	if (sum(is.nan(dist2)) > 0) 
	{
        	print("missing species!")
        	dist2[is.nan(dist2)] <- 10000
    	}
    	speciesdistance <- pair.dist.mulseq(dist2, species.structure)
        print(speciesdistance)
	tree<-write.tree(nj(speciesdistance))
	node2name(tree,name=spname)
}

#My code
args=commandArgs(TRUE)

if (!(args[1] == "steac" || args[1] == "star" || args[1] == "njst"))
{ 
print("Method incorrectly set")
quit()
}

#originaltrees=read.tree("../bestml/alltrees.rooted")
#write.tree(originaltrees,"gtrees")
treefile=read.tree.string(args[2],format="phylip")
trees=treefile$tree
g_names=treefile$names
outgroup="s_0"

s_names=read.table(args[3]) #first column
s_names=s_names[,1] #From data.frame to vector

ind_per_sp=(length(g_names)-1)/(length(s_names)-1) #0 is the outgroup, with only one replicate, the rest have the same number of individuals per species

species.structure= matrix(0, nrow = length(s_names), ncol= length(g_names))
diag(species.structure)<-1
species.structure
#for (i in 1:length(g_names))
#{
#	species=regmatches(g_names[i],regexpr("(?<=s)[0-9]+",g_names[i],perl=TRUE))
#	row=which(s_names == species)
#	species.structure[row,i]=1
#}

print(s_names)

if (args[1]== "steac") {
outtree=steac.sptree(trees, s_names, g_names,species.structure,outgroup,method="nj")
} else if (args[1]== "star"){
outtree=star.sptree(trees, s_names, g_names,species.structure,outgroup,method="nj")
} else {
outtree=njst.sptree(trees, s_names, g_names,species.structure)
}
write.tree.string(outtree, format = "Phylip", file = args[4])


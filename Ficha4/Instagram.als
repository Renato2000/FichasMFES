sig User {
	follows : set User,
	sees : set Photo,
	posts : set Photo,
	suggested : set User
}

sig Influencer extends User {}

sig Photo {
	date : one Day
}
sig Ad extends Photo {}

sig Day {}

// Specify the following properties
// You can check their correctness with the different commands and
// when specifying each property you can assume all the previous ones to be true

pred inv1 {
	// Every image is posted by one user
  	all p : Photo | one posts.p
}

pred inv2 {
	// An user cannot follow itself.
  	//all u : User | u->u not in follows
	no follows & iden
}

pred inv3 {
	// An user only sees (non ad) photos posted by followed users. 
	// Ads can be seen by everyone.
	// all u1 : User, i : Photo | (i not in Ad and u1 in sees.i) implies (some u2 : User | u1 in follows.u2 and u2 in posts.i) 
	all u : User | u.sees - Ad in u.follows.posts
}

pred inv4 {
	// If an user posts an ad then all its posts should be labelled as ads
  	// all u : User | (some a : Ad | u->a in posts) implies all p : Photo | u->p in posts implies p in Ad
	all u : User | u.posts in Ad or u.posts in Photo - Ad
}

pred inv5 {
	// Influencers are followed by everyone else
	// all i : Influencer, u : User | u != i implies u->i in follows
  	all u : User | (Influencer-u) in u.follows 
}

pred inv6 {
	// Influencers post every day
	// all d : Day, i : Influencer | some p : Photo | i->p in posts and p->d in date
  	// all d : Day, i : Influencer | some p : Photo | i in posts.p and p in date.d
  	all i : Influencer | i.posts.date = Day
}

pred inv7 {
	// Suggested are other users followed by followed users, but not yet followed
	// all u1, u2 : User | u1->u2 in suggested iff (some u3 : User | u1->u3 in follows and u3->u2 in follows and u1->u2 not in follows and u1 != u2)
  	// all u1, u2 : User | u1 in suggested.u2 iff (some u3 : User | u1 in follows.u3 - follows.u2 and u3 in follows.u2 and u1 != u2)
  	all u : User | u.suggested = (u.follows.follows - u.follows - u)
}

pred inv8 {
	// An user only sees ads from followed or suggested users
	// all u1 : User, a : Ad | u1->a in sees implies some u2 : User | u2->a in posts and (u1->u2 in follows or u1->u2 in suggested)
	// all u1 : User, a : Ad | u1 in sees.a implies some u2 : User | u2 in posts.a and u1 in follows.u2 + suggested.u2
  	all u : User | (u.sees & Ad) in (u.follows.posts + u.suggested.posts)
}
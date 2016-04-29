[![Stories in Ready](https://badge.waffle.io/three-triangles/ganondorf.png?label=ready&title=Ready)](https://waffle.io/three-triangles/ganondorf)
# Ganondorf

<p align="center">
  <img
    src="https://cloud.githubusercontent.com/assets/2657901/14548051/14e453f0-0279-11e6-9eaf-5e599c0d3c1d.png"
    width="730"
    alt="The InnKeeper"/>
</p>

An OpenID Connect authentication platform designed for multiple applications in
mind.  The goal is to be able to use this as an independent user authentication
which you can have multiple applications rely on.

## Current Roadmap

Currently looking to tackle the [core](http://openid.net/specs/openid-connect-core-1_0.html)
of the spec.

  - [x] Simple Internal User Authentication
  - [ ] OpenID Connect Authentication
    - [ ] [Authorization Code Flow](http://openid.net/specs/openid-connect-core-1_0.html#CodeFlowAuth)
    - [ ] [Implicit Flow](http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth)
    - [ ] [Hybrid Flow](http://openid.net/specs/openid-connect-core-1_0.html#HybridFlowAuth)
  - [ ] Claims
    - [ ] [User Info Endpoint](http://openid.net/specs/openid-connect-core-1_0.html#UserInfo) 
    - [ ] Normal Claims
    - [ ] Aggregated Claims
    - [ ] Distributed Claims
  - [ ] [Request Parameters as JWT](http://openid.net/specs/openid-connect-core-1_0.html#JWTRequests)
  - [ ] Self Issued OP Registration
  - [ ] Client Authentication
  - [ ] Offline Access
  - [ ] Refresh Tokens

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2C5A6D72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH3Tgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH3Tgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:36:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133161B1A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661888207; x=1693424207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nkkM0Dp1B2YkJRrxHxMFQf65AUlTMbDUhqGUOeVfgSw=;
  b=RcpKecc3IW1q+22wBP2xoRgdijdM4PbqNna9tVOFI551CwUdRjixZQSK
   JmZELxy+6N8o1oiotbgVjiK/3LGP7aMsK9Q8IdFTK1wtLIEFeENAS6QoI
   gnhRnU1v5hlMVUfCsqHcicLEfUeOc7NzJaFU8j8Vz854qDo5OqAqdeR3L
   E0my79GB7DIejCBXxtNF3hlmUq6V9t2aECzPAznY4uXhVQ3O3CAcP2d1V
   xyz5npC8o6Ko4M8xNTZdNwbJ++egZ1AWuMh27fFnX4uP+MCWyMLUcJc3x
   gyM1gkq9mtlGVF1gyI2s4L3S4fEvesuMTzYUKCRmPrIue/H2ASXSJZtFd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282255679"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="282255679"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 12:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="680166135"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2022 12:36:29 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT72C-0000XT-2X;
        Tue, 30 Aug 2022 19:36:28 +0000
Date:   Wed, 31 Aug 2022 03:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-fixes 1/5]
 net/rxrpc/peer_event.c:234:3: warning: variable 'err' is used uninitialized
 whenever switch default is taken
Message-ID: <202208310344.BhjBqXzR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-fixes
head:   c2f6ecfc2c8d95244507cfe244710f61e0f727a7
commit: b6b6fa5db526817c2b4e8f2fdec40592e9817804 [1/5] rxrpc: Fix ICMP/ICMP6 error handling
config: hexagon-randconfig-r045-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310344.BhjBqXzR-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c7df82e4693c19e3fd2e25c83eb04d9deb7b7b59)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b6b6fa5db526817c2b4e8f2fdec40592e9817804
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-fixes
        git checkout b6b6fa5db526817c2b4e8f2fdec40592e9817804
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/peer_event.c:234:3: warning: variable 'err' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
                   default:
                   ^~~~~~~
   net/rxrpc/peer_event.c:241:17: note: uninitialized use occurs here
                   ee.ee_errno = err;
                                 ^~~
   net/rxrpc/peer_event.c:167:9: note: initialize the variable 'err' to silence this warning
           int err;
                  ^
                   = 0
>> net/rxrpc/peer_event.c:418:6: warning: variable 'peer' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/rxrpc/peer_event.c:430:17: note: uninitialized use occurs here
           rxrpc_put_peer(peer);
                          ^~~~
   net/rxrpc/peer_event.c:418:2: note: remove the 'if' if its condition is always true
           if (serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/rxrpc/peer_event.c:393:25: note: initialize the variable 'peer' to silence this warning
           struct rxrpc_peer *peer;
                                  ^
                                   = NULL
   2 warnings generated.


vim +/err +234 net/rxrpc/peer_event.c

   155	
   156	/*
   157	 * Handle an error received on the local endpoint as a tunnel.
   158	 */
   159	void rxrpc_encap_err_rcv(struct sock *sk, struct sk_buff *skb,
   160				 unsigned int udp_offset)
   161	{
   162		struct sock_extended_err ee;
   163		struct sockaddr_rxrpc srx;
   164		struct rxrpc_local *local;
   165		struct rxrpc_peer *peer;
   166		unsigned int info = 0;
   167		int err;
   168		u8 version = ip_hdr(skb)->version;
   169		u8 type = icmp_hdr(skb)->type;
   170		u8 code = icmp_hdr(skb)->code;
   171	
   172		rcu_read_lock();
   173		local = rcu_dereference_sk_user_data(sk);
   174		if (unlikely(!local)) {
   175			rcu_read_unlock();
   176			return;
   177		}
   178	
   179		rxrpc_new_skb(skb, rxrpc_skb_received);
   180	
   181		switch (ip_hdr(skb)->version) {
   182		case IPVERSION:
   183			peer = rxrpc_lookup_peer_icmp_rcu(local, skb, udp_offset,
   184							  &info, &srx);
   185			break;
   186		case 6:
   187			peer = rxrpc_lookup_peer_icmp6_rcu(local, skb, udp_offset,
   188							   &info, &srx);
   189			break;
   190		default:
   191			rcu_read_unlock();
   192			return;
   193		}
   194	
   195		if (peer && !rxrpc_get_peer_maybe(peer))
   196			peer = NULL;
   197		if (!peer) {
   198			rcu_read_unlock();
   199			return;
   200		}
   201	
   202		memset(&ee, 0, sizeof(ee));
   203	
   204		switch (version) {
   205		case IPVERSION:
   206			switch (type) {
   207			case ICMP_DEST_UNREACH:
   208				switch (code) {
   209				case ICMP_FRAG_NEEDED:
   210					rxrpc_adjust_mtu(peer, info);
   211					rcu_read_unlock();
   212					rxrpc_put_peer(peer);
   213					return;
   214				default:
   215					break;
   216				}
   217	
   218				err = EHOSTUNREACH;
   219				if (code <= NR_ICMP_UNREACH) {
   220					/* Might want to do something different with
   221					 * non-fatal errors
   222					 */
   223					//harderr = icmp_err_convert[code].fatal;
   224					err = icmp_err_convert[code].errno;
   225				}
   226				break;
   227	
   228			case ICMP_PARAMETERPROB:
   229				err = EPROTO;
   230				break;
   231			case ICMP_TIME_EXCEEDED:
   232				err = EHOSTUNREACH;
   233				break;
 > 234			default:
   235				break;
   236			}
   237	
   238			ee.ee_origin = SO_EE_ORIGIN_ICMP;
   239			ee.ee_type = type;
   240			ee.ee_code = code;
   241			ee.ee_errno = err;
   242			break;
   243	
   244		case 6:
   245			switch (type) {
   246			case ICMPV6_PKT_TOOBIG:
   247				rxrpc_adjust_mtu(peer, info);
   248				rcu_read_unlock();
   249				rxrpc_put_peer(peer);
   250				return;
   251			}
   252	
   253			icmpv6_err_convert(type, code, &err);
   254	
   255			if (err == EACCES)
   256				err = EHOSTUNREACH;
   257	
   258			ee.ee_origin = SO_EE_ORIGIN_ICMP6;
   259			ee.ee_type = type;
   260			ee.ee_code = code;
   261			ee.ee_errno = err;
   262			break;
   263		}
   264	
   265		trace_rxrpc_rx_icmp(peer, &ee, &srx);
   266	
   267		rxrpc_distribute_error(peer, err, RXRPC_CALL_NETWORK_ERROR);
   268		rcu_read_unlock();
   269		rxrpc_put_peer(peer);
   270	}
   271	
   272	/*
   273	 * Find the peer associated with a local error.
   274	 */
   275	static struct rxrpc_peer *rxrpc_lookup_peer_local_rcu(struct rxrpc_local *local,
   276							      const struct sk_buff *skb,
   277							      struct sockaddr_rxrpc *srx)
   278	{
   279		struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
   280	
   281		_enter("");
   282	
   283		memset(srx, 0, sizeof(*srx));
   284		srx->transport_type = local->srx.transport_type;
   285		srx->transport_len = local->srx.transport_len;
   286		srx->transport.family = local->srx.transport.family;
   287	
   288		switch (srx->transport.family) {
   289		case AF_INET:
   290			srx->transport_len = sizeof(srx->transport.sin);
   291			srx->transport.family = AF_INET;
   292			srx->transport.sin.sin_port = serr->port;
   293			switch (serr->ee.ee_origin) {
   294			case SO_EE_ORIGIN_ICMP:
   295				_net("Rx ICMP");
   296				memcpy(&srx->transport.sin.sin_addr,
   297				       skb_network_header(skb) + serr->addr_offset,
   298				       sizeof(struct in_addr));
   299				break;
   300			case SO_EE_ORIGIN_ICMP6:
   301				_net("Rx ICMP6 on v4 sock");
   302				memcpy(&srx->transport.sin.sin_addr,
   303				       skb_network_header(skb) + serr->addr_offset + 12,
   304				       sizeof(struct in_addr));
   305				break;
   306			default:
   307				memcpy(&srx->transport.sin.sin_addr, &ip_hdr(skb)->saddr,
   308				       sizeof(struct in_addr));
   309				break;
   310			}
   311			break;
   312	
   313	#ifdef CONFIG_AF_RXRPC_IPV6
   314		case AF_INET6:
   315			switch (serr->ee.ee_origin) {
   316			case SO_EE_ORIGIN_ICMP6:
   317				_net("Rx ICMP6");
   318				srx->transport.sin6.sin6_port = serr->port;
   319				memcpy(&srx->transport.sin6.sin6_addr,
   320				       skb_network_header(skb) + serr->addr_offset,
   321				       sizeof(struct in6_addr));
   322				break;
   323			case SO_EE_ORIGIN_ICMP:
   324				_net("Rx ICMP on v6 sock");
   325				srx->transport_len = sizeof(srx->transport.sin);
   326				srx->transport.family = AF_INET;
   327				srx->transport.sin.sin_port = serr->port;
   328				memcpy(&srx->transport.sin.sin_addr,
   329				       skb_network_header(skb) + serr->addr_offset,
   330				       sizeof(struct in_addr));
   331				break;
   332			default:
   333				memcpy(&srx->transport.sin6.sin6_addr,
   334				       &ipv6_hdr(skb)->saddr,
   335				       sizeof(struct in6_addr));
   336				break;
   337			}
   338			break;
   339	#endif
   340	
   341		default:
   342			BUG();
   343		}
   344	
   345		return rxrpc_lookup_peer_rcu(local, srx);
   346	}
   347	
   348	/*
   349	 * Handle an MTU/fragmentation problem.
   350	 */
   351	static void rxrpc_adjust_mtu(struct rxrpc_peer *peer, unsigned int mtu)
   352	{
   353		_net("Rx ICMP Fragmentation Needed (%d)", mtu);
   354	
   355		/* wind down the local interface MTU */
   356		if (mtu > 0 && peer->if_mtu == 65535 && mtu < peer->if_mtu) {
   357			peer->if_mtu = mtu;
   358			_net("I/F MTU %u", mtu);
   359		}
   360	
   361		if (mtu == 0) {
   362			/* they didn't give us a size, estimate one */
   363			mtu = peer->if_mtu;
   364			if (mtu > 1500) {
   365				mtu >>= 1;
   366				if (mtu < 1500)
   367					mtu = 1500;
   368			} else {
   369				mtu -= 100;
   370				if (mtu < peer->hdrsize)
   371					mtu = peer->hdrsize + 4;
   372			}
   373		}
   374	
   375		if (mtu < peer->mtu) {
   376			spin_lock_bh(&peer->lock);
   377			peer->mtu = mtu;
   378			peer->maxdata = peer->mtu - peer->hdrsize;
   379			spin_unlock_bh(&peer->lock);
   380			_net("Net MTU %u (maxdata %u)",
   381			     peer->mtu, peer->maxdata);
   382		}
   383	}
   384	
   385	/*
   386	 * Handle an error received on the local endpoint.
   387	 */
   388	void rxrpc_error_report(struct sock *sk)
   389	{
   390		struct sock_exterr_skb *serr;
   391		struct sockaddr_rxrpc srx;
   392		struct rxrpc_local *local;
   393		struct rxrpc_peer *peer;
   394		struct sk_buff *skb;
   395	
   396		rcu_read_lock();
   397		local = rcu_dereference_sk_user_data(sk);
   398		if (unlikely(!local)) {
   399			rcu_read_unlock();
   400			return;
   401		}
   402		_enter("%p{%d}", sk, local->debug_id);
   403	
   404		/* Clear the outstanding error value on the socket so that it doesn't
   405		 * cause kernel_sendmsg() to return it later.
   406		 */
   407		sock_error(sk);
   408	
   409		skb = sock_dequeue_err_skb(sk);
   410		if (!skb) {
   411			rcu_read_unlock();
   412			_leave("UDP socket errqueue empty");
   413			return;
   414		}
   415		rxrpc_new_skb(skb, rxrpc_skb_received);
   416		serr = SKB_EXT_ERR(skb);
   417	
 > 418		if (serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL) {
   419			peer = rxrpc_lookup_peer_local_rcu(local, skb, &srx);
   420			if (peer && !rxrpc_get_peer_maybe(peer))
   421				peer = NULL;
   422			if (peer) {
   423				trace_rxrpc_rx_icmp(peer, &serr->ee, &srx);
   424				rxrpc_store_error(peer, serr);
   425			}
   426		}
   427	
   428		rcu_read_unlock();
   429		rxrpc_free_skb(skb, rxrpc_skb_freed);
   430		rxrpc_put_peer(peer);
   431		_leave("");
   432	}
   433	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469CB535884
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiE0EcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiE0EcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:32:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9726133
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653625924; x=1685161924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QAo4z+N2epTpMkqPp/2Ce7Ax1qWOBU6R7cgIEkCv3zM=;
  b=Y++4PgjLxblRXjO4VSA9aZK2QsnFpKRpvmlWLIWH+x4VQGWi9LB0gso9
   DGhBI2gEWfx4V+IzavRnJ6bt7k9lBhlk6TkpDMp/GF1Q8FPhikX8cBiU6
   YIhIl63w+XFl3X4xwSeeRkWoP2gaHEdhgzfcclcYD/JtOdTRvfOtWfeVl
   sj/CpAnwubAuxgau5Kv2v5EPn3/h5zFfNmC1oWa8rgov+epbAZibi+XwF
   TJvgrTC80a4Q3UIw95z2pDHXBkdaZzvI80FJd5WmrRYgXBirVd0WTP7z4
   jtPOfSByvNrVE8Az+uOB/ybWCDF8Z751k18C+f3XUs0aPgIMV7QfNfUMq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335022369"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335022369"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 21:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="527777511"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2022 21:32:02 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuRdp-0004PC-O2;
        Fri, 27 May 2022 04:32:01 +0000
Date:   Fri, 27 May 2022 12:31:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/ipvs/ip_vs_core.c:1386 ip_vs_out_hook() warn:
 inconsistent indenting
Message-ID: <202205271235.DEQpeDHA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7f50d4dfe816dd916a7cbf39039674825c2b388b
commit: 9dd43a5f4b11b161c9dfcce9391e843e65d6a4cc netfilter: ipvs: prepare for hook function reduction
date:   7 months ago
config: s390-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271235.DEQpeDHA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
net/netfilter/ipvs/ip_vs_core.c:1386 ip_vs_out_hook() warn: inconsistent indenting
net/netfilter/ipvs/ip_vs_core.c:2032 ip_vs_in_hook() warn: inconsistent indenting

Old smatch warnings:
include/net/ip_vs.h:200 ip_vs_dbg_addr() warn: inconsistent indenting
net/netfilter/ipvs/ip_vs_core.c:741 ip_vs_route_me_harder() warn: inconsistent indenting
net/netfilter/ipvs/ip_vs_core.c:1406 ip_vs_out_hook() warn: inconsistent indenting

vim +1386 net/netfilter/ipvs/ip_vs_core.c

4856c84c1358b7 net/ipv4/ipvs/ip_vs_core.c      Malcolm Turnbull       2008-09-05  1328  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1329  /*
4856c84c1358b7 net/ipv4/ipvs/ip_vs_core.c      Malcolm Turnbull       2008-09-05  1330   *	Check if outgoing packet belongs to the established ip_vs_conn.
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1331   */
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1332  static unsigned int
9dd43a5f4b11b1 net/netfilter/ipvs/ip_vs_core.c Florian Westphal       2021-10-12  1333  ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1334  {
9dd43a5f4b11b1 net/netfilter/ipvs/ip_vs_core.c Florian Westphal       2021-10-12  1335  	struct netns_ipvs *ipvs = net_ipvs(state->net);
9dd43a5f4b11b1 net/netfilter/ipvs/ip_vs_core.c Florian Westphal       2021-10-12  1336  	unsigned int hooknum = state->hook;
51ef348b141837 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1337  	struct ip_vs_iphdr iph;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1338  	struct ip_vs_protocol *pp;
9330419d9aa4f9 net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-01-03  1339  	struct ip_vs_proto_data *pd;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1340  	struct ip_vs_conn *cp;
9dd43a5f4b11b1 net/netfilter/ipvs/ip_vs_core.c Florian Westphal       2021-10-12  1341  	int af = state->pf;
340c78e5906264 net/netfilter/ipvs/ip_vs_core.c Eric Dumazet           2015-11-12  1342  	struct sock *sk;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1343  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1344  	EnterFunction(11);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1345  
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1346  	/* Already marked as IPVS request or reply? */
6869c4d8e066e2 net/ipv4/ipvs/ip_vs_core.c      Harald Welte           2005-08-09  1347  	if (skb->ipvs_property)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1348  		return NF_ACCEPT;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1349  
340c78e5906264 net/netfilter/ipvs/ip_vs_core.c Eric Dumazet           2015-11-12  1350  	sk = skb_to_full_sk(skb);
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1351  	/* Bad... Do not break raw sockets */
340c78e5906264 net/netfilter/ipvs/ip_vs_core.c Eric Dumazet           2015-11-12  1352  	if (unlikely(sk && hooknum == NF_INET_LOCAL_OUT &&
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1353  		     af == AF_INET)) {
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1354  
340c78e5906264 net/netfilter/ipvs/ip_vs_core.c Eric Dumazet           2015-11-12  1355  		if (sk->sk_family == PF_INET && inet_sk(sk)->nodefrag)
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1356  			return NF_ACCEPT;
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1357  	}
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1358  
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1359  	if (unlikely(!skb_dst(skb)))
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1360  		return NF_ACCEPT;
fc604767613b6d net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1361  
48aed1b029597d net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1362  	if (!ipvs->enable)
7a4f0761fce32f net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-05-03  1363  		return NF_ACCEPT;
7a4f0761fce32f net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-05-03  1364  
4fd9beef37f3a1 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  1365  	ip_vs_fill_iph_skb(af, skb, false, &iph);
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1366  #ifdef CONFIG_IP_VS_IPV6
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1367  	if (af == AF_INET6) {
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1368  		if (unlikely(iph.protocol == IPPROTO_ICMPV6)) {
1ca5bb5450aa24 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1369  			int related;
7b5f689a2c25fb net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1370  			int verdict = ip_vs_out_icmp_v6(ipvs, skb, &related,
d4383f04d145cc net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  1371  							hooknum, &iph);
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1372  
f5a41847acc535 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1373  			if (related)
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1374  				return verdict;
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1375  		}
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1376  	} else
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1377  #endif
51ef348b141837 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1378  		if (unlikely(iph.protocol == IPPROTO_ICMP)) {
1ca5bb5450aa24 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1379  			int related;
7b5f689a2c25fb net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1380  			int verdict = ip_vs_out_icmp(ipvs, skb, &related, hooknum);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1381  
f5a41847acc535 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1382  			if (related)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1383  				return verdict;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1384  		}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1385  
18d6ade63c8d79 net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21 @1386  	pd = ip_vs_proto_data_get(ipvs, iph.protocol);
9330419d9aa4f9 net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-01-03  1387  	if (unlikely(!pd))
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1388  		return NF_ACCEPT;
9330419d9aa4f9 net/netfilter/ipvs/ip_vs_core.c Hans Schillstrom       2011-01-03  1389  	pp = pd->pp;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1390  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1391  	/* reassemble IP fragments */
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1392  #ifdef CONFIG_IP_VS_IPV6
63dca2c0b0e7a9 net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  1393  	if (af == AF_INET)
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1394  #endif
56f8a75c17abb8 net/netfilter/ipvs/ip_vs_core.c Paul Gortmaker         2011-06-21  1395  		if (unlikely(ip_is_fragment(ip_hdr(skb)) && !pp->dont_defrag)) {
57781c1ceead5a net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1396  			if (ip_vs_gather_frags(ipvs, skb,
1ca5bb5450aa24 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1397  					       ip_vs_defrag_user(hooknum)))
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1398  				return NF_STOLEN;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1399  
4fd9beef37f3a1 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  1400  			ip_vs_fill_iph_skb(AF_INET, skb, false, &iph);
51ef348b141837 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1401  		}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1402  
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1403  	/*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1404  	 * Check if the packet belongs to an existing entry
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1405  	 */
6ecd754883daff net/netfilter/ipvs/ip_vs_core.c Matteo Croce           2019-01-19  1406  	cp = INDIRECT_CALL_1(pp->conn_out_get, ip_vs_conn_out_get_proto,
6ecd754883daff net/netfilter/ipvs/ip_vs_core.c Matteo Croce           2019-01-19  1407  			     ipvs, af, skb, &iph);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1408  
073b04e76be6d5 net/netfilter/ipvs/ip_vs_core.c longguang.yue          2020-10-05  1409  	if (likely(cp))
579eb62ac35845 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2014-12-18  1410  		return handle_response(af, skb, pd, cp, &iph, hooknum);
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1411  
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1412  	/* Check for real-server-started requests */
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1413  	if (atomic_read(&ipvs->conn_out_counter)) {
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1414  		/* Currently only for UDP:
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1415  		 * connection oriented protocols typically use
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1416  		 * ephemeral ports for outgoing connections, so
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1417  		 * related incoming responses would not match any VS
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1418  		 */
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1419  		if (pp->protocol == IPPROTO_UDP) {
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1420  			cp = __ip_vs_rs_conn_out(hooknum, ipvs, af, skb, &iph);
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1421  			if (likely(cp))
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1422  				return handle_response(af, skb, pd, cp, &iph,
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1423  						       hooknum);
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1424  		}
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1425  	}
39b97223153641 net/netfilter/ipvs/ip_vs_core.c Marco Angaroni         2016-04-05  1426  
2300f0451e5fa5 net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1427  	if (sysctl_nat_icmp_send(ipvs) &&
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1428  	    (pp->protocol == IPPROTO_TCP ||
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1429  	     pp->protocol == IPPROTO_UDP ||
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1430  	     pp->protocol == IPPROTO_SCTP)) {
014d730d56b559 net/ipv4/ipvs/ip_vs_core.c      Al Viro                2006-09-28  1431  		__be16 _ports[2], *pptr;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1432  
2f74713d1436b7 net/netfilter/ipvs/ip_vs_core.c Jesper Dangaard Brouer 2012-09-26  1433  		pptr = frag_safe_skb_hp(skb, iph.len,
6b3d933000cbe5 net/netfilter/ipvs/ip_vs_core.c Gao Feng               2017-11-13  1434  					 sizeof(_ports), _ports);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1435  		if (pptr == NULL)
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1436  			return NF_ACCEPT;	/* Not for me */
48aed1b029597d net/netfilter/ipvs/ip_vs_core.c Eric W. Biederman      2015-09-21  1437  		if (ip_vs_has_real_service(ipvs, af, iph.protocol, &iph.saddr,
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1438  					   pptr[0])) {
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1439  			/*
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1440  			 * Notify the real server: there is no
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1441  			 * existing entry if it is not RST
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1442  			 * packet or not TCP packet.
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1443  			 */
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1444  			if ((iph.protocol != IPPROTO_TCP &&
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1445  			     iph.protocol != IPPROTO_SCTP)
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1446  			     || ((iph.protocol == IPPROTO_TCP
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1447  				  && !is_tcp_reset(skb, iph.len))
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1448  				 || (iph.protocol == IPPROTO_SCTP
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1449  					&& !is_sctp_abort(skb,
2906f66a5682e5 net/netfilter/ipvs/ip_vs_core.c Venkata Mohan Reddy    2010-02-18  1450  						iph.len)))) {
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1451  #ifdef CONFIG_IP_VS_IPV6
cb59155f21d4c0 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1452  				if (af == AF_INET6) {
cb59155f21d4c0 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1453  					if (!skb->dev)
ed1c9f0e78b3b3 net/netfilter/ipvs/ip_vs_core.c David Ahern            2015-10-01  1454  						skb->dev = ipvs->net->loopback_dev;
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1455  					icmpv6_send(skb,
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1456  						    ICMPV6_DEST_UNREACH,
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1457  						    ICMPV6_PORT_UNREACH,
3ffe533c87281b net/netfilter/ipvs/ip_vs_core.c Alexey Dobriyan        2010-02-18  1458  						    0);
cb59155f21d4c0 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1459  				} else
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1460  #endif
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1461  					icmp_send(skb,
2a3b791e6e1169 net/ipv4/ipvs/ip_vs_core.c      Julius Volz            2008-09-02  1462  						  ICMP_DEST_UNREACH,
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1463  						  ICMP_PORT_UNREACH, 0);
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1464  				return NF_DROP;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1465  			}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1466  		}
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1467  	}
3c5ab3f395d66a net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2017-04-29  1468  
b0e010c527de74 net/netfilter/ipvs/ip_vs_core.c Alex Gartrell          2015-08-26  1469  	IP_VS_DBG_PKT(12, af, pp, skb, iph.off,
cb59155f21d4c0 net/netfilter/ipvs/ip_vs_core.c Julian Anastasov       2010-10-17  1470  		      "ip_vs_out: packet continues traversal as normal");
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1471  	return NF_ACCEPT;
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1472  }
^1da177e4c3f41 net/ipv4/ipvs/ip_vs_core.c      Linus Torvalds         2005-04-16  1473  

:::::: The code at line 1386 was first introduced by commit
:::::: 18d6ade63c8d796c272e2b4922d649cf108d7980 ipvs: Pass ipvs not net to ip_vs_proto_data_get

:::::: TO: Eric W. Biederman <ebiederm@xmission.com>
:::::: CC: Simon Horman <horms@verge.net.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887734D7231
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 03:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCMCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 21:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiCMCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 21:41:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A637EB3A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647139249; x=1678675249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3TEMZ6JGrSqCrHXC0AsoypfXwz2WCwrOhrkmqjeajGQ=;
  b=EshXvxqMmTzGZ3ee2z6gZJsgmk7vvq8scA7iq+6ZqOWvqmLMf3A3p5aM
   C2JolwuXDseUCH7HxVQNUjad0Abop+i6SuQcaFy9qJ2AbawatN78tR0Le
   Sn5VWHgJ3WWp0SovntM6+3UErQPq91Ba3/DDVVlUogz+8AJ+Yi/9Yt6za
   ng2wlTFF8XtS7EgA1+QipfGIEwLF81P9ub8peYg7g7oeceTF6OAB6AGgX
   GOnWmO4FxV1+53D2UEEGDxpKXkBLHRTfT/ZFgwQ1Z+EjXtGH4RJpacect
   w1XbyKQcJFFv5D0t3IZ8VALn7jlwQQCSTNfxrUDX4ramH1o1y7rvkUSZ8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="243282932"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="243282932"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 18:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="645380167"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 18:40:47 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTEA2-0008Vk-D1; Sun, 13 Mar 2022 02:40:46 +0000
Date:   Sun, 13 Mar 2022 10:40:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ahern <dsahern@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dsahern:vrf-keep-orig-oif 1/2] net/xfrm/xfrm_interface.c:514:64:
 error: too few arguments to function call, expected 7, have 6
Message-ID: <202203131015.oW2gjrul-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/dsahern/linux vrf-keep-orig-oif
head:   9830d54a15a0e242fe89180d8e54fe04211abd82
commit: 038474b9858f889e59d274e2eaea63e2d3bcc00e [1/2] wip - mostly works needs to be simplified
config: hexagon-randconfig-r032-20220313 (https://download.01.org/0day-ci/archive/20220313/202203131015.oW2gjrul-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/dsahern/linux/commit/038474b9858f889e59d274e2eaea63e2d3bcc00e
        git remote add dsahern https://github.com/dsahern/linux
        git fetch --no-tags dsahern vrf-keep-orig-oif
        git checkout 038474b9858f889e59d274e2eaea63e2d3bcc00e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/xfrm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/xfrm/xfrm_interface.c:514:64: error: too few arguments to function call, expected 7, have 6
                   ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
                   ~~~~~~~~~~~~~~~                                              ^
   include/net/ip6_route.h:185:6: note: 'ip6_update_pmtu' declared here
   void ip6_update_pmtu(struct sk_buff *skb, struct net *net, __be32 mtu, int oif,
        ^
   1 error generated.


vim +514 net/xfrm/xfrm_interface.c

f203b76d78092f Steffen Klassert 2018-06-12  464  
f203b76d78092f Steffen Klassert 2018-06-12  465  static int xfrmi6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
f203b76d78092f Steffen Klassert 2018-06-12  466  		    u8 type, u8 code, int offset, __be32 info)
f203b76d78092f Steffen Klassert 2018-06-12  467  {
f203b76d78092f Steffen Klassert 2018-06-12  468  	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
f203b76d78092f Steffen Klassert 2018-06-12  469  	struct net *net = dev_net(skb->dev);
f203b76d78092f Steffen Klassert 2018-06-12  470  	int protocol = iph->nexthdr;
f203b76d78092f Steffen Klassert 2018-06-12  471  	struct ip_comp_hdr *ipch;
f203b76d78092f Steffen Klassert 2018-06-12  472  	struct ip_esp_hdr *esph;
f203b76d78092f Steffen Klassert 2018-06-12  473  	struct ip_auth_hdr *ah;
f203b76d78092f Steffen Klassert 2018-06-12  474  	struct xfrm_state *x;
f203b76d78092f Steffen Klassert 2018-06-12  475  	struct xfrm_if *xi;
f203b76d78092f Steffen Klassert 2018-06-12  476  	__be32 spi;
f203b76d78092f Steffen Klassert 2018-06-12  477  
f203b76d78092f Steffen Klassert 2018-06-12  478  	switch (protocol) {
f203b76d78092f Steffen Klassert 2018-06-12  479  	case IPPROTO_ESP:
f203b76d78092f Steffen Klassert 2018-06-12  480  		esph = (struct ip_esp_hdr *)(skb->data + offset);
f203b76d78092f Steffen Klassert 2018-06-12  481  		spi = esph->spi;
f203b76d78092f Steffen Klassert 2018-06-12  482  		break;
f203b76d78092f Steffen Klassert 2018-06-12  483  	case IPPROTO_AH:
f203b76d78092f Steffen Klassert 2018-06-12  484  		ah = (struct ip_auth_hdr *)(skb->data + offset);
f203b76d78092f Steffen Klassert 2018-06-12  485  		spi = ah->spi;
f203b76d78092f Steffen Klassert 2018-06-12  486  		break;
f203b76d78092f Steffen Klassert 2018-06-12  487  	case IPPROTO_COMP:
f203b76d78092f Steffen Klassert 2018-06-12  488  		ipch = (struct ip_comp_hdr *)(skb->data + offset);
f203b76d78092f Steffen Klassert 2018-06-12  489  		spi = htonl(ntohs(ipch->cpi));
f203b76d78092f Steffen Klassert 2018-06-12  490  		break;
f203b76d78092f Steffen Klassert 2018-06-12  491  	default:
f203b76d78092f Steffen Klassert 2018-06-12  492  		return 0;
f203b76d78092f Steffen Klassert 2018-06-12  493  	}
f203b76d78092f Steffen Klassert 2018-06-12  494  
f203b76d78092f Steffen Klassert 2018-06-12  495  	if (type != ICMPV6_PKT_TOOBIG &&
f203b76d78092f Steffen Klassert 2018-06-12  496  	    type != NDISC_REDIRECT)
f203b76d78092f Steffen Klassert 2018-06-12  497  		return 0;
f203b76d78092f Steffen Klassert 2018-06-12  498  
f203b76d78092f Steffen Klassert 2018-06-12  499  	x = xfrm_state_lookup(net, skb->mark, (const xfrm_address_t *)&iph->daddr,
f203b76d78092f Steffen Klassert 2018-06-12  500  			      spi, protocol, AF_INET6);
f203b76d78092f Steffen Klassert 2018-06-12  501  	if (!x)
f203b76d78092f Steffen Klassert 2018-06-12  502  		return 0;
f203b76d78092f Steffen Klassert 2018-06-12  503  
f203b76d78092f Steffen Klassert 2018-06-12  504  	xi = xfrmi_lookup(net, x);
f203b76d78092f Steffen Klassert 2018-06-12  505  	if (!xi) {
f203b76d78092f Steffen Klassert 2018-06-12  506  		xfrm_state_put(x);
f203b76d78092f Steffen Klassert 2018-06-12  507  		return -1;
f203b76d78092f Steffen Klassert 2018-06-12  508  	}
f203b76d78092f Steffen Klassert 2018-06-12  509  
f203b76d78092f Steffen Klassert 2018-06-12  510  	if (type == NDISC_REDIRECT)
f203b76d78092f Steffen Klassert 2018-06-12  511  		ip6_redirect(skb, net, skb->dev->ifindex, 0,
f203b76d78092f Steffen Klassert 2018-06-12  512  			     sock_net_uid(net, NULL));
f203b76d78092f Steffen Klassert 2018-06-12  513  	else
f203b76d78092f Steffen Klassert 2018-06-12 @514  		ip6_update_pmtu(skb, net, info, 0, 0, sock_net_uid(net, NULL));
f203b76d78092f Steffen Klassert 2018-06-12  515  	xfrm_state_put(x);
f203b76d78092f Steffen Klassert 2018-06-12  516  
f203b76d78092f Steffen Klassert 2018-06-12  517  	return 0;
f203b76d78092f Steffen Klassert 2018-06-12  518  }
f203b76d78092f Steffen Klassert 2018-06-12  519  

:::::: The code at line 514 was first introduced by commit
:::::: f203b76d78092faf248db3f851840fbecf80b40e xfrm: Add virtual xfrm interfaces

:::::: TO: Steffen Klassert <steffen.klassert@secunet.com>
:::::: CC: Steffen Klassert <steffen.klassert@secunet.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B695359C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbiE0HEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244763AbiE0HEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:04:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58396E2777
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653635060; x=1685171060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h6nZL9pLWIn5hicXJICcK6gt8B4QWF8L2t2kqdB3Nts=;
  b=bbMzw1XUa6bynoQI6jXrrGxahY5xapXs0ulLzLtWcW9dsLzGFLmk54UW
   v4+Rk945lKrwR5vBakBE3NY0JO9Tp8LIHKobJVyChkOVNnP0hDVHeuUq0
   FkDTdIJBUKXW4/wIuTKuX/PQsRt18ABI0umnhM/+pGlukjpmkNbCDAJqV
   ba/VyK5OxXWbkodjuM/GE5Ti4q+ZCNOvKqi3oRhR3CM3E4pl1WjaZbh8J
   pcCNUdcvP9+TYdyprUr/UUjtdhQeFxMfQ2zwd8FOJ9O8jg+zA9mnxmL+k
   XOvU7ABRTlrGDPaVyxgM41jpetIJWxv6MilKyqOGTcmjTFanYpAUSbQ0e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256475518"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="256475518"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 00:04:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="550009877"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2022 00:04:18 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuU1B-0004VO-Pz;
        Fri, 27 May 2022 07:04:17 +0000
Date:   Fri, 27 May 2022 15:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 6/11]
 net/netfilter/nf_nat_proto.c:721:25: warning: unused variable 'skb'
Message-ID: <202205271540.880v8PNJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   1baa240a3c6507449f4a3cd150dddacf69d95fb5
commit: 93d6b481397f4c62da1568b463a4d4b254578c37 [6/11] netfilter: make hook functions accept only one argument
config: i386-randconfig-a014-20211029 (https://download.01.org/0day-ci/archive/20220527/202205271540.880v8PNJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=93d6b481397f4c62da1568b463a4d4b254578c37
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 93d6b481397f4c62da1568b463a4d4b254578c37
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/netfilter/nf_nat_proto.c: In function 'nf_nat_ipv4_out':
>> net/netfilter/nf_nat_proto.c:721:25: warning: unused variable 'skb' [-Wunused-variable]
     721 |         struct sk_buff *skb = state->skb;
         |                         ^~~
   net/netfilter/nf_nat_proto.c: In function 'nf_nat_ipv6_out':
   net/netfilter/nf_nat_proto.c:960:25: warning: unused variable 'skb' [-Wunused-variable]
     960 |         struct sk_buff *skb = state->skb;
         |                         ^~~


vim +/skb +721 net/netfilter/nf_nat_proto.c

   717	
   718	static unsigned int
   719	nf_nat_ipv4_out(const struct nf_hook_state *state)
   720	{
 > 721		struct sk_buff *skb = state->skb;
   722	#ifdef CONFIG_XFRM
   723		const struct nf_conn *ct;
   724		enum ip_conntrack_info ctinfo;
   725		int err;
   726	#endif
   727		unsigned int ret;
   728	
   729		ret = nf_nat_ipv4_fn(state);
   730	#ifdef CONFIG_XFRM
   731		if (ret != NF_ACCEPT)
   732			return ret;
   733	
   734		if (IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED)
   735			return ret;
   736	
   737		ct = nf_ct_get(skb, &ctinfo);
   738		if (ct) {
   739			enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
   740	
   741			if (ct->tuplehash[dir].tuple.src.u3.ip !=
   742			     ct->tuplehash[!dir].tuple.dst.u3.ip ||
   743			    (ct->tuplehash[dir].tuple.dst.protonum != IPPROTO_ICMP &&
   744			     ct->tuplehash[dir].tuple.src.u.all !=
   745			     ct->tuplehash[!dir].tuple.dst.u.all)) {
   746				err = nf_xfrm_me_harder(state->net, skb, AF_INET);
   747				if (err < 0)
   748					ret = NF_DROP_ERR(err);
   749			}
   750		}
   751	#endif
   752		return ret;
   753	}
   754	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

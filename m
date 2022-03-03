Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE94CBCFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiCCLnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiCCLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:43:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98410F3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646307774; x=1677843774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F+m8Rx68JLtGS1ypq//Or1gja316qsP2GMXCoqYbkEc=;
  b=GkcitjTDnJNGrIkxSzGjBAnMO3e65kLneZojFC4zOXOJP+KFRg9AtC7n
   RXxXXINlJyAU+r4Gsu0zJnRtILwFgQyLEtpDv+R5zGA3USRPMVmeVDm7J
   n0E/R0MzXmL80BUvbHmGuLCBmD1sTgfJZNXNv0Ziq6jirF6vJhF/e2aD8
   YvE2RM3cUuC/unz5QJ+UavbowWm4aObFzYHwNhyF4Hc5ddchfU9u8eMCt
   /O2F7J0TwkP67TKTC1L8dc6aeDaoCO7WB2/1bXuys9kqoNoJU61az/ru+
   Pvl1r2Sz/AMHZUvsZ6QG37W/5Rfx65wEtktr5MP9igArizAupX1+xXAA+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278332633"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="278332633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="642086974"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 03:42:51 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjr9-0000S8-7I; Thu, 03 Mar 2022 11:42:51 +0000
Date:   Thu, 3 Mar 2022 19:41:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [netfilter-nf-next:master 8/12]
 net/netfilter/nf_conntrack_netlink.c:1817:15: error: implicit declaration of
 function 'nf_conn_pernet_ecache'
Message-ID: <202203031953.bHVCmKKO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git master
head:   25485ffb54ac073e82957218404e303469477c2f
commit: 78babcd3d89c2de2bc8ba688faa4f6d64d82f7ff [8/12] netfilter: conntrack: include ecache dying list in dumps
config: riscv-randconfig-r042-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031953.bHVCmKKO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=78babcd3d89c2de2bc8ba688faa4f6d64d82f7ff
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next master
        git checkout 78babcd3d89c2de2bc8ba688faa4f6d64d82f7ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_netlink.c:1817:15: error: implicit declaration of function 'nf_conn_pernet_ecache' [-Werror,-Wimplicit-function-declaration]
           ecache_net = nf_conn_pernet_ecache(net);
                        ^
>> net/netfilter/nf_conntrack_netlink.c:1817:13: warning: incompatible integer to pointer conversion assigning to 'struct nf_conntrack_net_ecache *' from 'int' [-Wint-conversion]
           ecache_net = nf_conn_pernet_ecache(net);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netfilter/nf_conntrack_netlink.c:3941:2: error: implicit declaration of function 'nf_conntrack_register_notifier' [-Werror,-Wimplicit-function-declaration]
           nf_conntrack_register_notifier(&ctnl_notifier);
           ^
   net/netfilter/nf_conntrack_netlink.c:3941:2: note: did you mean 'netlink_register_notifier'?
   include/linux/netlink.h:151:5: note: 'netlink_register_notifier' declared here
   int netlink_register_notifier(struct notifier_block *nb);
       ^
   net/netfilter/nf_conntrack_netlink.c:3941:34: error: use of undeclared identifier 'ctnl_notifier'; did you mean 'rtnl_notify'?
           nf_conntrack_register_notifier(&ctnl_notifier);
                                           ^~~~~~~~~~~~~
                                           rtnl_notify
   include/linux/rtnetlink.h:14:13: note: 'rtnl_notify' declared here
   extern void rtnl_notify(struct sk_buff *skb, struct net *net, u32 pid,
               ^
   1 warning and 3 errors generated.


vim +/nf_conn_pernet_ecache +1817 net/netfilter/nf_conntrack_netlink.c

  1802	
  1803	static int
  1804	ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
  1805	{
  1806		struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
  1807		struct nf_conntrack_net_ecache *ecache_net;
  1808		const struct net *net = sock_net(skb->sk);
  1809		struct nf_conn *last = ctx->last;
  1810		struct nf_conntrack_tuple_hash *h;
  1811		struct hlist_nulls_node *n;
  1812	
  1813		if (ctx->retrans_done)
  1814			return ctnetlink_dump_list(skb, cb, true);
  1815	
  1816		ctx->last = NULL;
> 1817		ecache_net = nf_conn_pernet_ecache(net);
  1818		spin_lock_bh(&ecache_net->dying_lock);
  1819	
  1820		hlist_nulls_for_each_entry(h, n, &ecache_net->dying_list, hnnode) {
  1821			struct nf_conn *ct;
  1822			int res;
  1823	
  1824			ct = nf_ct_tuplehash_to_ctrack(h);
  1825			if (last && last != ct)
  1826				continue;
  1827	
  1828			res = ctnetlink_dump_one_entry(skb, cb, ct, true);
  1829			if (res < 0) {
  1830				spin_unlock_bh(&ecache_net->dying_lock);
  1831				nf_ct_put(last);
  1832				return skb->len;
  1833			}
  1834	
  1835			nf_ct_put(last);
  1836			last = NULL;
  1837		}
  1838	
  1839		ctx->retrans_done = true;
  1840		spin_unlock_bh(&ecache_net->dying_lock);
  1841		nf_ct_put(last);
  1842	
  1843		return ctnetlink_dump_list(skb, cb, true);
  1844	}
  1845	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5154CBC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiCCLCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiCCLCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:02:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE31786B7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646305314; x=1677841314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y3r8Ib7tswZuhTlRizACNTSXhPpUNhhBtSN6IXXbiwM=;
  b=UB1+5QQAriOwuqHhIb82vYJ19hddfkiqGpmNEL0c1d6PpH8bGc8u5iBq
   xHRLdkOAfCR7wG70eTCxEFrOAVaEB6ZafcCa9jWgDPSk2uTli65+MC/SA
   7kr2zwJ06QX/XYcpuCWNrtDpcUWrZFl/WiOAzla4f+eVqEysuEEdPeJKE
   zbv4dtdlMhTnWhi8bVZRRbjQgcaJrzTTNAaGHpYFfnghI8H/kAu/dYnhA
   5q7LwIGnPVHeyRkPyX4EUIxjZDY6N96Q6xUQvHnwLh1av4+kSzLhAHTJ0
   Mf2BMpZbNwp6wGQBqCidEvOPV8Mcc8YU+ViRkyLLrpYhLRHDvTYLHfU3k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234256873"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="234256873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 03:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="535785161"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2022 03:01:51 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPjDS-0000Pw-EN; Thu, 03 Mar 2022 11:01:50 +0000
Date:   Thu, 3 Mar 2022 19:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [netfilter-nf-next:master 4/12]
 net/netfilter/nf_conntrack_netlink.c:3885:2: error: implicit declaration of
 function 'nf_conntrack_register_notifier'
Message-ID: <202203031802.iTj8Fo1p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git master
head:   25485ffb54ac073e82957218404e303469477c2f
commit: e999c34a878887e8413b6f728b929d668e191888 [4/12] netfilter: ctnetlink: make ecache event cb global again
config: riscv-randconfig-r042-20220303 (https://download.01.org/0day-ci/archive/20220303/202203031802.iTj8Fo1p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=e999c34a878887e8413b6f728b929d668e191888
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next master
        git checkout e999c34a878887e8413b6f728b929d668e191888
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_netlink.c:3885:2: error: implicit declaration of function 'nf_conntrack_register_notifier' [-Werror,-Wimplicit-function-declaration]
           nf_conntrack_register_notifier(&ctnl_notifier);
           ^
   net/netfilter/nf_conntrack_netlink.c:3885:2: note: did you mean 'netlink_register_notifier'?
   include/linux/netlink.h:151:5: note: 'netlink_register_notifier' declared here
   int netlink_register_notifier(struct notifier_block *nb);
       ^
>> net/netfilter/nf_conntrack_netlink.c:3885:34: error: use of undeclared identifier 'ctnl_notifier'; did you mean 'rtnl_notify'?
           nf_conntrack_register_notifier(&ctnl_notifier);
                                           ^~~~~~~~~~~~~
                                           rtnl_notify
   include/linux/rtnetlink.h:14:13: note: 'rtnl_notify' declared here
   extern void rtnl_notify(struct sk_buff *skb, struct net *net, u32 pid,
               ^
   2 errors generated.


vim +/nf_conntrack_register_notifier +3885 net/netfilter/nf_conntrack_netlink.c

  3866	
  3867	static int __init ctnetlink_init(void)
  3868	{
  3869		int ret;
  3870	
  3871		BUILD_BUG_ON(sizeof(struct ctnetlink_list_dump_ctx) > sizeof_field(struct netlink_callback, ctx));
  3872	
  3873		ret = nfnetlink_subsys_register(&ctnl_subsys);
  3874		if (ret < 0) {
  3875			pr_err("ctnetlink_init: cannot register with nfnetlink.\n");
  3876			goto err_out;
  3877		}
  3878	
  3879		ret = nfnetlink_subsys_register(&ctnl_exp_subsys);
  3880		if (ret < 0) {
  3881			pr_err("ctnetlink_init: cannot register exp with nfnetlink.\n");
  3882			goto err_unreg_subsys;
  3883		}
  3884	
> 3885		nf_conntrack_register_notifier(&ctnl_notifier);
  3886	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

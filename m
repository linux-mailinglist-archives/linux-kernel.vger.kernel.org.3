Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A153D8E9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiFEAr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 20:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiFEAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 20:47:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE22314D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390043; x=1685926043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fnbcv66SeQAd1at2MtK+QImZYF52AxEOjsIR5CMdfUA=;
  b=ngkmGMttTIXDbdMWE+s0ePBju1jmuOvWCPHoXrckX+Dk+PtLLvsjzY5h
   UPC6XHBbdbF+0p/5/vgwkdcV1m0hrORW+lBxph/kNMOlW+wIPbA868iwB
   9jXPYZw9UuEE81hveIjOTOjhNfCi5eUagp8T+OhtVfbA7P+/rL0R4zq0c
   q7lm6H7R+F0XgyATz6h13URJ9BLWmUskWezx6Nouh9gIUMpSRa1J+Du4u
   KFguozKE79MbGQyIGChvQNmGjIHwmfmNbcsbmD0bmeB6Blwf7a+g5zxxL
   8v69x8hRnOfvtGqeQBMiiEv6zQpxEGkEetaG/ff/TGPfJ9VC4ok4x/HMS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256359814"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256359814"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="757983683"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2022 17:47:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxeQH-000BJR-Q2;
        Sun, 05 Jun 2022 00:47:17 +0000
Date:   Sun, 5 Jun 2022 08:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Brian Vazquez <brianvv@google.com>
Subject: net/core/dev.c:10290:18: sparse: sparse: cast removes address space
 '__percpu' of expression
Message-ID: <202206050845.IJUsAUy8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d0e60d46bc03252b8d4ffaaaa0b371970ac16cda
commit: 625788b5844511cf4c30cffa7fa0bc3a69cebc82 net: add per-cpu storage and net->core_stats
date:   3 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220605/202206050845.IJUsAUy8-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=625788b5844511cf4c30cffa7fa0bc3a69cebc82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 625788b5844511cf4c30cffa7fa0bc3a69cebc82
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3254:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3254:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3254:23: sparse:     got unsigned int
   net/core/dev.c:3254:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:10290:18: sparse: sparse: cast removes address space '__percpu' of expression
   net/core/dev.c:3759:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:4961:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block

vim +/__percpu +10290 net/core/dev.c

 10282	
 10283	struct net_device_core_stats *netdev_core_stats_alloc(struct net_device *dev)
 10284	{
 10285		struct net_device_core_stats __percpu *p;
 10286	
 10287		p = alloc_percpu_gfp(struct net_device_core_stats,
 10288				     GFP_ATOMIC | __GFP_NOWARN);
 10289	
 10290		if (p && cmpxchg(&dev->core_stats, NULL, p))
 10291			free_percpu(p);
 10292	
 10293		/* This READ_ONCE() pairs with the cmpxchg() above */
 10294		p = READ_ONCE(dev->core_stats);
 10295		if (!p)
 10296			return NULL;
 10297	
 10298		return this_cpu_ptr(p);
 10299	}
 10300	EXPORT_SYMBOL(netdev_core_stats_alloc);
 10301	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

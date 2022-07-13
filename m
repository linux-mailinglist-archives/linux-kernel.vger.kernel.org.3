Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71CE573AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiGMPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiGMPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:55:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E944E852
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657727716; x=1689263716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OJYgszKDoNAcc0vzhgDLq9HJwqVYguHdW9WNBKVVEU4=;
  b=h3c1LbjOIQV1Zy5Cf0GGvMDcMonSH1MYOeEkTzjORJY3BPpTQ5xLVsM4
   oaHhOJVtwl62p/5OWW53VxKy5reiQYE9AA7WuSMuK5i8iBfjm+FmYhhxi
   phIWB9QwsmWpsy5bzHJE5U9LkngV6X6x7PR+UB3C7CXXnBnSU9HoN8grs
   6dN4fofyeGX4N0GJ5f3EEiWkHPiCwPTwAn4+CL56Rq5HYrnrigJ0qHUWi
   HEdc0M7VK1aSEn0hYO7HuF0IWGF6ncvTUQovXz3hcu30FDKJqsG2kBMal
   vnegTXMJYezY9DoE0z/XBU+atEwOSyrzz4YHDBexF/oNWpgliiryh05w+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="268297325"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="268297325"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 08:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="545903814"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2022 08:49:02 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBebm-0003dP-6X;
        Wed, 13 Jul 2022 15:49:02 +0000
Date:   Wed, 13 Jul 2022 23:48:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Brian Vazquez <brianvv@google.com>
Subject: net/core/dev.c:10290:18: sparse: sparse: cast removes address space
 '__percpu' of expression
Message-ID: <202207132315.QFxcZZNI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b047602d579b4fb028128a525f056bbdc890e7f0
commit: 625788b5844511cf4c30cffa7fa0bc3a69cebc82 net: add per-cpu storage and net->core_stats
date:   4 months ago
config: riscv-randconfig-s032-20220713 (https://download.01.org/0day-ci/archive/20220713/202207132315.QFxcZZNI-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
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

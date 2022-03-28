Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EFA4E8E38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiC1GbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiC1GbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:31:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7A1162
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648448973; x=1679984973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mCUg0G2v9xFHuX6jFEwIq91SRiCp6hnBE4YhBVhE4X4=;
  b=AeKX+Dm+qeX2Ljio4WvARWW+7aDBypW+1/nfjNe3BhuYGUrSx+TeMj19
   EOkecmpo7BJ8IXhA6S2fYHIh6VpdAuj7Xzv3bgzciVXQ87CPesKdTlY/x
   Ixqpfx0ewiUjcvKjjADuIrXSASjlmfCFk0aDvhluGqRCCoUJ6Y6YEKgqP
   QQOh5/ZY4uPO9F3UZDxP1LEn94Z6tHI5yoBVMEYmikXrQtDg/F5nr/USY
   o1l+ASXPQ8xzcqrf2Unyvg9wLPZYPnSoWTxFSvW0wguyGi5aE8qepJb9Y
   igriUKapd8cZ35qG9XsQ42/lU51PZhLuNW94jIs6pohfTqQ6vW19wrsUQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="259109676"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="259109676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 23:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="718983513"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2022 23:29:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYisc-0001ms-PD; Mon, 28 Mar 2022 06:29:30 +0000
Date:   Mon, 28 Mar 2022 14:28:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Brian Vazquez <brianvv@google.com>
Subject: net/core/dev.c:10290:18: sparse: sparse: cast removes address space
 '__percpu' of expression
Message-ID: <202203281436.hsNgYWWu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: 625788b5844511cf4c30cffa7fa0bc3a69cebc82 net: add per-cpu storage and net->core_stats
date:   2 weeks ago
config: riscv-randconfig-s032-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281436.hsNgYWWu-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=625788b5844511cf4c30cffa7fa0bc3a69cebc82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 625788b5844511cf4c30cffa7fa0bc3a69cebc82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C157F57B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiGXOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 10:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiGXOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 10:18:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD013CFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658672284; x=1690208284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r25DWjiX7sbnAPxb+ZFv2bzJI+SP4JHE3swdFz26Eg8=;
  b=bJEIhFLl0HWtbaTaICqLcEnOS04n3P+pN+dV3kds+wN5xU+K0VtCy0xU
   HwT7+fIObcmjGOo8JYJ5LeCqs5c+R7Xhwd4JwzMtkw/pMG2LFdFZ/aL6o
   4pdHfKFjFbbKmYmtApRl5NbI3UktQZg8rqeaK0oOr1DMUQ/lfe/Qg2LYN
   NgK4XwxWaOwDQlnyRJbY+38fucMUKHmkWsTJnwzfthVfgi4LRwWm0tIAE
   ZHNwWTqviSOv5gX1y8OA1s1pWIo5xVuKX03d0+d5saVrU0aex2doxbeFp
   B73aaF7z1JMADz+j1qOgM1UAf0/RmsnAXmEzAmP4CsOAxSQFz7c8STm8H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373851607"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="373851607"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 07:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926591677"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 07:18:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFcQk-0003uj-0S;
        Sun, 24 Jul 2022 14:18:02 +0000
Date:   Sun, 24 Jul 2022 22:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/percpu.c:3007:59: warning: the comparison will always evaluate as
 'true' for the address of 'pglist' will never be NULL
Message-ID: <202207242252.HNteQE9R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 23f917169ef157aa7a6bf80d8c4aad6f1282852c mm: percpu: add generic pcpu_fc_alloc/free funciton
date:   6 months ago
config: mips-buildonly-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220724/202207242252.HNteQE9R-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23f917169ef157aa7a6bf80d8c4aad6f1282852c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 23f917169ef157aa7a6bf80d8c4aad6f1282852c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/percpu.c: In function 'pcpu_fc_alloc':
>> mm/percpu.c:3007:59: warning: the comparison will always evaluate as 'true' for the address of 'pglist' will never be NULL [-Waddress]
    3007 |         if (node == NUMA_NO_NODE || !node_online(node) || !NODE_DATA(node)) {
         |                                                           ^
   In file included from arch/mips/include/asm/mmzone.h:12,
                    from include/linux/mmzone.h:1099,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/memblock.h:13,
                    from mm/percpu.c:73:
   arch/mips/include/asm/mach-ip27/mmzone.h:19:28: note: 'pglist' declared here
      19 |         struct pglist_data pglist;
         |                            ^~~~~~


vim +3007 mm/percpu.c

  2995	
  2996	static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align,
  2997					   pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
  2998	{
  2999		const unsigned long goal = __pa(MAX_DMA_ADDRESS);
  3000	#ifdef CONFIG_NUMA
  3001		int node = NUMA_NO_NODE;
  3002		void *ptr;
  3003	
  3004		if (cpu_to_nd_fn)
  3005			node = cpu_to_nd_fn(cpu);
  3006	
> 3007		if (node == NUMA_NO_NODE || !node_online(node) || !NODE_DATA(node)) {
  3008			ptr = memblock_alloc_from(size, align, goal);
  3009			pr_info("cpu %d has no node %d or node-local memory\n",
  3010				cpu, node);
  3011			pr_debug("per cpu data for cpu%d %zu bytes at 0x%llx\n",
  3012				 cpu, size, (u64)__pa(ptr));
  3013		} else {
  3014			ptr = memblock_alloc_try_nid(size, align, goal,
  3015						     MEMBLOCK_ALLOC_ACCESSIBLE,
  3016						     node);
  3017	
  3018			pr_debug("per cpu data for cpu%d %zu bytes on node%d at 0x%llx\n",
  3019				 cpu, size, node, (u64)__pa(ptr));
  3020		}
  3021		return ptr;
  3022	#else
  3023		return memblock_alloc_from(size, align, goal);
  3024	#endif
  3025	}
  3026	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30C4E6A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355158AbiCXVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355147AbiCXVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:21:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF06580ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648156797; x=1679692797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D8sPrOjiIKGdUQKHrNVyVsbnrKxhLjYhxLtXX7edhCI=;
  b=Qgj/EadZRO1KmUv1TQS7iZUtfuOg7fRMqPLYdXuMZ0cXX1yUlgbp/rKW
   qCD7H9kWnrYrwyL3kmdgzj/Ds8MPvtwCBk4cD/CXMy5BuMbaWPaLgbmBC
   ilm9ZwwB9WJ4A0MlAJWaqy71gJfnPr2hiWjQG00ZVmyKzxErpA/jpKTqQ
   7pG7aXF4DRxAUHbsLU9E2Cqm0cyN0ZwkVFXtQwqu3LwfACUHT4fOdR7zX
   CBPg4HcUX4OIf2jjFvfGkOSaA5MIpo4S0qKn2t8E3vR1iBy7K9CrHzi1o
   Eg5tzJvhuDYcDJ3i7ygixCuDmKUHOy97u31ymDImtk5huTg/GbhpuM6Vh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283358908"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="283358908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 14:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="717979796"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 14:19:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXUs6-000LRy-Cs; Thu, 24 Mar 2022 21:19:54 +0000
Date:   Fri, 25 Mar 2022 05:19:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used
Message-ID: <202203250552.DbRtnNEv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed4643521e6af8ab8ed1e467630a85884d2696cf
commit: bb192ed9aa7191a5d65548f82c42b6750d65f569 mm/slub: Convert most struct page to struct slab by spatch
date:   3 months ago
config: mips-buildonly-randconfig-r004-20220324 (https://download.01.org/0day-ci/archive/20220325/202203250552.DbRtnNEv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb192ed9aa7191a5d65548f82c42b6750d65f569
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bb192ed9aa7191a5d65548f82c42b6750d65f569
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used [-Wunused-but-set-variable]
           unsigned int partial_slabs = 0;
                        ^
   mm/slub.c:1663:29: warning: unused function 'node_nr_slabs' [-Wunused-function]
   static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
                               ^
   mm/slub.c:1681:21: warning: unused function 'kmalloc_large_node_hook' [-Wunused-function]
   static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
                       ^
   3 warnings generated.


vim +/partial_slabs +2142 mm/slub.c

  2132	
  2133	/*
  2134	 * Try to allocate a partial slab from a specific node.
  2135	 */
  2136	static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  2137				      struct slab **ret_slab, gfp_t gfpflags)
  2138	{
  2139		struct slab *slab, *slab2;
  2140		void *object = NULL;
  2141		unsigned long flags;
> 2142		unsigned int partial_slabs = 0;
  2143	
  2144		/*
  2145		 * Racy check. If we mistakenly see no partial slabs then we
  2146		 * just allocate an empty slab. If we mistakenly try to get a
  2147		 * partial slab and there is none available then get_partial()
  2148		 * will return NULL.
  2149		 */
  2150		if (!n || !n->nr_partial)
  2151			return NULL;
  2152	
  2153		spin_lock_irqsave(&n->list_lock, flags);
  2154		list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
  2155			void *t;
  2156	
  2157			if (!pfmemalloc_match(slab, gfpflags))
  2158				continue;
  2159	
  2160			t = acquire_slab(s, n, slab, object == NULL);
  2161			if (!t)
  2162				break;
  2163	
  2164			if (!object) {
  2165				*ret_slab = slab;
  2166				stat(s, ALLOC_FROM_PARTIAL);
  2167				object = t;
  2168			} else {
  2169				put_cpu_partial(s, slab, 0);
  2170				stat(s, CPU_PARTIAL_NODE);
  2171				partial_slabs++;
  2172			}
  2173	#ifdef CONFIG_SLUB_CPU_PARTIAL
  2174			if (!kmem_cache_has_cpu_partial(s)
  2175				|| partial_slabs > s->cpu_partial_slabs / 2)
  2176				break;
  2177	#else
  2178			break;
  2179	#endif
  2180	
  2181		}
  2182		spin_unlock_irqrestore(&n->list_lock, flags);
  2183		return object;
  2184	}
  2185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

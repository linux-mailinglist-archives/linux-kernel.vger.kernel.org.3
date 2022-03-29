Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF54EA6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiC2FBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiC2FBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:01:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062A2487B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648529998; x=1680065998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3DmyMMVrm4meu3ZhVmr9v7FNsG2hasc0VDYGmM2qrek=;
  b=HxovxLUUR7cXBxSgYdkx0WYjymenwJ5UBGak0S7Rtv/yOwhklRG/vJGP
   8/lc+BNGVnYBXT+msuW1OMMUEOeUQih6qw65UU3rGDf4vPCEH9w/D5Yzm
   du309CCyEAw0UWhaHDrh67qXRkT/c+fCmNCuTubEoZ7A6l/lYjYG5XOP4
   VMiVqlJn4Pz1rWkIgF/UGP4PnOZZuJ7UjRI9yNcE/5VNz8Im3nAQbgEBS
   HFwCkPgprQxxQ971EiKOhItTFLPGH9RQ6bzdLyIqHug7Gy+Ysc31or2gU
   ZTQhma9Sn5/G5jlNiesNMLqWgl2W0e67QE0d2ihnvy4EqMWpjs27VQe6a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239757532"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239757532"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 21:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="546236550"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2022 21:59:55 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ3xS-0002fd-VY; Tue, 29 Mar 2022 04:59:54 +0000
Date:   Tue, 29 Mar 2022 12:59:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peifeng Li <lipeifeng@oppo.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-kiwi-5.10
 9998/9999] mm/vmscan.c:673:15: warning: no previous prototype for function
 'shrink_slab'
Message-ID: <202203291216.x17ha1nQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-kiwi-5.10
head:   9c6bdae16301919fcab74129dee1083eba844952
commit: 71d560e017415ead361cfc10cc50ef36a0545cc2 [9998/9999] ANDROID: vendor_hooks: export shrink_slab
config: i386-randconfig-a012-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291216.x17ha1nQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/71d560e017415ead361cfc10cc50ef36a0545cc2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-kiwi-5.10
        git checkout 71d560e017415ead361cfc10cc50ef36a0545cc2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/vmscan.c:673:15: warning: no previous prototype for function 'shrink_slab' [-Wmissing-prototypes]
   unsigned long shrink_slab(gfp_t gfp_mask, int nid,
                 ^
   mm/vmscan.c:673:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long shrink_slab(gfp_t gfp_mask, int nid,
   ^
   static 
   1 warning generated.


vim +/shrink_slab +673 mm/vmscan.c

   652	
   653	/**
   654	 * shrink_slab - shrink slab caches
   655	 * @gfp_mask: allocation context
   656	 * @nid: node whose slab caches to target
   657	 * @memcg: memory cgroup whose slab caches to target
   658	 * @priority: the reclaim priority
   659	 *
   660	 * Call the shrink functions to age shrinkable caches.
   661	 *
   662	 * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
   663	 * unaware shrinkers will receive a node id of 0 instead.
   664	 *
   665	 * @memcg specifies the memory cgroup to target. Unaware shrinkers
   666	 * are called only if it is the root cgroup.
   667	 *
   668	 * @priority is sc->priority, we take the number of objects and >> by priority
   669	 * in order to get the scan target.
   670	 *
   671	 * Returns the number of reclaimed slab objects.
   672	 */
 > 673	unsigned long shrink_slab(gfp_t gfp_mask, int nid,
   674					 struct mem_cgroup *memcg,
   675					 int priority)
   676	{
   677		unsigned long ret, freed = 0;
   678		struct shrinker *shrinker;
   679		bool bypass = false;
   680	
   681		trace_android_vh_shrink_slab_bypass(gfp_mask, nid, memcg, priority, &bypass);
   682		if (bypass)
   683			return 0;
   684	
   685		/*
   686		 * The root memcg might be allocated even though memcg is disabled
   687		 * via "cgroup_disable=memory" boot parameter.  This could make
   688		 * mem_cgroup_is_root() return false, then just run memcg slab
   689		 * shrink, but skip global shrink.  This may result in premature
   690		 * oom.
   691		 */
   692		if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
   693			return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
   694	
   695		if (!down_read_trylock(&shrinker_rwsem))
   696			goto out;
   697	
   698		list_for_each_entry(shrinker, &shrinker_list, list) {
   699			struct shrink_control sc = {
   700				.gfp_mask = gfp_mask,
   701				.nid = nid,
   702				.memcg = memcg,
   703			};
   704	
   705			ret = do_shrink_slab(&sc, shrinker, priority);
   706			if (ret == SHRINK_EMPTY)
   707				ret = 0;
   708			freed += ret;
   709			/*
   710			 * Bail out if someone want to register a new shrinker to
   711			 * prevent the registration from being stalled for long periods
   712			 * by parallel ongoing shrinking.
   713			 */
   714			if (rwsem_is_contended(&shrinker_rwsem)) {
   715				freed = freed ? : 1;
   716				break;
   717			}
   718		}
   719	
   720		up_read(&shrinker_rwsem);
   721	out:
   722		cond_resched();
   723		return freed;
   724	}
   725	EXPORT_SYMBOL_GPL(shrink_slab);
   726	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

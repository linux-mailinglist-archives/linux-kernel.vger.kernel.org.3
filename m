Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03553F373
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiFGBpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFGBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:45:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852D98754
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654566338; x=1686102338;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=961pAuhKqRvTk5Rh3Hpt2dVquDp8eG+F/18I15kl+/0=;
  b=ST1GqJRkdy0SsbqcDc2giVmpjna3EBZHzM2EfO4zv5Ck8JZnGmfMMfbN
   gcELdwQRp9u1JFDdwcNkHVviPkKAnqRSPOV2QI66fMOvaq5FHf1LIfXg2
   fsazScVhhe8acxewECCsFAawBvmMhwPgvS2kwF5nEYEZUgFtmNxeijNsK
   bJA+9hQETuW1pPXVZbzjBBhWr2qWyzW06PVZYffg0nyP3HuqDFBfQW+Gu
   HjAspz5ESDKDrCrpgD+ulN1KEuiDLpAUEE/tSPniCoodTKT2BUtLTlDBr
   S4A3TuxI5/zb75lWumCwWuwZmJcedhf1Szc0BgyN5wGlKzjgiDnaEBGxu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259280328"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="259280328"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="583957880"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2022 18:45:36 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyOHn-000DDR-Tx;
        Tue, 07 Jun 2022 01:45:35 +0000
Date:   Tue, 7 Jun 2022 09:44:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:cpumask 1/2] include/linux/slab.h:608:46: error: conflicting
 types for 'kmalloc_node'; have 'void *(size_t,  gfp_t,  int)' {aka 'void
 *(unsigned int,  unsigned int,  int)'}
Message-ID: <202206070941.bncwkp2B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux cpumask
head:   baf4c0c7943ff03b66ab7c18550df9071b5ba097
commit: 4fb0cdef75eb28ca37159b5c208ef574d6ccba98 [1/2] move cpumask
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220607/202206070941.bncwkp2B-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/4fb0cdef75eb28ca37159b5c208ef574d6ccba98
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov cpumask
        git checkout 4fb0cdef75eb28ca37159b5c208ef574d6ccba98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/cpumask.h: In function 'alloc_cpumask_var_node':
   include/linux/cpumask.h:812:17: error: implicit declaration of function 'kmalloc_node'; did you mean 'bitmap_alloc_node'? [-Werror=implicit-function-declaration]
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |                 ^~~~~~~~~~~~
         |                 bitmap_alloc_node
   include/linux/cpumask.h:812:15: warning: assignment to 'cpumask_var_t' {aka 'struct cpumask *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |               ^
   include/linux/cpumask.h: In function 'alloc_cpumask_var':
   include/linux/cpumask.h:836:52: error: 'NUMA_NO_NODE' undeclared (first use in this function)
     836 |         return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
         |                                                    ^~~~~~~~~~~~
   include/linux/cpumask.h:836:52: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/cpumask.h: In function 'zalloc_cpumask_var_node':
   include/linux/cpumask.h:841:53: error: '__GFP_ZERO' undeclared (first use in this function)
     841 |         return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
         |                                                     ^~~~~~~~~~
   include/linux/cpumask.h: In function 'zalloc_cpumask_var':
   include/linux/cpumask.h:846:48: error: '__GFP_ZERO' undeclared (first use in this function)
     846 |         return alloc_cpumask_var(mask, flags | __GFP_ZERO);
         |                                                ^~~~~~~~~~
   include/linux/cpumask.h: In function 'alloc_bootmem_cpumask_var':
   include/linux/cpumask.h:860:17: error: implicit declaration of function 'memblock_alloc' [-Werror=implicit-function-declaration]
     860 |         *mask = memblock_alloc(cpumask_size(), SMP_CACHE_BYTES);
         |                 ^~~~~~~~~~~~~~
   include/linux/cpumask.h:860:15: warning: assignment to 'cpumask_var_t' {aka 'struct cpumask *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     860 |         *mask = memblock_alloc(cpumask_size(), SMP_CACHE_BYTES);
         |               ^
   include/linux/cpumask.h: In function 'free_cpumask_var':
   include/linux/cpumask.h:874:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
     874 |         kfree(mask);
         |         ^~~~~
   include/linux/cpumask.h: In function 'free_bootmem_cpumask_var':
   include/linux/cpumask.h:883:9: error: implicit declaration of function 'memblock_free' [-Werror=implicit-function-declaration]
     883 |         memblock_free(mask, cpumask_size());
         |         ^~~~~~~~~~~~~
   In file included from include/linux/fs.h:45,
                    from include/linux/compat.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/slab.h: At top level:
   include/linux/slab.h:188:6: warning: conflicting types for 'kfree'; have 'void(const void *)'
     188 | void kfree(const void *objp);
         |      ^~~~~
   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/cpumask.h:874:9: note: previous implicit declaration of 'kfree' with type 'void(const void *)'
     874 |         kfree(mask);
         |         ^~~~~
   In file included from include/linux/fs.h:45,
                    from include/linux/compat.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> include/linux/slab.h:608:46: error: conflicting types for 'kmalloc_node'; have 'void *(size_t,  gfp_t,  int)' {aka 'void *(unsigned int,  unsigned int,  int)'}
     608 | static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
         |                                              ^~~~~~~~~~~~
   In file included from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/cpumask.h:812:17: note: previous implicit declaration of 'kmalloc_node' with type 'int()'
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +608 include/linux/slab.h

ce6a50263d4ddeb Christoph Lameter 2013-01-10  607  
c37495d6254c237 Kees Cook         2021-11-05 @608  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
f1b6eb6e6be149b Christoph Lameter 2013-09-04  609  {
f1b6eb6e6be149b Christoph Lameter 2013-09-04  610  #ifndef CONFIG_SLOB
f1b6eb6e6be149b Christoph Lameter 2013-09-04  611  	if (__builtin_constant_p(size) &&
cc252eae85e0955 Vlastimil Babka   2018-10-26  612  		size <= KMALLOC_MAX_CACHE_SIZE) {
36071a279b4100a Alexey Dobriyan   2018-04-05  613  		unsigned int i = kmalloc_index(size);
f1b6eb6e6be149b Christoph Lameter 2013-09-04  614  
f1b6eb6e6be149b Christoph Lameter 2013-09-04  615  		if (!i)
f1b6eb6e6be149b Christoph Lameter 2013-09-04  616  			return ZERO_SIZE_PTR;
f1b6eb6e6be149b Christoph Lameter 2013-09-04  617  
cc252eae85e0955 Vlastimil Babka   2018-10-26  618  		return kmem_cache_alloc_node_trace(
cc252eae85e0955 Vlastimil Babka   2018-10-26  619  				kmalloc_caches[kmalloc_type(flags)][i],
f1b6eb6e6be149b Christoph Lameter 2013-09-04  620  						flags, node, size);
f1b6eb6e6be149b Christoph Lameter 2013-09-04  621  	}
f1b6eb6e6be149b Christoph Lameter 2013-09-04  622  #endif
f1b6eb6e6be149b Christoph Lameter 2013-09-04  623  	return __kmalloc_node(size, flags, node);
f1b6eb6e6be149b Christoph Lameter 2013-09-04  624  }
f1b6eb6e6be149b Christoph Lameter 2013-09-04  625  

:::::: The code at line 608 was first introduced by commit
:::::: c37495d6254c237578db3121dcf79857e033f8ff slab: add __alloc_size attributes for better bounds checking

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

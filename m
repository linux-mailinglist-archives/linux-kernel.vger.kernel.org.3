Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D653F2D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiFFXxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiFFXxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:53:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E712BA9A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654559616; x=1686095616;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u/6OKKSRKuHfpmc056RieSVosnvmkPkqafvE6/QeA3Y=;
  b=cNPC7j12sfiaW72WwtiSr0Sh52VyQsVtA2fzqjUgape9qFcHqn5Vfy0J
   rgQ4HGuJSPFz5RmUkNjH8ajCrWI+HYfYIUj5oM2Gsb4pIS8KBmOO414la
   EVenB4STbiA4ejNHSgDUuOZz0b8YVxM3Ax1F4/12km3dsd334hnTnREVE
   c66bIezW8+oAu7OBeadDkF2y20vbPm8VYsLrVilMenrFmH8KczQkOvu8V
   Zhn0uz1zVhsTBXRR6vdPQrw7gQbQ38htfa6dMU3rGFmP2oscTUDxcEDBr
   ZfiYPAwvgtTjF1NAehczxeRsL7b/mQEz7A/a4X059JnZYwWyM2fUEe86P
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363043595"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="363043595"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 16:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="608961791"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2022 16:53:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyMXM-000D93-9E;
        Mon, 06 Jun 2022 23:53:32 +0000
Date:   Tue, 7 Jun 2022 07:52:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:cpumask 1/2] include/linux/cpumask.h:812:17: error: implicit
 declaration of function 'kmalloc_node'; did you mean 'bitmap_alloc_node'?
Message-ID: <202206070725.plGxIFpd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux cpumask
head:   baf4c0c7943ff03b66ab7c18550df9071b5ba097
commit: 4fb0cdef75eb28ca37159b5c208ef574d6ccba98 [1/2] move cpumask
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220607/202206070725.plGxIFpd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/norov/linux/commit/4fb0cdef75eb28ca37159b5c208ef574d6ccba98
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov cpumask
        git checkout 4fb0cdef75eb28ca37159b5c208ef574d6ccba98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/cpumask.h: In function 'alloc_cpumask_var_node':
>> include/linux/cpumask.h:812:17: error: implicit declaration of function 'kmalloc_node'; did you mean 'bitmap_alloc_node'? [-Werror=implicit-function-declaration]
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |                 ^~~~~~~~~~~~
         |                 bitmap_alloc_node
>> include/linux/cpumask.h:812:15: warning: assignment to 'cpumask_var_t' {aka 'struct cpumask *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |               ^
   include/linux/cpumask.h: In function 'alloc_cpumask_var':
>> include/linux/cpumask.h:836:52: error: 'NUMA_NO_NODE' undeclared (first use in this function)
     836 |         return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
         |                                                    ^~~~~~~~~~~~
   include/linux/cpumask.h:836:52: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/cpumask.h: In function 'zalloc_cpumask_var_node':
>> include/linux/cpumask.h:841:53: error: '__GFP_ZERO' undeclared (first use in this function)
     841 |         return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
         |                                                     ^~~~~~~~~~
   include/linux/cpumask.h: In function 'zalloc_cpumask_var':
   include/linux/cpumask.h:846:48: error: '__GFP_ZERO' undeclared (first use in this function)
     846 |         return alloc_cpumask_var(mask, flags | __GFP_ZERO);
         |                                                ^~~~~~~~~~
   include/linux/cpumask.h: In function 'alloc_bootmem_cpumask_var':
>> include/linux/cpumask.h:860:17: error: implicit declaration of function 'memblock_alloc' [-Werror=implicit-function-declaration]
     860 |         *mask = memblock_alloc(cpumask_size(), SMP_CACHE_BYTES);
         |                 ^~~~~~~~~~~~~~
>> include/linux/cpumask.h:860:48: error: 'SMP_CACHE_BYTES' undeclared (first use in this function); did you mean 'L1_CACHE_BYTES'?
     860 |         *mask = memblock_alloc(cpumask_size(), SMP_CACHE_BYTES);
         |                                                ^~~~~~~~~~~~~~~
         |                                                L1_CACHE_BYTES
   include/linux/cpumask.h: In function 'free_cpumask_var':
>> include/linux/cpumask.h:874:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
     874 |         kfree(mask);
         |         ^~~~~
   include/linux/cpumask.h: In function 'free_bootmem_cpumask_var':
>> include/linux/cpumask.h:883:9: error: implicit declaration of function 'memblock_free' [-Werror=implicit-function-declaration]
     883 |         memblock_free(mask, cpumask_size());
         |         ^~~~~~~~~~~~~
   In file included from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/slab.h: At top level:
>> include/linux/slab.h:188:6: warning: conflicting types for 'kfree'; have 'void(const void *)'
     188 | void kfree(const void *objp);
         |      ^~~~~
   In file included from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/cpumask.h:874:9: note: previous implicit declaration of 'kfree' with type 'void(const void *)'
     874 |         kfree(mask);
         |         ^~~~~
   In file included from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/slab.h:608:46: error: conflicting types for 'kmalloc_node'; have 'void *(size_t,  gfp_t,  int)' {aka 'void *(long unsigned int,  unsigned int,  int)'}
     608 | static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
         |                                              ^~~~~~~~~~~~
   In file included from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/cpumask.h:812:17: note: previous implicit declaration of 'kmalloc_node' with type 'int()'
     812 |         *mask = kmalloc_node(cpumask_size(), flags, node);
         |                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +812 include/linux/cpumask.h

   795	
   796	/**
   797	 * alloc_cpumask_var_node - allocate a struct cpumask on a given node
   798	 * @mask: pointer to cpumask_var_t where the cpumask is returned
   799	 * @flags: GFP_ flags
   800	 *
   801	 * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
   802	 * a nop returning a constant 1 (in <linux/cpumask.h>)
   803	 * Returns TRUE if memory allocation succeeded, FALSE otherwise.
   804	 *
   805	 * In addition, mask will be NULL if this fails.  Note that gcc is
   806	 * usually smart enough to know that mask can never be NULL if
   807	 * CONFIG_CPUMASK_OFFSTACK=n, so does code elimination in that case
   808	 * too.
   809	 */
   810	static inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
   811	{
 > 812		*mask = kmalloc_node(cpumask_size(), flags, node);
   813	
   814	#ifdef CONFIG_DEBUG_PER_CPU_MAPS
   815		if (!*mask) {
   816			printk(KERN_ERR "=> alloc_cpumask_var: failed!\n");
   817			dump_stack();
   818		}
   819	#endif
   820	
   821		return *mask != NULL;
   822	}
   823	
   824	/**
   825	 * alloc_cpumask_var - allocate a struct cpumask
   826	 * @mask: pointer to cpumask_var_t where the cpumask is returned
   827	 * @flags: GFP_ flags
   828	 *
   829	 * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
   830	 * a nop returning a constant 1 (in <linux/cpumask.h>).
   831	 *
   832	 * See alloc_cpumask_var_node.
   833	 */
   834	static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
   835	{
 > 836		return alloc_cpumask_var_node(mask, flags, NUMA_NO_NODE);
   837	}
   838	
   839	static inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
   840	{
 > 841		return alloc_cpumask_var_node(mask, flags | __GFP_ZERO, node);
   842	}
   843	
   844	static inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
   845	{
   846		return alloc_cpumask_var(mask, flags | __GFP_ZERO);
   847	}
   848	
   849	/**
   850	 * alloc_bootmem_cpumask_var - allocate a struct cpumask from the bootmem arena.
   851	 * @mask: pointer to cpumask_var_t where the cpumask is returned
   852	 *
   853	 * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
   854	 * a nop (in <linux/cpumask.h>).
   855	 * Either returns an allocated (zero-filled) cpumask, or causes the
   856	 * system to panic.
   857	 */
   858	static inline void __init alloc_bootmem_cpumask_var(cpumask_var_t *mask)
   859	{
 > 860		*mask = memblock_alloc(cpumask_size(), SMP_CACHE_BYTES);
   861		if (!*mask)
   862			panic("%s: Failed to allocate %u bytes\n", __func__,
   863			      cpumask_size());
   864	}
   865	
   866	/**
   867	 * free_cpumask_var - frees memory allocated for a struct cpumask.
   868	 * @mask: cpumask to free
   869	 *
   870	 * This is safe on a NULL mask.
   871	 */
   872	static inline void free_cpumask_var(cpumask_var_t mask)
   873	{
 > 874		kfree(mask);
   875	}
   876	
   877	/**
   878	 * free_bootmem_cpumask_var - frees result of alloc_bootmem_cpumask_var
   879	 * @mask: cpumask to free
   880	 */
   881	static inline void __init free_bootmem_cpumask_var(cpumask_var_t mask)
   882	{
 > 883		memblock_free(mask, cpumask_size());
   884	}
   885	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

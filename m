Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D952A302
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347358AbiEQNQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbiEQNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:15:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A8C15
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652793343; x=1684329343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8mWjW4yAnDCSLkP6NBgFg32a6PR/TmaX5fUPkbkf5AQ=;
  b=i5FDiQE3unyKsqb+b1nz3+AQUu2P8/sRHcaRB52DbY9iw0pAm91CeTIR
   4Yq/1Fc46cz1U2+5sL/GK9MpDCPyUXID2ko8llLRS9yCxU+biq1XUociO
   DQKnIbAI/rF2CMq35MJoqcJVertUdfIGXMrnF0JtAz6wqYXVAB7Yrro8p
   Sztpucnc9+f3QOKoad8cZV060bIToZtRIPsrgZnlycfTtr/Te0kbcZVFV
   ESYOWJhp5LIA0cJKxunb+0yNPafD0O/YUWKjdZ0H1K9Tn4d8k6LnzFN6Q
   lUiC/6ZhBXJt1lbxirEF5YsowLVo0wnVw6bUNlmckIkwmSVIDLMUZIpAJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270869787"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="270869787"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 06:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="522954807"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2022 06:15:41 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqx37-0000zL-6N;
        Tue, 17 May 2022 13:15:41 +0000
Date:   Tue, 17 May 2022 21:15:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 6/9]
 arch/arm/mm/init.c:276:5: warning: format specifies type 'unsigned long' but
 the argument has type 'char *'
Message-ID: <202205172143.m2ngCwCl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   67a8d6eb3d015908f35d6091c02f17d7c3b55bf3
commit: e916acde63f41816676698a5d750588269d0fd64 [6/9] ARM: Print virtual memory info again
config: arm-randconfig-r021-20220516 (https://download.01.org/0day-ci/archive/20220517/202205172143.m2ngCwCl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=e916acde63f41816676698a5d750588269d0fd64
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout e916acde63f41816676698a5d750588269d0fd64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/mm/init.c:97:13: warning: no previous prototype for function 'setup_dma_zone' [-Wmissing-prototypes]
   void __init setup_dma_zone(const struct machine_desc *mdesc)
               ^
   arch/arm/mm/init.c:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init setup_dma_zone(const struct machine_desc *mdesc)
   ^
   static 
>> arch/arm/mm/init.c:276:5: warning: format specifies type 'unsigned long' but the argument has type 'char *' [-Wformat]
                     "     kernel : 0x%08lx - 0x%08lx   (%4ld MB)\n",
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
>> arch/arm/mm/init.c:281:5: warning: data argument not used by format string [-Wformat-extra-args]
                     MLM(MODULES_VADDR, MODULES_END),
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:509:36: note: expanded from macro 'pr_notice'
           printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^
   arch/arm/mm/init.c:268:25: note: expanded from macro 'MLM'
   #define MLM(b, t) b, t, ((t) - (b)) >> 20
                           ^
   arch/arm/mm/init.c:266:13: warning: no previous prototype for function 'mem_init_print_arm_info' [-Wmissing-prototypes]
   void __init mem_init_print_arm_info(void)
               ^
   arch/arm/mm/init.c:266:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init mem_init_print_arm_info(void)
   ^
   static 
   4 warnings generated.


vim +276 arch/arm/mm/init.c

    96	
  > 97	void __init setup_dma_zone(const struct machine_desc *mdesc)
    98	{
    99	#ifdef CONFIG_ZONE_DMA
   100		if (mdesc->dma_zone_size) {
   101			arm_dma_zone_size = mdesc->dma_zone_size;
   102			arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
   103		} else
   104			arm_dma_limit = 0xffffffff;
   105		arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
   106	#endif
   107	}
   108	
   109	static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
   110		unsigned long max_high)
   111	{
   112		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
   113	
   114	#ifdef CONFIG_ZONE_DMA
   115		max_zone_pfn[ZONE_DMA] = min(arm_dma_pfn_limit, max_low);
   116	#endif
   117		max_zone_pfn[ZONE_NORMAL] = max_low;
   118	#ifdef CONFIG_HIGHMEM
   119		max_zone_pfn[ZONE_HIGHMEM] = max_high;
   120	#endif
   121		free_area_init(max_zone_pfn);
   122	}
   123	
   124	#ifdef CONFIG_HAVE_ARCH_PFN_VALID
   125	int pfn_valid(unsigned long pfn)
   126	{
   127		phys_addr_t addr = __pfn_to_phys(pfn);
   128		unsigned long pageblock_size = PAGE_SIZE * pageblock_nr_pages;
   129	
   130		if (__phys_to_pfn(addr) != pfn)
   131			return 0;
   132	
   133		/*
   134		 * If address less than pageblock_size bytes away from a present
   135		 * memory chunk there still will be a memory map entry for it
   136		 * because we round freed memory map to the pageblock boundaries.
   137		 */
   138		if (memblock_overlaps_region(&memblock.memory,
   139					     ALIGN_DOWN(addr, pageblock_size),
   140					     pageblock_size))
   141			return 1;
   142	
   143		return 0;
   144	}
   145	EXPORT_SYMBOL(pfn_valid);
   146	#endif
   147	
   148	static bool arm_memblock_steal_permitted = true;
   149	
   150	phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
   151	{
   152		phys_addr_t phys;
   153	
   154		BUG_ON(!arm_memblock_steal_permitted);
   155	
   156		phys = memblock_phys_alloc(size, align);
   157		if (!phys)
   158			panic("Failed to steal %pa bytes at %pS\n",
   159			      &size, (void *)_RET_IP_);
   160	
   161		memblock_phys_free(phys, size);
   162		memblock_remove(phys, size);
   163	
   164		return phys;
   165	}
   166	
   167	#ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
   168	void check_cpu_icache_size(int cpuid)
   169	{
   170		u32 size, ctr;
   171	
   172		asm("mrc p15, 0, %0, c0, c0, 1" : "=r" (ctr));
   173	
   174		size = 1 << ((ctr & 0xf) + 2);
   175		if (cpuid != 0 && icache_size != size)
   176			pr_info("CPU%u: detected I-Cache line size mismatch, workaround enabled\n",
   177				cpuid);
   178		if (icache_size > size)
   179			icache_size = size;
   180	}
   181	#endif
   182	
   183	void __init arm_memblock_init(const struct machine_desc *mdesc)
   184	{
   185		/* Register the kernel text, kernel data and initrd with memblock. */
   186		memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
   187	
   188		reserve_initrd_mem();
   189	
   190		arm_mm_memblock_reserve();
   191	
   192		/* reserve any platform specific memblock areas */
   193		if (mdesc->reserve)
   194			mdesc->reserve();
   195	
   196		early_init_fdt_scan_reserved_mem();
   197	
   198		/* reserve memory for DMA contiguous allocations */
   199		dma_contiguous_reserve(arm_dma_limit);
   200	
   201		arm_memblock_steal_permitted = false;
   202		memblock_dump_all();
   203	}
   204	
   205	void __init bootmem_init(void)
   206	{
   207		memblock_allow_resize();
   208	
   209		find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
   210	
   211		early_memtest((phys_addr_t)min_low_pfn << PAGE_SHIFT,
   212			      (phys_addr_t)max_low_pfn << PAGE_SHIFT);
   213	
   214		/*
   215		 * sparse_init() tries to allocate memory from memblock, so must be
   216		 * done after the fixed reservations
   217		 */
   218		sparse_init();
   219	
   220		/*
   221		 * Now free the memory - free_area_init needs
   222		 * the sparse mem_map arrays initialized by sparse_init()
   223		 * for memmap_init_zone(), otherwise all PFNs are invalid.
   224		 */
   225		zone_sizes_init(min_low_pfn, max_low_pfn, max_pfn);
   226	}
   227	
   228	/*
   229	 * Poison init memory with an undefined instruction (ARM) or a branch to an
   230	 * undefined instruction (Thumb).
   231	 */
   232	static inline void poison_init_mem(void *s, size_t count)
   233	{
   234		u32 *p = (u32 *)s;
   235		for (; count != 0; count -= 4)
   236			*p++ = 0xe7fddef0;
   237	}
   238	
   239	static void __init free_highpages(void)
   240	{
   241	#ifdef CONFIG_HIGHMEM
   242		unsigned long max_low = max_low_pfn;
   243		phys_addr_t range_start, range_end;
   244		u64 i;
   245	
   246		/* set highmem page free */
   247		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
   248					&range_start, &range_end, NULL) {
   249			unsigned long start = PFN_UP(range_start);
   250			unsigned long end = PFN_DOWN(range_end);
   251	
   252			/* Ignore complete lowmem entries */
   253			if (end <= max_low)
   254				continue;
   255	
   256			/* Truncate partial highmem entries */
   257			if (start < max_low)
   258				start = max_low;
   259	
   260			for (; start < end; start++)
   261				free_highmem_page(pfn_to_page(start));
   262		}
   263	#endif
   264	}
   265	
   266	void __init mem_init_print_arm_info(void)
   267	{
   268	#define MLM(b, t) b, t, ((t) - (b)) >> 20
   269		pr_notice("Virtual kernel memory layout:\n"
   270			  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   271			  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   272			  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
   273	#ifdef CONFIG_MODULES
   274			  "    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n",
   275	#endif
 > 276			  "     kernel : 0x%08lx - 0x%08lx   (%4ld MB)\n",
   277			  MLM(FIXADDR_START, FIXADDR_END),
   278			  MLM(VMALLOC_START, VMALLOC_END),
   279			  MLM(PAGE_OFFSET, (unsigned long)high_memory),
   280	#ifdef CONFIG_MODULES
 > 281			  MLM(MODULES_VADDR, MODULES_END),
   282	#endif
   283			  /* From beginning of .text to end of .bss */
   284			  MLM((unsigned long)_text, (unsigned long)__bss_stop));
   285	#undef MLM
   286	}
   287	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

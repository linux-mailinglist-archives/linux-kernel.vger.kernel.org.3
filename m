Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7425641C0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiGBRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:05:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93550B4B7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656781504; x=1688317504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EHtnOCX+GkxOoadcw78XBhY1Za2N/WXq+F95gM6qG/s=;
  b=RgBO1f9jmUtEIuopDL0KMVS5l0/mc6J0lIHCc/SDbhjArj5fTovgJxlr
   JK5cR4vEQDZ6sGx9P5e8d3JuQMSYPF1nLjNM7HA72xTvhNrdcZqHN5/RU
   9c4VvuUFwNQob/raNawZVKtUz6YYpJG8+QbLTRW8xbOUGeRT0kQjpUOie
   lVAgIBhqWDWTGwxDItW2skaqNlNvv28HqHpvIKhjk9AIcviMRtvTUwS/Y
   MTPGGHdJ2WiWf9XIx+U9tVNpKMzAfRbHShAKDIHKCThcDA46L6/4qcmZw
   PLt97NII6I7447xAk/1v9yuVvzTxj8VQV7iRbCxFxYwDH9T7bnH3DLQB6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="346834805"
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="346834805"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 10:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,240,1650956400"; 
   d="scan'208";a="542037399"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2022 10:05:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7gYH-000FRZ-Hg;
        Sat, 02 Jul 2022 17:05:01 +0000
Date:   Sun, 3 Jul 2022 01:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/85xx/smp.c:218:28: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202207030004.CAWSGbLU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   089866061428ec9bf67221247c936792078c41a4
commit: 84a61fb43fdfc528a3a7ff00e0b14ba91f5eb745 powerpc/85xx: Make mpc85xx_smp_kexec_cpu_down() static
date:   7 months ago
config: powerpc-randconfig-s031-20220702 (https://download.01.org/0day-ci/archive/20220703/202207030004.CAWSGbLU-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84a61fb43fdfc528a3a7ff00e0b14ba91f5eb745
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 84a61fb43fdfc528a3a7ff00e0b14ba91f5eb745
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/nohash/ arch/powerpc/platforms/85xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/85xx/smp.c:218:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@     got void * @@
   arch/powerpc/platforms/85xx/smp.c:218:28: sparse:     expected struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:218:28: sparse:     got void *
>> arch/powerpc/platforms/85xx/smp.c:227:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:227:36: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:227:36: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
>> arch/powerpc/platforms/85xx/smp.c:367:10: sparse: sparse: symbol 'kexec_down_cpus' was not declared. Should it be static?
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *

vim +218 arch/powerpc/platforms/85xx/smp.c

bc15236fbed1e0 York Sun              2012-09-29  168  
bc15236fbed1e0 York Sun              2012-09-29  169  static inline u32 read_spin_table_addr_l(void *spin_table)
bc15236fbed1e0 York Sun              2012-09-29  170  {
bc15236fbed1e0 York Sun              2012-09-29  171  	flush_dcache_range((ulong)spin_table,
bc15236fbed1e0 York Sun              2012-09-29  172  		(ulong)spin_table + sizeof(struct epapr_spin_table));
bc15236fbed1e0 York Sun              2012-09-29 @173  	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
bc15236fbed1e0 York Sun              2012-09-29  174  }
bc15236fbed1e0 York Sun              2012-09-29  175  
e16c8765533a15 Andy Fleming          2011-12-08  176  #ifdef CONFIG_PPC64
e16c8765533a15 Andy Fleming          2011-12-08  177  static void wake_hw_thread(void *info)
e16c8765533a15 Andy Fleming          2011-12-08  178  {
e16c8765533a15 Andy Fleming          2011-12-08  179  	void fsl_secondary_thread_init(void);
6becef7ea04a69 chenhui zhao          2015-11-20  180  	unsigned long inia;
6becef7ea04a69 chenhui zhao          2015-11-20  181  	int cpu = *(const int *)info;
e16c8765533a15 Andy Fleming          2011-12-08  182  
01c593d749f476 Scott Wood            2015-10-06  183  	inia = *(unsigned long *)fsl_secondary_thread_init;
6becef7ea04a69 chenhui zhao          2015-11-20  184  	book3e_start_thread(cpu_thread_in_core(cpu), inia);
e16c8765533a15 Andy Fleming          2011-12-08  185  }
e16c8765533a15 Andy Fleming          2011-12-08  186  #endif
e16c8765533a15 Andy Fleming          2011-12-08  187  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  188  static int smp_85xx_start_cpu(int cpu)
d5b26db2cfcf09 Kumar Gala            2008-11-19  189  {
2f4f1f815bc6d0 chenhui zhao          2015-11-20  190  	int ret = 0;
d5b26db2cfcf09 Kumar Gala            2008-11-19  191  	struct device_node *np;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  192  	const u64 *cpu_rel_addr;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  193  	unsigned long flags;
d1d47ec6e62ab0 Peter Tyser           2009-12-18  194  	int ioremappable;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  195  	int hw_cpu = get_hard_smp_processor_id(cpu);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  196  	struct epapr_spin_table __iomem *spin_table;
e16c8765533a15 Andy Fleming          2011-12-08  197  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  198  	np = of_get_cpu_node(cpu, NULL);
d5b26db2cfcf09 Kumar Gala            2008-11-19  199  	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  200  	if (!cpu_rel_addr) {
2f4f1f815bc6d0 chenhui zhao          2015-11-20  201  		pr_err("No cpu-release-addr for cpu %d\n", cpu);
de300974761d92 Michael Ellerman      2011-04-11  202  		return -ENOENT;
d5b26db2cfcf09 Kumar Gala            2008-11-19  203  	}
d5b26db2cfcf09 Kumar Gala            2008-11-19  204  
d1d47ec6e62ab0 Peter Tyser           2009-12-18  205  	/*
d1d47ec6e62ab0 Peter Tyser           2009-12-18  206  	 * A secondary core could be in a spinloop in the bootpage
d1d47ec6e62ab0 Peter Tyser           2009-12-18  207  	 * (0xfffff000), somewhere in highmem, or somewhere in lowmem.
d1d47ec6e62ab0 Peter Tyser           2009-12-18  208  	 * The bootpage and highmem can be accessed via ioremap(), but
d1d47ec6e62ab0 Peter Tyser           2009-12-18  209  	 * we need to directly access the spinloop if its in lowmem.
d1d47ec6e62ab0 Peter Tyser           2009-12-18  210  	 */
d1d47ec6e62ab0 Peter Tyser           2009-12-18  211  	ioremappable = *cpu_rel_addr > virt_to_phys(high_memory);
d1d47ec6e62ab0 Peter Tyser           2009-12-18  212  
d5b26db2cfcf09 Kumar Gala            2008-11-19  213  	/* Map the spin table */
d1d47ec6e62ab0 Peter Tyser           2009-12-18  214  	if (ioremappable)
aa91796ec46339 Christophe Leroy      2018-10-09  215  		spin_table = ioremap_coherent(*cpu_rel_addr,
aa91796ec46339 Christophe Leroy      2018-10-09  216  					      sizeof(struct epapr_spin_table));
d1d47ec6e62ab0 Peter Tyser           2009-12-18  217  	else
15f34eb12340b2 Zhao Chenhui          2012-07-20 @218  		spin_table = phys_to_virt(*cpu_rel_addr);
d5b26db2cfcf09 Kumar Gala            2008-11-19  219  
cb1ffb6204712b Kumar Gala            2009-06-19  220  	local_irq_save(flags);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  221  	hard_irq_disable();
d0832a75075b11 Zhao Chenhui          2012-07-20  222  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  223  	if (qoriq_pm_ops)
2f4f1f815bc6d0 chenhui zhao          2015-11-20  224  		qoriq_pm_ops->cpu_up_prepare(cpu);
cb1ffb6204712b Kumar Gala            2009-06-19  225  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  226  	/* if cpu is not spinning, reset it */
2f4f1f815bc6d0 chenhui zhao          2015-11-20 @227  	if (read_spin_table_addr_l(spin_table) != 1) {
d0832a75075b11 Zhao Chenhui          2012-07-20  228  		/*
d0832a75075b11 Zhao Chenhui          2012-07-20  229  		 * We don't set the BPTR register here since it already points
d0832a75075b11 Zhao Chenhui          2012-07-20  230  		 * to the boot page properly.
d0832a75075b11 Zhao Chenhui          2012-07-20  231  		 */
2f4f1f815bc6d0 chenhui zhao          2015-11-20  232  		mpic_reset_core(cpu);
d0832a75075b11 Zhao Chenhui          2012-07-20  233  
bc15236fbed1e0 York Sun              2012-09-29  234  		/*
bc15236fbed1e0 York Sun              2012-09-29  235  		 * wait until core is ready...
bc15236fbed1e0 York Sun              2012-09-29  236  		 * We need to invalidate the stale data, in case the boot
bc15236fbed1e0 York Sun              2012-09-29  237  		 * loader uses a cache-inhibited spin table.
bc15236fbed1e0 York Sun              2012-09-29  238  		 */
bc15236fbed1e0 York Sun              2012-09-29  239  		if (!spin_event_timeout(
bc15236fbed1e0 York Sun              2012-09-29  240  				read_spin_table_addr_l(spin_table) == 1,
d0832a75075b11 Zhao Chenhui          2012-07-20  241  				10000, 100)) {
2f4f1f815bc6d0 chenhui zhao          2015-11-20  242  			pr_err("timeout waiting for cpu %d to reset\n",
2f4f1f815bc6d0 chenhui zhao          2015-11-20  243  				hw_cpu);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  244  			ret = -EAGAIN;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  245  			goto err;
d0832a75075b11 Zhao Chenhui          2012-07-20  246  		}
d0832a75075b11 Zhao Chenhui          2012-07-20  247  	}
decbb280bb8e3b Kumar Gala            2011-02-14  248  
bc15236fbed1e0 York Sun              2012-09-29  249  	flush_spin_table(spin_table);
d0832a75075b11 Zhao Chenhui          2012-07-20  250  	out_be32(&spin_table->pir, hw_cpu);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  251  #ifdef CONFIG_PPC64
15f34eb12340b2 Zhao Chenhui          2012-07-20  252  	out_be64((u64 *)(&spin_table->addr_h),
2751b628c97e66 Anton Blanchard       2014-03-11  253  		__pa(ppc_function_entry(generic_secondary_smp_init)));
2f4f1f815bc6d0 chenhui zhao          2015-11-20  254  #else
eeb09917c138cc Bai Yingjie           2020-01-06  255  #ifdef CONFIG_PHYS_ADDR_T_64BIT
eeb09917c138cc Bai Yingjie           2020-01-06  256  	/*
eeb09917c138cc Bai Yingjie           2020-01-06  257  	 * We need also to write addr_h to spin table for systems
eeb09917c138cc Bai Yingjie           2020-01-06  258  	 * in which their physical memory start address was configured
eeb09917c138cc Bai Yingjie           2020-01-06  259  	 * to above 4G, otherwise the secondary core can not get
eeb09917c138cc Bai Yingjie           2020-01-06  260  	 * correct entry to start from.
eeb09917c138cc Bai Yingjie           2020-01-06  261  	 */
eeb09917c138cc Bai Yingjie           2020-01-06  262  	out_be32(&spin_table->addr_h, __pa(__early_start) >> 32);
eeb09917c138cc Bai Yingjie           2020-01-06  263  #endif
2f4f1f815bc6d0 chenhui zhao          2015-11-20  264  	out_be32(&spin_table->addr_l, __pa(__early_start));
5b8544c38e6fde Kumar Gala            2010-10-08  265  #endif
2f4f1f815bc6d0 chenhui zhao          2015-11-20  266  	flush_spin_table(spin_table);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  267  err:
d5b26db2cfcf09 Kumar Gala            2008-11-19  268  	local_irq_restore(flags);
d5b26db2cfcf09 Kumar Gala            2008-11-19  269  
d1d47ec6e62ab0 Peter Tyser           2009-12-18  270  	if (ioremappable)
15f34eb12340b2 Zhao Chenhui          2012-07-20  271  		iounmap(spin_table);
cb1ffb6204712b Kumar Gala            2009-06-19  272  
d0832a75075b11 Zhao Chenhui          2012-07-20  273  	return ret;
d5b26db2cfcf09 Kumar Gala            2008-11-19  274  }
d5b26db2cfcf09 Kumar Gala            2008-11-19  275  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  276  static int smp_85xx_kick_cpu(int nr)
2f4f1f815bc6d0 chenhui zhao          2015-11-20  277  {
2f4f1f815bc6d0 chenhui zhao          2015-11-20  278  	int ret = 0;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  279  #ifdef CONFIG_PPC64
2f4f1f815bc6d0 chenhui zhao          2015-11-20  280  	int primary = nr;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  281  #endif
2f4f1f815bc6d0 chenhui zhao          2015-11-20  282  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  283  	WARN_ON(nr < 0 || nr >= num_possible_cpus());
2f4f1f815bc6d0 chenhui zhao          2015-11-20  284  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  285  	pr_debug("kick CPU #%d\n", nr);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  286  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  287  #ifdef CONFIG_PPC64
6becef7ea04a69 chenhui zhao          2015-11-20  288  	if (threads_per_core == 2) {
2f4f1f815bc6d0 chenhui zhao          2015-11-20  289  		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
2f4f1f815bc6d0 chenhui zhao          2015-11-20  290  			return -ENOENT;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  291  
6becef7ea04a69 chenhui zhao          2015-11-20  292  		booting_thread_hwid = cpu_thread_in_core(nr);
6becef7ea04a69 chenhui zhao          2015-11-20  293  		primary = cpu_first_thread_sibling(nr);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  294  
6becef7ea04a69 chenhui zhao          2015-11-20  295  		if (qoriq_pm_ops)
6becef7ea04a69 chenhui zhao          2015-11-20  296  			qoriq_pm_ops->cpu_up_prepare(nr);
6becef7ea04a69 chenhui zhao          2015-11-20  297  
6becef7ea04a69 chenhui zhao          2015-11-20  298  		/*
6becef7ea04a69 chenhui zhao          2015-11-20  299  		 * If either thread in the core is online, use it to start
6becef7ea04a69 chenhui zhao          2015-11-20  300  		 * the other.
6becef7ea04a69 chenhui zhao          2015-11-20  301  		 */
6becef7ea04a69 chenhui zhao          2015-11-20  302  		if (cpu_online(primary)) {
6becef7ea04a69 chenhui zhao          2015-11-20  303  			smp_call_function_single(primary,
6becef7ea04a69 chenhui zhao          2015-11-20  304  					wake_hw_thread, &nr, 1);
6becef7ea04a69 chenhui zhao          2015-11-20  305  			goto done;
6becef7ea04a69 chenhui zhao          2015-11-20  306  		} else if (cpu_online(primary + 1)) {
6becef7ea04a69 chenhui zhao          2015-11-20  307  			smp_call_function_single(primary + 1,
6becef7ea04a69 chenhui zhao          2015-11-20  308  					wake_hw_thread, &nr, 1);
6becef7ea04a69 chenhui zhao          2015-11-20  309  			goto done;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  310  		}
2f4f1f815bc6d0 chenhui zhao          2015-11-20  311  
6becef7ea04a69 chenhui zhao          2015-11-20  312  		/*
6becef7ea04a69 chenhui zhao          2015-11-20  313  		 * If getting here, it means both threads in the core are
6becef7ea04a69 chenhui zhao          2015-11-20  314  		 * offline. So start the primary thread, then it will start
6becef7ea04a69 chenhui zhao          2015-11-20  315  		 * the thread specified in booting_thread_hwid, the one
6becef7ea04a69 chenhui zhao          2015-11-20  316  		 * corresponding to nr.
6becef7ea04a69 chenhui zhao          2015-11-20  317  		 */
6becef7ea04a69 chenhui zhao          2015-11-20  318  
6becef7ea04a69 chenhui zhao          2015-11-20  319  	} else if (threads_per_core == 1) {
6becef7ea04a69 chenhui zhao          2015-11-20  320  		/*
6becef7ea04a69 chenhui zhao          2015-11-20  321  		 * If one core has only one thread, set booting_thread_hwid to
6becef7ea04a69 chenhui zhao          2015-11-20  322  		 * an invalid value.
6becef7ea04a69 chenhui zhao          2015-11-20  323  		 */
6becef7ea04a69 chenhui zhao          2015-11-20  324  		booting_thread_hwid = INVALID_THREAD_HWID;
6becef7ea04a69 chenhui zhao          2015-11-20  325  
6becef7ea04a69 chenhui zhao          2015-11-20  326  	} else if (threads_per_core > 2) {
6becef7ea04a69 chenhui zhao          2015-11-20  327  		pr_err("Do not support more than 2 threads per CPU.");
6becef7ea04a69 chenhui zhao          2015-11-20  328  		return -EINVAL;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  329  	}
2f4f1f815bc6d0 chenhui zhao          2015-11-20  330  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  331  	ret = smp_85xx_start_cpu(primary);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  332  	if (ret)
2f4f1f815bc6d0 chenhui zhao          2015-11-20  333  		return ret;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  334  
6becef7ea04a69 chenhui zhao          2015-11-20  335  done:
d2e60075a3d442 Nicholas Piggin       2018-02-14  336  	paca_ptrs[nr]->cpu_start = 1;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  337  	generic_set_cpu_up(nr);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  338  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  339  	return ret;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  340  #else
2f4f1f815bc6d0 chenhui zhao          2015-11-20  341  	ret = smp_85xx_start_cpu(nr);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  342  	if (ret)
2f4f1f815bc6d0 chenhui zhao          2015-11-20  343  		return ret;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  344  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  345  	generic_set_cpu_up(nr);
2f4f1f815bc6d0 chenhui zhao          2015-11-20  346  
2f4f1f815bc6d0 chenhui zhao          2015-11-20  347  	return ret;
2f4f1f815bc6d0 chenhui zhao          2015-11-20  348  #endif
2f4f1f815bc6d0 chenhui zhao          2015-11-20  349  }
2f4f1f815bc6d0 chenhui zhao          2015-11-20  350  
d5b26db2cfcf09 Kumar Gala            2008-11-19  351  struct smp_ops_t smp_85xx_ops = {
c64af6458e2e2d Nicholas Piggin       2016-12-20  352  	.cause_nmi_ipi = NULL,
d5b26db2cfcf09 Kumar Gala            2008-11-19  353  	.kick_cpu = smp_85xx_kick_cpu,
39fd40274d1f3a Andy Fleming          2013-08-05  354  	.cpu_bootable = smp_generic_cpu_bootable,
d0832a75075b11 Zhao Chenhui          2012-07-20  355  #ifdef CONFIG_HOTPLUG_CPU
d0832a75075b11 Zhao Chenhui          2012-07-20  356  	.cpu_disable	= generic_cpu_disable,
d0832a75075b11 Zhao Chenhui          2012-07-20  357  	.cpu_die	= generic_cpu_die,
d0832a75075b11 Zhao Chenhui          2012-07-20  358  #endif
da6658859b9c73 Thiago Jung Bauermann 2016-11-29  359  #if defined(CONFIG_KEXEC_CORE) && !defined(CONFIG_PPC64)
f933a41e419a95 Matthew McClintock    2010-07-21  360  	.give_timebase	= smp_generic_give_timebase,
f933a41e419a95 Matthew McClintock    2010-07-21  361  	.take_timebase	= smp_generic_take_timebase,
f933a41e419a95 Matthew McClintock    2010-07-21  362  #endif
d5b26db2cfcf09 Kumar Gala            2008-11-19  363  };
d5b26db2cfcf09 Kumar Gala            2008-11-19  364  
da6658859b9c73 Thiago Jung Bauermann 2016-11-29  365  #ifdef CONFIG_KEXEC_CORE
939fbf00805b39 Tiejun Chen           2015-10-06  366  #ifdef CONFIG_PPC32
5d692961633d4e Matthew McClintock    2010-09-16 @367  atomic_t kexec_down_cpus = ATOMIC_INIT(0);
f933a41e419a95 Matthew McClintock    2010-07-21  368  

:::::: The code at line 218 was first introduced by commit
:::::: 15f34eb12340b2c2e0cd90c5987ad6b5f73b79b7 powerpc/85xx: Replace epapr spin table macros/defines with a struct

:::::: TO: Zhao Chenhui <chenhui.zhao@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

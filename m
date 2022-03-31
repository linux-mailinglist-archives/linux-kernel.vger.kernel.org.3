Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911044EDB09
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiCaOE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCaOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:04:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC11706C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648735357; x=1680271357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gQ4gNsiQs/jeGmI4HCF69x77mQCtr6eITstOzZLg814=;
  b=gLFY9PUi4+54AYFZFRC/YL6lmDwNsaoXc4BfDZkQG3rfYSEX1wap5s/2
   CrRSs1XGZVyymK7eZ4neDWsvUJ6Cw2aZCCgfFBEFolNsqnQ4Bv2oSoRMY
   3XK8OdcFzOIM+6So6og5Rq18zYPDnjh0LtPMHyCdOsgwxJr19D6+R8/ku
   JJEHCv/e2Cb8jItqujOG2GVJn8jmpGmb8DNsfKy94BJcj4JvrkA7648mV
   7eyd0KVWOHmkFLkQzWFifSIZTG/Bw0CrZMzTCi6GQmyqw9j2KcCdvBsYH
   E2as0jOBLpUoW2GrcWLFyFFNXLxa5tW0yFRRgM/6id0LiKU34E7uf0j6j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="323021636"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="323021636"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 07:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720474418"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 07:02:34 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZvNi-0000K4-0r;
        Thu, 31 Mar 2022 14:02:34 +0000
Date:   Thu, 31 Mar 2022 22:01:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     John David Anglin <dave.anglin@bell.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [deller-parisc:for-next 2/3] block/blk-map.c:318:17: error: implicit
 declaration of function 'invalidate_kernel_vmap_range'
Message-ID: <202203312108.YiMaVSNd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git for-next
head:   22fe34a0015587b8b1c7eddbf97752b046c24927
commit: 5753bafd53dc8cdcbf6a3388747e11bc8d634ce1 [2/3] parisc: Implement flush_cache_vmap_vunmap
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220331/202203312108.YiMaVSNd-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=5753bafd53dc8cdcbf6a3388747e11bc8d634ce1
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc for-next
        git checkout 5753bafd53dc8cdcbf6a3388747e11bc8d634ce1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash arch/parisc/kernel/ block/ drivers/md/ sound/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:11,
                    from arch/parisc/kernel/cache.c:19:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/kernel/cache.c:623:6: warning: no previous prototype for 'flush_kernel_vmap_range' [-Wmissing-prototypes]
     623 | void flush_kernel_vmap_range(void *vaddr, int size)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/parisc/kernel/cache.c:640:6: warning: no previous prototype for 'invalidate_kernel_vmap_range' [-Wmissing-prototypes]
     640 | void invalidate_kernel_vmap_range(void *vaddr, int size)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/parisc/kernel/setup.c:29:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/setup.c:48:13: warning: no previous prototype for 'setup_cmdline' [-Wmissing-prototypes]
      48 | void __init setup_cmdline(char **cmdline_p)
         |             ^~~~~~~~~~~~~
   arch/parisc/kernel/setup.c:87:13: warning: no previous prototype for 'dma_ops_init' [-Wmissing-prototypes]
      87 | void __init dma_ops_init(void)
         |             ^~~~~~~~~~~~
   arch/parisc/kernel/setup.c:390:13: warning: no previous prototype for 'start_parisc' [-Wmissing-prototypes]
     390 | void __init start_parisc(void)
         |             ^~~~~~~~~~~~
--
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:9,
                    from arch/parisc/kernel/pdt.c:21:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
--
   In file included from arch/parisc/kernel/traps.c:46:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/traps.c:338:6: warning: no previous prototype for 'transfer_pim_to_trap_frame' [-Wmissing-prototypes]
     338 | void transfer_pim_to_trap_frame(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/traps.c:479:14: warning: no previous prototype for 'handle_interruption' [-Wmissing-prototypes]
     479 | void notrace handle_interruption(int code, struct pt_regs *regs)
         |              ^~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/traps.c:806:13: warning: no previous prototype for 'initialize_ivt' [-Wmissing-prototypes]
     806 | void __init initialize_ivt(const void *iva)
         |             ^~~~~~~~~~~~~~
   arch/parisc/kernel/traps.c: In function 'initialize_ivt':
   arch/parisc/kernel/traps.c:813:14: warning: variable 'hpmcp' set but not used [-Wunused-but-set-variable]
     813 |         u32 *hpmcp;
         |              ^~~~~
   arch/parisc/kernel/traps.c: At top level:
   arch/parisc/kernel/traps.c:858:14: warning: no previous prototype for 'early_trap_init' [-Wmissing-prototypes]
     858 | void  __init early_trap_init(void)
         |              ^~~~~~~~~~~~~~~
--
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:22,
                    from include/linux/resume_user_mode.h:8,
                    from arch/parisc/kernel/signal.c:22:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/signal.c:77:1: warning: no previous prototype for 'sys_rt_sigreturn' [-Wmissing-prototypes]
      77 | sys_rt_sigreturn(struct pt_regs *regs, int in_syscall)
         | ^~~~~~~~~~~~~~~~
   arch/parisc/kernel/signal.c:581:6: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     581 | void do_notify_resume(struct pt_regs *regs, long in_syscall)
         |      ^~~~~~~~~~~~~~~~
--
   In file included from arch/parisc/kernel/process.c:50:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/process.c:67:6: warning: no previous prototype for 'machine_restart' [-Wmissing-prototypes]
      67 | void machine_restart(char *cmd)
         |      ^~~~~~~~~~~~~~~
   arch/parisc/kernel/process.c:105:6: warning: no previous prototype for 'machine_power_off' [-Wmissing-prototypes]
     105 | void machine_power_off(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/parisc/kernel/process.c:137:6: warning: no previous prototype for 'machine_halt' [-Wmissing-prototypes]
     137 | void machine_halt(void)
         |      ^~~~~~~~~~~~
--
   In file included from arch/parisc/kernel/smp.c:47:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/smp.c:120:1: warning: no previous prototype for 'ipi_interrupt' [-Wmissing-prototypes]
     120 | ipi_interrupt(int irq, void *dev_id)
         | ^~~~~~~~~~~~~
   arch/parisc/kernel/smp.c:311:6: warning: no previous prototype for 'smp_callin' [-Wmissing-prototypes]
     311 | void smp_callin(unsigned long pdce_proc)
         |      ^~~~~~~~~~
   arch/parisc/kernel/smp.c:518:5: warning: no previous prototype for 'setup_profiling_timer' [-Wmissing-prototypes]
     518 | int setup_profiling_timer(unsigned int multiplier)
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/parisc/kernel/pci-dma.c:31:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   arch/parisc/kernel/pci-dma.c:249:1: warning: no previous prototype for 'pcxl_alloc_range' [-Wmissing-prototypes]
     249 | pcxl_alloc_range(size_t size)
         | ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/bio.h:10,
                    from block/blk-map.c:8:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   block/blk-map.c: In function 'bio_invalidate_vmalloc_pages':
>> block/blk-map.c:318:17: error: implicit declaration of function 'invalidate_kernel_vmap_range' [-Werror=implicit-function-declaration]
     318 |                 invalidate_kernel_vmap_range(bio->bi_private, len);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/blk-map.c: In function 'bio_map_kern':
>> block/blk-map.c:356:17: error: implicit declaration of function 'flush_kernel_vmap_range'; did you mean 'flush_kernel_dcache_range'? [-Werror=implicit-function-declaration]
     356 |                 flush_kernel_vmap_range(data, len);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 flush_kernel_dcache_range
   cc1: some warnings being treated as errors
--
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/linux/blk-mq.h:5,
                    from drivers/md/dm-core.h:14,
                    from drivers/md/dm-io.c:8:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   drivers/md/dm-io.c: In function 'complete_io':
>> drivers/md/dm-io.c:121:17: error: implicit declaration of function 'invalidate_kernel_vmap_range' [-Werror=implicit-function-declaration]
     121 |                 invalidate_kernel_vmap_range(io->vma_invalidate_address,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/dm-io.c: In function 'dp_init':
>> drivers/md/dm-io.c:491:17: error: implicit declaration of function 'flush_kernel_vmap_range'; did you mean 'flush_kernel_dcache_range'? [-Werror=implicit-function-declaration]
     491 |                 flush_kernel_vmap_range(io_req->mem.ptr.vma, size);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 flush_kernel_dcache_range
   cc1: some warnings being treated as errors
--
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from sound/core/memalloc.c:13:
>> arch/parisc/include/asm/cacheflush.h:44: warning: "flush_cache_vmap" redefined
      44 | #define flush_cache_vmap(start, end)            flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:41: note: this is the location of the previous definition
      41 | #define flush_cache_vmap(start, end)    flush_cache_vmap_vunmap(start, end)
         | 
>> arch/parisc/include/asm/cacheflush.h:45: warning: "flush_cache_vunmap" redefined
      45 | #define flush_cache_vunmap(start, end)          flush_cache_all()
         | 
   arch/parisc/include/asm/cacheflush.h:42: note: this is the location of the previous definition
      42 | #define flush_cache_vunmap(start, end)  flush_cache_vmap_vunmap(start, end)
         | 
   sound/core/memalloc.c: In function 'snd_dma_noncontig_sync':
>> sound/core/memalloc.c:544:17: error: implicit declaration of function 'invalidate_kernel_vmap_range' [-Werror=implicit-function-declaration]
     544 |                 invalidate_kernel_vmap_range(dmab->area, dmab->bytes);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/core/memalloc.c:550:17: error: implicit declaration of function 'flush_kernel_vmap_range'; did you mean 'flush_kernel_dcache_range'? [-Werror=implicit-function-declaration]
     550 |                 flush_kernel_vmap_range(dmab->area, dmab->bytes);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 flush_kernel_dcache_range
   cc1: some warnings being treated as errors


vim +/invalidate_kernel_vmap_range +318 block/blk-map.c

130879f1ee0e25 Christoph Hellwig 2020-03-27  309  
130879f1ee0e25 Christoph Hellwig 2020-03-27  310  static void bio_invalidate_vmalloc_pages(struct bio *bio)
130879f1ee0e25 Christoph Hellwig 2020-03-27  311  {
f358afc52c3066 Christoph Hellwig 2021-09-02  312  #ifdef ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE
130879f1ee0e25 Christoph Hellwig 2020-03-27  313  	if (bio->bi_private && !op_is_write(bio_op(bio))) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  314  		unsigned long i, len = 0;
130879f1ee0e25 Christoph Hellwig 2020-03-27  315  
130879f1ee0e25 Christoph Hellwig 2020-03-27  316  		for (i = 0; i < bio->bi_vcnt; i++)
130879f1ee0e25 Christoph Hellwig 2020-03-27  317  			len += bio->bi_io_vec[i].bv_len;
130879f1ee0e25 Christoph Hellwig 2020-03-27 @318  		invalidate_kernel_vmap_range(bio->bi_private, len);
130879f1ee0e25 Christoph Hellwig 2020-03-27  319  	}
130879f1ee0e25 Christoph Hellwig 2020-03-27  320  #endif
130879f1ee0e25 Christoph Hellwig 2020-03-27  321  }
130879f1ee0e25 Christoph Hellwig 2020-03-27  322  
130879f1ee0e25 Christoph Hellwig 2020-03-27  323  static void bio_map_kern_endio(struct bio *bio)
130879f1ee0e25 Christoph Hellwig 2020-03-27  324  {
130879f1ee0e25 Christoph Hellwig 2020-03-27  325  	bio_invalidate_vmalloc_pages(bio);
130879f1ee0e25 Christoph Hellwig 2020-03-27  326  	bio_put(bio);
130879f1ee0e25 Christoph Hellwig 2020-03-27  327  }
130879f1ee0e25 Christoph Hellwig 2020-03-27  328  
130879f1ee0e25 Christoph Hellwig 2020-03-27  329  /**
130879f1ee0e25 Christoph Hellwig 2020-03-27  330   *	bio_map_kern	-	map kernel address into bio
130879f1ee0e25 Christoph Hellwig 2020-03-27  331   *	@q: the struct request_queue for the bio
130879f1ee0e25 Christoph Hellwig 2020-03-27  332   *	@data: pointer to buffer to map
130879f1ee0e25 Christoph Hellwig 2020-03-27  333   *	@len: length in bytes
130879f1ee0e25 Christoph Hellwig 2020-03-27  334   *	@gfp_mask: allocation flags for bio allocation
130879f1ee0e25 Christoph Hellwig 2020-03-27  335   *
130879f1ee0e25 Christoph Hellwig 2020-03-27  336   *	Map the kernel address into a bio suitable for io to a block
130879f1ee0e25 Christoph Hellwig 2020-03-27  337   *	device. Returns an error pointer in case of error.
130879f1ee0e25 Christoph Hellwig 2020-03-27  338   */
130879f1ee0e25 Christoph Hellwig 2020-03-27  339  static struct bio *bio_map_kern(struct request_queue *q, void *data,
130879f1ee0e25 Christoph Hellwig 2020-03-27  340  		unsigned int len, gfp_t gfp_mask)
130879f1ee0e25 Christoph Hellwig 2020-03-27  341  {
130879f1ee0e25 Christoph Hellwig 2020-03-27  342  	unsigned long kaddr = (unsigned long)data;
130879f1ee0e25 Christoph Hellwig 2020-03-27  343  	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
130879f1ee0e25 Christoph Hellwig 2020-03-27  344  	unsigned long start = kaddr >> PAGE_SHIFT;
130879f1ee0e25 Christoph Hellwig 2020-03-27  345  	const int nr_pages = end - start;
130879f1ee0e25 Christoph Hellwig 2020-03-27  346  	bool is_vmalloc = is_vmalloc_addr(data);
130879f1ee0e25 Christoph Hellwig 2020-03-27  347  	struct page *page;
130879f1ee0e25 Christoph Hellwig 2020-03-27  348  	int offset, i;
130879f1ee0e25 Christoph Hellwig 2020-03-27  349  	struct bio *bio;
130879f1ee0e25 Christoph Hellwig 2020-03-27  350  
130879f1ee0e25 Christoph Hellwig 2020-03-27  351  	bio = bio_kmalloc(gfp_mask, nr_pages);
130879f1ee0e25 Christoph Hellwig 2020-03-27  352  	if (!bio)
130879f1ee0e25 Christoph Hellwig 2020-03-27  353  		return ERR_PTR(-ENOMEM);
130879f1ee0e25 Christoph Hellwig 2020-03-27  354  
130879f1ee0e25 Christoph Hellwig 2020-03-27  355  	if (is_vmalloc) {
130879f1ee0e25 Christoph Hellwig 2020-03-27 @356  		flush_kernel_vmap_range(data, len);
130879f1ee0e25 Christoph Hellwig 2020-03-27  357  		bio->bi_private = data;
130879f1ee0e25 Christoph Hellwig 2020-03-27  358  	}
130879f1ee0e25 Christoph Hellwig 2020-03-27  359  
130879f1ee0e25 Christoph Hellwig 2020-03-27  360  	offset = offset_in_page(kaddr);
130879f1ee0e25 Christoph Hellwig 2020-03-27  361  	for (i = 0; i < nr_pages; i++) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  362  		unsigned int bytes = PAGE_SIZE - offset;
130879f1ee0e25 Christoph Hellwig 2020-03-27  363  
130879f1ee0e25 Christoph Hellwig 2020-03-27  364  		if (len <= 0)
130879f1ee0e25 Christoph Hellwig 2020-03-27  365  			break;
130879f1ee0e25 Christoph Hellwig 2020-03-27  366  
130879f1ee0e25 Christoph Hellwig 2020-03-27  367  		if (bytes > len)
130879f1ee0e25 Christoph Hellwig 2020-03-27  368  			bytes = len;
130879f1ee0e25 Christoph Hellwig 2020-03-27  369  
130879f1ee0e25 Christoph Hellwig 2020-03-27  370  		if (!is_vmalloc)
130879f1ee0e25 Christoph Hellwig 2020-03-27  371  			page = virt_to_page(data);
130879f1ee0e25 Christoph Hellwig 2020-03-27  372  		else
130879f1ee0e25 Christoph Hellwig 2020-03-27  373  			page = vmalloc_to_page(data);
130879f1ee0e25 Christoph Hellwig 2020-03-27  374  		if (bio_add_pc_page(q, bio, page, bytes,
130879f1ee0e25 Christoph Hellwig 2020-03-27  375  				    offset) < bytes) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  376  			/* we don't support partial mappings */
130879f1ee0e25 Christoph Hellwig 2020-03-27  377  			bio_put(bio);
130879f1ee0e25 Christoph Hellwig 2020-03-27  378  			return ERR_PTR(-EINVAL);
130879f1ee0e25 Christoph Hellwig 2020-03-27  379  		}
130879f1ee0e25 Christoph Hellwig 2020-03-27  380  
130879f1ee0e25 Christoph Hellwig 2020-03-27  381  		data += bytes;
130879f1ee0e25 Christoph Hellwig 2020-03-27  382  		len -= bytes;
130879f1ee0e25 Christoph Hellwig 2020-03-27  383  		offset = 0;
130879f1ee0e25 Christoph Hellwig 2020-03-27  384  	}
130879f1ee0e25 Christoph Hellwig 2020-03-27  385  
130879f1ee0e25 Christoph Hellwig 2020-03-27  386  	bio->bi_end_io = bio_map_kern_endio;
130879f1ee0e25 Christoph Hellwig 2020-03-27  387  	return bio;
130879f1ee0e25 Christoph Hellwig 2020-03-27  388  }
130879f1ee0e25 Christoph Hellwig 2020-03-27  389  

:::::: The code at line 318 was first introduced by commit
:::::: 130879f1ee0e25b0391b8c78b3baac6fe41f4d38 block: move bio_map_* to blk-map.c

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

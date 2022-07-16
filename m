Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFCE576C42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiGPGjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiGPGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 02:39:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0215FE4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657953543; x=1689489543;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2nEE9ZMAZMw7mnnMKS99hcpaIP/rcsLPC/jZ6kT+oo=;
  b=QZA1dVgIcptXSalKca874GUt3v0P4XMv02WBKOU8OBKSyDFkU2kTl0Gf
   s514qREXXNtR9jxRWg4sCMhDak7/6uu0L8zt9bnb4hItYO/aMzxNCvBB0
   60yELxjxHOTcgVN0mo69ngY99McLxa3kQ0dOJH2kxUWPiPfReJ53x7y5D
   ABaI2yfvNiRgxTUAho8lDpYgS7bq1yIFWZfR+Y27bRNIVr53FaBzeymMk
   yyxdm2WkgrzwWHPcN6nENTqwrYnwEMqWf5UNaGKSiHLl7lUSkY1WX6GFY
   x2n75POO3o/1WuRyOTeeRvHlIHCMDq3YiZkkzCw+y/azcQKxSBHKWRcxX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266365277"
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="266365277"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,276,1650956400"; 
   d="scan'208";a="571809693"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2022 23:39:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbS8-0001EY-GM;
        Sat, 16 Jul 2022 06:39:00 +0000
Date:   Sat, 16 Jul 2022 14:38:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: arch/loongarch/kernel/asm-offsets.c:16:6: warning: no previous
 prototype for 'output_ptreg_defines'
Message-ID: <202207161431.vZSd19V3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 46859ac8af52ae599e1b51992ddef3eb43f295fc LoongArch: Add multi-processor (SMP) support
date:   6 weeks ago
config: loongarch-randconfig-r025-20220715 (https://download.01.org/0day-ci/archive/20220716/202207161431.vZSd19V3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46859ac8af52ae599e1b51992ddef3eb43f295fc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 46859ac8af52ae599e1b51992ddef3eb43f295fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/loongarch/include/asm/page.h:33,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:16,
                    from arch/loongarch/kernel/asm-offsets.c:8:
   arch/loongarch/include/asm/page.h: In function 'pfn_valid':
>> arch/loongarch/include/asm/page.h:42:32: error: 'PHYS_OFFSET' undeclared (first use in this function)
      42 | #define ARCH_PFN_OFFSET PFN_UP(PHYS_OFFSET)
         |                                ^~~~~~~~~~~
   include/linux/pfn.h:19:28: note: in definition of macro 'PFN_UP'
      19 | #define PFN_UP(x)       (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
         |                            ^
   arch/loongarch/include/asm/page.h:92:36: note: in expansion of macro 'ARCH_PFN_OFFSET'
      92 |         unsigned long pfn_offset = ARCH_PFN_OFFSET;
         |                                    ^~~~~~~~~~~~~~~
   arch/loongarch/include/asm/page.h:42:32: note: each undeclared identifier is reported only once for each function it appears in
      42 | #define ARCH_PFN_OFFSET PFN_UP(PHYS_OFFSET)
         |                                ^~~~~~~~~~~
   include/linux/pfn.h:19:28: note: in definition of macro 'PFN_UP'
      19 | #define PFN_UP(x)       (((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
         |                            ^
   arch/loongarch/include/asm/page.h:92:36: note: in expansion of macro 'ARCH_PFN_OFFSET'
      92 |         unsigned long pfn_offset = ARCH_PFN_OFFSET;
         |                                    ^~~~~~~~~~~~~~~
   arch/loongarch/kernel/asm-offsets.c: At top level:
>> arch/loongarch/kernel/asm-offsets.c:16:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      16 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:63:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      63 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:75:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      75 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:91:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
      91 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:132:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     132 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:173:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     173 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:211:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     211 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:219:6: warning: no previous prototype for 'output_signal_defines' [-Wmissing-prototypes]
     219 | void output_signal_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/asm-offsets.c:257:6: warning: no previous prototype for 'output_smpboot_defines' [-Wmissing-prototypes]
     257 | void output_smpboot_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/loongarch/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/output_ptreg_defines +16 arch/loongarch/kernel/asm-offsets.c

7153c3cbb5b9b99 Huacai Chen 2022-05-31   15  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  @16  void output_ptreg_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31   17  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31   18  	COMMENT("LoongArch pt_regs offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31   19  	OFFSET(PT_R0, pt_regs, regs[0]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   20  	OFFSET(PT_R1, pt_regs, regs[1]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   21  	OFFSET(PT_R2, pt_regs, regs[2]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   22  	OFFSET(PT_R3, pt_regs, regs[3]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   23  	OFFSET(PT_R4, pt_regs, regs[4]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   24  	OFFSET(PT_R5, pt_regs, regs[5]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   25  	OFFSET(PT_R6, pt_regs, regs[6]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   26  	OFFSET(PT_R7, pt_regs, regs[7]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   27  	OFFSET(PT_R8, pt_regs, regs[8]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   28  	OFFSET(PT_R9, pt_regs, regs[9]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   29  	OFFSET(PT_R10, pt_regs, regs[10]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   30  	OFFSET(PT_R11, pt_regs, regs[11]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   31  	OFFSET(PT_R12, pt_regs, regs[12]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   32  	OFFSET(PT_R13, pt_regs, regs[13]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   33  	OFFSET(PT_R14, pt_regs, regs[14]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   34  	OFFSET(PT_R15, pt_regs, regs[15]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   35  	OFFSET(PT_R16, pt_regs, regs[16]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   36  	OFFSET(PT_R17, pt_regs, regs[17]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   37  	OFFSET(PT_R18, pt_regs, regs[18]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   38  	OFFSET(PT_R19, pt_regs, regs[19]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   39  	OFFSET(PT_R20, pt_regs, regs[20]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   40  	OFFSET(PT_R21, pt_regs, regs[21]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   41  	OFFSET(PT_R22, pt_regs, regs[22]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   42  	OFFSET(PT_R23, pt_regs, regs[23]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   43  	OFFSET(PT_R24, pt_regs, regs[24]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   44  	OFFSET(PT_R25, pt_regs, regs[25]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   45  	OFFSET(PT_R26, pt_regs, regs[26]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   46  	OFFSET(PT_R27, pt_regs, regs[27]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   47  	OFFSET(PT_R28, pt_regs, regs[28]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   48  	OFFSET(PT_R29, pt_regs, regs[29]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   49  	OFFSET(PT_R30, pt_regs, regs[30]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   50  	OFFSET(PT_R31, pt_regs, regs[31]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   51  	OFFSET(PT_CRMD, pt_regs, csr_crmd);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   52  	OFFSET(PT_PRMD, pt_regs, csr_prmd);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   53  	OFFSET(PT_EUEN, pt_regs, csr_euen);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   54  	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   55  	OFFSET(PT_ESTAT, pt_regs, csr_estat);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   56  	OFFSET(PT_ERA, pt_regs, csr_era);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   57  	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   58  	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   59  	DEFINE(PT_SIZE, sizeof(struct pt_regs));
7153c3cbb5b9b99 Huacai Chen 2022-05-31   60  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31   61  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31   62  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  @63  void output_task_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31   64  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31   65  	COMMENT("LoongArch task_struct offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31   66  	OFFSET(TASK_STATE, task_struct, __state);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   67  	OFFSET(TASK_THREAD_INFO, task_struct, stack);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   68  	OFFSET(TASK_FLAGS, task_struct, flags);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   69  	OFFSET(TASK_MM, task_struct, mm);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   70  	OFFSET(TASK_PID, task_struct, pid);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   71  	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
7153c3cbb5b9b99 Huacai Chen 2022-05-31   72  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31   73  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31   74  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  @75  void output_thread_info_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31   76  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31   77  	COMMENT("LoongArch thread_info offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31   78  	OFFSET(TI_TASK, thread_info, task);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   79  	OFFSET(TI_FLAGS, thread_info, flags);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   80  	OFFSET(TI_TP_VALUE, thread_info, tp_value);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   81  	OFFSET(TI_CPU, thread_info, cpu);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   82  	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   83  	OFFSET(TI_REGS, thread_info, regs);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   84  	DEFINE(_THREAD_SIZE, THREAD_SIZE);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   85  	DEFINE(_THREAD_MASK, THREAD_MASK);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   86  	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   87  	DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   88  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31   89  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31   90  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  @91  void output_thread_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31   92  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31   93  	COMMENT("LoongArch specific thread_struct offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31   94  	OFFSET(THREAD_REG01, task_struct, thread.reg01);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   95  	OFFSET(THREAD_REG03, task_struct, thread.reg03);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   96  	OFFSET(THREAD_REG22, task_struct, thread.reg22);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   97  	OFFSET(THREAD_REG23, task_struct, thread.reg23);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   98  	OFFSET(THREAD_REG24, task_struct, thread.reg24);
7153c3cbb5b9b99 Huacai Chen 2022-05-31   99  	OFFSET(THREAD_REG25, task_struct, thread.reg25);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  100  	OFFSET(THREAD_REG26, task_struct, thread.reg26);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  101  	OFFSET(THREAD_REG27, task_struct, thread.reg27);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  102  	OFFSET(THREAD_REG28, task_struct, thread.reg28);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  103  	OFFSET(THREAD_REG29, task_struct, thread.reg29);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  104  	OFFSET(THREAD_REG30, task_struct, thread.reg30);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  105  	OFFSET(THREAD_REG31, task_struct, thread.reg31);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  106  	OFFSET(THREAD_CSRCRMD, task_struct,
7153c3cbb5b9b99 Huacai Chen 2022-05-31  107  	       thread.csr_crmd);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  108  	OFFSET(THREAD_CSRPRMD, task_struct,
7153c3cbb5b9b99 Huacai Chen 2022-05-31  109  	       thread.csr_prmd);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  110  	OFFSET(THREAD_CSREUEN, task_struct,
7153c3cbb5b9b99 Huacai Chen 2022-05-31  111  	       thread.csr_euen);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  112  	OFFSET(THREAD_CSRECFG, task_struct,
7153c3cbb5b9b99 Huacai Chen 2022-05-31  113  	       thread.csr_ecfg);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  114  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  115  	OFFSET(THREAD_SCR0, task_struct, thread.scr0);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  116  	OFFSET(THREAD_SCR1, task_struct, thread.scr1);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  117  	OFFSET(THREAD_SCR2, task_struct, thread.scr2);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  118  	OFFSET(THREAD_SCR3, task_struct, thread.scr3);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  119  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  120  	OFFSET(THREAD_EFLAGS, task_struct, thread.eflags);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  121  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  122  	OFFSET(THREAD_FPU, task_struct, thread.fpu);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  123  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  124  	OFFSET(THREAD_BVADDR, task_struct, \
7153c3cbb5b9b99 Huacai Chen 2022-05-31  125  	       thread.csr_badvaddr);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  126  	OFFSET(THREAD_ECODE, task_struct, \
7153c3cbb5b9b99 Huacai Chen 2022-05-31  127  	       thread.error_code);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  128  	OFFSET(THREAD_TRAPNO, task_struct, thread.trap_nr);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  129  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  130  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31  131  
7153c3cbb5b9b99 Huacai Chen 2022-05-31 @132  void output_thread_fpu_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31  133  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31  134  	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  135  	OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  136  	OFFSET(THREAD_FPR2, loongarch_fpu, fpr[2]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  137  	OFFSET(THREAD_FPR3, loongarch_fpu, fpr[3]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  138  	OFFSET(THREAD_FPR4, loongarch_fpu, fpr[4]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  139  	OFFSET(THREAD_FPR5, loongarch_fpu, fpr[5]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  140  	OFFSET(THREAD_FPR6, loongarch_fpu, fpr[6]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  141  	OFFSET(THREAD_FPR7, loongarch_fpu, fpr[7]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  142  	OFFSET(THREAD_FPR8, loongarch_fpu, fpr[8]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  143  	OFFSET(THREAD_FPR9, loongarch_fpu, fpr[9]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  144  	OFFSET(THREAD_FPR10, loongarch_fpu, fpr[10]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  145  	OFFSET(THREAD_FPR11, loongarch_fpu, fpr[11]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  146  	OFFSET(THREAD_FPR12, loongarch_fpu, fpr[12]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  147  	OFFSET(THREAD_FPR13, loongarch_fpu, fpr[13]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  148  	OFFSET(THREAD_FPR14, loongarch_fpu, fpr[14]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  149  	OFFSET(THREAD_FPR15, loongarch_fpu, fpr[15]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  150  	OFFSET(THREAD_FPR16, loongarch_fpu, fpr[16]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  151  	OFFSET(THREAD_FPR17, loongarch_fpu, fpr[17]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  152  	OFFSET(THREAD_FPR18, loongarch_fpu, fpr[18]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  153  	OFFSET(THREAD_FPR19, loongarch_fpu, fpr[19]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  154  	OFFSET(THREAD_FPR20, loongarch_fpu, fpr[20]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  155  	OFFSET(THREAD_FPR21, loongarch_fpu, fpr[21]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  156  	OFFSET(THREAD_FPR22, loongarch_fpu, fpr[22]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  157  	OFFSET(THREAD_FPR23, loongarch_fpu, fpr[23]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  158  	OFFSET(THREAD_FPR24, loongarch_fpu, fpr[24]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  159  	OFFSET(THREAD_FPR25, loongarch_fpu, fpr[25]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  160  	OFFSET(THREAD_FPR26, loongarch_fpu, fpr[26]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  161  	OFFSET(THREAD_FPR27, loongarch_fpu, fpr[27]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  162  	OFFSET(THREAD_FPR28, loongarch_fpu, fpr[28]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  163  	OFFSET(THREAD_FPR29, loongarch_fpu, fpr[29]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  164  	OFFSET(THREAD_FPR30, loongarch_fpu, fpr[30]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  165  	OFFSET(THREAD_FPR31, loongarch_fpu, fpr[31]);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  166  
7153c3cbb5b9b99 Huacai Chen 2022-05-31  167  	OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  168  	OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  169  	OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  170  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  171  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31  172  
7153c3cbb5b9b99 Huacai Chen 2022-05-31 @173  void output_mm_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31  174  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31  175  	COMMENT("Size of struct page");
7153c3cbb5b9b99 Huacai Chen 2022-05-31  176  	DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
7153c3cbb5b9b99 Huacai Chen 2022-05-31  177  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  178  	COMMENT("Linux mm_struct offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31  179  	OFFSET(MM_USERS, mm_struct, mm_users);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  180  	OFFSET(MM_PGD, mm_struct, pgd);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  181  	OFFSET(MM_CONTEXT, mm_struct, context);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  182  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  183  	DEFINE(_PGD_T_SIZE, sizeof(pgd_t));
7153c3cbb5b9b99 Huacai Chen 2022-05-31  184  	DEFINE(_PMD_T_SIZE, sizeof(pmd_t));
7153c3cbb5b9b99 Huacai Chen 2022-05-31  185  	DEFINE(_PTE_T_SIZE, sizeof(pte_t));
7153c3cbb5b9b99 Huacai Chen 2022-05-31  186  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  187  	DEFINE(_PGD_T_LOG2, PGD_T_LOG2);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  188  #ifndef __PAGETABLE_PMD_FOLDED
7153c3cbb5b9b99 Huacai Chen 2022-05-31  189  	DEFINE(_PMD_T_LOG2, PMD_T_LOG2);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  190  #endif
7153c3cbb5b9b99 Huacai Chen 2022-05-31  191  	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  192  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  193  	DEFINE(_PGD_ORDER, PGD_ORDER);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  194  #ifndef __PAGETABLE_PMD_FOLDED
7153c3cbb5b9b99 Huacai Chen 2022-05-31  195  	DEFINE(_PMD_ORDER, PMD_ORDER);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  196  #endif
7153c3cbb5b9b99 Huacai Chen 2022-05-31  197  	DEFINE(_PTE_ORDER, PTE_ORDER);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  198  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  199  	DEFINE(_PMD_SHIFT, PMD_SHIFT);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  200  	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  201  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  202  	DEFINE(_PTRS_PER_PGD, PTRS_PER_PGD);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  203  	DEFINE(_PTRS_PER_PMD, PTRS_PER_PMD);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  204  	DEFINE(_PTRS_PER_PTE, PTRS_PER_PTE);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  205  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  206  	DEFINE(_PAGE_SHIFT, PAGE_SHIFT);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  207  	DEFINE(_PAGE_SIZE, PAGE_SIZE);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  208  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  209  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31  210  
7153c3cbb5b9b99 Huacai Chen 2022-05-31 @211  void output_sc_defines(void)
7153c3cbb5b9b99 Huacai Chen 2022-05-31  212  {
7153c3cbb5b9b99 Huacai Chen 2022-05-31  213  	COMMENT("Linux sigcontext offsets.");
7153c3cbb5b9b99 Huacai Chen 2022-05-31  214  	OFFSET(SC_REGS, sigcontext, sc_regs);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  215  	OFFSET(SC_PC, sigcontext, sc_pc);
7153c3cbb5b9b99 Huacai Chen 2022-05-31  216  	BLANK();
7153c3cbb5b9b99 Huacai Chen 2022-05-31  217  }
7153c3cbb5b9b99 Huacai Chen 2022-05-31  218  

:::::: The code at line 16 was first introduced by commit
:::::: 7153c3cbb5b9b99755659b97861fd4fc909ed86f LoongArch: Add misc common routines

:::::: TO: Huacai Chen <chenhuacai@loongson.cn>
:::::: CC: Huacai Chen <chenhuacai@loongson.cn>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

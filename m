Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E705748E01B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiAMWOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:14:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:52671 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235200AbiAMWOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642112047; x=1673648047;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mGqO5WmsnZqFn6V4XFtPM6EpmQW/xumA/+hpUuQaoRc=;
  b=m5iVGLzJEMurr90A7Z2DNRxkfNbB+PGo+qwW0Uz0PwtkcC6YcW/zJ8+u
   Q2E1i9Sft8cYo0xRo2Ovg4Ue+XsIfAyGSK9AWxtKMj8U2iqeOica8QATg
   K09rFdTAvN+3zn0YXASCoqrpeEIexGyMLz1w56vkdLePisx1PCHK91F/r
   xfOJL6LzLFKmvkSVr15h6ASb3dHcbFSLHlq50kiVEer5Q/LWmNMFwy9Cs
   o3t8da4dgVzzKpE+cCZ/jNHT7O2KiAbmh0jrtme+YlTTwGr4UjgaZorfx
   8m3GlGD87V53TbAPHgccJUmD+ha09vKYuCAZLBgVASnFsV0NHaEPWl9+X
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244079854"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244079854"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 14:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="516108016"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2022 14:14:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n88M8-0007hY-RK; Thu, 13 Jan 2022 22:14:04 +0000
Date:   Fri, 14 Jan 2022 06:13:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration
 of function 'nmi_cpu_backtrace'
Message-ID: <202201140631.ZuSwa9QF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb3b0673b7d5b477ed104949450cd511337ba3c6
commit: 1614b2b11fab29dd4ff31ebba9d266961f5af69e arch: Make ARCH_STACKWALK independent of STACKTRACE
date:   5 weeks ago
config: powerpc64-randconfig-r025-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140631.ZuSwa9QF-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1614b2b11fab29dd4ff31ebba9d266961f5af69e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1614b2b11fab29dd4ff31ebba9d266961f5af69e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/stacktrace.c: In function 'handle_backtrace_ipi':
>> arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of function 'nmi_cpu_backtrace' [-Werror=implicit-function-declaration]
     171 |         nmi_cpu_backtrace(regs);
         |         ^~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/stacktrace.c: At top level:
   arch/powerpc/kernel/stacktrace.c:224:6: warning: no previous prototype for 'arch_trigger_cpumask_backtrace' [-Wmissing-prototypes]
     224 | void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/stacktrace.c: In function 'arch_trigger_cpumask_backtrace':
>> arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of function 'nmi_trigger_cpumask_backtrace'; did you mean 'arch_trigger_cpumask_backtrace'? [-Werror=implicit-function-declaration]
     226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         arch_trigger_cpumask_backtrace
   cc1: some warnings being treated as errors


vim +/nmi_cpu_backtrace +171 arch/powerpc/kernel/stacktrace.c

018cce33c5e62d Christophe Leroy 2019-01-31  167  
e08ecba17b72ae Michael Ellerman 2018-06-19  168  #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
5cc05910f26e6f Michael Ellerman 2018-05-02  169  static void handle_backtrace_ipi(struct pt_regs *regs)
5cc05910f26e6f Michael Ellerman 2018-05-02  170  {
5cc05910f26e6f Michael Ellerman 2018-05-02 @171  	nmi_cpu_backtrace(regs);
5cc05910f26e6f Michael Ellerman 2018-05-02  172  }
5cc05910f26e6f Michael Ellerman 2018-05-02  173  
5cc05910f26e6f Michael Ellerman 2018-05-02  174  static void raise_backtrace_ipi(cpumask_t *mask)
5cc05910f26e6f Michael Ellerman 2018-05-02  175  {
7c6986ade69e3c Michael Ellerman 2021-06-25  176  	struct paca_struct *p;
5cc05910f26e6f Michael Ellerman 2018-05-02  177  	unsigned int cpu;
7c6986ade69e3c Michael Ellerman 2021-06-25  178  	u64 delay_us;
5cc05910f26e6f Michael Ellerman 2018-05-02  179  
5cc05910f26e6f Michael Ellerman 2018-05-02  180  	for_each_cpu(cpu, mask) {
7c6986ade69e3c Michael Ellerman 2021-06-25  181  		if (cpu == smp_processor_id()) {
5cc05910f26e6f Michael Ellerman 2018-05-02  182  			handle_backtrace_ipi(NULL);
7c6986ade69e3c Michael Ellerman 2021-06-25  183  			continue;
5cc05910f26e6f Michael Ellerman 2018-05-02  184  		}
5cc05910f26e6f Michael Ellerman 2018-05-02  185  
7c6986ade69e3c Michael Ellerman 2021-06-25  186  		delay_us = 5 * USEC_PER_SEC;
7c6986ade69e3c Michael Ellerman 2021-06-25  187  
7c6986ade69e3c Michael Ellerman 2021-06-25  188  		if (smp_send_safe_nmi_ipi(cpu, handle_backtrace_ipi, delay_us)) {
7c6986ade69e3c Michael Ellerman 2021-06-25  189  			// Now wait up to 5s for the other CPU to do its backtrace
7c6986ade69e3c Michael Ellerman 2021-06-25  190  			while (cpumask_test_cpu(cpu, mask) && delay_us) {
7c6986ade69e3c Michael Ellerman 2021-06-25  191  				udelay(1);
7c6986ade69e3c Michael Ellerman 2021-06-25  192  				delay_us--;
7c6986ade69e3c Michael Ellerman 2021-06-25  193  			}
7c6986ade69e3c Michael Ellerman 2021-06-25  194  
7c6986ade69e3c Michael Ellerman 2021-06-25  195  			// Other CPU cleared itself from the mask
7c6986ade69e3c Michael Ellerman 2021-06-25  196  			if (delay_us)
7c6986ade69e3c Michael Ellerman 2021-06-25  197  				continue;
7c6986ade69e3c Michael Ellerman 2021-06-25  198  		}
7c6986ade69e3c Michael Ellerman 2021-06-25  199  
7c6986ade69e3c Michael Ellerman 2021-06-25  200  		p = paca_ptrs[cpu];
5cc05910f26e6f Michael Ellerman 2018-05-02  201  
5cc05910f26e6f Michael Ellerman 2018-05-02  202  		cpumask_clear_cpu(cpu, mask);
5cc05910f26e6f Michael Ellerman 2018-05-02  203  
5cc05910f26e6f Michael Ellerman 2018-05-02  204  		pr_warn("CPU %d didn't respond to backtrace IPI, inspecting paca.\n", cpu);
5cc05910f26e6f Michael Ellerman 2018-05-02  205  		if (!virt_addr_valid(p)) {
5cc05910f26e6f Michael Ellerman 2018-05-02  206  			pr_warn("paca pointer appears corrupt? (%px)\n", p);
5cc05910f26e6f Michael Ellerman 2018-05-02  207  			continue;
5cc05910f26e6f Michael Ellerman 2018-05-02  208  		}
5cc05910f26e6f Michael Ellerman 2018-05-02  209  
5cc05910f26e6f Michael Ellerman 2018-05-02  210  		pr_warn("irq_soft_mask: 0x%02x in_mce: %d in_nmi: %d",
5cc05910f26e6f Michael Ellerman 2018-05-02  211  			p->irq_soft_mask, p->in_mce, p->in_nmi);
5cc05910f26e6f Michael Ellerman 2018-05-02  212  
5cc05910f26e6f Michael Ellerman 2018-05-02  213  		if (virt_addr_valid(p->__current))
5cc05910f26e6f Michael Ellerman 2018-05-02  214  			pr_cont(" current: %d (%s)\n", p->__current->pid,
5cc05910f26e6f Michael Ellerman 2018-05-02  215  				p->__current->comm);
5cc05910f26e6f Michael Ellerman 2018-05-02  216  		else
5cc05910f26e6f Michael Ellerman 2018-05-02  217  			pr_cont(" current pointer corrupt? (%px)\n", p->__current);
5cc05910f26e6f Michael Ellerman 2018-05-02  218  
5cc05910f26e6f Michael Ellerman 2018-05-02  219  		pr_warn("Back trace of paca->saved_r1 (0x%016llx) (possibly stale):\n", p->saved_r1);
9cb8f069deeed7 Dmitry Safonov   2020-06-08  220  		show_stack(p->__current, (unsigned long *)p->saved_r1, KERN_WARNING);
5cc05910f26e6f Michael Ellerman 2018-05-02  221  	}
5cc05910f26e6f Michael Ellerman 2018-05-02  222  }
5cc05910f26e6f Michael Ellerman 2018-05-02  223  
5cc05910f26e6f Michael Ellerman 2018-05-02  224  void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
5cc05910f26e6f Michael Ellerman 2018-05-02  225  {
5cc05910f26e6f Michael Ellerman 2018-05-02 @226  	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);

:::::: The code at line 171 was first introduced by commit
:::::: 5cc05910f26e6fd6da15f052f86f6150e4b91664 powerpc/64s: Wire up arch_trigger_cpumask_backtrace()

:::::: TO: Michael Ellerman <mpe@ellerman.id.au>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

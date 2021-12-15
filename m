Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AB4754ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhLOJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:14:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:46569 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhLOJO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639559698; x=1671095698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ww8YFhZjlV+lY2z8D7ci3JSnJj2dHRzhsBtQXZ3CiT4=;
  b=afFqBpTj5uWG+vku44ppNaWvbVW/6kjPXV8ciyjtSxruoe7jf4g+/gYV
   yS4azULNV7Yi2iKAPClVhOj0PBoDR40+KIwjkEy6EYw/JuI9IEkuuL9pG
   sBvSvGQqHLeOS62rII2hgUQo9K68TYueLORu/OB6SNawjj4rVlh1+vzNJ
   qGZoUJoXJ+OJ63oOe3cX25siTCHpOmkwlELCaqExmgryZKswN9lz5ivXV
   COgoeOLnNS89n2BTQhnDWisiJUMM+4XjERLWjvOlOzHfqocnWeu+X0cIq
   u6yvuMsGiH/otp22lRKhJxB7euBwat3zfvShdYFumpGQDy4yQq5zjBwYB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302561471"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302561471"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 01:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505718547"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 01:14:55 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxQNC-0001XI-EX; Wed, 15 Dec 2021 09:14:54 +0000
Date:   Wed, 15 Dec 2021 17:14:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dirk Mueller <dmueller@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [linux-stable-rc:queue/4.14 3742/9999]
 arch/powerpc/kernel/traps.c:1658:6: error: no previous declaration for
 'DebugException'
Message-ID: <202112151740.QoiLaP9D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dirk,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
head:   93489bfff5495e498b3932e011b0221ff242e0b7
commit: 88f7a6aa7fb9aa5076b65489146045dac865f1d3 [3742/9999] scripts/dtc: Remove redundant YYLOC global declaration
config: powerpc-randconfig-r003-20211214 (https://download.01.org/0day-ci/archive/20211215/202112151740.QoiLaP9D-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=88f7a6aa7fb9aa5076b65489146045dac865f1d3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.14
        git checkout 88f7a6aa7fb9aa5076b65489146045dac865f1d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:14:0,
                    from arch/powerpc/include/asm/sections.h:7,
                    from include/linux/interrupt.h:22,
                    from arch/powerpc/kernel/traps.c:27:
   arch/powerpc/kernel/traps.c: In function 'emulate_string_inst':
   arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:253:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_READ, __gu_addr, (size))) {  \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro '__get_user_check'
     __get_user_check((x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:889:9: note: in expansion of macro 'get_user'
        if (get_user(val, (u8 __user *)EA))
            ^~~~~~~~
   arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:160:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_WRITE, __pu_addr, size))   \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:82:2: note: in expansion of macro '__put_user_check'
     __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:900:9: note: in expansion of macro 'put_user'
        if (put_user(val, (u8 __user *)EA))
            ^~~~~~~~
   arch/powerpc/kernel/traps.c: At top level:
   arch/powerpc/kernel/traps.c:1281:6: error: no previous declaration for 'slb_miss_bad_addr' [-Werror=missing-declarations]
    void slb_miss_bad_addr(struct pt_regs *regs)
         ^~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/traps.c:1658:6: error: no previous declaration for 'DebugException' [-Werror=missing-declarations]
    void DebugException(struct pt_regs *regs, unsigned long debug_status)
         ^~~~~~~~~~~~~~
>> arch/powerpc/kernel/traps.c:1771:6: error: no previous declaration for 'CacheLockingException' [-Werror=missing-declarations]
    void CacheLockingException(struct pt_regs *regs, unsigned long address,
         ^~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:1785:6: error: no previous declaration for 'SPEFloatingPointException' [-Werror=missing-declarations]
    void SPEFloatingPointException(struct pt_regs *regs)
         ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/traps.c:1833:6: error: no previous declaration for 'SPEFloatingPointRoundException' [-Werror=missing-declarations]
    void SPEFloatingPointRoundException(struct pt_regs *regs)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/traps.c:1884:29: error: no previous declaration for 'WatchdogHandler' [-Werror=missing-declarations]
    void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
                                ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/uaccess.h:14:0,
                    from include/asm-generic/termios-base.h:8,
                    from arch/powerpc/include/asm/termios.h:20,
                    from include/uapi/linux/termios.h:6,
                    from include/linux/tty.h:7,
                    from arch/powerpc/kernel/setup_32.c:13:
   include/asm-generic/termios-base.h: In function 'user_termio_to_kernel_termios':
   arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:253:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_READ, __gu_addr, (size))) {  \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:80:2: note: in expansion of macro '__get_user_check'
     __get_user_check((x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   include/asm-generic/termios-base.h:36:6: note: in expansion of macro 'get_user'
     if (get_user(termios->c_line, &termio->c_line) < 0)
         ^~~~~~~~
   include/asm-generic/termios-base.h: In function 'kernel_termios_to_user_termio':
   arch/powerpc/include/asm/uaccess.h:52:35: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
      (((size) == 0) || (((size) - 1) <= ((segment).seg - (addr)))))
                                      ^
   arch/powerpc/include/asm/uaccess.h:58:3: note: in expansion of macro '__access_ok'
      __access_ok((__force unsigned long)(addr), (size), get_fs()))
      ^~~~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:160:6: note: in expansion of macro 'access_ok'
     if (access_ok(VERIFY_WRITE, __pu_addr, size))   \
         ^~~~~~~~~
   arch/powerpc/include/asm/uaccess.h:82:2: note: in expansion of macro '__put_user_check'
     __put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
     ^~~~~~~~~~~~~~~~
   include/asm-generic/termios-base.h:58:6: note: in expansion of macro 'put_user'
         put_user(termios->c_line,  &termio->c_line) < 0 ||
         ^~~~~~~~
   arch/powerpc/kernel/setup_32.c: At top level:
   arch/powerpc/kernel/setup_32.c:68:30: error: no previous declaration for 'early_init' [-Werror=missing-declarations]
    notrace unsigned long __init early_init(unsigned long dt_ptr)
                                 ^~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:99:21: error: no previous declaration for 'machine_init' [-Werror=missing-declarations]
    notrace void __init machine_init(u64 dt_ptr)
                        ^~~~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:124:12: error: no previous declaration for 'ppc_setup_l2cr' [-Werror=missing-declarations]
    int __init ppc_setup_l2cr(char *str)
               ^~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:137:12: error: no previous declaration for 'ppc_setup_l3cr' [-Werror=missing-declarations]
    int __init ppc_setup_l3cr(char *str)
               ^~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:183:12: error: no previous declaration for 'ppc_init' [-Werror=missing-declarations]
    int __init ppc_init(void)
               ^~~~~~~~
   arch/powerpc/kernel/setup_32.c:198:13: error: no previous declaration for 'irqstack_early_init' [-Werror=missing-declarations]
    void __init irqstack_early_init(void)
                ^~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/setup_32.c:213:13: error: no previous declaration for 'exc_lvl_early_init' [-Werror=missing-declarations]
    void __init exc_lvl_early_init(void)
                ^~~~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:238:13: error: no previous declaration for 'setup_power_save' [-Werror=missing-declarations]
    void __init setup_power_save(void)
                ^~~~~~~~~~~~~~~~
   arch/powerpc/kernel/setup_32.c:253:13: error: no previous declaration for 'initialize_cache_info' [-Werror=missing-declarations]
    __init void initialize_cache_info(void)
                ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/powerpc/mm/fsl_booke_mmu.c:70:15: error: no previous declaration for 'tlbcam_sz' [-Werror=missing-declarations]
    unsigned long tlbcam_sz(int idx)
                  ^~~~~~~~~
>> arch/powerpc/mm/fsl_booke_mmu.c:269:21: error: no previous declaration for 'relocate_init' [-Werror=missing-declarations]
    notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
                        ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/hugetlb.h:444:0,
                    from arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:50:
   arch/powerpc/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
   arch/powerpc/include/asm/hugetlb.h:167:8: error: variable 'pte' set but not used [-Werror=unused-but-set-variable]
     pte_t pte;
           ^~~
   arch/powerpc/kvm/../../../virt/kvm/kvm_main.c: At top level:
>> arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:140:13: error: no previous declaration for 'kvm_arch_mmu_notifier_invalidate_range' [-Werror=missing-declarations]
    __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:635:12: error: no previous declaration for 'kvm_arch_post_init_vm' [-Werror=missing-declarations]
    int __weak kvm_arch_post_init_vm(struct kvm *kvm)
               ^~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:644:13: error: no previous declaration for 'kvm_arch_pre_destroy_vm' [-Werror=missing-declarations]
    void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kvm_host.h:14:0,
                    from arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:21:
   include/linux/signal.h: In function 'sigemptyset':
   include/linux/signal.h:178:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
     case 2: set->sig[1] = 0;
             ~~~~~~~~~~~~^~~
   include/linux/signal.h:179:2: note: here
     case 1: set->sig[0] = 0;
     ^~~~
   cc1: all warnings being treated as errors
--
>> arch/powerpc/kvm/booke.c:602:6: error: no previous declaration for 'kvmppc_watchdog_func' [-Werror=missing-declarations]
    void kvmppc_watchdog_func(unsigned long data)
         ^~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kvm/booke.c:985:5: error: no previous declaration for 'kvmppc_handle_exit' [-Werror=missing-declarations]
    int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
        ^~~~~~~~~~~~~~~~~~
>> arch/powerpc/kvm/booke.c:1921:6: error: no previous declaration for 'kvm_guest_protect_msr' [-Werror=missing-declarations]
    void kvm_guest_protect_msr(struct kvm_vcpu *vcpu, ulong prot_bitmap, bool set)
         ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/hugetlb.h:444:0,
                    from arch/powerpc/kvm/e500_mmu.c:31:
   arch/powerpc/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
   arch/powerpc/include/asm/hugetlb.h:167:8: error: variable 'pte' set but not used [-Werror=unused-but-set-variable]
     pte_t pte;
           ^~~
   arch/powerpc/kvm/e500_mmu.c: At top level:
>> arch/powerpc/kvm/e500_mmu.c:539:6: error: no previous declaration for 'kvmppc_mmu_destroy_e500' [-Werror=missing-declarations]
    void kvmppc_mmu_destroy_e500(struct kvm_vcpu *vcpu)
         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   arch/powerpc/kvm/mpic.c: In function 'kvmppc_mpic_connect_vcpu':
>> arch/powerpc/kvm/mpic.c:1743:10: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
     if (cpu < 0 || cpu >= MAX_CPU)
             ^
   cc1: all warnings being treated as errors


vim +/DebugException +1658 arch/powerpc/kernel/traps.c

14cf11af6cf608 Paul Mackerras     2005-09-26  1657  
03465f899bdac7 Nicholas Piggin    2016-09-16 @1658  void DebugException(struct pt_regs *regs, unsigned long debug_status)
14cf11af6cf608 Paul Mackerras     2005-09-26  1659  {
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1660  	current->thread.debug.dbsr = debug_status;
3bffb6529cf10d Dave Kleikamp      2010-02-08  1661  
ec097c84dff175 Roland McGrath     2009-05-28  1662  	/* Hack alert: On BookE, Branch Taken stops on the branch itself, while
ec097c84dff175 Roland McGrath     2009-05-28  1663  	 * on server, it stops on the target of the branch. In order to simulate
ec097c84dff175 Roland McGrath     2009-05-28  1664  	 * the server behaviour, we thus restart right away with a single step
ec097c84dff175 Roland McGrath     2009-05-28  1665  	 * instead of stopping here when hitting a BT
ec097c84dff175 Roland McGrath     2009-05-28  1666  	 */
ec097c84dff175 Roland McGrath     2009-05-28  1667  	if (debug_status & DBSR_BT) {
ec097c84dff175 Roland McGrath     2009-05-28  1668  		regs->msr &= ~MSR_DE;
ec097c84dff175 Roland McGrath     2009-05-28  1669  
ec097c84dff175 Roland McGrath     2009-05-28  1670  		/* Disable BT */
ec097c84dff175 Roland McGrath     2009-05-28  1671  		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_BT);
ec097c84dff175 Roland McGrath     2009-05-28  1672  		/* Clear the BT event */
ec097c84dff175 Roland McGrath     2009-05-28  1673  		mtspr(SPRN_DBSR, DBSR_BT);
ec097c84dff175 Roland McGrath     2009-05-28  1674  
ec097c84dff175 Roland McGrath     2009-05-28  1675  		/* Do the single step trick only when coming from userspace */
ec097c84dff175 Roland McGrath     2009-05-28  1676  		if (user_mode(regs)) {
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1677  			current->thread.debug.dbcr0 &= ~DBCR0_BT;
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1678  			current->thread.debug.dbcr0 |= DBCR0_IDM | DBCR0_IC;
ec097c84dff175 Roland McGrath     2009-05-28  1679  			regs->msr |= MSR_DE;
ec097c84dff175 Roland McGrath     2009-05-28  1680  			return;
ec097c84dff175 Roland McGrath     2009-05-28  1681  		}
ec097c84dff175 Roland McGrath     2009-05-28  1682  
6cc89bad60a673 Naveen N. Rao      2016-11-21  1683  		if (kprobe_post_handler(regs))
6cc89bad60a673 Naveen N. Rao      2016-11-21  1684  			return;
6cc89bad60a673 Naveen N. Rao      2016-11-21  1685  
ec097c84dff175 Roland McGrath     2009-05-28  1686  		if (notify_die(DIE_SSTEP, "block_step", regs, 5,
ec097c84dff175 Roland McGrath     2009-05-28  1687  			       5, SIGTRAP) == NOTIFY_STOP) {
ec097c84dff175 Roland McGrath     2009-05-28  1688  			return;
ec097c84dff175 Roland McGrath     2009-05-28  1689  		}
ec097c84dff175 Roland McGrath     2009-05-28  1690  		if (debugger_sstep(regs))
ec097c84dff175 Roland McGrath     2009-05-28  1691  			return;
ec097c84dff175 Roland McGrath     2009-05-28  1692  	} else if (debug_status & DBSR_IC) { 	/* Instruction complete */
14cf11af6cf608 Paul Mackerras     2005-09-26  1693  		regs->msr &= ~MSR_DE;
f82796214a95b1 Kumar Gala         2008-06-26  1694  
14cf11af6cf608 Paul Mackerras     2005-09-26  1695  		/* Disable instruction completion */
14cf11af6cf608 Paul Mackerras     2005-09-26  1696  		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
14cf11af6cf608 Paul Mackerras     2005-09-26  1697  		/* Clear the instruction completion event */
14cf11af6cf608 Paul Mackerras     2005-09-26  1698  		mtspr(SPRN_DBSR, DBSR_IC);
f82796214a95b1 Kumar Gala         2008-06-26  1699  
6cc89bad60a673 Naveen N. Rao      2016-11-21  1700  		if (kprobe_post_handler(regs))
6cc89bad60a673 Naveen N. Rao      2016-11-21  1701  			return;
6cc89bad60a673 Naveen N. Rao      2016-11-21  1702  
f82796214a95b1 Kumar Gala         2008-06-26  1703  		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
f82796214a95b1 Kumar Gala         2008-06-26  1704  			       5, SIGTRAP) == NOTIFY_STOP) {
f82796214a95b1 Kumar Gala         2008-06-26  1705  			return;
f82796214a95b1 Kumar Gala         2008-06-26  1706  		}
f82796214a95b1 Kumar Gala         2008-06-26  1707  
14cf11af6cf608 Paul Mackerras     2005-09-26  1708  		if (debugger_sstep(regs))
14cf11af6cf608 Paul Mackerras     2005-09-26  1709  			return;
f82796214a95b1 Kumar Gala         2008-06-26  1710  
d6a61bfc06d6f2 Luis Machado       2008-07-24  1711  		if (user_mode(regs)) {
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1712  			current->thread.debug.dbcr0 &= ~DBCR0_IC;
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1713  			if (DBCR_ACTIVE_EVENTS(current->thread.debug.dbcr0,
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1714  					       current->thread.debug.dbcr1))
3bffb6529cf10d Dave Kleikamp      2010-02-08  1715  				regs->msr |= MSR_DE;
3bffb6529cf10d Dave Kleikamp      2010-02-08  1716  			else
3bffb6529cf10d Dave Kleikamp      2010-02-08  1717  				/* Make sure the IDM bit is off */
51ae8d4a2b9e4a Bharat Bhushan     2013-07-04  1718  				current->thread.debug.dbcr0 &= ~DBCR0_IDM;
14cf11af6cf608 Paul Mackerras     2005-09-26  1719  		}
3bffb6529cf10d Dave Kleikamp      2010-02-08  1720  
3bffb6529cf10d Dave Kleikamp      2010-02-08  1721  		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
3bffb6529cf10d Dave Kleikamp      2010-02-08  1722  	} else
3bffb6529cf10d Dave Kleikamp      2010-02-08  1723  		handle_debug(regs, debug_status);
14cf11af6cf608 Paul Mackerras     2005-09-26  1724  }
03465f899bdac7 Nicholas Piggin    2016-09-16  1725  NOKPROBE_SYMBOL(DebugException);
172ae2e7f8ff90 Dave Kleikamp      2010-02-08  1726  #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
14cf11af6cf608 Paul Mackerras     2005-09-26  1727  
14cf11af6cf608 Paul Mackerras     2005-09-26  1728  #if !defined(CONFIG_TAU_INT)
14cf11af6cf608 Paul Mackerras     2005-09-26  1729  void TAUException(struct pt_regs *regs)
14cf11af6cf608 Paul Mackerras     2005-09-26  1730  {
14cf11af6cf608 Paul Mackerras     2005-09-26  1731  	printk("TAU trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
14cf11af6cf608 Paul Mackerras     2005-09-26  1732  	       regs->nip, regs->msr, regs->trap, print_tainted());
14cf11af6cf608 Paul Mackerras     2005-09-26  1733  }
14cf11af6cf608 Paul Mackerras     2005-09-26  1734  #endif /* CONFIG_INT_TAU */
14cf11af6cf608 Paul Mackerras     2005-09-26  1735  
14cf11af6cf608 Paul Mackerras     2005-09-26  1736  #ifdef CONFIG_ALTIVEC
dc1c1ca3dcd94c Stephen Rothwell   2005-10-01  1737  void altivec_assist_exception(struct pt_regs *regs)
14cf11af6cf608 Paul Mackerras     2005-09-26  1738  {
14cf11af6cf608 Paul Mackerras     2005-09-26  1739  	int err;
14cf11af6cf608 Paul Mackerras     2005-09-26  1740  
14cf11af6cf608 Paul Mackerras     2005-09-26  1741  	if (!user_mode(regs)) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1742  		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
14cf11af6cf608 Paul Mackerras     2005-09-26  1743  		       " at %lx\n", regs->nip);
8dad3f9257414f Paul Mackerras     2005-10-06  1744  		die("Kernel VMX/Altivec assist exception", regs, SIGILL);
14cf11af6cf608 Paul Mackerras     2005-09-26  1745  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1746  
dc1c1ca3dcd94c Stephen Rothwell   2005-10-01  1747  	flush_altivec_to_thread(current);
dc1c1ca3dcd94c Stephen Rothwell   2005-10-01  1748  
eecff81d1fcda2 Anton Blanchard    2009-10-27  1749  	PPC_WARN_EMULATED(altivec, regs);
14cf11af6cf608 Paul Mackerras     2005-09-26  1750  	err = emulate_altivec(regs);
14cf11af6cf608 Paul Mackerras     2005-09-26  1751  	if (err == 0) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1752  		regs->nip += 4;		/* skip emulated instruction */
14cf11af6cf608 Paul Mackerras     2005-09-26  1753  		emulate_single_step(regs);
14cf11af6cf608 Paul Mackerras     2005-09-26  1754  		return;
14cf11af6cf608 Paul Mackerras     2005-09-26  1755  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1756  
14cf11af6cf608 Paul Mackerras     2005-09-26  1757  	if (err == -EFAULT) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1758  		/* got an error reading the instruction */
14cf11af6cf608 Paul Mackerras     2005-09-26  1759  		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
14cf11af6cf608 Paul Mackerras     2005-09-26  1760  	} else {
14cf11af6cf608 Paul Mackerras     2005-09-26  1761  		/* didn't recognize the instruction */
14cf11af6cf608 Paul Mackerras     2005-09-26  1762  		/* XXX quick hack for now: set the non-Java bit in the VSCR */
76462232c21dc0 Christian Dietrich 2011-06-04  1763  		printk_ratelimited(KERN_ERR "Unrecognized altivec instruction "
14cf11af6cf608 Paul Mackerras     2005-09-26  1764  				   "in %s at %lx\n", current->comm, regs->nip);
de79f7b9f6f92e Paul Mackerras     2013-09-10  1765  		current->thread.vr_state.vscr.u[3] |= 0x10000;
14cf11af6cf608 Paul Mackerras     2005-09-26  1766  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1767  }
14cf11af6cf608 Paul Mackerras     2005-09-26  1768  #endif /* CONFIG_ALTIVEC */
14cf11af6cf608 Paul Mackerras     2005-09-26  1769  
14cf11af6cf608 Paul Mackerras     2005-09-26  1770  #ifdef CONFIG_FSL_BOOKE
14cf11af6cf608 Paul Mackerras     2005-09-26 @1771  void CacheLockingException(struct pt_regs *regs, unsigned long address,
14cf11af6cf608 Paul Mackerras     2005-09-26  1772  			   unsigned long error_code)
14cf11af6cf608 Paul Mackerras     2005-09-26  1773  {
14cf11af6cf608 Paul Mackerras     2005-09-26  1774  	/* We treat cache locking instructions from the user
14cf11af6cf608 Paul Mackerras     2005-09-26  1775  	 * as priv ops, in the future we could try to do
14cf11af6cf608 Paul Mackerras     2005-09-26  1776  	 * something smarter
14cf11af6cf608 Paul Mackerras     2005-09-26  1777  	 */
14cf11af6cf608 Paul Mackerras     2005-09-26  1778  	if (error_code & (ESR_DLK|ESR_ILK))
14cf11af6cf608 Paul Mackerras     2005-09-26  1779  		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
14cf11af6cf608 Paul Mackerras     2005-09-26  1780  	return;
14cf11af6cf608 Paul Mackerras     2005-09-26  1781  }
14cf11af6cf608 Paul Mackerras     2005-09-26  1782  #endif /* CONFIG_FSL_BOOKE */
14cf11af6cf608 Paul Mackerras     2005-09-26  1783  
14cf11af6cf608 Paul Mackerras     2005-09-26  1784  #ifdef CONFIG_SPE
14cf11af6cf608 Paul Mackerras     2005-09-26  1785  void SPEFloatingPointException(struct pt_regs *regs)
14cf11af6cf608 Paul Mackerras     2005-09-26  1786  {
6a800f36acd5bf Liu Yu             2008-10-28  1787  	extern int do_spe_mathemu(struct pt_regs *regs);
14cf11af6cf608 Paul Mackerras     2005-09-26  1788  	unsigned long spefscr;
14cf11af6cf608 Paul Mackerras     2005-09-26  1789  	int fpexc_mode;
14cf11af6cf608 Paul Mackerras     2005-09-26  1790  	int code = 0;
6a800f36acd5bf Liu Yu             2008-10-28  1791  	int err;
6a800f36acd5bf Liu Yu             2008-10-28  1792  
685659ee70db0b yu liu             2011-06-14  1793  	flush_spe_to_thread(current);
14cf11af6cf608 Paul Mackerras     2005-09-26  1794  
14cf11af6cf608 Paul Mackerras     2005-09-26  1795  	spefscr = current->thread.spefscr;
14cf11af6cf608 Paul Mackerras     2005-09-26  1796  	fpexc_mode = current->thread.fpexc_mode;
14cf11af6cf608 Paul Mackerras     2005-09-26  1797  
14cf11af6cf608 Paul Mackerras     2005-09-26  1798  	if ((spefscr & SPEFSCR_FOVF) && (fpexc_mode & PR_FP_EXC_OVF)) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1799  		code = FPE_FLTOVF;
14cf11af6cf608 Paul Mackerras     2005-09-26  1800  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1801  	else if ((spefscr & SPEFSCR_FUNF) && (fpexc_mode & PR_FP_EXC_UND)) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1802  		code = FPE_FLTUND;
14cf11af6cf608 Paul Mackerras     2005-09-26  1803  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1804  	else if ((spefscr & SPEFSCR_FDBZ) && (fpexc_mode & PR_FP_EXC_DIV))
14cf11af6cf608 Paul Mackerras     2005-09-26  1805  		code = FPE_FLTDIV;
14cf11af6cf608 Paul Mackerras     2005-09-26  1806  	else if ((spefscr & SPEFSCR_FINV) && (fpexc_mode & PR_FP_EXC_INV)) {
14cf11af6cf608 Paul Mackerras     2005-09-26  1807  		code = FPE_FLTINV;
14cf11af6cf608 Paul Mackerras     2005-09-26  1808  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1809  	else if ((spefscr & (SPEFSCR_FG | SPEFSCR_FX)) && (fpexc_mode & PR_FP_EXC_RES))
14cf11af6cf608 Paul Mackerras     2005-09-26  1810  		code = FPE_FLTRES;
14cf11af6cf608 Paul Mackerras     2005-09-26  1811  
6a800f36acd5bf Liu Yu             2008-10-28  1812  	err = do_spe_mathemu(regs);
6a800f36acd5bf Liu Yu             2008-10-28  1813  	if (err == 0) {
6a800f36acd5bf Liu Yu             2008-10-28  1814  		regs->nip += 4;		/* skip emulated instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1815  		emulate_single_step(regs);
6a800f36acd5bf Liu Yu             2008-10-28  1816  		return;
6a800f36acd5bf Liu Yu             2008-10-28  1817  	}
14cf11af6cf608 Paul Mackerras     2005-09-26  1818  
6a800f36acd5bf Liu Yu             2008-10-28  1819  	if (err == -EFAULT) {
6a800f36acd5bf Liu Yu             2008-10-28  1820  		/* got an error reading the instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1821  		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1822  	} else if (err == -EINVAL) {
6a800f36acd5bf Liu Yu             2008-10-28  1823  		/* didn't recognize the instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1824  		printk(KERN_ERR "unrecognized spe instruction "
6a800f36acd5bf Liu Yu             2008-10-28  1825  		       "in %s at %lx\n", current->comm, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1826  	} else {
14cf11af6cf608 Paul Mackerras     2005-09-26  1827  		_exception(SIGFPE, regs, code, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1828  	}
6a800f36acd5bf Liu Yu             2008-10-28  1829  
14cf11af6cf608 Paul Mackerras     2005-09-26  1830  	return;
14cf11af6cf608 Paul Mackerras     2005-09-26  1831  }
6a800f36acd5bf Liu Yu             2008-10-28  1832  
6a800f36acd5bf Liu Yu             2008-10-28 @1833  void SPEFloatingPointRoundException(struct pt_regs *regs)
6a800f36acd5bf Liu Yu             2008-10-28  1834  {
6a800f36acd5bf Liu Yu             2008-10-28  1835  	extern int speround_handler(struct pt_regs *regs);
6a800f36acd5bf Liu Yu             2008-10-28  1836  	int err;
6a800f36acd5bf Liu Yu             2008-10-28  1837  
6a800f36acd5bf Liu Yu             2008-10-28  1838  	preempt_disable();
6a800f36acd5bf Liu Yu             2008-10-28  1839  	if (regs->msr & MSR_SPE)
6a800f36acd5bf Liu Yu             2008-10-28  1840  		giveup_spe(current);
6a800f36acd5bf Liu Yu             2008-10-28  1841  	preempt_enable();
6a800f36acd5bf Liu Yu             2008-10-28  1842  
6a800f36acd5bf Liu Yu             2008-10-28  1843  	regs->nip -= 4;
6a800f36acd5bf Liu Yu             2008-10-28  1844  	err = speround_handler(regs);
6a800f36acd5bf Liu Yu             2008-10-28  1845  	if (err == 0) {
6a800f36acd5bf Liu Yu             2008-10-28  1846  		regs->nip += 4;		/* skip emulated instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1847  		emulate_single_step(regs);
6a800f36acd5bf Liu Yu             2008-10-28  1848  		return;
6a800f36acd5bf Liu Yu             2008-10-28  1849  	}
6a800f36acd5bf Liu Yu             2008-10-28  1850  
6a800f36acd5bf Liu Yu             2008-10-28  1851  	if (err == -EFAULT) {
6a800f36acd5bf Liu Yu             2008-10-28  1852  		/* got an error reading the instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1853  		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1854  	} else if (err == -EINVAL) {
6a800f36acd5bf Liu Yu             2008-10-28  1855  		/* didn't recognize the instruction */
6a800f36acd5bf Liu Yu             2008-10-28  1856  		printk(KERN_ERR "unrecognized spe instruction "
6a800f36acd5bf Liu Yu             2008-10-28  1857  		       "in %s at %lx\n", current->comm, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1858  	} else {
6a800f36acd5bf Liu Yu             2008-10-28  1859  		_exception(SIGFPE, regs, 0, regs->nip);
6a800f36acd5bf Liu Yu             2008-10-28  1860  		return;
6a800f36acd5bf Liu Yu             2008-10-28  1861  	}
6a800f36acd5bf Liu Yu             2008-10-28  1862  }
14cf11af6cf608 Paul Mackerras     2005-09-26  1863  #endif
dc1c1ca3dcd94c Stephen Rothwell   2005-10-01  1864  

:::::: The code at line 1658 was first introduced by commit
:::::: 03465f899bdac70d34f6ca447a74d8ae9e284ce5 powerpc: Use kprobe blacklist for exception handlers

:::::: TO: Nicholas Piggin <npiggin@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

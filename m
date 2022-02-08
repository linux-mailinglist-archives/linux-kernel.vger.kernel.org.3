Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5684ACED1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiBHCVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbiBHCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:21:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E8C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644286867; x=1675822867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k/yQaBB1IzPVIVXojTejUiY5GpaFvSt0d2mtJXOa+tM=;
  b=eNV4AT8LOQIcQjyfRPRoNHvghj6+fjBSrA5jXSirXCVtHbWoUDKYj4Sx
   rwjl9cdBATRwGwfCpPPNxE4JOtY62n0thEfyHMWqcxdoAkuAyoa23HuY8
   sZ8N7XO73zRhN1UANZOZ/e0xv0Oz2wczG9JDMiGUj/6Ypm15TeEDMScrr
   Gnr1Y49iVxTvQk5bvWXE+jpjl5H6SjnPCv4ejVtxXrZxOl3CWjtaG2hj1
   w36D7XWvQsbxEyKRUWNRA/F4/VFE89F9/XlVALOpN38fufgFRq3BsgzNl
   Sz1l5e1tJ6GVTd5q+x1q50XCmciQCI32OaMn/nNGiPVW7BLeGSOsMdyr0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246444253"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="246444253"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525367506"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2022 18:21:05 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHG7s-0001DM-On; Tue, 08 Feb 2022 02:21:04 +0000
Date:   Tue, 8 Feb 2022 10:20:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
 2420/8858] arch/arm64/mm/fault.c:594:15: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202202081049.0q2EDAfF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
head:   9771767708df4fcf51cd1642e041c804a86e740c
commit: 9e4d84273c9d786ee7592970f0a46c1c28eb3c18 [2420/8858] ANDROID: Fix sparse warning in __handle_speculative_fault caused by SPF
config: arm64-randconfig-s031-20220207 (https://download.01.org/0day-ci/archive/20220208/202202081049.0q2EDAfF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9e4d84273c9d786ee7592970f0a46c1c28eb3c18
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-gs-raviole-5.10-android12-qpr1-d
        git checkout 9e4d84273c9d786ee7592970f0a46c1c28eb3c18
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm64/mm/fault.c:494:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted vm_fault_t @@
   arch/arm64/mm/fault.c:494:31: sparse:     expected int
   arch/arm64/mm/fault.c:494:31: sparse:     got restricted vm_fault_t
>> arch/arm64/mm/fault.c:594:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [assigned] [usertype] fault @@     got int @@
   arch/arm64/mm/fault.c:594:15: sparse:     expected restricted vm_fault_t [assigned] [usertype] fault
   arch/arm64/mm/fault.c:594:15: sparse:     got int
   arch/arm64/mm/fault.c:623:13: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/arm64/mm/fault.c:623:13: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/arm64/mm/fault.c:666:39: sparse: sparse: restricted vm_fault_t degrades to integer

vim +594 arch/arm64/mm/fault.c

c49bd02f4c7412 Anshuman Khandual   2019-06-07  510  
1ad9551f1d90e3 Peter Collingbourne 2021-01-22  511  static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
1d18c47c735e8a Catalin Marinas     2012-03-05  512  				   struct pt_regs *regs)
1d18c47c735e8a Catalin Marinas     2012-03-05  513  {
2d2837fab5fada Eric W. Biederman   2018-09-22  514  	const struct fault_info *inf;
61681036004318 Anshuman Khandual   2019-06-03  515  	struct mm_struct *mm = current->mm;
6a1bb025d28e10 Peter Xu            2020-08-11  516  	vm_fault_t fault;
6cb4d9a2870d20 Anshuman Khandual   2020-04-10  517  	unsigned long vm_flags = VM_ACCESS_FLAGS;
dde1607248328c Peter Xu            2020-04-01  518  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  519  	struct vm_area_struct *vma = NULL;
1ad9551f1d90e3 Peter Collingbourne 2021-01-22  520  	unsigned long addr = untagged_addr(far);
db6f41063cbdb5 Will Deacon         2013-07-19  521  
b98cca444d287a Anshuman Khandual   2019-07-16  522  	if (kprobe_page_fault(regs, esr))
2dd0e8d2d2a157 Sandeepa Prabhu     2016-07-08  523  		return 0;
2dd0e8d2d2a157 Sandeepa Prabhu     2016-07-08  524  
1d18c47c735e8a Catalin Marinas     2012-03-05  525  	/*
1d18c47c735e8a Catalin Marinas     2012-03-05  526  	 * If we're in an interrupt or have no user context, we must not take
1d18c47c735e8a Catalin Marinas     2012-03-05  527  	 * the fault.
1d18c47c735e8a Catalin Marinas     2012-03-05  528  	 */
70ffdb9393a726 David Hildenbrand   2015-05-11  529  	if (faulthandler_disabled() || !mm)
1d18c47c735e8a Catalin Marinas     2012-03-05  530  		goto no_context;
1d18c47c735e8a Catalin Marinas     2012-03-05  531  
759496ba6407c6 Johannes Weiner     2013-09-12  532  	if (user_mode(regs))
759496ba6407c6 Johannes Weiner     2013-09-12  533  		mm_flags |= FAULT_FLAG_USER;
759496ba6407c6 Johannes Weiner     2013-09-12  534  
541ec870ef3143 Mark Rutland        2016-05-31  535  	if (is_el0_instruction_abort(esr)) {
759496ba6407c6 Johannes Weiner     2013-09-12  536  		vm_flags = VM_EXEC;
01de1776f62e64 Anshuman Khandual   2019-05-05  537  		mm_flags |= FAULT_FLAG_INSTRUCTION;
c49bd02f4c7412 Anshuman Khandual   2019-06-07  538  	} else if (is_write_abort(esr)) {
759496ba6407c6 Johannes Weiner     2013-09-12  539  		vm_flags = VM_WRITE;
759496ba6407c6 Johannes Weiner     2013-09-12  540  		mm_flags |= FAULT_FLAG_WRITE;
759496ba6407c6 Johannes Weiner     2013-09-12  541  	}
759496ba6407c6 Johannes Weiner     2013-09-12  542  
356607f21e6035 Andrey Konovalov    2018-12-28  543  	if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, regs)) {
e19a6ee2460bdd James Morse         2016-06-20  544  		/* regs->orig_addr_limit may be 0 if we entered from EL0 */
e19a6ee2460bdd James Morse         2016-06-20  545  		if (regs->orig_addr_limit == KERNEL_DS)
c870f14ea115bb Mark Rutland        2018-05-21  546  			die_kernel_fault("access to user memory with fs=KERNEL_DS",
c870f14ea115bb Mark Rutland        2018-05-21  547  					 addr, esr, regs);
705441960033e6 James Morse         2016-02-05  548  
9adeb8e72dbfe9 Laura Abbott        2016-08-09  549  		if (is_el1_instruction_abort(esr))
c870f14ea115bb Mark Rutland        2018-05-21  550  			die_kernel_fault("execution of user memory",
c870f14ea115bb Mark Rutland        2018-05-21  551  					 addr, esr, regs);
9adeb8e72dbfe9 Laura Abbott        2016-08-09  552  
57f4959bad0a15 James Morse         2016-02-05  553  		if (!search_exception_tables(regs->pc))
c870f14ea115bb Mark Rutland        2018-05-21  554  			die_kernel_fault("access to user memory outside uaccess routines",
c870f14ea115bb Mark Rutland        2018-05-21  555  					 addr, esr, regs);
57f4959bad0a15 James Morse         2016-02-05  556  	}
338d4f49d6f711 James Morse         2015-07-22  557  
0e3a9026396cd7 Punit Agrawal       2017-06-08  558  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
0e3a9026396cd7 Punit Agrawal       2017-06-08  559  
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  560  	/*
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  561  	 * let's try a speculative page fault without grabbing the
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  562  	 * mmap_sem.
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  563  	 */
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  564  	fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  565  	if (fault != VM_FAULT_RETRY)
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  566  		goto done;
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  567  
1d18c47c735e8a Catalin Marinas     2012-03-05  568  	/*
1d18c47c735e8a Catalin Marinas     2012-03-05  569  	 * As per x86, we may deadlock here. However, since the kernel only
1d18c47c735e8a Catalin Marinas     2012-03-05  570  	 * validly references user space from well defined areas of the code,
1d18c47c735e8a Catalin Marinas     2012-03-05  571  	 * we can bug out early if this is from code which shouldn't.
1d18c47c735e8a Catalin Marinas     2012-03-05  572  	 */
d8ed45c5dcd455 Michel Lespinasse   2020-06-08  573  	if (!mmap_read_trylock(mm)) {
1d18c47c735e8a Catalin Marinas     2012-03-05  574  		if (!user_mode(regs) && !search_exception_tables(regs->pc))
1d18c47c735e8a Catalin Marinas     2012-03-05  575  			goto no_context;
1d18c47c735e8a Catalin Marinas     2012-03-05  576  retry:
d8ed45c5dcd455 Michel Lespinasse   2020-06-08  577  		mmap_read_lock(mm);
1d18c47c735e8a Catalin Marinas     2012-03-05  578  	} else {
1d18c47c735e8a Catalin Marinas     2012-03-05  579  		/*
1d18c47c735e8a Catalin Marinas     2012-03-05  580  		 * The above down_read_trylock() might have succeeded in which
1d18c47c735e8a Catalin Marinas     2012-03-05  581  		 * case, we'll have missed the might_sleep() from down_read().
1d18c47c735e8a Catalin Marinas     2012-03-05  582  		 */
1d18c47c735e8a Catalin Marinas     2012-03-05  583  		might_sleep();
1d18c47c735e8a Catalin Marinas     2012-03-05  584  #ifdef CONFIG_DEBUG_VM
a0509313d5dea0 Anshuman Khandual   2019-06-03  585  		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
d8ed45c5dcd455 Michel Lespinasse   2020-06-08  586  			mmap_read_unlock(mm);
1d18c47c735e8a Catalin Marinas     2012-03-05  587  			goto no_context;
a0509313d5dea0 Anshuman Khandual   2019-06-03  588  		}
1d18c47c735e8a Catalin Marinas     2012-03-05  589  #endif
1d18c47c735e8a Catalin Marinas     2012-03-05  590  	}
1d18c47c735e8a Catalin Marinas     2012-03-05  591  
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  592  	if (!vma || !can_reuse_spf_vma(vma, addr))
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  593  		vma = find_vma(mm, addr);
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04 @594  	fault = __do_page_fault(vma, addr, mm_flags, vm_flags, regs);
1d18c47c735e8a Catalin Marinas     2012-03-05  595  
b502f038f2ffc9 Peter Xu            2020-04-01  596  	/* Quick path to respond to signals */
b502f038f2ffc9 Peter Xu            2020-04-01  597  	if (fault_signal_pending(fault, regs)) {
289d07a2dc6c6b Mark Rutland        2017-07-11  598  		if (!user_mode(regs))
289d07a2dc6c6b Mark Rutland        2017-07-11  599  			goto no_context;
1d18c47c735e8a Catalin Marinas     2012-03-05  600  		return 0;
289d07a2dc6c6b Mark Rutland        2017-07-11  601  	}
1d18c47c735e8a Catalin Marinas     2012-03-05  602  
b502f038f2ffc9 Peter Xu            2020-04-01  603  	if (fault & VM_FAULT_RETRY) {
0e3a9026396cd7 Punit Agrawal       2017-06-08  604  		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
569ba74a7ba69f Mark Salyzyn        2015-09-21  605  			mm_flags |= FAULT_FLAG_TRIED;
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  606  
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  607  			/*
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  608  			 * Do not try to reuse this vma and fetch it
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  609  			 * again since we will release the mmap_sem.
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  610  			 */
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  611  			vma = NULL;
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  612  
1d18c47c735e8a Catalin Marinas     2012-03-05  613  			goto retry;
1d18c47c735e8a Catalin Marinas     2012-03-05  614  		}
1d18c47c735e8a Catalin Marinas     2012-03-05  615  	}
d8ed45c5dcd455 Michel Lespinasse   2020-06-08  616  	mmap_read_unlock(mm);
1d18c47c735e8a Catalin Marinas     2012-03-05  617  
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  618  done:
2fd69fa6bcab98 Mahendran Ganesh    2018-05-04  619  
1d18c47c735e8a Catalin Marinas     2012-03-05  620  	/*
0e3a9026396cd7 Punit Agrawal       2017-06-08  621  	 * Handle the "normal" (no error) case first.
1d18c47c735e8a Catalin Marinas     2012-03-05  622  	 */
1d18c47c735e8a Catalin Marinas     2012-03-05  623  	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
6a1bb025d28e10 Peter Xu            2020-08-11  624  			      VM_FAULT_BADACCESS))))
1d18c47c735e8a Catalin Marinas     2012-03-05  625  		return 0;
1d18c47c735e8a Catalin Marinas     2012-03-05  626  
871341023c771a Johannes Weiner     2013-09-12  627  	/*
871341023c771a Johannes Weiner     2013-09-12  628  	 * If we are in kernel mode at this point, we have no context to
871341023c771a Johannes Weiner     2013-09-12  629  	 * handle this fault with.
871341023c771a Johannes Weiner     2013-09-12  630  	 */
871341023c771a Johannes Weiner     2013-09-12  631  	if (!user_mode(regs))
871341023c771a Johannes Weiner     2013-09-12  632  		goto no_context;
871341023c771a Johannes Weiner     2013-09-12  633  
1d18c47c735e8a Catalin Marinas     2012-03-05  634  	if (fault & VM_FAULT_OOM) {
1d18c47c735e8a Catalin Marinas     2012-03-05  635  		/*
1d18c47c735e8a Catalin Marinas     2012-03-05  636  		 * We ran out of memory, call the OOM killer, and return to
1d18c47c735e8a Catalin Marinas     2012-03-05  637  		 * userspace (which will retry the fault, or kill us if we got
1d18c47c735e8a Catalin Marinas     2012-03-05  638  		 * oom-killed).
1d18c47c735e8a Catalin Marinas     2012-03-05  639  		 */
1d18c47c735e8a Catalin Marinas     2012-03-05  640  		pagefault_out_of_memory();
1d18c47c735e8a Catalin Marinas     2012-03-05  641  		return 0;
1d18c47c735e8a Catalin Marinas     2012-03-05  642  	}
1d18c47c735e8a Catalin Marinas     2012-03-05  643  
2d2837fab5fada Eric W. Biederman   2018-09-22  644  	inf = esr_to_fault_info(esr);
559d8d91a89cc2 Eric W. Biederman   2018-09-22  645  	set_thread_esr(addr, esr);
1d18c47c735e8a Catalin Marinas     2012-03-05  646  	if (fault & VM_FAULT_SIGBUS) {
1d18c47c735e8a Catalin Marinas     2012-03-05  647  		/*
1d18c47c735e8a Catalin Marinas     2012-03-05  648  		 * We had some memory, but were unable to successfully fix up
1d18c47c735e8a Catalin Marinas     2012-03-05  649  		 * this page fault.
1d18c47c735e8a Catalin Marinas     2012-03-05  650  		 */
1ad9551f1d90e3 Peter Collingbourne 2021-01-22  651  		arm64_force_sig_fault(SIGBUS, BUS_ADRERR, far, inf->name);
9ea3a9743cac4f Eric W. Biederman   2018-09-22  652  	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
9ea3a9743cac4f Eric W. Biederman   2018-09-22  653  		unsigned int lsb;
9ea3a9743cac4f Eric W. Biederman   2018-09-22  654  
9ea3a9743cac4f Eric W. Biederman   2018-09-22  655  		lsb = PAGE_SHIFT;
9ea3a9743cac4f Eric W. Biederman   2018-09-22  656  		if (fault & VM_FAULT_HWPOISON_LARGE)
9ea3a9743cac4f Eric W. Biederman   2018-09-22  657  			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
92ff0674f5d801 Will Deacon         2018-02-20  658  
1ad9551f1d90e3 Peter Collingbourne 2021-01-22  659  		arm64_force_sig_mceerr(BUS_MCEERR_AR, far, lsb, inf->name);
1d18c47c735e8a Catalin Marinas     2012-03-05  660  	} else {
1d18c47c735e8a Catalin Marinas     2012-03-05  661  		/*
1d18c47c735e8a Catalin Marinas     2012-03-05  662  		 * Something tried to access memory that isn't in our memory
1d18c47c735e8a Catalin Marinas     2012-03-05  663  		 * map.
1d18c47c735e8a Catalin Marinas     2012-03-05  664  		 */
feca355b3d8eba Eric W. Biederman   2018-09-22  665  		arm64_force_sig_fault(SIGSEGV,
feca355b3d8eba Eric W. Biederman   2018-09-22  666  				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
1ad9551f1d90e3 Peter Collingbourne 2021-01-22  667  				      far, inf->name);
1d18c47c735e8a Catalin Marinas     2012-03-05  668  	}
1d18c47c735e8a Catalin Marinas     2012-03-05  669  
1d18c47c735e8a Catalin Marinas     2012-03-05  670  	return 0;
1d18c47c735e8a Catalin Marinas     2012-03-05  671  
1d18c47c735e8a Catalin Marinas     2012-03-05  672  no_context:
67ce16ec15ce9d Kristina Martsenko  2017-06-09  673  	__do_kernel_fault(addr, esr, regs);
1d18c47c735e8a Catalin Marinas     2012-03-05  674  	return 0;
1d18c47c735e8a Catalin Marinas     2012-03-05  675  }
1d18c47c735e8a Catalin Marinas     2012-03-05  676  

:::::: The code at line 594 was first introduced by commit
:::::: 2fd69fa6bcab984b56ccfd4860b10f11f1966bed FROMLIST: arm64/mm: add speculative page fault

:::::: TO: Mahendran Ganesh <opensource.ganesh@gmail.com>
:::::: CC: Suren Baghdasaryan <surenb@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

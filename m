Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A006257F5B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiGXPTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiGXPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:19:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C230DFA6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658675946; x=1690211946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gu7U97ROE89TChPpXIUv+5sXXD2kTAmHBeudwTCt5LE=;
  b=V3iWkVQmVSLxPH35PGMxBZdHNPLe9OaZWRKRkwKnT5zKHBVtTkI6gsiq
   G1+sptFCcOu1/GyNVNIpFnUgoCLRb8sumwvGkkY/eWqBvGSv0VaAiHtdN
   BxiGazoJY4XYzyC72Zka7gTZWHSjXH48tpfIqfIUyvVLoAyt7r918bHgR
   58jkVwsTPIJIHZ7y6s3CvVFmk4djghs6gsWY0Q4w91KSEoQA+F5nvcdQq
   PIX/eFVHxirdHcHdgh47yco6lW21HStp3xNLndGWUVkpCDHvA0/Gz+POv
   aBbWliIY7v6LLHM78OPsHZ+O5n0iq+lpTv931el6hNaDurZ8lZn2lsU55
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274412228"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="274412228"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 08:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="574749054"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2022 08:19:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFdNn-0003wt-1w;
        Sun, 24 Jul 2022 15:19:03 +0000
Date:   Sun, 24 Jul 2022 23:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.19-rochester 7/13]
 arch/xtensa/mm/fault.c:126:23: error: implicit declaration of function
 'itlb_probe'
Message-ID: <202207242321.33sllypl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.19-rochester
head:   a9635269505502dd939295e872fd5e6933ee9876
commit: 89e4c5d30f8b46b631f3e9f11f1c2e30a8d20631 [7/13] xtensa: add logging to do_page_fault
config: xtensa-nommu_kc705_defconfig (https://download.01.org/0day-ci/archive/20220724/202207242321.33sllypl-lkp@intel.com/config)
compiler: xtensa-de212-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/89e4c5d30f8b46b631f3e9f11f1c2e30a8d20631
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.19-rochester
        git checkout 89e4c5d30f8b46b631f3e9f11f1c2e30a8d20631
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/xtensa/mm/fault.c:87:6: warning: no previous prototype for 'do_page_fault' [-Wmissing-prototypes]
      87 | void do_page_fault(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~
   arch/xtensa/mm/fault.c: In function 'do_page_fault':
>> arch/xtensa/mm/fault.c:126:23: error: implicit declaration of function 'itlb_probe' [-Werror=implicit-function-declaration]
     126 |                 way = itlb_probe(address);
         |                       ^~~~~~~~~~
>> arch/xtensa/mm/fault.c:128:34: error: 'ITLB_HIT_BIT' undeclared (first use in this function)
     128 |                 if ((way & (1 << ITLB_HIT_BIT)) != 0) {
         |                                  ^~~~~~~~~~~~
   arch/xtensa/mm/fault.c:128:34: note: each undeclared identifier is reported only once for each function it appears in
>> arch/xtensa/mm/fault.c:129:39: error: implicit declaration of function 'read_itlb_virtual' [-Werror=implicit-function-declaration]
     129 |                         tlb_virtual = read_itlb_virtual(way);
         |                                       ^~~~~~~~~~~~~~~~~
>> arch/xtensa/mm/fault.c:130:43: error: implicit declaration of function 'read_itlb_translation' [-Werror=implicit-function-declaration]
     130 |                         tlb_translation = read_itlb_translation(way);
         |                                           ^~~~~~~~~~~~~~~~~~~~~
>> arch/xtensa/mm/fault.c:133:23: error: implicit declaration of function 'dtlb_probe' [-Werror=implicit-function-declaration]
     133 |                 way = dtlb_probe(address);
         |                       ^~~~~~~~~~
>> arch/xtensa/mm/fault.c:135:34: error: 'DTLB_HIT_BIT' undeclared (first use in this function)
     135 |                 if ((way & (1 << DTLB_HIT_BIT)) != 0) {
         |                                  ^~~~~~~~~~~~
>> arch/xtensa/mm/fault.c:136:39: error: implicit declaration of function 'read_dtlb_virtual' [-Werror=implicit-function-declaration]
     136 |                         tlb_virtual = read_dtlb_virtual(way);
         |                                       ^~~~~~~~~~~~~~~~~
>> arch/xtensa/mm/fault.c:137:43: error: implicit declaration of function 'read_dtlb_translation' [-Werror=implicit-function-declaration]
     137 |                         tlb_translation = read_dtlb_translation(way);
         |                                           ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/itlb_probe +126 arch/xtensa/mm/fault.c

    25	
    26	static void vmalloc_fault(struct pt_regs *regs, unsigned int address)
    27	{
    28	#ifdef CONFIG_MMU
    29		/* Synchronize this task's top level page-table
    30		 * with the 'reference' page table.
    31		 */
    32		struct mm_struct *act_mm = current->active_mm;
    33		int index = pgd_index(address);
    34		pgd_t *pgd, *pgd_k;
    35		p4d_t *p4d, *p4d_k;
    36		pud_t *pud, *pud_k;
    37		pmd_t *pmd, *pmd_k;
    38		pte_t *pte_k;
    39	
    40		if (act_mm == NULL)
    41			goto bad_page_fault;
    42	
    43		pgd = act_mm->pgd + index;
    44		pgd_k = init_mm.pgd + index;
    45	
    46		if (!pgd_present(*pgd_k))
    47			goto bad_page_fault;
    48	
    49		pgd_val(*pgd) = pgd_val(*pgd_k);
    50	
    51		p4d = p4d_offset(pgd, address);
    52		p4d_k = p4d_offset(pgd_k, address);
    53		if (!p4d_present(*p4d) || !p4d_present(*p4d_k))
    54			goto bad_page_fault;
    55	
    56		pud = pud_offset(p4d, address);
    57		pud_k = pud_offset(p4d_k, address);
    58		if (!pud_present(*pud) || !pud_present(*pud_k))
    59			goto bad_page_fault;
    60	
    61		pmd = pmd_offset(pud, address);
    62		pmd_k = pmd_offset(pud_k, address);
    63		if (!pmd_present(*pmd) || !pmd_present(*pmd_k))
    64			goto bad_page_fault;
    65	
    66		pmd_val(*pmd) = pmd_val(*pmd_k);
    67		pte_k = pte_offset_kernel(pmd_k, address);
    68	
    69		if (!pte_present(*pte_k))
    70			goto bad_page_fault;
    71		return;
    72	
    73	bad_page_fault:
    74		bad_page_fault(regs, address, SIGKILL);
    75	#else
    76		WARN_ONCE(1, "%s in noMMU configuration\n", __func__);
    77	#endif
    78	}
    79	/*
    80	 * This routine handles page faults.  It determines the address,
    81	 * and the problem, and then passes it off to one of the appropriate
    82	 * routines.
    83	 *
    84	 * Note: does not handle Miss and MultiHit.
    85	 */
    86	
    87	void do_page_fault(struct pt_regs *regs)
    88	{
    89		struct vm_area_struct * vma;
    90		struct mm_struct *mm = current->mm;
    91		unsigned int exccause = regs->exccause;
    92		unsigned int address = regs->excvaddr;
    93		unsigned long tlb_virtual = -1ul;
    94		unsigned long tlb_translation = -1ul;
    95		unsigned long way;
    96		int code;
    97	
    98		int is_write, is_exec;
    99		vm_fault_t fault;
   100		unsigned int flags = FAULT_FLAG_DEFAULT;
   101	
   102		code = SEGV_MAPERR;
   103	
   104		/* We fault-in kernel-space virtual memory on-demand. The
   105		 * 'reference' page table is init_mm.pgd.
   106		 */
   107		if (address >= TASK_SIZE && !user_mode(regs)) {
   108			vmalloc_fault(regs, address);
   109			return;
   110		}
   111	
   112		/* If we're in an interrupt or have no user
   113		 * context, we must not take the fault..
   114		 */
   115		if (faulthandler_disabled() || !mm) {
   116			bad_page_fault(regs, address, SIGSEGV);
   117			return;
   118		}
   119	
   120		is_write = (exccause == EXCCAUSE_STORE_CACHE_ATTRIBUTE) ? 1 : 0;
   121		is_exec =  (exccause == EXCCAUSE_ITLB_PRIVILEGE ||
   122			    exccause == EXCCAUSE_ITLB_MISS ||
   123			    exccause == EXCCAUSE_FETCH_CACHE_ATTRIBUTE) ? 1 : 0;
   124	
   125		if (is_exec) {
 > 126			way = itlb_probe(address);
   127	
 > 128			if ((way & (1 << ITLB_HIT_BIT)) != 0) {
 > 129				tlb_virtual = read_itlb_virtual(way);
 > 130				tlb_translation = read_itlb_translation(way);
   131			}
   132		} else {
 > 133			way = dtlb_probe(address);
   134	
 > 135			if ((way & (1 << DTLB_HIT_BIT)) != 0) {
 > 136				tlb_virtual = read_dtlb_virtual(way);
 > 137				tlb_translation = read_dtlb_translation(way);
   138			}
   139		}
   140	
   141		pr_debug("[%s:%d:%08x:%d:%08lx:%s][w:%08lx, virt:%08lx, trans:%08lx]\n",
   142			 current->comm, current->pid,
   143			 address, exccause, regs->pc,
   144			 is_exec ? "x" : is_write ? "w" : "r",
   145			 way, tlb_virtual, tlb_translation);
   146	
   147		if (user_mode(regs))
   148			flags |= FAULT_FLAG_USER;
   149	
   150		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
   151	
   152	retry:
   153		mmap_read_lock(mm);
   154		vma = find_vma(mm, address);
   155	
   156		if (!vma)
   157			goto bad_area;
   158		if (vma->vm_start <= address)
   159			goto good_area;
   160		if (!(vma->vm_flags & VM_GROWSDOWN))
   161			goto bad_area;
   162		if (expand_stack(vma, address))
   163			goto bad_area;
   164	
   165		/* Ok, we have a good vm_area for this memory access, so
   166		 * we can handle it..
   167		 */
   168	
   169	good_area:
   170		code = SEGV_ACCERR;
   171	
   172		if (is_write) {
   173			if (!(vma->vm_flags & VM_WRITE))
   174				goto bad_area;
   175			flags |= FAULT_FLAG_WRITE;
   176		} else if (is_exec) {
   177			if (!(vma->vm_flags & VM_EXEC))
   178				goto bad_area;
   179		} else	/* Allow read even from write-only pages. */
   180			if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
   181				goto bad_area;
   182	
   183		/* If for any reason at all we couldn't handle the fault,
   184		 * make sure we exit gracefully rather than endlessly redo
   185		 * the fault.
   186		 */
   187		fault = handle_mm_fault(vma, address, flags, regs);
   188	
   189		if (fault_signal_pending(fault, regs)) {
   190			if (!user_mode(regs))
   191				bad_page_fault(regs, address, SIGKILL);
   192			return;
   193		}
   194	
   195		if (unlikely(fault & VM_FAULT_ERROR)) {
   196			if (fault & VM_FAULT_OOM)
   197				goto out_of_memory;
   198			else if (fault & VM_FAULT_SIGSEGV)
   199				goto bad_area;
   200			else if (fault & VM_FAULT_SIGBUS)
   201				goto do_sigbus;
   202			BUG();
   203		}
   204	
   205		if (fault & VM_FAULT_RETRY) {
   206			flags |= FAULT_FLAG_TRIED;
   207	
   208			/* No need to mmap_read_unlock(mm) as we would
   209			 * have already released it in __lock_page_or_retry
   210			 * in mm/filemap.c.
   211			 */
   212	
   213			goto retry;
   214		}
   215	
   216		mmap_read_unlock(mm);
   217		return;
   218	
   219		/* Something tried to access memory that isn't in our memory map..
   220		 * Fix it, but check if it's kernel or user first..
   221		 */
   222	bad_area:
   223		mmap_read_unlock(mm);
   224		if (user_mode(regs)) {
   225			current->thread.bad_vaddr = address;
   226			current->thread.error_code = is_write;
   227			force_sig_fault(SIGSEGV, code, (void *) address);
   228			return;
   229		}
   230		bad_page_fault(regs, address, SIGSEGV);
   231		return;
   232	
   233	
   234		/* We ran out of memory, or some other thing happened to us that made
   235		 * us unable to handle the page fault gracefully.
   236		 */
   237	out_of_memory:
   238		mmap_read_unlock(mm);
   239		if (!user_mode(regs))
   240			bad_page_fault(regs, address, SIGKILL);
   241		else
   242			pagefault_out_of_memory();
   243		return;
   244	
   245	do_sigbus:
   246		mmap_read_unlock(mm);
   247	
   248		/* Send a sigbus, regardless of whether we were in kernel
   249		 * or user mode.
   250		 */
   251		current->thread.bad_vaddr = address;
   252		force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address);
   253	
   254		/* Kernel mode? Handle exceptions or die */
   255		if (!user_mode(regs))
   256			bad_page_fault(regs, address, SIGBUS);
   257		return;
   258	}
   259	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

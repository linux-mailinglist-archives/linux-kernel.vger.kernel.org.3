Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07B4C0634
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiBWAdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBWAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:33:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513835C64B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645576393; x=1677112393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5wC0ctmgTuEoVSdyUpEPm0LqqJTQpVk/W/oJ8s+rpPU=;
  b=IzIaT9ntfKGry/SNyOVV5cWPVIUQr+Rn4FvngzISP8E+gz1iuUYydPuh
   AT6Dt9uKuSxn48FyQ7iwT+QzcxyBPRNlh0CdvQ7LLx7RFDLWg+DH8qNMs
   Qb42nPoUGfCfMaX8di3lLHbn5F4gdcwBEWPv8GtNXecKuT4HmRFYjpzUx
   Rs4z2XeYR5ir2X3nXcCtHPpFXZQlT7vR1LpeECgpbevNfdXq8rsI9F47s
   Ds2w5QYc+PI7MW7dwWDCmxi0zkB5EOgTvpVW7MT+A8bxATGgkc+A7v8LC
   jeS/i3uy9UKLvJg3fmqfN0oKdmLY1oCw5KDHN8vun8gafXN6DwojrvlZm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338284927"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="338284927"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 16:33:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="505729741"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Feb 2022 16:33:09 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMfae-0000mz-E3; Wed, 23 Feb 2022 00:33:08 +0000
Date:   Wed, 23 Feb 2022 08:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     hanchuanhua <hanchuanhua@oppo.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/for-next 3/3]
 arch/riscv/mm/fault.c:126:9: error: 'pgd' undeclared; did you mean 'pid'?
Message-ID: <202202230809.3HxMqsaH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/for-next
head:   c4f1d47294c4a59c09d14c5802bc0e978bad7b9a
commit: c4f1d47294c4a59c09d14c5802bc0e978bad7b9a [3/3] riscv: mm: Remove the copy operation of pmd
config: riscv-randconfig-m031-20220222 (https://download.01.org/0day-ci/archive/20220223/202202230809.3HxMqsaH-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/c4f1d47294c4a59c09d14c5802bc0e978bad7b9a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/for-next
        git checkout c4f1d47294c4a59c09d14c5802bc0e978bad7b9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/mm/fault.c: In function 'vmalloc_fault':
>> arch/riscv/mm/fault.c:126:9: error: 'pgd' undeclared (first use in this function); did you mean 'pid'?
     126 |         pgd = (pgd_t *)pfn_to_virt(pfn) + index;
         |         ^~~
         |         pid
   arch/riscv/mm/fault.c:126:9: note: each undeclared identifier is reported only once for each function it appears in


vim +126 arch/riscv/mm/fault.c

a51271d99cdd049 Pekka Enberg 2020-08-25  101  
2baa6d9506f24d5 Pekka Enberg 2020-09-05  102  static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
ac416a724f11320 Pekka Enberg 2020-08-25  103  {
c4f1d47294c4a59 hanchuanhua  2022-01-27  104  	pgd_t *pgd_k;
c4f1d47294c4a59 hanchuanhua  2022-01-27  105  	pud_t *pud_k;
c4f1d47294c4a59 hanchuanhua  2022-01-27  106  	p4d_t *p4d_k;
c4f1d47294c4a59 hanchuanhua  2022-01-27  107  	pmd_t *pmd_k;
ac416a724f11320 Pekka Enberg 2020-08-25  108  	pte_t *pte_k;
ac416a724f11320 Pekka Enberg 2020-08-25  109  	int index;
bcacf5f6f239a9e Liu Shaohua  2020-10-26  110  	unsigned long pfn;
ac416a724f11320 Pekka Enberg 2020-08-25  111  
ac416a724f11320 Pekka Enberg 2020-08-25  112  	/* User mode accesses just cause a SIGSEGV */
ac416a724f11320 Pekka Enberg 2020-08-25  113  	if (user_mode(regs))
ac416a724f11320 Pekka Enberg 2020-08-25  114  		return do_trap(regs, SIGSEGV, code, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  115  
ac416a724f11320 Pekka Enberg 2020-08-25  116  	/*
ac416a724f11320 Pekka Enberg 2020-08-25  117  	 * Synchronize this task's top level page-table
ac416a724f11320 Pekka Enberg 2020-08-25  118  	 * with the 'reference' page table.
ac416a724f11320 Pekka Enberg 2020-08-25  119  	 *
ac416a724f11320 Pekka Enberg 2020-08-25  120  	 * Do _not_ use "tsk->active_mm->pgd" here.
ac416a724f11320 Pekka Enberg 2020-08-25  121  	 * We might be inside an interrupt in the middle
ac416a724f11320 Pekka Enberg 2020-08-25  122  	 * of a task switch.
ac416a724f11320 Pekka Enberg 2020-08-25  123  	 */
ac416a724f11320 Pekka Enberg 2020-08-25  124  	index = pgd_index(addr);
bcacf5f6f239a9e Liu Shaohua  2020-10-26  125  	pfn = csr_read(CSR_SATP) & SATP_PPN;
bcacf5f6f239a9e Liu Shaohua  2020-10-26 @126  	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
ac416a724f11320 Pekka Enberg 2020-08-25  127  	pgd_k = init_mm.pgd + index;
ac416a724f11320 Pekka Enberg 2020-08-25  128  
ac416a724f11320 Pekka Enberg 2020-08-25  129  	if (!pgd_present(*pgd_k)) {
ac416a724f11320 Pekka Enberg 2020-08-25  130  		no_context(regs, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  131  		return;
ac416a724f11320 Pekka Enberg 2020-08-25  132  	}
ac416a724f11320 Pekka Enberg 2020-08-25  133  	set_pgd(pgd, *pgd_k);
ac416a724f11320 Pekka Enberg 2020-08-25  134  
ac416a724f11320 Pekka Enberg 2020-08-25  135  	p4d_k = p4d_offset(pgd_k, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  136  	if (!p4d_present(*p4d_k)) {
ac416a724f11320 Pekka Enberg 2020-08-25  137  		no_context(regs, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  138  		return;
ac416a724f11320 Pekka Enberg 2020-08-25  139  	}
ac416a724f11320 Pekka Enberg 2020-08-25  140  
ac416a724f11320 Pekka Enberg 2020-08-25  141  	pud_k = pud_offset(p4d_k, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  142  	if (!pud_present(*pud_k)) {
ac416a724f11320 Pekka Enberg 2020-08-25  143  		no_context(regs, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  144  		return;
ac416a724f11320 Pekka Enberg 2020-08-25  145  	}
ac416a724f11320 Pekka Enberg 2020-08-25  146  
ac416a724f11320 Pekka Enberg 2020-08-25  147  	/*
ac416a724f11320 Pekka Enberg 2020-08-25  148  	 * Since the vmalloc area is global, it is unnecessary
ac416a724f11320 Pekka Enberg 2020-08-25  149  	 * to copy individual PTEs
ac416a724f11320 Pekka Enberg 2020-08-25  150  	 */
ac416a724f11320 Pekka Enberg 2020-08-25  151  	pmd_k = pmd_offset(pud_k, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  152  	if (!pmd_present(*pmd_k)) {
ac416a724f11320 Pekka Enberg 2020-08-25  153  		no_context(regs, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  154  		return;
ac416a724f11320 Pekka Enberg 2020-08-25  155  	}
ac416a724f11320 Pekka Enberg 2020-08-25  156  
ac416a724f11320 Pekka Enberg 2020-08-25  157  	/*
ac416a724f11320 Pekka Enberg 2020-08-25  158  	 * Make sure the actual PTE exists as well to
ac416a724f11320 Pekka Enberg 2020-08-25  159  	 * catch kernel vmalloc-area accesses to non-mapped
ac416a724f11320 Pekka Enberg 2020-08-25  160  	 * addresses. If we don't do this, this will just
ac416a724f11320 Pekka Enberg 2020-08-25  161  	 * silently loop forever.
ac416a724f11320 Pekka Enberg 2020-08-25  162  	 */
ac416a724f11320 Pekka Enberg 2020-08-25  163  	pte_k = pte_offset_kernel(pmd_k, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  164  	if (!pte_present(*pte_k)) {
ac416a724f11320 Pekka Enberg 2020-08-25  165  		no_context(regs, addr);
ac416a724f11320 Pekka Enberg 2020-08-25  166  		return;
ac416a724f11320 Pekka Enberg 2020-08-25  167  	}
ac416a724f11320 Pekka Enberg 2020-08-25  168  
ac416a724f11320 Pekka Enberg 2020-08-25  169  	/*
ac416a724f11320 Pekka Enberg 2020-08-25  170  	 * The kernel assumes that TLBs don't cache invalid
ac416a724f11320 Pekka Enberg 2020-08-25  171  	 * entries, but in RISC-V, SFENCE.VMA specifies an
ac416a724f11320 Pekka Enberg 2020-08-25  172  	 * ordering constraint, not a cache flush; it is
ac416a724f11320 Pekka Enberg 2020-08-25  173  	 * necessary even after writing invalid entries.
ac416a724f11320 Pekka Enberg 2020-08-25  174  	 */
ac416a724f11320 Pekka Enberg 2020-08-25  175  	local_flush_tlb_page(addr);
ac416a724f11320 Pekka Enberg 2020-08-25  176  }
ac416a724f11320 Pekka Enberg 2020-08-25  177  

:::::: The code at line 126 was first introduced by commit
:::::: bcacf5f6f239a9e60287680514f392748cb4ec39 riscv: fix pfn_to_virt err in do_page_fault().

:::::: TO: Liu Shaohua <liush@allwinnertech.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

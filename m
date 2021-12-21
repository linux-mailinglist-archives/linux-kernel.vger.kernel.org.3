Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696947B91D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhLUDzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:55:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:53919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhLUDzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640058946; x=1671594946;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wiRm+HGuSSiVqrBtxw6zO/utF4M46cxeHDugLyWMyZU=;
  b=CkMtZlDZZta/hKXN3VYpo+IY3kpEokGvsajXYA/zRQ68fz3eBH9qcNFg
   POF7tb5ijbSlEhCE6xuOBXDS9EZ/27EV2pPMozfpnRhGf9OvMeuVK2z15
   5g9+f/cxRuh3l6WANsvOMA5g64aGodVOTSZ1HiLP2amB58/jTnN90Fpz1
   KmhyAhFu75ZZQOEBQOzYAtjC2oOTbHM/YVEJK+PodLU+U4xxuKdWeSORA
   QUE2iT3UiDkZRxH2MhqQleICpJi3glQ6e3oJh60fHer2dpxVWrdCaHgO0
   y6drD772z4nJEdxK6FTiDb9XmyTx53Y+fa0Wv14YgLCc5ut8+3eQXR03A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264507292"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="264507292"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 19:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="466163079"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2021 19:55:43 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzWFb-0008eX-0L; Tue, 21 Dec 2021 03:55:43 +0000
Date:   Tue, 21 Dec 2021 11:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [davidhildenbrand:unshare_new 2/4] include/linux/mm.h:1384:31:
 error: implicit declaration of function 'PageAnonUnshared'
Message-ID: <202112211111.sq7Cb8GK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux unshare_new
head:   0b0d58f51fe2675e4dcfb11263ad4cbec053711f
commit: a37ffb6fd951d770096d5612e00da380d4b3a286 [2/4] mm: support GUP-triggered unsharing via FAULT_FLAG_UNSHARE (!hugetlb)
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211221/202112211111.sq7Cb8GK-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/a37ffb6fd951d770096d5612e00da380d4b3a286
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand unshare_new
        git checkout a37ffb6fd951d770096d5612e00da380d4b3a286
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:15:
   include/linux/mm.h: In function 'page_needs_cow_for_dma':
>> include/linux/mm.h:1384:31: error: implicit declaration of function 'PageAnonUnshared' [-Werror=implicit-function-declaration]
    1384 |         if (PageAnon(page) && PageAnonUnshared(page)) {
         |                               ^~~~~~~~~~~~~~~~
>> include/linux/mm.h:1386:25: error: implicit declaration of function 'ClearPageAnonUnshared' [-Werror=implicit-function-declaration]
    1386 |                         ClearPageAnonUnshared(page);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c: At top level:
   arch/mips/kernel/asm-offsets.c:26:6: warning: no previous prototype for 'output_ptreg_defines' [-Wmissing-prototypes]
      26 | void output_ptreg_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:78:6: warning: no previous prototype for 'output_task_defines' [-Wmissing-prototypes]
      78 | void output_task_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:92:6: warning: no previous prototype for 'output_thread_info_defines' [-Wmissing-prototypes]
      92 | void output_thread_info_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:108:6: warning: no previous prototype for 'output_thread_defines' [-Wmissing-prototypes]
     108 | void output_thread_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:136:6: warning: no previous prototype for 'output_thread_fpu_defines' [-Wmissing-prototypes]
     136 | void output_thread_fpu_defines(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:179:6: warning: no previous prototype for 'output_mm_defines' [-Wmissing-prototypes]
     179 | void output_mm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:218:6: warning: no previous prototype for 'output_sc_defines' [-Wmissing-prototypes]
     218 | void output_sc_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:253:6: warning: no previous prototype for 'output_signal_defined' [-Wmissing-prototypes]
     253 | void output_signal_defined(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:320:6: warning: no previous prototype for 'output_pbe_defines' [-Wmissing-prototypes]
     320 | void output_pbe_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:332:6: warning: no previous prototype for 'output_pm_defines' [-Wmissing-prototypes]
     332 | void output_pm_defines(void)
         |      ^~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:346:6: warning: no previous prototype for 'output_kvm_defines' [-Wmissing-prototypes]
     346 | void output_kvm_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/asm-offsets.c:390:6: warning: no previous prototype for 'output_cps_defines' [-Wmissing-prototypes]
     390 | void output_cps_defines(void)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:121: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/PageAnonUnshared +1384 include/linux/mm.h

  1355	
  1356	/*
  1357	 * This should most likely only be called during fork() to see whether we
  1358	 * should break the cow immediately for a page on the src mm.
  1359	 */
  1360	static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
  1361						  struct page *page)
  1362	{
  1363		if (!is_cow_mapping(vma->vm_flags))
  1364			return false;
  1365	
  1366		/*
  1367		 * If an anon page is markes as "unshared" we must not share it with
  1368		 * our child, ever. Try to unshare: unsharing is only possible if there
  1369		 * are no additional references on the page. Users that care about
  1370		 * unsharing to take R/O references that are consitent with the MM
  1371		 * (i.e., GUP) have to synchronize against fork() to detect
  1372		 * concurrent unsharing, back off, and trigger unsharing again.
  1373		 *
  1374		 * For ordinary GUP, this is synchronized via the mmap_lock. For
  1375		 * gup-fast, this is synchronized via the mm->write_protect_seq of
  1376		 * the parent.
  1377		 *
  1378		 * Notes:
  1379		 * 1) This covers the DMA pinned case below for anonymous pages, just
  1380		 *    the way pinning also increases the page_count() of the page.
  1381		 * 2) This also covers references on the page that are not due to
  1382		 *    page pinning.
  1383		 */
> 1384		if (PageAnon(page) && PageAnonUnshared(page)) {
  1385			if (page_count(page) == 1) {
> 1386				ClearPageAnonUnshared(page);
  1387				return false;
  1388			}
  1389			return true;
  1390		}
  1391	
  1392		if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
  1393			return false;
  1394	
  1395		return page_maybe_dma_pinned(page);
  1396	}
  1397	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

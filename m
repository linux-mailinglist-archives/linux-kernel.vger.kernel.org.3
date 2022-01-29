Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931784A2C32
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244536AbiA2Gww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:52:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:28236 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242876AbiA2Gwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643439167; x=1674975167;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OXEwoEBMxYHyfw1o9+Y27zCj9IDiO6kkIrGZbOCAEJA=;
  b=KKtzwD/27c4YGZvKo0+YefcKs/Yh7RibiNDOuxn0g+XhauOuidQQuBdZ
   xMQ543KGIxp4WsBrlUq/6ZepbI2+K21ZhlU4UgpSCpi1Mehfhq3lc5+Fy
   0hNl2SYJKBOQsJJlmSSfCxQd+20ysAJyltCRpPqv1zrsV6gjYFxuUcycR
   AYCRz64SjznBpPjaaqFMhldz8ted+q5+7dcXLbdKyF39sDvBUAzKjXM7s
   2fMxZU9KhtpV6t7k9vJtGihH4O2rWhCBVNywHYpQqeKFB8F54UE6OmGaq
   tC8uSbvUAqv2FongkM6dwBtBsC16sTBQ4T2lYSdeqww/GTy92mhBj2YZs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247020908"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="247020908"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 22:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="629359322"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2022 22:52:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDhbG-000Ost-UA; Sat, 29 Jan 2022 06:52:42 +0000
Date:   Sat, 29 Jan 2022 14:52:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 78/9999] mm/hugetlb.c:5458:8: error: conflicting types for 'huge_pmd_share'
Message-ID: <202201291403.OkBFrIUS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   8a98494ddc958f3f43d2411306524b505e2f4fa9
commit: 59caf93f36aed4b7c5960672376b966e3f5b2bf1 [78/9999] BACKPORT: FROMGIT: hugetlb: pass vma into huge_pte_alloc() and huge_pmd_share()
config: arm64-randconfig-r034-20220127 (https://download.01.org/0day-ci/archive/20220129/202201291403.OkBFrIUS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/59caf93f36aed4b7c5960672376b966e3f5b2bf1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 59caf93f36aed4b7c5960672376b966e3f5b2bf1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/google/android/kernel/common/android13-5.10 HEAD 8a98494ddc958f3f43d2411306524b505e2f4fa9 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> mm/hugetlb.c:5458:8: error: conflicting types for 'huge_pmd_share'
   pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
          ^
   include/linux/hugetlb.h:155:8: note: previous declaration is here
   pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
          ^
   1 error generated.


vim +/huge_pmd_share +5458 mm/hugetlb.c

  5425	
  5426	/*
  5427	 * unmap huge page backed by shared pte.
  5428	 *
  5429	 * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
  5430	 * indicated by page_count > 1, unmap is achieved by clearing pud and
  5431	 * decrementing the ref count. If count == 1, the pte page is not shared.
  5432	 *
  5433	 * Called with page table lock held and i_mmap_rwsem held in write mode.
  5434	 *
  5435	 * returns: 1 successfully unmapped a shared pte page
  5436	 *	    0 the underlying pte page is not shared, or it is the last user
  5437	 */
  5438	int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
  5439						unsigned long *addr, pte_t *ptep)
  5440	{
  5441		pgd_t *pgd = pgd_offset(mm, *addr);
  5442		p4d_t *p4d = p4d_offset(pgd, *addr);
  5443		pud_t *pud = pud_offset(p4d, *addr);
  5444	
  5445		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
  5446		BUG_ON(page_count(virt_to_page(ptep)) == 0);
  5447		if (page_count(virt_to_page(ptep)) == 1)
  5448			return 0;
  5449	
  5450		pud_clear(pud);
  5451		put_page(virt_to_page(ptep));
  5452		mm_dec_nr_pmds(mm);
  5453		*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
  5454		return 1;
  5455	}
  5456	#define want_pmd_share()	(1)
  5457	#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> 5458	pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
  5459			      unsigned long addr, pud_t *pud)
  5460	{
  5461		return NULL;
  5462	}
  5463	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

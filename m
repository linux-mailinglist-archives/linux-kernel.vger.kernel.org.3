Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8D47C834
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhLUUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:25:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:4230 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhLUUZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640118329; x=1671654329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hDiSJycoqPRiInzLXU+hnh8Z79k4LoNmY31KU/Uddk8=;
  b=fRasu5hDAqkbOf067nmsmbe4CZSfJ5pAWoUDQP8ru7YJQjornKhpgcKr
   McFXEs6imZgWolLZ2FztbwrL76eccyz2J03cp+eZTzv8B72/oKC4pdCkl
   Rw4oW/hjjmKRLxrNggOT5IRp+8H/FDVNb25sXrGwHOB9WTdXtbEwWWPUU
   Rkhz6i6Ah1cBbUCmEHuTdtSbv059mYiINQbK+16cWturtCPcbRzAJmCoU
   JDqNIaAv7ScNXMp7rkUdbdQuSs1F+kPJDjNlFgLp1HeL/XTmv6YT6HyPD
   Hc1A/FLR7x1uYfU4hoNvwuBBUbiWbDnv+zKCj9Jw+zUvXo1dt+akBH4nq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220498557"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="220498557"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 12:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="466422594"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2021 12:25:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzlhE-0009WI-A8; Tue, 21 Dec 2021 20:25:16 +0000
Date:   Wed, 22 Dec 2021 04:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [davidhildenbrand:unshare_new 3/4] mm/huge_memory.c:1381:13: error:
 too few arguments to function 'gup_must_unshare'
Message-ID: <202112220427.4D3zNiRN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux unshare_new
head:   0b0d58f51fe2675e4dcfb11263ad4cbec053711f
commit: d3eb6d68346c3d9e89ae68461e0eabb5bc7def17 [3/4] mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required (!hugetlb)
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220427.4D3zNiRN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand unshare_new
        git checkout d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/huge_memory.c:8:
   include/linux/mm.h: In function 'page_needs_cow_for_dma':
   include/linux/mm.h:1384:31: error: implicit declaration of function 'PageAnonUnshared' [-Werror=implicit-function-declaration]
    1384 |         if (PageAnon(page) && PageAnonUnshared(page)) {
         |                               ^~~~~~~~~~~~~~~~
   include/linux/mm.h:1386:25: error: implicit declaration of function 'ClearPageAnonUnshared' [-Werror=implicit-function-declaration]
    1386 |                         ClearPageAnonUnshared(page);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   mm/huge_memory.c: In function 'follow_trans_huge_pmd':
>> mm/huge_memory.c:1381:13: error: too few arguments to function 'gup_must_unshare'
    1381 |         if (gup_must_unshare(flags, page)) {
         |             ^~~~~~~~~~~~~~~~
   In file included from mm/huge_memory.c:8:
   include/linux/mm.h:3086:13: note: declared here
    3086 | extern bool gup_must_unshare(unsigned int flags, struct page *page,
         |             ^~~~~~~~~~~~~~~~
>> mm/huge_memory.c:1382:22: error: implicit declaration of function 'mark_anon_page_shared' [-Werror=implicit-function-declaration]
    1382 |                 if (!mark_anon_page_shared(page, pmd_write(pmd)))
         |                      ^~~~~~~~~~~~~~~~~~~~~
>> mm/huge_memory.c:1382:60: error: incompatible type for argument 1 of 'pmd_write'
    1382 |                 if (!mark_anon_page_shared(page, pmd_write(pmd)))
         |                                                            ^~~
         |                                                            |
         |                                                            pmd_t *
   In file included from arch/sparc/include/asm/pgtable.h:5,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from mm/huge_memory.c:8:
   arch/sparc/include/asm/pgtable_64.h:698:45: note: expected 'pmd_t' but argument is of type 'pmd_t *'
     698 | static inline unsigned long pmd_write(pmd_t pmd)
         |                                       ~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/gup_must_unshare +1381 mm/huge_memory.c

  1352	
  1353	struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
  1354					   unsigned long addr,
  1355					   pmd_t *pmd,
  1356					   unsigned int flags)
  1357	{
  1358		struct mm_struct *mm = vma->vm_mm;
  1359		struct page *page = NULL;
  1360	
  1361		assert_spin_locked(pmd_lockptr(mm, pmd));
  1362	
  1363		if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
  1364			goto out;
  1365	
  1366		/* Avoid dumping huge zero page */
  1367		if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
  1368			return ERR_PTR(-EFAULT);
  1369	
  1370		/* Full NUMA hinting faults to serialise migration in fault paths */
  1371		if ((flags & FOLL_NUMA) && pmd_protnone(*pmd))
  1372			goto out;
  1373	
  1374		page = pmd_page(*pmd);
  1375		VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
  1376	
  1377		/*
  1378		 * If unsharing is required, keep retrying to unshare until the
  1379		 * page becomes exclusive.
  1380		 */
> 1381		if (gup_must_unshare(flags, page)) {
> 1382			if (!mark_anon_page_shared(page, pmd_write(pmd)))
  1383				return ERR_PTR(-EMLINK);
  1384		}
  1385	
  1386		if (!try_grab_page(page, flags))
  1387			return ERR_PTR(-ENOMEM);
  1388	
  1389		if (flags & FOLL_TOUCH)
  1390			touch_pmd(vma, addr, pmd, flags);
  1391	
  1392		if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
  1393			/*
  1394			 * We don't mlock() pte-mapped THPs. This way we can avoid
  1395			 * leaking mlocked pages into non-VM_LOCKED VMAs.
  1396			 *
  1397			 * For anon THP:
  1398			 *
  1399			 * In most cases the pmd is the only mapping of the page as we
  1400			 * break COW for the mlock() -- see gup_flags |= FOLL_WRITE for
  1401			 * writable private mappings in populate_vma_page_range().
  1402			 *
  1403			 * The only scenario when we have the page shared here is if we
  1404			 * mlocking read-only mapping shared over fork(). We skip
  1405			 * mlocking such pages.
  1406			 *
  1407			 * For file THP:
  1408			 *
  1409			 * We can expect PageDoubleMap() to be stable under page lock:
  1410			 * for file pages we set it in page_add_file_rmap(), which
  1411			 * requires page to be locked.
  1412			 */
  1413	
  1414			if (PageAnon(page) && compound_mapcount(page) != 1)
  1415				goto skip_mlock;
  1416			if (PageDoubleMap(page) || !page->mapping)
  1417				goto skip_mlock;
  1418			if (!trylock_page(page))
  1419				goto skip_mlock;
  1420			if (page->mapping && !PageDoubleMap(page))
  1421				mlock_vma_page(page);
  1422			unlock_page(page);
  1423		}
  1424	skip_mlock:
  1425		page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
  1426		VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
  1427	
  1428	out:
  1429		return page;
  1430	}
  1431	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54AF4B4EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351885AbiBNLe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351848AbiBNLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:34:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083869CDC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644837659; x=1676373659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ti7mFt3h430vZH2EbX5GTh7/m0VDNjVSg5lsADuLQEM=;
  b=EOPGdonNhrGlZK9Q+4A9ZKewlEVm25gBQYnypMxptm8b+hCcZUB+G4Ro
   gXUn8fcbZQKZ0IAnzbYF5WPYsTslrjILwt38BtgiH62Hk4X/t5Hp+EV+R
   u6cjf78JFoYPh+gGO4Ae4cjwcaIQKhb2LwAPVbQ4cuCTVv0yMn0jvblUK
   QrXxi/t28ztUFp3QI/uhJ5zFylgzHHbwqMwprZkCp2MmzT+aubzF/xIHZ
   2fKru84GCPW6Yel6T24QHcdC+t3M9qMMJF41Rns6VEhWtBYs+aPuHf+pt
   83BdXp5fwq/rQC67z2hPau0Y6E/GG5gDmCv+xJAjjW2NWL3WEam9663Mr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="274640816"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="274640816"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="570117941"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2022 03:20:57 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJZPd-0008Rs-1v; Mon, 14 Feb 2022 11:20:57 +0000
Date:   Mon, 14 Feb 2022 19:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 52/85] mm/page_vma_mapped.c:219:20: error:
 implicit declaration of function 'pmd_pfn'
Message-ID: <202202141924.UPUvH4uw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   c267b33d0001488f1d9dad12d6a87655e174d914
commit: 9733dd1f11d6b6f8a38fa82f0cc014f7840cbd67 [52/85] mm: Convert page_vma_mapped_walk to work on PFNs
config: mips-buildonly-randconfig-r003-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141924.UPUvH4uw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 9733dd1f11d6b6f8a38fa82f0cc014f7840cbd67
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/page_vma_mapped.c:219:20: error: implicit declaration of function 'pmd_pfn' [-Werror,-Wimplicit-function-declaration]
                                   if (!check_pmd(pmd_pfn(pmde), pvmw))
                                                  ^
   mm/page_vma_mapped.c:219:20: note: did you mean 'pmd_off'?
   include/linux/pgtable.h:150:22: note: 'pmd_off' declared here
   static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long va)
                        ^
   1 error generated.


vim +/pmd_pfn +219 mm/page_vma_mapped.c

   126	
   127	/**
   128	 * page_vma_mapped_walk - check if @pvmw->pfn is mapped in @pvmw->vma at
   129	 * @pvmw->address
   130	 * @pvmw: pointer to struct page_vma_mapped_walk. page, vma, address and flags
   131	 * must be set. pmd, pte and ptl must be NULL.
   132	 *
   133	 * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
   134	 * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
   135	 * adjusted if needed (for PTE-mapped THPs).
   136	 *
   137	 * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
   138	 * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
   139	 * a loop to find all PTEs that map the THP.
   140	 *
   141	 * For HugeTLB pages, @pvmw->pte is set to the relevant page table entry
   142	 * regardless of which page table level the page is mapped at. @pvmw->pmd is
   143	 * NULL.
   144	 *
   145	 * Returns false if there are no more page table entries for the page in
   146	 * the vma. @pvmw->ptl is unlocked and @pvmw->pte is unmapped.
   147	 *
   148	 * If you need to stop the walk before page_vma_mapped_walk() returned false,
   149	 * use page_vma_mapped_walk_done(). It will do the housekeeping.
   150	 */
   151	bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
   152	{
   153		struct vm_area_struct *vma = pvmw->vma;
   154		struct mm_struct *mm = vma->vm_mm;
   155		unsigned long end;
   156		pgd_t *pgd;
   157		p4d_t *p4d;
   158		pud_t *pud;
   159		pmd_t pmde;
   160	
   161		/* The only possible pmd mapping has been handled on last iteration */
   162		if (pvmw->pmd && !pvmw->pte)
   163			return not_found(pvmw);
   164	
   165		if (unlikely(is_vm_hugetlb_page(vma))) {
   166			unsigned long size = pvmw->nr_pages * PAGE_SIZE;
   167			/* The only possible mapping was handled on last iteration */
   168			if (pvmw->pte)
   169				return not_found(pvmw);
   170	
   171			/* when pud is not present, pte will be NULL */
   172			pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
   173			if (!pvmw->pte)
   174				return false;
   175	
   176			pvmw->ptl = huge_pte_lockptr(size_to_hstate(size), mm,
   177							pvmw->pte);
   178			spin_lock(pvmw->ptl);
   179			if (!check_pte(pvmw))
   180				return not_found(pvmw);
   181			return true;
   182		}
   183	
   184		end = vma_address_end(pvmw);
   185		if (pvmw->pte)
   186			goto next_pte;
   187	restart:
   188		do {
   189			pgd = pgd_offset(mm, pvmw->address);
   190			if (!pgd_present(*pgd)) {
   191				step_forward(pvmw, PGDIR_SIZE);
   192				continue;
   193			}
   194			p4d = p4d_offset(pgd, pvmw->address);
   195			if (!p4d_present(*p4d)) {
   196				step_forward(pvmw, P4D_SIZE);
   197				continue;
   198			}
   199			pud = pud_offset(p4d, pvmw->address);
   200			if (!pud_present(*pud)) {
   201				step_forward(pvmw, PUD_SIZE);
   202				continue;
   203			}
   204	
   205			pvmw->pmd = pmd_offset(pud, pvmw->address);
   206			/*
   207			 * Make sure the pmd value isn't cached in a register by the
   208			 * compiler and used as a stale value after we've observed a
   209			 * subsequent update.
   210			 */
   211			pmde = READ_ONCE(*pvmw->pmd);
   212	
   213			if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
   214				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
   215				pmde = *pvmw->pmd;
   216				if (likely(pmd_trans_huge(pmde))) {
   217					if (pvmw->flags & PVMW_MIGRATION)
   218						return not_found(pvmw);
 > 219					if (!check_pmd(pmd_pfn(pmde), pvmw))
   220						return not_found(pvmw);
   221					return true;
   222				}
   223				if (!pmd_present(pmde)) {
   224					swp_entry_t entry;
   225	
   226					if (!thp_migration_supported() ||
   227					    !(pvmw->flags & PVMW_MIGRATION))
   228						return not_found(pvmw);
   229					entry = pmd_to_swp_entry(pmde);
   230					if (!is_migration_entry(entry) ||
   231					    !check_pmd(swp_offset(entry), pvmw))
   232						return not_found(pvmw);
   233					return true;
   234				}
   235				/* THP pmd was split under us: handle on pte level */
   236				spin_unlock(pvmw->ptl);
   237				pvmw->ptl = NULL;
   238			} else if (!pmd_present(pmde)) {
   239				/*
   240				 * If PVMW_SYNC, take and drop THP pmd lock so that we
   241				 * cannot return prematurely, while zap_huge_pmd() has
   242				 * cleared *pmd but not decremented compound_mapcount().
   243				 */
   244				if ((pvmw->flags & PVMW_SYNC) &&
   245				    transparent_hugepage_active(vma) &&
   246				    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
   247					spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
   248	
   249					spin_unlock(ptl);
   250				}
   251				step_forward(pvmw, PMD_SIZE);
   252				continue;
   253			}
   254			if (!map_pte(pvmw))
   255				goto next_pte;
   256	this_pte:
   257			if (check_pte(pvmw))
   258				return true;
   259	next_pte:
   260			do {
   261				pvmw->address += PAGE_SIZE;
   262				if (pvmw->address >= end)
   263					return not_found(pvmw);
   264				/* Did we cross page table boundary? */
   265				if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
   266					if (pvmw->ptl) {
   267						spin_unlock(pvmw->ptl);
   268						pvmw->ptl = NULL;
   269					}
   270					pte_unmap(pvmw->pte);
   271					pvmw->pte = NULL;
   272					goto restart;
   273				}
   274				pvmw->pte++;
   275				if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
   276					pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
   277					spin_lock(pvmw->ptl);
   278				}
   279			} while (pte_none(*pvmw->pte));
   280	
   281			if (!pvmw->ptl) {
   282				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
   283				spin_lock(pvmw->ptl);
   284			}
   285			goto this_pte;
   286		} while (pvmw->address < end);
   287	
   288		return false;
   289	}
   290	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

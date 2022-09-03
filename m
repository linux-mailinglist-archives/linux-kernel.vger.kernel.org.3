Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81F5ABD73
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiICGaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiICG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:29:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F192C13F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662186596; x=1693722596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mkl196/saNTuDxx3QucDAn6dgNFeifJ1m4pVF+7WdoQ=;
  b=AByj9F0UBiSaBw1WTban2Q+tx3R/N22SIYeC8Vkplsb57ji9cHiZq5C2
   VmAsOJTP0fJmv+xdo7tFA70r6IZzBBOOaA3kmvbMH9ukNHTupuZIp7HKH
   oxQtz92Lmsj4M+JqTaY+DCJaYjSSU5hKQs5/tBvKzJTsjCLtXwo/ky6NG
   a8ly1l17yM5nwuYXeCBSfmrREkev3ssk4TH5SbU/EtCSLrgfsRVoAnBdL
   ijWWfm0U2lSaBgKCWPAN+QhsyEJ7guL7tdUCLJQBnJfirvBaHFmc1x6iH
   gzE1s5ksToDyA8ITag7/nnEvNxbrx6L5cQMdZJNITEAwyjiPjWGvYtiif
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="322299133"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="322299133"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 23:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="646354560"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2022 23:29:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUMfB-0001Ax-1r;
        Sat, 03 Sep 2022 06:29:53 +0000
Date:   Sat, 3 Sep 2022 14:28:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 402/439] mm/shmem.c:1738:10:
 error: implicit declaration of function 'swap_cache_get_folio' is invalid in
 C99
Message-ID: <202209031437.da4oMdee-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   1e6b789996e7b8b0d382a144a6dccde7b824b510
commit: 91a46452f641672b82f8a01c9f114f85cdfe0d76 [402/439] shmem: eliminate struct page from shmem_swapin_folio()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220903/202209031437.da4oMdee-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/91a46452f641672b82f8a01c9f114f85cdfe0d76
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout 91a46452f641672b82f8a01c9f114f85cdfe0d76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> mm/shmem.c:1738:10: error: implicit declaration of function 'swap_cache_get_folio' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           folio = swap_cache_get_folio(swap, NULL, 0);
                   ^
>> mm/shmem.c:1738:8: warning: incompatible integer to pointer conversion assigning to 'struct folio *' from 'int' [-Wint-conversion]
           folio = swap_cache_get_folio(swap, NULL, 0);
                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/swap_cache_get_folio +1738 mm/shmem.c

  1711	
  1712	/*
  1713	 * Swap in the folio pointed to by *foliop.
  1714	 * Caller has to make sure that *foliop contains a valid swapped folio.
  1715	 * Returns 0 and the folio in foliop if success. On failure, returns the
  1716	 * error code and NULL in *foliop.
  1717	 */
  1718	static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  1719				     struct folio **foliop, enum sgp_type sgp,
  1720				     gfp_t gfp, struct vm_area_struct *vma,
  1721				     vm_fault_t *fault_type)
  1722	{
  1723		struct address_space *mapping = inode->i_mapping;
  1724		struct shmem_inode_info *info = SHMEM_I(inode);
  1725		struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
  1726		struct folio *folio = NULL;
  1727		swp_entry_t swap;
  1728		int error;
  1729	
  1730		VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
  1731		swap = radix_to_swp_entry(*foliop);
  1732		*foliop = NULL;
  1733	
  1734		if (is_swapin_error_entry(swap))
  1735			return -EIO;
  1736	
  1737		/* Look it up and read it in.. */
> 1738		folio = swap_cache_get_folio(swap, NULL, 0);
  1739		if (!folio) {
  1740			/* Or update major stats only when swapin succeeds?? */
  1741			if (fault_type) {
  1742				*fault_type |= VM_FAULT_MAJOR;
  1743				count_vm_event(PGMAJFAULT);
  1744				count_memcg_event_mm(charge_mm, PGMAJFAULT);
  1745			}
  1746			/* Here we actually start the io */
  1747			folio = shmem_swapin(swap, gfp, info, index);
  1748			if (!folio) {
  1749				error = -ENOMEM;
  1750				goto failed;
  1751			}
  1752		}
  1753	
  1754		/* We have to do this with folio locked to prevent races */
  1755		folio_lock(folio);
  1756		if (!folio_test_swapcache(folio) ||
  1757		    folio_swap_entry(folio).val != swap.val ||
  1758		    !shmem_confirm_swap(mapping, index, swap)) {
  1759			error = -EEXIST;
  1760			goto unlock;
  1761		}
  1762		if (!folio_test_uptodate(folio)) {
  1763			error = -EIO;
  1764			goto failed;
  1765		}
  1766		folio_wait_writeback(folio);
  1767	
  1768		/*
  1769		 * Some architectures may have to restore extra metadata to the
  1770		 * folio after reading from swap.
  1771		 */
  1772		arch_swap_restore(swap, folio);
  1773	
  1774		if (shmem_should_replace_folio(folio, gfp)) {
  1775			error = shmem_replace_folio(&folio, gfp, info, index);
  1776			if (error)
  1777				goto failed;
  1778		}
  1779	
  1780		error = shmem_add_to_page_cache(folio, mapping, index,
  1781						swp_to_radix_entry(swap), gfp,
  1782						charge_mm);
  1783		if (error)
  1784			goto failed;
  1785	
  1786		spin_lock_irq(&info->lock);
  1787		info->swapped--;
  1788		shmem_recalc_inode(inode);
  1789		spin_unlock_irq(&info->lock);
  1790	
  1791		if (sgp == SGP_WRITE)
  1792			folio_mark_accessed(folio);
  1793	
  1794		delete_from_swap_cache(folio);
  1795		folio_mark_dirty(folio);
  1796		swap_free(swap);
  1797	
  1798		*foliop = folio;
  1799		return 0;
  1800	failed:
  1801		if (!shmem_confirm_swap(mapping, index, swap))
  1802			error = -EEXIST;
  1803		if (error == -EIO)
  1804			shmem_set_folio_swapin_error(inode, index, folio, swap);
  1805	unlock:
  1806		if (folio) {
  1807			folio_unlock(folio);
  1808			folio_put(folio);
  1809		}
  1810	
  1811		return error;
  1812	}
  1813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

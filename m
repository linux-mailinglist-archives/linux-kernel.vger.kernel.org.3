Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977A849F454
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiA1H3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:29:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:3523 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346790AbiA1H3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643354951; x=1674890951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XCwRoBaa0ELVyrdhteZijBEAwmPKSrzqj4Ge9pj6KlE=;
  b=AKxFVTvKIy576Z5AXyhstY6ev+/W0GMAxDATbh+A7Z7By3xCyiGhdrRz
   JG7fYcbYilfL6vbo/M7Mfy/+ygLbrJjse5peMCDeAt4GBNEuQiVCkMSZ8
   kDu5K27uSvCeL+Jv0AEmQUOZ/GxGkmBrtd8Lp7oVAsYA1ZA8iUxe5KKps
   SnlXt8zAqb+WNFHV10eyYUXVgqSpUCm2HKVFMLWTXfz1mDtVdZQcRVFRL
   xxkyt2iL+e8Nfc4vL0oVtF7gRxWDTRhU6dZJlTq3d+RamT3YMnSDVOlrJ
   vmYG9hEVQKjU3vcGip652wFhIRe3rVksqL4z95WwbhwKcx2dCrw7yh+N2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307782147"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="307782147"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="675017086"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 23:29:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDLgu-000NcA-6t; Fri, 28 Jan 2022 07:29:04 +0000
Date:   Fri, 28 Jan 2022 15:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philip Yang <Philip.Yang@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [agd5f:drm-next 185/212]
 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2067:22: warning: variable
 'p' set but not used
Message-ID: <202201281547.sPuZ2yPF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   af60f9540e16fe6300d2e57f69484d364f76da34
commit: 367c9b0f1b8750a704070e7ae85234d591290434 [185/212] drm/amdkfd: Ensure mm remain valid in svm deferred_list work
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201281547.sPuZ2yPF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 367c9b0f1b8750a704070e7ae85234d591290434
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function 'svm_range_deferred_list_work':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2067:22: warning: variable 'p' set but not used [-Wunused-but-set-variable]
    2067 |  struct kfd_process *p;
         |                      ^


vim +/p +2067 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c

373e3ccd859b4b Philip Yang    2021-04-19  2061  
4683cfecadeb38 Philip Yang    2020-04-08  2062  static void svm_range_deferred_list_work(struct work_struct *work)
4683cfecadeb38 Philip Yang    2020-04-08  2063  {
4683cfecadeb38 Philip Yang    2020-04-08  2064  	struct svm_range_list *svms;
4683cfecadeb38 Philip Yang    2020-04-08  2065  	struct svm_range *prange;
4683cfecadeb38 Philip Yang    2020-04-08  2066  	struct mm_struct *mm;
a0c55ecee10055 Philip Yang    2021-11-16 @2067  	struct kfd_process *p;
4683cfecadeb38 Philip Yang    2020-04-08  2068  
4683cfecadeb38 Philip Yang    2020-04-08  2069  	svms = container_of(work, struct svm_range_list, deferred_list_work);
4683cfecadeb38 Philip Yang    2020-04-08  2070  	pr_debug("enter svms 0x%p\n", svms);
4683cfecadeb38 Philip Yang    2020-04-08  2071  
a0c55ecee10055 Philip Yang    2021-11-16  2072  	p = container_of(svms, struct kfd_process, svms);
367c9b0f1b8750 Philip Yang    2022-01-18  2073  
367c9b0f1b8750 Philip Yang    2022-01-18  2074  	spin_lock(&svms->deferred_list_lock);
367c9b0f1b8750 Philip Yang    2022-01-18  2075  	while (!list_empty(&svms->deferred_range_list)) {
367c9b0f1b8750 Philip Yang    2022-01-18  2076  		prange = list_first_entry(&svms->deferred_range_list,
367c9b0f1b8750 Philip Yang    2022-01-18  2077  					  struct svm_range, deferred_list);
367c9b0f1b8750 Philip Yang    2022-01-18  2078  		spin_unlock(&svms->deferred_list_lock);
367c9b0f1b8750 Philip Yang    2022-01-18  2079  
367c9b0f1b8750 Philip Yang    2022-01-18  2080  		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
367c9b0f1b8750 Philip Yang    2022-01-18  2081  			 prange->start, prange->last, prange->work_item.op);
367c9b0f1b8750 Philip Yang    2022-01-18  2082  
367c9b0f1b8750 Philip Yang    2022-01-18  2083  		mm = prange->work_item.mm;
a44fe9ee051aca Felix Kuehling 2021-11-05  2084  retry:
4683cfecadeb38 Philip Yang    2020-04-08  2085  		mmap_write_lock(mm);
4683cfecadeb38 Philip Yang    2020-04-08  2086  
a0c55ecee10055 Philip Yang    2021-11-16  2087  		/* Checking for the need to drain retry faults must be inside
a44fe9ee051aca Felix Kuehling 2021-11-05  2088  		 * mmap write lock to serialize with munmap notifiers.
4683cfecadeb38 Philip Yang    2020-04-08  2089  		 */
2e4477282c8cff Philip Yang    2021-11-19  2090  		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
a44fe9ee051aca Felix Kuehling 2021-11-05  2091  			mmap_write_unlock(mm);
a44fe9ee051aca Felix Kuehling 2021-11-05  2092  			svm_range_drain_retry_fault(svms);
a44fe9ee051aca Felix Kuehling 2021-11-05  2093  			goto retry;
a44fe9ee051aca Felix Kuehling 2021-11-05  2094  		}
a0c55ecee10055 Philip Yang    2021-11-16  2095  
367c9b0f1b8750 Philip Yang    2022-01-18  2096  		/* Remove from deferred_list must be inside mmap write lock, for
367c9b0f1b8750 Philip Yang    2022-01-18  2097  		 * two race cases:
367c9b0f1b8750 Philip Yang    2022-01-18  2098  		 * 1. unmap_from_cpu may change work_item.op and add the range
367c9b0f1b8750 Philip Yang    2022-01-18  2099  		 *    to deferred_list again, cause use after free bug.
367c9b0f1b8750 Philip Yang    2022-01-18  2100  		 * 2. svm_range_list_lock_and_flush_work may hold mmap write
367c9b0f1b8750 Philip Yang    2022-01-18  2101  		 *    lock and continue because deferred_list is empty, but
367c9b0f1b8750 Philip Yang    2022-01-18  2102  		 *    deferred_list work is actually waiting for mmap lock.
367c9b0f1b8750 Philip Yang    2022-01-18  2103  		 */
a0c55ecee10055 Philip Yang    2021-11-16  2104  		spin_lock(&svms->deferred_list_lock);
4683cfecadeb38 Philip Yang    2020-04-08  2105  		list_del_init(&prange->deferred_list);
4683cfecadeb38 Philip Yang    2020-04-08  2106  		spin_unlock(&svms->deferred_list_lock);
4683cfecadeb38 Philip Yang    2020-04-08  2107  
a0c55ecee10055 Philip Yang    2021-11-16  2108  		mutex_lock(&svms->lock);
0b0e518d61af8e Felix Kuehling 2021-02-24  2109  		mutex_lock(&prange->migrate_mutex);
4683cfecadeb38 Philip Yang    2020-04-08  2110  		while (!list_empty(&prange->child_list)) {
4683cfecadeb38 Philip Yang    2020-04-08  2111  			struct svm_range *pchild;
4683cfecadeb38 Philip Yang    2020-04-08  2112  
4683cfecadeb38 Philip Yang    2020-04-08  2113  			pchild = list_first_entry(&prange->child_list,
4683cfecadeb38 Philip Yang    2020-04-08  2114  						struct svm_range, child_list);
4683cfecadeb38 Philip Yang    2020-04-08  2115  			pr_debug("child prange 0x%p op %d\n", pchild,
4683cfecadeb38 Philip Yang    2020-04-08  2116  				 pchild->work_item.op);
4683cfecadeb38 Philip Yang    2020-04-08  2117  			list_del_init(&pchild->child_list);
367c9b0f1b8750 Philip Yang    2022-01-18  2118  			svm_range_handle_list_op(svms, pchild, mm);
4683cfecadeb38 Philip Yang    2020-04-08  2119  		}
0b0e518d61af8e Felix Kuehling 2021-02-24  2120  		mutex_unlock(&prange->migrate_mutex);
4683cfecadeb38 Philip Yang    2020-04-08  2121  
367c9b0f1b8750 Philip Yang    2022-01-18  2122  		svm_range_handle_list_op(svms, prange, mm);
4683cfecadeb38 Philip Yang    2020-04-08  2123  		mutex_unlock(&svms->lock);
367c9b0f1b8750 Philip Yang    2022-01-18  2124  		mmap_write_unlock(mm);
367c9b0f1b8750 Philip Yang    2022-01-18  2125  
367c9b0f1b8750 Philip Yang    2022-01-18  2126  		/* Pairs with mmget in svm_range_add_list_work */
367c9b0f1b8750 Philip Yang    2022-01-18  2127  		mmput(mm);
4683cfecadeb38 Philip Yang    2020-04-08  2128  
4683cfecadeb38 Philip Yang    2020-04-08  2129  		spin_lock(&svms->deferred_list_lock);
4683cfecadeb38 Philip Yang    2020-04-08  2130  	}
4683cfecadeb38 Philip Yang    2020-04-08  2131  	spin_unlock(&svms->deferred_list_lock);
4683cfecadeb38 Philip Yang    2020-04-08  2132  	pr_debug("exit svms 0x%p\n", svms);
4683cfecadeb38 Philip Yang    2020-04-08  2133  }
4683cfecadeb38 Philip Yang    2020-04-08  2134  

:::::: The code at line 2067 was first introduced by commit
:::::: a0c55ecee10055901c9c1b46d0d129cb6b51fa5d drm/amdkfd: process exit and retry fault race

:::::: TO: Philip Yang <Philip.Yang@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

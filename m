Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3832A4BD1E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiBTVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbiBTVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:23:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A2C377D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645392174; x=1676928174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yoEzQt8cKhPyMjQZPNtUsTOxhaZ/yE5I6z999NWYwWM=;
  b=iIny0Qk+5gdrdTDAR9MuV4yhxXp/PSNrNHqz5v9csup/6168F44wB4wX
   Xv+CDFaCMdRmPqW2qDndQz0On2Smlq5/Cy4Gjpca30zUXqIXeT9D+pkpF
   9ZIg5avZ3kdlE+uoygS0SxDVpgJ3x6xKM+FBsNFxiQAeEDO2mYAP7mZ4z
   gsbf7mj7IEIqC0HDV4d905+q61NUbOqaeFwjBjZBwOll5rWchFAIhbGSX
   QpHcxvWlOS2m1CHZ1OO8NSYEcXqaSZDnUVhTdCSU/xixqQz1cjiXRp2dS
   AM7yzP702Z4ojloTyjVKxeVnbMgprtj8eYdgC+kIWpsGPBnYr83gr9ioo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314667096"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="314667096"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 13:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="706024764"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 13:22:53 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLtfQ-0000p9-KU; Sun, 20 Feb 2022 21:22:52 +0000
Date:   Mon, 21 Feb 2022 05:22:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 4/11] drivers/iommu/iommufd/pages.c:472:35:
 error: passing argument 1 of 'atomic64_read' from incompatible pointer type
Message-ID: <202202210555.Jl3so3EM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   eb047b2ba449f66ffc3f427bb50c9ca60f6c9b95
commit: 72a206491bb65ff62cca14b086edd5ff35625873 [4/11] iommufd: Data structure for PFN storage
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220221/202202210555.Jl3so3EM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/72a206491bb65ff62cca14b086edd5ff35625873
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 72a206491bb65ff62cca14b086edd5ff35625873
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/iommu/iommufd/pages.c:45:
   drivers/iommu/iommufd/pages.c: In function 'update_unpinned':
>> drivers/iommu/iommufd/pages.c:472:35: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
     472 |             WARN_ON(atomic64_read(&pages->source_user->locked_vm) < npages))
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   atomic_long_t * {aka atomic_t *}
   include/asm-generic/bug.h:121:32: note: in definition of macro 'WARN_ON'
     121 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/iommu/iommufd/pages.c:45:
   include/linux/atomic/atomic-instrumented.h:644:33: note: expected 'const atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     644 | atomic64_read(const atomic64_t *v)
         |               ~~~~~~~~~~~~~~~~~~^
>> drivers/iommu/iommufd/pages.c:474:30: error: passing argument 2 of 'atomic64_sub' from incompatible pointer type [-Werror=incompatible-pointer-types]
     474 |         atomic64_sub(npages, &pages->source_user->locked_vm);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                              |
         |                              atomic_long_t * {aka atomic_t *}
   In file included from include/linux/atomic.h:82,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/iommu/iommufd/pages.c:45:
   include/linux/atomic/atomic-instrumented.h:740:33: note: expected 'atomic64_t *' but argument is of type 'atomic_long_t *' {aka 'atomic_t *'}
     740 | atomic64_sub(s64 i, atomic64_t *v)
         |                     ~~~~~~~~~~~~^
   cc1: some warnings being treated as errors


vim +/atomic64_read +472 drivers/iommu/iommufd/pages.c

   461	
   462	static void update_unpinned(struct iopt_pages *pages)
   463	{
   464		unsigned long npages = pages->last_npinned - pages->npinned;
   465	
   466		lockdep_assert_held(&pages->mutex);
   467	
   468		if (pages->has_cap_ipc_lock)
   469			return;
   470	
   471		if (WARN_ON(pages->npinned > pages->last_npinned) ||
 > 472		    WARN_ON(atomic64_read(&pages->source_user->locked_vm) < npages))
   473			return;
 > 474		atomic64_sub(npages, &pages->source_user->locked_vm);
   475		atomic64_sub(npages, &pages->source_mm->pinned_vm);
   476		pages->last_npinned = pages->npinned;
   477	}
   478	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244F548A6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbiAKEK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:10:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:6906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234203AbiAKEKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641874225; x=1673410225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fko5tSHAqkpnrbRvu4UMb7PHCxpyhJg0p+Ve7Au1TpI=;
  b=GH2k6ahY2Ottai3Bc7QkNhsmEitl1290qkhTei74ajQ+MS4w5dS5I/Mc
   ViEadSdtPFJT6gh7N0zgIvaQIKchjf01ylSjfubdhRW/na+aCFoOFYw0y
   OSzxeI+WZ77iFeYiwuIfojxc+VkyfPlQCkbYroFLrlvfvpdo6PM1batrN
   mdbt54DP7T5ykPwknZzf4YjN9Fiec438gxGmXIQ12g7axl7pKDC56E2Ko
   XMGdVtx7oN6mz+i6Z5oDzCvbap1EMoICOOtEbJPNRQ8Xab5eKOvj3+PX9
   ErWJdHqCO8/vnwQd075GV4K9w0cy13Rs5Zc20PAUorDINX3quclNuzlSz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243194191"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243194191"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 20:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="514937789"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2022 20:10:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n78UI-0004JB-L6; Tue, 11 Jan 2022 04:10:22 +0000
Date:   Tue, 11 Jan 2022 12:10:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2564/2575] arch/arm64/kvm/hyp/nvhe/iommu/s2mpu.c:104: warning: This comment
 starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202201111216.YaxndGDc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   d52e3e4473075ddf199c9ae763e747302d729468
commit: f6b90bb6f59d0dab524f623b255f29c149557270 [2564/2575] ANDROID: KVM: arm64: Enable S2MPUs in __pkvm_init_stage2_iommu
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220111/202201111216.YaxndGDc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f6b90bb6f59d0dab524f623b255f29c149557270
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout f6b90bb6f59d0dab524f623b255f29c149557270
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/hyp/nvhe/iommu/s2mpu.c:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initialize S2MPU device and set all GB regions to 1G granularity with


vim +104 arch/arm64/kvm/hyp/nvhe/iommu/s2mpu.c

   102	
   103	/**
 > 104	 * Initialize S2MPU device and set all GB regions to 1G granularity with
   105	 * given protection bits.
   106	 */
   107	static void initialize_with_prot(struct s2mpu *dev, enum mpt_prot prot)
   108	{
   109		unsigned int gb, vid;
   110	
   111		/* Must write CONTEXT_CFG_VALID_VID before setting L1ENTRY registers. */
   112		__set_context_ids(dev);
   113	
   114		for_each_gb_and_vid(gb, vid)
   115			__set_l1entry_attr_with_prot(dev, gb, vid, prot);
   116		__all_invalidation(dev);
   117	
   118		/* Set control registers, enable the S2MPU. */
   119		__set_control_regs(dev);
   120	}
   121	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

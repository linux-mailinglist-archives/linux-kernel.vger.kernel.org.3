Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5421B5AB493
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiIBO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiIBO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:58:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0F51C9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662128633; x=1693664633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8rPf23hyyD1KcvMCjUWBcV4HJfUbaMGNgSAFaMNAq/I=;
  b=SxZG541fpMD7rqXeqQqYAfWTNruETtJDaOnkGp4H/ak43r95UcAoaTb7
   w4H6PjtwPTXM5AytiwvzzytUp454b1XmaT9lm21NV2RG2J5Wfqq46IB7k
   JG8JU933utL9RXIx3dF33YYPdYc+RtjJGzgM+pSDOcoxAPWxVq1hLNh4X
   B+Qhc0P7NfBljpenWNeX7V0hvc+Uj7SdJ+ZZp8BHjB7XPbyYABIs+KGqI
   5FpQuaA61E0CrS8Wgk20nCPSpf8LYmzvkT2bxDMbHyrvfOhotE9Xfd8jM
   KjuK+hOcAHyesH71d1+gQXVVR9Wp/05R0Vd3AeKDmn1E/YldUWQ1695bK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="382289230"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382289230"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941304688"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 07:23:49 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU7aH-0000BD-0J;
        Fri, 02 Sep 2022 14:23:49 +0000
Date:   Fri, 2 Sep 2022 22:23:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: mm/khugepaged.c:2046:56: warning: 'struct khugepaged_mm_slot'
 declared inside parameter list will not be visible outside of this
 definition or declaration
Message-ID: <202209022248.TEjW4Cld-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149
head:   32b787e37af17f7fe75f9b9c9bb22bf044722229
commit: 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e mm: thp: fix build error with CONFIG_SHMEM disabled
date:   30 hours ago
config: sparc-randconfig-r023-20220901 (https://download.01.org/0day-ci/archive/20220902/202209022248.TEjW4Cld-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220901-154717/Qi-Zheng/add-common-struct-mm_slot-and-use-it-in-THP-and-KSM/20220831-112149
        git checkout 7ad02cf1645071c2bf1ed6ae0e48907aa0a3119e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/khugepaged.c:2046:56: warning: 'struct khugepaged_mm_slot' declared inside parameter list will not be visible outside of this definition or declaration
    2046 | static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
         |                                                        ^~~~~~~~~~~~~~~~~~
   mm/khugepaged.c: In function 'khugepaged_scan_mm_slot':
   mm/khugepaged.c:2076:45: error: passing argument 1 of 'khugepaged_collapse_pte_mapped_thps' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2076 |         khugepaged_collapse_pte_mapped_thps(mm_slot);
         |                                             ^~~~~~~
         |                                             |
         |                                             struct mm_slot *
   mm/khugepaged.c:2046:76: note: expected 'struct khugepaged_mm_slot *' but argument is of type 'struct mm_slot *'
    2046 | static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors


vim +2046 mm/khugepaged.c

  2045	
> 2046	static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
  2047	{
  2048	}
  2049	#endif
  2050	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

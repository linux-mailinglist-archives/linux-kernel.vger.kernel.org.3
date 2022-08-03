Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F1E5891B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiHCRsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:48:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BC13D1A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659548899; x=1691084899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rF3OY9Dsb4CCvexrUxd7GJarnmlUWzpt1tT0LjQD9tw=;
  b=kJ+yJNhuNrjrSQ99I7u5aCXS5+0bT5RQOAtBBDVYRB4XOt0GyhHeYKrp
   +szg6oDqsWAK1QO4/OB4sduGcStQ97UY5rRj3An8b5zGhKjb3wUf/zs9E
   PoCqSePnerYy0GMMMwBh1D5zj1OOMzho7nnEjMJxt/G/jV1ubEK3ErXrR
   EqpNtgpjLpLAw8hygZWvbawqwjn84sx6WR6fSyuFRqpU4goOFmFT/O1Yn
   SLyNxW+qsgDgBOmxuy5hr831mKbN9wrieWPy6NG2JsUIgLyN/v7qpboiL
   YsfOC4nsj72VKTGoJcaV8SKRvegWgwzrzU5ADqzFvi7rahwU6LAyhtaJJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="290956085"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="290956085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 10:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="930474334"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2022 10:48:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJITg-000HWC-0D;
        Wed, 03 Aug 2022 17:48:16 +0000
Date:   Thu, 4 Aug 2022 01:48:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Harrison <John.C.Harrison@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Jordan Justen <jordan.l.justen@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:110: warning:
 expecting prototype for intel_guc_hwconfig_init(). Prototype was for
 guc_hwconfig_init() instead
Message-ID: <202208040157.aQqPWbKV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2b542100719a93f8cdf6d90185410d38a57a4c1
commit: 8781f0515247f441623a01f6e036a1d7898170e2 drm/i915/guc: Add fetch of hwconfig blob
date:   5 months ago
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220804/202208040157.aQqPWbKV-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8781f0515247f441623a01f6e036a1d7898170e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8781f0515247f441623a01f6e036a1d7898170e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:110: warning: Function parameter or member 'gt' not described in 'guc_hwconfig_init'
>> drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:110: warning: expecting prototype for intel_guc_hwconfig_init(). Prototype was for guc_hwconfig_init() instead
   drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:143: warning: Function parameter or member 'gt' not described in 'intel_gt_init_hwconfig'
   drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:156: warning: Function parameter or member 'gt' not described in 'intel_gt_fini_hwconfig'


vim +110 drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c

   102	
   103	/**
   104	 * intel_guc_hwconfig_init - Initialize the HWConfig
   105	 *
   106	 * Retrieve the HWConfig table from the GuC and save it locally.
   107	 * It can then be queried on demand by other users later on.
   108	 */
   109	static int guc_hwconfig_init(struct intel_gt *gt)
 > 110	{
   111		struct intel_hwconfig *hwconfig = &gt->info.hwconfig;
   112		struct intel_guc *guc = &gt->uc.guc;
   113		int ret;
   114	
   115		if (!has_table(gt->i915))
   116			return 0;
   117	
   118		ret = guc_hwconfig_discover_size(guc, hwconfig);
   119		if (ret)
   120			return ret;
   121	
   122		hwconfig->ptr = kmalloc(hwconfig->size, GFP_KERNEL);
   123		if (!hwconfig->ptr) {
   124			hwconfig->size = 0;
   125			return -ENOMEM;
   126		}
   127	
   128		ret = guc_hwconfig_fill_buffer(guc, hwconfig);
   129		if (ret < 0) {
   130			intel_gt_fini_hwconfig(gt);
   131			return ret;
   132		}
   133	
   134		return 0;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

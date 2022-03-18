Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DD4DDB9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiCROZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiCROZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:25:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B162197AC6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647613424; x=1679149424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8zKtcZ8R8SGa0J6tXQaiMLxoieJ+sOb7fjtfyllTGMU=;
  b=E3U9zFy1oE/ByNKo9KH86yqAfPN1L3YDevFxu/KhjRnTLzJKZqYAQjOw
   VTxwx1EQhgL+qQV2h10+Sr64KmX7Byr7gqrakRzQk8oHVR3xcn07DvcS5
   /OdnJPaAQWs8qcdD1aKusieUGxR51p77kwqrWR/svJZifj2p9srBdndg2
   ikm6ZNkzvJuFMf4Y/h8xczQKj0npbyWVyXdS5yur8UWISYW+stsNmEYOU
   84XqrtvVvZPAydjQOpqhnLjM36gyKoM9FIVK4q9XDn9p4rkRjkxYY/bSg
   ptA/N+i15wAQ7WP+hmn6kMjRAp8gShXuTn7qdGOkJEmJSE7aVypwFGTOS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257093426"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257093426"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715500449"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 07:23:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVDW0-000Ep1-Sq; Fri, 18 Mar 2022 14:23:40 +0000
Date:   Fri, 18 Mar 2022 22:22:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Harrison <John.C.Harrison@Intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Jordan Justen <jordan.l.justen@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: [drm-drm-intel:drm-intel-gt-next 1/2]
 drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c:110: warning: expecting
 prototype for intel_guc_hwconfig_init(). Prototype was for
 guc_hwconfig_init() instead
Message-ID: <202203182256.uEbGTBvI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-intel drm-intel-gt-next
head:   78e1fb3112c0ac440bf9dce080a4aefbaa547d52
commit: 8781f0515247f441623a01f6e036a1d7898170e2 [1/2] drm/i915/guc: Add fetch of hwconfig blob
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220318/202203182256.uEbGTBvI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-drm-intel git://anongit.freedesktop.org/drm/drm-intel
        git fetch --no-tags drm-drm-intel drm-intel-gt-next
        git checkout 8781f0515247f441623a01f6e036a1d7898170e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

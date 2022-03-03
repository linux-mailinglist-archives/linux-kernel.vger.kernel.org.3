Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22924CBDA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiCCMYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiCCMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:24:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF596F47CC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646310234; x=1677846234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5A8+UwEKET76Z6QSlxRtN3MfuThIgRUQ9Vh7luEAVyQ=;
  b=a2d1kUDws6ohhA/unXoBTd92VO4CoWABm4vlYeNFuCoUFRlKj55OJC4J
   kuSB+fodaVA0TuoIxi9DMhpJ9IHY7fXiixF0oEvx9IzJwG78RI1If5Ba8
   Wq4Op22RHyXP+scgiHUpfomlTwjySxoCOQg6zLspljA2GirwhOwff8bJR
   WPBwLZbQvSweJKPRHl07Ig+kdMYSNKcXNV+/x2m5Wzc7UWmtoadR79knA
   Jhtic3zlXBBolt3tpkJVyUgWe6eQJE0x3fhhOYNOCrsgO7HNcd7/zREJm
   iBWbKdvIOjYiyIOweNNvid+9dOiSiwb4CfcnyKUYwwVnMNp3fnraNcXRq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253589635"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="253589635"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 04:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="709906632"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2022 04:23:52 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPkUq-0000UR-3z; Thu, 03 Mar 2022 12:23:52 +0000
Date:   Thu, 3 Mar 2022 20:22:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     yipechai <YiPeng.Chai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>
Subject: [agd5f:drm-next 16/45]
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c:27:6: warning: no previous
 prototype for 'amdgpu_mmhub_ras_fini'
Message-ID: <202203032029.NklrWWSk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   efa8692773c96d85dd24fdb76e49ff9056f963a1
commit: 9dad47c50f9bf19153c092a73eb4721344f4a78d [16/45] drm/amdgpu: Remove redundant calls of amdgpu_ras_block_late_fini in mmhub ras block
config: ia64-randconfig-r012-20220303 (https://download.01.org/0day-ci/archive/20220303/202203032029.NklrWWSk-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 9dad47c50f9bf19153c092a73eb4721344f4a78d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c:27:6: warning: no previous prototype for 'amdgpu_mmhub_ras_fini' [-Wmissing-prototypes]
      27 | void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/amdgpu_mmhub_ras_fini +27 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c

47930de4aa70681 Hawking Zhang 2019-09-03  26  
01d468d9a420152 yipechai      2022-02-17 @27  void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
196041205cd4838 Tao Zhou      2019-09-18  28  {
9dad47c50f9bf19 yipechai      2022-02-14  29  

:::::: The code at line 27 was first introduced by commit
:::::: 01d468d9a420152e4a1270992e69a37ea0c98e04 drm/amdgpu: Modify .ras_fini function pointer parameter

:::::: TO: yipechai <YiPeng.Chai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

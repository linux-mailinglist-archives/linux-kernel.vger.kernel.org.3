Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066950C77B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiDWFKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:10:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF061C82DC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650690468; x=1682226468;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RSzK28hpmsPwsJaYE/nRXiMqFWZp1ifH+SCFd8dQ7H4=;
  b=fkLn6O+ebnXrVTp2i4i3W8PELChwV+zJAqf50EokID7bYM2tcG0rRjfD
   KYBjwy9YxPtPLkPewEcSWR9gYSpnyjZDNenRRLFrg1HkKfj75l2HfLx0T
   oLzFcLZ2taM3mD4VB3mQn3afHcv3VyEwQNWt6KOtnmJg2HB2BAdd2U+vb
   G08tUArvhJu1w8Qi0KqolN09emVCTkcw7yhxCCOUNG9DOUR/BcG/gmwDy
   o0VfasH62xEyQjoYOY2KFvoXER2reRl+QOy98UpZ26J4wvvzmgb7X6M0J
   HJ2RXrpYusoFiquN5cKL+CloSFMq+r6VGS7gR/MZtkEgyf8PxDCH+6bX+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245421920"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="245421920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 22:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="531171263"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2022 22:07:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni7zl-000B2J-5A;
        Sat, 23 Apr 2022 05:07:45 +0000
Date:   Sat, 23 Apr 2022 13:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
 kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk
 >= 0) => (0-u32max >= 0)'
Message-ID: <202204231316.BkRCaafM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c00c5e1d157bec0ef0b0b59aa5482eb8dc7e8e49
commit: 837d542a09cd533055423dfca7e621a9c1d13c5b drm/amd/pm: relocate the power related headers
date:   3 months ago
config: xtensa-randconfig-m031-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231316.BkRCaafM-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641 kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'

vim +1641 drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c

a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1633  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1634  static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1635  {
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1636  	u8 i;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1637  	struct amdgpu_clock_voltage_dependency_table *table =
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1638  		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1639  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1640  	for (i = 0; i < table->count; i++) {
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20 @1641  		if (table->entries[i].clk >= 0) /* XXX */
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1642  			break;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1643  	}
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1644  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1645  	if (i >= table->count)
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1646  		i = table->count - 1;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1647  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1648  	return i;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1649  }
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1650  

:::::: The code at line 1641 was first introduced by commit
:::::: a2e73f56fa6282481927ec43aa9362c03c2e2104 drm/amdgpu: Add support for CIK parts

:::::: TO: Alex Deucher <alexander.deucher@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

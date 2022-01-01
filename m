Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1278482817
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiAASK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 13:10:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:6946 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbiAASK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 13:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641060658; x=1672596658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6K3CoX9YAWSrcp9OBFlitgEmNzH3DMhqxHNj6k1aLfM=;
  b=eZ0ZjWybNN1ZRDO1AeYQ2ogZ0FfMNZekOVVPYZR0/8/zpaoAi2R4rg+o
   jDtceWPsSX5mcRJJiBvNcGn0UJfL4HOkwjbByY6o9kWUgpN0TaeIUmPwC
   Abk3bB7yJG3uLoq/6Dm9g24iheR2VkKoKR4Z3q0DFdhAO09eDFOnb8Khh
   Uyu59XcOgTZmkaGPqXX4hNE8BHRizMjqCO1UWmNda/R5JSGLrGfB4o25x
   KwLslV69CN7g0DuglUAc05NOEshL1Hcp/fK6HVftnxqE2BGIuhapamfU2
   DHv8zTrTvA7V07HtnfD4QC5gc0hnB8RDuS96rIHAG74qeLWs3ESLDKDy2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="241867569"
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="241867569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 10:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,254,1635231600"; 
   d="scan'208";a="619890056"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jan 2022 10:10:57 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3iqG-000CjQ-GR; Sat, 01 Jan 2022 18:10:56 +0000
Date:   Sun, 2 Jan 2022 02:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     JianMin Liu <jian-min.liu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2021-12
 8788/9999] kernel/sched/pelt.c:35:5: warning: no previous prototype for
 'get_pelt_halflife'
Message-ID: <202201020220.ooYV0tfD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JianMin,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2021-12
head:   982761134d974e5ec66bd02c18df9b3e2d61dbb4
commit: 1efc36b815769cb8c7dae1d53373b190c017f5d1 [8788/9999] ANDROID: sched: add a helper function to change PELT half-life
config: i386-buildonly-randconfig-r003-20211111 (https://download.01.org/0day-ci/archive/20220102/202201020220.ooYV0tfD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/1efc36b815769cb8c7dae1d53373b190c017f5d1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2021-12
        git checkout 1efc36b815769cb8c7dae1d53373b190c017f5d1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/pelt.c:35:5: warning: no previous prototype for 'get_pelt_halflife' [-Wmissing-prototypes]
      35 | int get_pelt_halflife(void)
         |     ^~~~~~~~~~~~~~~~~
>> kernel/sched/pelt.c:68:5: warning: no previous prototype for 'set_pelt_halflife' [-Wmissing-prototypes]
      68 | int set_pelt_halflife(int num)
         |     ^~~~~~~~~~~~~~~~~


vim +/get_pelt_halflife +35 kernel/sched/pelt.c

    34	
  > 35	int get_pelt_halflife(void)
    36	{
    37		return pelt_load_avg_period;
    38	}
    39	EXPORT_SYMBOL_GPL(get_pelt_halflife);
    40	
    41	static int __set_pelt_halflife(void *data)
    42	{
    43		int rc = 0;
    44		int num = *(int *)data;
    45	
    46		switch (num) {
    47		case PELT8_LOAD_AVG_PERIOD:
    48			pelt_load_avg_period = PELT8_LOAD_AVG_PERIOD;
    49			pelt_load_avg_max = PELT8_LOAD_AVG_MAX;
    50			pelt_runnable_avg_yN_inv = pelt8_runnable_avg_yN_inv;
    51			pr_info("PELT half life is set to %dms\n", num);
    52			break;
    53		case PELT32_LOAD_AVG_PERIOD:
    54			pelt_load_avg_period = PELT32_LOAD_AVG_PERIOD;
    55			pelt_load_avg_max = PELT32_LOAD_AVG_MAX;
    56			pelt_runnable_avg_yN_inv = pelt32_runnable_avg_yN_inv;
    57			pr_info("PELT half life is set to %dms\n", num);
    58			break;
    59		default:
    60			rc = -EINVAL;
    61			pr_err("Failed to set PELT half life to %dms, the current value is %dms\n",
    62				num, pelt_load_avg_period);
    63		}
    64	
    65		return rc;
    66	}
    67	
  > 68	int set_pelt_halflife(int num)
    69	{
    70		return stop_machine(__set_pelt_halflife, &num, NULL);
    71	}
    72	EXPORT_SYMBOL_GPL(set_pelt_halflife);
    73	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65FC49CA5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiAZNG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:06:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:30249 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234750AbiAZNG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202416; x=1674738416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XjWMcWPURe33zryHgBxjpCyZGZWbFlH2+4e/kRAz0KE=;
  b=W0w0nVTSdkevENXXrv06v5yAZV6r0BiQ37YYm50Y4ZEhEaTv3DCC4Wpw
   QrY4MKe1+u54yjddvZTSws+dkXmpH2vW00M3dMLWa5U4aKONyt5rRx2ru
   KNmerH7f7bgABALPFPu9XQvS1yf8SnxpCVMuEl7IzglIbRQqagzQLhF3U
   qFZj3wegygcXOmPTDp6VqFQYLwANKlVTZ3y5v27jD1kH7DJmaSv2dWt+3
   NHOfq1PbXo1qQlY/KI5YC+j/v02d6skuGJPASsL9mhhq3vUZvndxSOtPh
   uoaidC0uD1bK0sse/dv28mJrW02QNPhgTiAevb8P+Mocf568G8ObdYx1Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244142975"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244142975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="563404328"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2022 05:06:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCi0k-000LEo-F1; Wed, 26 Jan 2022 13:06:54 +0000
Date:   Wed, 26 Jan 2022 21:06:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 94/137]
 drivers/platform/mpam/mpam_devices.c:660:6: warning: no previous prototype
 for 'mpam_enable_once'
Message-ID: <202201262115.SStlJyqy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: 33a96085f6c98eddf4ae74babf67cf03c979e2fb [94/137] arm_mpam: Add cpuhp callbacks to probe MSC hardware
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201262115.SStlJyqy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=33a96085f6c98eddf4ae74babf67cf03c979e2fb
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout 33a96085f6c98eddf4ae74babf67cf03c979e2fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/mpam/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/mpam/mpam_devices.c:299:5: warning: no previous prototype for 'mpam_ris_get_affinity' [-Wmissing-prototypes]
     299 | int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:332:5: warning: no previous prototype for 'mpam_ris_create_locked' [-Wmissing-prototypes]
     332 | int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/mpam/mpam_devices.c:660:6: warning: no previous prototype for 'mpam_enable_once' [-Wmissing-prototypes]
     660 | void mpam_enable_once(void)
         |      ^~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:700:5: warning: no previous prototype for 'mpam_msc_drv_remove' [-Wmissing-prototypes]
     700 | int mpam_msc_drv_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~


vim +/mpam_enable_once +660 drivers/platform/mpam/mpam_devices.c

   659	
 > 660	void mpam_enable_once(void)
   661	{
   662		mutex_lock(&mpam_cpuhp_state_lock);
   663		cpuhp_remove_state(mpam_cpuhp_state);
   664		mpam_cpuhp_state = 0;
   665		mutex_unlock(&mpam_cpuhp_state_lock);
   666	
   667		mpam_register_cpuhp_callbacks(mpam_cpu_online);
   668	
   669		pr_info("MPAM enabled\n");
   670	}
   671	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

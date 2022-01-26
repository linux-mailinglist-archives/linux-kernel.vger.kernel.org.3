Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1949CBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiAZOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:08:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:4254 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235353AbiAZOIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206100; x=1674742100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jWQT0Hr52MPEMkaY+ICcXVCIeDJzbpVLM5b8dODPcWg=;
  b=HVnYhCEhLkpepSQVBVkMG0v4EU/W1gwAo+8wm3T391RugA2C10Q6E28T
   gE30kPFVr3bNRqEyqZ7j1e6yE7OCq48VOYnaxoT/khnDErHTA/krTPKBq
   LS67uk67p8+qCz98WqSQQytJ+SfPEyeDYHEfno0oRT8hoarfuZZ9BBv1Y
   EFRaiWZjOKyimFmgJ/FsLIS0TJtl95rVAAXmd5r8h9nLmPhA9LNLSrBtn
   W/bDhGGbqczKaf1De+u79AlOFHTBQG7hyEHd1rbqcJcLeJJ5kAxkcHZ+c
   NRm87RaKe5SU4MmoG4mLWdmcIh7ZikfzHkJ1gspvxhKSH1LGD9OIetHbe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246500116"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246500116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="479891726"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jan 2022 06:07:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCixn-000LH7-Cp; Wed, 26 Jan 2022 14:07:55 +0000
Date:   Wed, 26 Jan 2022 22:07:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.16 103/137]
 drivers/platform/mpam/mpam_devices.c:1559:6: warning: no previous prototype
 for '__write_config'
Message-ID: <202201262225.apzl51l5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.16
head:   364c1c42b229912132e1615c2ce15be7154e2156
commit: b9325e10d6bf95422eae60f2a9797f7790ec2dfc [103/137] arm_mpam: Allow configuration to be applied and restored during cpu online
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201262225.apzl51l5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=b9325e10d6bf95422eae60f2a9797f7790ec2dfc
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.16
        git checkout b9325e10d6bf95422eae60f2a9797f7790ec2dfc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/platform/mpam/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/mpam/mpam_devices.c:392:5: warning: no previous prototype for 'mpam_ris_get_affinity' [-Wmissing-prototypes]
     392 | int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:425:5: warning: no previous prototype for 'mpam_ris_create_locked' [-Wmissing-prototypes]
     425 | int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:1409:6: warning: no previous prototype for 'mpam_enable_once' [-Wmissing-prototypes]
    1409 | void mpam_enable_once(void)
         |      ^~~~~~~~~~~~~~~~
   drivers/platform/mpam/mpam_devices.c:1535:5: warning: no previous prototype for 'mpam_msc_drv_remove' [-Wmissing-prototypes]
    1535 | int mpam_msc_drv_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/platform/mpam/mpam_devices.c:1559:6: warning: no previous prototype for '__write_config' [-Wmissing-prototypes]
    1559 | void __write_config(void *arg)
         |      ^~~~~~~~~~~~~~


vim +/__write_config +1559 drivers/platform/mpam/mpam_devices.c

  1558	
> 1559	void __write_config(void *arg)
  1560	{
  1561		struct mpam_write_config_arg *c = arg;
  1562	
  1563		mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
  1564	}
  1565	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

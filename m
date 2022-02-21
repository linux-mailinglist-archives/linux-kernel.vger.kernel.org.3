Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104E4BD54F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 06:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbiBUFRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:17:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiBUFRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:17:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A590B3A5EA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645420628; x=1676956628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QBxRq81C7ONLxFicA4U4nO1gGJGA1fiLHV4lwhK0ynU=;
  b=STixCErAq4u06ehljr73S2I2QyD0KddyWrB9d2pM0z6k4OwOmyp5iEtC
   7zI2mt6ZHMFt8ZLLUOwqR6/Seym1/dFKi36U7izuKcF4vNTjDPAKYXBvr
   H+iPXf0MUR1UeXeZbJfNWF//HILCT0huJeLVjPvW5s7wFLXzDm4FwlwEH
   bD8Vz+cclWYwON5RYPqh905MNJ81XU0q18RKOgAwEfCl4PcJEvag/ZuXR
   tfoXSyc9v4NN2spA9l8bkiOAol+E2KCU4rzqRSQzVrkIkoUMQazgKsixX
   cj5sM8F6GCtjh/Z2AsqFaQeqWBKYHAoahBEpL9JQ813DEIYI8TurWRgA/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="232059023"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="232059023"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 21:17:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="638430209"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2022 21:17:07 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM14M-0001LD-Gc; Mon, 21 Feb 2022 05:17:06 +0000
Date:   Mon, 21 Feb 2022 13:16:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/soc/apple/apple-pmgr-pwrstate.c:176:32: sparse: sparse:
 symbol 'apple_pmgr_reset_ops' was not declared. Should it be static?
Message-ID: <202202211309.mUqlMP6u-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2 soc: apple: Add driver for Apple PMGR power state controls
date:   3 months ago
config: arm64-randconfig-s032-20220220 (https://download.01.org/0day-ci/archive/20220221/202202211309.mUqlMP6u-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/soc/apple/apple-pmgr-pwrstate.c:176:32: sparse: sparse: symbol 'apple_pmgr_reset_ops' was not declared. Should it be static?

vim +/apple_pmgr_reset_ops +176 drivers/soc/apple/apple-pmgr-pwrstate.c

   167	
   168	static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned long id)
   169	{
   170		struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
   171		u32 reg = 0;
   172	
   173		regmap_read(ps->regmap, ps->offset, &reg);
   174	
   175		return !!(reg & APPLE_PMGR_RESET);
 > 176	}
   177	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

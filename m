Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ACF4EBCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiC3IsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244422AbiC3IsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:48:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462AD9D4D7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648629979; x=1680165979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9S3rPTNIv2WGwUkveRzKZbZiUovYAhHbssxF+2197lM=;
  b=Xp1rOJ0h0w/2fwLwIx4qV7eXn+ACpvFdHTx6GFEHJDYN+qVfZWH20NPm
   wPI96L58HygPdBEhk5Q7R4ykBya00ZpfvJt/Sty3I2Fslu/IjuyzoOmDY
   0DAMv8Y/IYDZfd50df1Pi9ACaxsP9RjN6UNzuRqBZ3b1WKyobXx6tMDxt
   07M2M5+YEwqFv+qNgeednzpVSGI7oFUuMPhiGvNlivJgcENCrV3bfF0vn
   ajKCr0D8zAvuTO0S95KZFZo9CvAcOalDcCDz3pQNSPesTJz3bdt6bSF2h
   9DdMA+1vyCN0X7gHhMK47Xb5CAY51RaCrCKsQfnIoZCuSWh0eF+MsDlhk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246985396"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="246985396"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="837108365"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2022 01:46:15 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZTy3-00009Y-0V; Wed, 30 Mar 2022 08:46:15 +0000
Date:   Wed, 30 Mar 2022 16:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shirish S <Shirish.S@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no previous prototype
 for 'disable_err_thresholding'
Message-ID: <202203301632.RmI9R5aU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shirish,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   965181d7ef7e1a863477536dc328c23a7ebc8a1d
commit: 30aa3d26edb0f3d7992757287eec0ca588a5c259 x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
date:   3 years, 2 months ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220330/202203301632.RmI9R5aU-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30aa3d26edb0f3d7992757287eec0ca588a5c259
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 30aa3d26edb0f3d7992757287eec0ca588a5c259
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/ drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no previous prototype for 'disable_err_thresholding' [-Wmissing-prototypes]
     552 | void disable_err_thresholding(struct cpuinfo_x86 *c)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/disable_err_thresholding +552 arch/x86/kernel/cpu/mce/amd.c

   547	
   548	/*
   549	 * Turn off MC4_MISC thresholding banks on all family 0x15 models since
   550	 * they're not supported there.
   551	 */
 > 552	void disable_err_thresholding(struct cpuinfo_x86 *c)
   553	{
   554		int i;
   555		u64 hwcr;
   556		bool need_toggle;
   557		u32 msrs[] = {
   558			0x00000413, /* MC4_MISC0 */
   559			0xc0000408, /* MC4_MISC1 */
   560		};
   561	
   562		if (c->x86 != 0x15)
   563			return;
   564	
   565		rdmsrl(MSR_K7_HWCR, hwcr);
   566	
   567		/* McStatusWrEn has to be set */
   568		need_toggle = !(hwcr & BIT(18));
   569	
   570		if (need_toggle)
   571			wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
   572	
   573		/* Clear CntP bit safely */
   574		for (i = 0; i < ARRAY_SIZE(msrs); i++)
   575			msr_clear_bit(msrs[i], 62);
   576	
   577		/* restore old settings */
   578		if (need_toggle)
   579			wrmsrl(MSR_K7_HWCR, hwcr);
   580	}
   581	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

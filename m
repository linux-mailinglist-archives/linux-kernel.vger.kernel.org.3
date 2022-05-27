Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB09536922
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355134AbiE0XKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiE0XKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:10:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613313324D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653693042; x=1685229042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WMf+Iq4X63beNCR5etERUReOBjsPOCYah3nJoU0S55I=;
  b=QRDcqKTFmk5NTmPCRGJKy5kfms/wU8laaHlw/0C+eX7dSvNUqaSEhMJL
   ilOiiOqSBn5qRWUL7oLwH1lRxdlSAglhOdRtOJiijzL/yR4LUCAMqD9CW
   VfDvhpYmCYfmWX6LgUR6ui/sBQs6u2odvGFGfmLEC/CSfCetpHSAe9/ll
   BvY5tzdEb5/4lDBJliZupoTcfJgDPxRzXdS7clv2MlYSx/BP7fQWrFxSD
   3elNgm5zbJR4B5sqgJMCMh9N6TAKY5utjtI8w1DbV37rl8KpKcS3ft3pe
   x/eFJYmmA/Lnl1iHQDcDBkiHKRflIDN00Y4HnbQU9LlFB93mwPad3nbdv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274603143"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274603143"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 16:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="705347285"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 16:10:40 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuj6N-0005DD-UT;
        Fri, 27 May 2022 23:10:39 +0000
Date:   Sat, 28 May 2022 07:09:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [kdave-btrfs-devel:misc-next 14/15] fs/btrfs/ioctl.c:4370: warning:
 expecting prototype for Try to acquire fs_info:(). Prototype was for
 btrfs_try_lock_balance() instead
Message-ID: <202205280749.Ch7bthGN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   2c4fedaae1820aadce7526d2b30bfb3ed37333c0
commit: 519a96e3fc2d886281991d3e030ee9f37ae761f0 [14/15] btrfs: introduce btrfs_try_lock_balance
config: ia64-buildonly-randconfig-r004-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280749.Ch7bthGN-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/519a96e3fc2d886281991d3e030ee9f37ae761f0
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout 519a96e3fc2d886281991d3e030ee9f37ae761f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:4370: warning: expecting prototype for Try to acquire fs_info:(). Prototype was for btrfs_try_lock_balance() instead

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
   Depends on HAS_IOMEM && DRM && OF
   Selected by
   - DRM_MSM && HAS_IOMEM && DRM && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST && COMMON_CLK && IOMMU_SUPPORT && (QCOM_OCMEM || QCOM_OCMEM && (QCOM_LLCC || QCOM_LLCC && (QCOM_COMMAND_DB || QCOM_COMMAND_DB


vim +4370 fs/btrfs/ioctl.c

  4357	
  4358	/**
  4359	 * Try to acquire fs_info::balance_mutex as well as set BTRFS_EXLCOP_BALANCE as
  4360	 * required.
  4361	 *
  4362	 * @fs_info:       the filesystem
  4363	 * @excl_acquired: ptr to boolean value which is set to false in case balance
  4364	 *                 is being resumed
  4365	 *
  4366	 * Return 0 on success in which case both fs_info::balance is acquired as well
  4367	 * as exclusive ops are blocked. In case of failure return an error code.
  4368	 */
  4369	static int btrfs_try_lock_balance(struct btrfs_fs_info *fs_info, bool *excl_acquired)
> 4370	{
  4371		int ret;
  4372	
  4373		/*
  4374		 * Exclusive operation is locked. Three possibilities:
  4375		 *   (1) some other op is running
  4376		 *   (2) balance is running
  4377		 *   (3) balance is paused -- special case (think resume)
  4378		 */
  4379		while (1) {
  4380			if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
  4381				*excl_acquired = true;
  4382				mutex_lock(&fs_info->balance_mutex);
  4383				return 0;
  4384			}
  4385	
  4386			mutex_lock(&fs_info->balance_mutex);
  4387			if (fs_info->balance_ctl) {
  4388				/* This is either (2) or (3) */
  4389				if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
  4390					/* This is (2) */
  4391					ret = -EINPROGRESS;
  4392					goto out_failure;
  4393	
  4394				} else {
  4395					mutex_unlock(&fs_info->balance_mutex);
  4396					/*
  4397					 * Lock released to allow other waiters to
  4398					 * continue, we'll reexamine the status again.
  4399					 */
  4400					mutex_lock(&fs_info->balance_mutex);
  4401	
  4402					if (fs_info->balance_ctl &&
  4403					    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
  4404						/* This is (3) */
  4405						*excl_acquired = false;
  4406						return 0;
  4407					}
  4408				}
  4409			} else {
  4410				/* This is (1) */
  4411				ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
  4412				goto out_failure;
  4413			}
  4414	
  4415			mutex_unlock(&fs_info->balance_mutex);
  4416		}
  4417	
  4418	out_failure:
  4419		mutex_unlock(&fs_info->balance_mutex);
  4420		*excl_acquired = false;
  4421		return ret;
  4422	}
  4423	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

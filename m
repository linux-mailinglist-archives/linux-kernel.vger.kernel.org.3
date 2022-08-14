Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C0591FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiHNMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHNMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:30:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD31CFD6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660480199; x=1692016199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+tc0O//ewjffkXM2kwutZHrS5qdyDIVb3PC7Ivm2r6c=;
  b=guNISI9nMcG8REk4P2JFAHYd8D1afDFpr7iJ3DKNXJXYX1lhv/uBZsKJ
   0yicwCyCjpQCX0ckbgYLQiPOuQqv8qCXaHUJEPjqGR1o5zgH0fY2b8DN+
   mIgzZaEEhFI85pRskYAC+rM5PuLB15gSGLMgtAk7Ls0jC7UvlvfOvQh63
   ZLp5wpUPioe+zdezjqhGwSEVVyz2P48QLEz5NW4clO1X8AUD53CAnq9U5
   vi1zU5I1foUJxuYisH0vVw/0SBkomRSoRFxUztvHYYqU7vQXkatHT2/az
   qoyQfi7zGOfohF6ivWjYji5+PNPRXR29wA9clsvN1Z9ioWIH60tPuqsEm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274876433"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274876433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 05:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="557003177"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2022 05:29:57 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNCke-00004p-22;
        Sun, 14 Aug 2022 12:29:56 +0000
Date:   Sun, 14 Aug 2022 20:29:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: fs/btrfs/ioctl.c:4370: warning: expecting prototype for Try to
 acquire fs_info:(). Prototype was for btrfs_try_lock_balance() instead
Message-ID: <202208142017.toR0Cz6v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: 7fb10ed89e95e26f5f81087a75f2a4bfa43b1705 btrfs: introduce btrfs_try_lock_balance
date:   3 weeks ago
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208142017.toR0Cz6v-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fb10ed89e95e26f5f81087a75f2a4bfa43b1705
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7fb10ed89e95e26f5f81087a75f2a4bfa43b1705
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:4370: warning: expecting prototype for Try to acquire fs_info:(). Prototype was for btrfs_try_lock_balance() instead


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

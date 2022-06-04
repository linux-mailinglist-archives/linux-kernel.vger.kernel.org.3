Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932F853D886
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiFDUsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiFDUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:47:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78026547
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654375674; x=1685911674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p1Hzk3F3uuqm5NfqizxDeJYiY2e+z6CPo2P14nYuS84=;
  b=bwc0oCc4C9WVAIrrTDFmqd95YjD6fTQ2Qj2zDZxSBCuL2qitciyzOL4H
   mTGxQ/Lx4roUH7x7eOy8H366KcIFJrz7uOINt+oEyQecQ8NWhks6smvqj
   HZd5Wu2TzufGfZ+yPrK47N1vgbO7XLHvKuFI28hMrouZdC4uyTTbFpSAD
   oDMkTrGg+0vtki2p9T+jG5cRBvHZ1ZBzBZTT3of6opJqO2vFJ1aToAH6Q
   e7t215zmNICHu5p3UyeNoPcUhpAFOaGk9tO7aiUseMX17n3NGFhEf+9HX
   6Tm8fRbjIfpqzw5LQzpHlTdFekeEGbo4VkMASuw7YuZ7L0paHqgCgnzYN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="276237814"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="276237814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 13:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="583048838"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2022 13:47:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxaga-000BCV-5S;
        Sat, 04 Jun 2022 20:47:52 +0000
Date:   Sun, 5 Jun 2022 04:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 59/401] fs/xfs/xfs_mount.c:1395:1:
 sparse: sparse: symbol 'xfs_drain_waiter_hook' was not declared. Should it
 be static?
Message-ID: <202206050410.XuV4Iw7k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 3af08f1b3aa1b9abb663bf030786a97d41f9081f [59/401] xfs: use per-cpu counters to implement intent draining
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220605/202206050410.XuV4Iw7k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=3af08f1b3aa1b9abb663bf030786a97d41f9081f
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 3af08f1b3aa1b9abb663bf030786a97d41f9081f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_mount.c:1395:1: sparse: sparse: symbol 'xfs_drain_waiter_hook' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

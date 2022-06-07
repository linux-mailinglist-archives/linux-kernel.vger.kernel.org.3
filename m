Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0643253F70C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiFGHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiFGHUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:20:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA4A30BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654586431; x=1686122431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7LqP5o8EeWLKi/H6Vk6YANUmWT12ilBLd3k0WVcpBkc=;
  b=ESmro0bUC+97moKZCQ8flQuMcRfrm6NxahScKhDW/EPdR8m8ieJCFqtz
   wIkm9eL50yVNTzrggc3OzN+L+lFs0vF6Vt/y4aCJdWbgqAaaSr+grBzDj
   GKG0t7/b4+N/vQSE4SBr7C1FsWH+txWvYt8oJuTnqLDp5mtA44Grka2p8
   yh1oqp+ghAml6/fSOvGdwTRO+11O0qwcaTAtDtPQ34eq51VShdI+OYxBR
   XzFCR9aKbAbpux2AdYb+XZwGX3pi8kNQo211LXhYAgI7J01taTZVJKnvH
   p38vJ2sOi4kcdzUc8xqs4Hgq8tFDx1CfcsKE1u/MJy+6T/zaF82RBYG4i
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337976749"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="337976749"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="532493944"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2022 00:19:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTVB-000DT9-TU;
        Tue, 07 Jun 2022 07:19:45 +0000
Date:   Tue, 7 Jun 2022 15:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 164/367] xfs_swapext.c:undefined
 reference to `__udivdi3'
Message-ID: <202206071526.U4CS4hli-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   879e09570c469d3320e25aa7f625ded1a2f5c24e
commit: ce8ec3f5e3c8baaf59687b1f077be69f86b60f75 [164/367] xfs: create deferred log items for extent swapping
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220607/202206071526.U4CS4hli-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=ce8ec3f5e3c8baaf59687b1f077be69f86b60f75
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout ce8ec3f5e3c8baaf59687b1f077be69f86b60f75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: fs/xfs/libxfs/xfs_swapext.o: in function `xfs_swapext_estimate_overhead':
>> xfs_swapext.c:(.text+0x119): undefined reference to `__udivdi3'
>> ld: xfs_swapext.c:(.text+0x190): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

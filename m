Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186953F70B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbiFGHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiFGHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:19:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950564D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654586388; x=1686122388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yu8t4z26qsJ8fD2huo7C0fLOmXT/T0TqYTOz2Lye/5w=;
  b=WlM+qMxk0GM0Zeh5EZEVwmwIp5nspQVbGT64YjDKMux9aXP8E8AZ6Usn
   IzWkIGr3ey1XZxnUP4HiVcpcTau3ufpFe7Zxuj7rRRkphrHtyB+TPsRDC
   7wtft8hsRtqirEdwUGNboq0bvd3AUWWVqGzFECXEog0X9iA/XvFbQFRV/
   TK10GlboT65JWukWw0CLrpoZD2y/BxxYT40ABKoprS/hn/gLtmejDiMKV
   ptl+u6/Jb+CfEuWVYjFwmWdNEZPo3dsriBFVz1rtiLvwl5jic+Cu8+C13
   /bZfRclOvIA1Go9WCJ/8W+RZ5Z29KDnVoqX1YD9EUqP2q38ctfnZ1nRGz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="256547362"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="256547362"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="826234951"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2022 00:19:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTVB-000DT7-Sp;
        Tue, 07 Jun 2022 07:19:45 +0000
Date:   Tue, 7 Jun 2022 15:19:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 115/367] fs/xfs/xfs_inode.c:956:1:
 warning: declaration does not declare anything
Message-ID: <202206071526.Y2P1K7gT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   879e09570c469d3320e25aa7f625ded1a2f5c24e
commit: 070c22c92d6f738172c822e7bf509633c37d3d31 [115/367] xfs: track file link count updates during live nlinks fsck
config: hexagon-buildonly-randconfig-r008-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071526.Y2P1K7gT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=070c22c92d6f738172c822e7bf509633c37d3d31
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 070c22c92d6f738172c822e7bf509633c37d3d31
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_inode.c:956:1: warning: declaration does not declare anything [-Wmissing-declarations]
   static XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   ^~~~~~
   1 warning generated.


vim +956 fs/xfs/xfs_inode.c

   954	
   955	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 956	static XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   957	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

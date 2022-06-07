Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72F53F6E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiFGHJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiFGHJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:09:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7CF813C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654585787; x=1686121787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wEITQjtai0jTLUc7WZmisdetOCGVs4EQWlbKG50Z63o=;
  b=Ndk02N+zzKOudtmVGiHBsb/PmJKDyQOzr7FJ3lG07UaCxCh3UlKf+5o7
   8r42yFQZPTDuvNVQjvwY3aNnqTT5r26tEwvUwHClkZFnHuBsQIDhFZHjW
   /KknaVxrKu8ZDApiB4OLXRRWfxgVSUr0d+EPEmAf891y1d4GZtxFAAhLS
   7fJD8zUBeCpq73djH+lvVxRG/khfAO8dPSxb1pJozOT8sDb9mg81kscGz
   CyC7yNIB+mr4sx6gftwNiD57xiZndN56VUowwLz/e15lc6MMLw1BFCgZQ
   V6dOGFunRemehtRIb3KkqpAemtIHKvi6CWuvNE5/SXu6tkzd3Qm0/t49A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275485465"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="275485465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="669850879"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2022 00:09:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTLV-000DSP-Fe;
        Tue, 07 Jun 2022 07:09:45 +0000
Date:   Tue, 7 Jun 2022 15:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 115/367] fs/xfs/xfs_inode.c:956:1:
 warning: useless storage class specifier in empty declaration
Message-ID: <202206071423.Ltbpv7E9-lkp@intel.com>
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
commit: 070c22c92d6f738172c822e7bf509633c37d3d31 [115/367] xfs: track file link count updates during live nlinks fsck
config: alpha-buildonly-randconfig-r010-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071423.Ltbpv7E9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=070c22c92d6f738172c822e7bf509633c37d3d31
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 070c22c92d6f738172c822e7bf509633c37d3d31
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_inode.c:956:1: warning: useless storage class specifier in empty declaration
     956 | static XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
         | ^~~~~~
>> fs/xfs/xfs_inode.c:956:1: warning: empty declaration


vim +956 fs/xfs/xfs_inode.c

   954	
   955	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 956	static XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   957	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

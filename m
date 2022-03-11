Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0B4D5C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbiCKHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiCKHNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:13:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6F74DF1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646982755; x=1678518755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FArHK96lOgBTp19FO7q4eMEsc13Qclytkv0jFOwy49M=;
  b=UMSrRgI3Pmque7me5LMI+9q0nfVoY18PrUDRDqY461kUmz4ia4CqrMBY
   6ybiC4xVOnlrml/tvRsNVEfS00lM2g+nMJB4c1pSnS2uKBWcMicFtcToh
   +4S06ek3ZPfZxlF3eK6R+LCYSY7fycU4uvItugyjRTgot/0JQNOfpRFno
   CVUd16sF8/g7M8PjD874606PBez5MByPuX3EC9TazQ+hHYHqrCSSbFsZ/
   MWyMEDHGDeXnodAOvNk0+tgN2fMD1A84Y5FIUIqQu22m99SaPi1u8bAre
   J819gMgnzibijaOayor3WlgaBEt+nbWLX5V09OWj16SHLfUDPqwwUn93l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318740823"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="318740823"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="579201420"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2022 23:12:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSZRx-00060w-Ca; Fri, 11 Mar 2022 07:12:33 +0000
Date:   Fri, 11 Mar 2022 15:11:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 95/346] fs/xfs/xfs_mount.h:78:43:
 error: expected identifier or '(' before 'void'
Message-ID: <202203111528.SKeFyJjX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   38ef7fcbbc5b33107155955dcd6ed6c92f4ceb91
commit: af5ea75e919d339b63fdbac6de44242559497a78 [95/346] xfs: track file link count updates during live nlinks fsck
config: csky-randconfig-r036-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111528.SKeFyJjX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=af5ea75e919d339b63fdbac6de44242559497a78
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout af5ea75e919d339b63fdbac6de44242559497a78
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/xfs/xfs_inode.c:14:
>> fs/xfs/xfs_mount.h:78:43: error: expected identifier or '(' before 'void'
      78 | # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
         |                                           ^~~~
   fs/xfs/xfs_inode.c:952:1: note: in expansion of macro 'XFS_HOOKS_SWITCH_DEFINE'
     952 | XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/xfs/xfs_mount.h:78:48: error: expected ')' before numeric constant
      78 | # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
         |                                                ^
   fs/xfs/xfs_inode.c:952:1: note: in expansion of macro 'XFS_HOOKS_SWITCH_DEFINE'
     952 | XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +78 fs/xfs/xfs_mount.h

f5548336fb5444 Darrick J. Wong 2022-01-06  64  
f5548336fb5444 Darrick J. Wong 2022-01-06  65  /*
f5548336fb5444 Darrick J. Wong 2022-01-06  66   * If hooks and jump labels are enabled, we use jump labels (aka patching of
f5548336fb5444 Darrick J. Wong 2022-01-06  67   * the code segment) to avoid the minute overhead of calling an empty notifier
f5548336fb5444 Darrick J. Wong 2022-01-06  68   * chain when we know there are no callers.  If hooks are enabled without jump
f5548336fb5444 Darrick J. Wong 2022-01-06  69   * labels, hardwire the predicate to true because calling an empty srcu
f5548336fb5444 Darrick J. Wong 2022-01-06  70   * notifier chain isn't so expensive.
f5548336fb5444 Darrick J. Wong 2022-01-06  71   */
f5548336fb5444 Darrick J. Wong 2022-01-06  72  #if defined(CONFIG_JUMP_LABEL) && defined(CONFIG_XFS_LIVE_HOOKS)
f5548336fb5444 Darrick J. Wong 2022-01-06  73  # define XFS_HOOKS_SWITCH_DEFINE(name)	DEFINE_STATIC_KEY_FALSE(name)
f5548336fb5444 Darrick J. Wong 2022-01-06  74  # define xfs_hooks_switch_on(name)	static_branch_inc(name)
f5548336fb5444 Darrick J. Wong 2022-01-06  75  # define xfs_hooks_switch_off(name)	static_branch_dec(name)
f5548336fb5444 Darrick J. Wong 2022-01-06  76  # define xfs_hooks_switched_on(name)	static_branch_unlikely(name)
f5548336fb5444 Darrick J. Wong 2022-01-06  77  #elif defined(CONFIG_XFS_LIVE_HOOKS)
f5548336fb5444 Darrick J. Wong 2022-01-06 @78  # define XFS_HOOKS_SWITCH_DEFINE(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  79  # define xfs_hooks_switch_on(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  80  # define xfs_hooks_switch_off(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  81  # define xfs_hooks_switched_on(name)	(true)
f5548336fb5444 Darrick J. Wong 2022-01-06  82  #else
f5548336fb5444 Darrick J. Wong 2022-01-06  83  # define XFS_HOOKS_SWITCH_DEFINE(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  84  # define xfs_hooks_switch_on(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  85  # define xfs_hooks_switch_off(name)	((void)0)
f5548336fb5444 Darrick J. Wong 2022-01-06  86  # define xfs_hooks_switched_on(name)	(false)
f5548336fb5444 Darrick J. Wong 2022-01-06  87  #endif /* JUMP_LABEL && XFS_LIVE_HOOKS */
f5548336fb5444 Darrick J. Wong 2022-01-06  88  

:::::: The code at line 78 was first introduced by commit
:::::: f5548336fb5444559e7759a30e560ecf7cdbc03d xfs: allow scrub to hook metadata updates in other writers

:::::: TO: Darrick J. Wong <djwong@kernel.org>
:::::: CC: Darrick J. Wong <djwong@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECD4D5E69
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbiCKJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiCKJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:28:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5EB7CB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646990864; x=1678526864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XK/3Vbkegr98tnNmM9a3loe1RZVP6tyIvUV7gAuPdk4=;
  b=iaygd3wQ/nTExO78Zz6b/NUevFiodNTNiBjo8psP78HWD72tP9sw6NSd
   LbHVOP+fxczWDVSBsCx8bxYSSy+sifEGO8fJwie5Rqz6xU6C/NJEvhAKD
   /VahvD936ZUm6PNNdVkCZCl6KndU10oqo+O9OCtinSR7kF+LXE7TxCmlq
   smDOwH35drg89FhqGdKvWzwwtGEgSR5niyE+MUlgEvT/0bscDpcjsYFYg
   4CObRH+FqM2WjQtct/HVzg/wax8eoUgGq85x4CJuuSBgR0BUK7xDbsExm
   712HSw/PSdIb4Pyjt08EYIfTiFf9GCWaPEiKqudiH3vlbBkk93W4CmpVt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254365159"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="254365159"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 01:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644877489"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2022 01:27:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSbYi-0006Aw-FG; Fri, 11 Mar 2022 09:27:40 +0000
Date:   Fri, 11 Mar 2022 17:26:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 95/346] fs/xfs/xfs_inode.c:952:1:
 error: expected identifier or '('
Message-ID: <202203111719.V8By8dfs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   38ef7fcbbc5b33107155955dcd6ed6c92f4ceb91
commit: af5ea75e919d339b63fdbac6de44242559497a78 [95/346] xfs: track file link count updates during live nlinks fsck
config: hexagon-randconfig-r025-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111719.V8By8dfs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=af5ea75e919d339b63fdbac6de44242559497a78
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout af5ea75e919d339b63fdbac6de44242559497a78
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_inode.c:952:1: error: expected identifier or '('
   XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   ^
   fs/xfs/xfs_mount.h:78:42: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                             ^
>> fs/xfs/xfs_inode.c:952:1: error: expected ')'
   fs/xfs/xfs_mount.h:78:42: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                             ^
   fs/xfs/xfs_inode.c:952:1: note: to match this '('
   fs/xfs/xfs_mount.h:78:41: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                            ^
>> fs/xfs/xfs_inode.c:952:1: error: expected ')'
   XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   ^
   fs/xfs/xfs_mount.h:78:47: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                                  ^
   fs/xfs/xfs_inode.c:952:1: note: to match this '('
   fs/xfs/xfs_mount.h:78:40: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                           ^
   3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP_GPMC
   Depends on MEMORY && OF_ADDRESS
   Selected by
   - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST && HAS_IOMEM


vim +952 fs/xfs/xfs_inode.c

   950	
   951	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 952	XFS_HOOKS_SWITCH_DEFINE(xfs_nlinks_hooks_switch);
   953	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F44D5FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbiCKKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbiCKKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:39:51 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F91B0C72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646995128; x=1678531128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ERoDqGPLZcDRwDdhAPlR9WKCdT1GPrd63rNG7I71OYY=;
  b=dyZg81u2DAMVzQWWAQuEExy6latdkQSGvIdUEX/euXWdMRTzT8LXV2sW
   FPV4X194+qSwvbJdxl0cHXu/rXRvvg8jnyLXcddXNlblNLmXG6GIWCGDU
   zHogBxo4aqAnsE96UjmUj0mbw4EmjVYf8ECVwn/7/51KjVsHWexqFB4t7
   mWnA0Ggs2k+SyUKrf5c/g/v3zR6XOdUHjDy66Wbbr3wxCn40aVt7MJUVH
   s48BpsTb+UWaR6Ivtkl63cMhM0TW85skOptVSQmILt7We2BVfBIk831UD
   P+n9DeD5p0Mtbz8Xlw1EY469xjW8O6liKB3W7F6mwoWQkUO7h//U9hwd9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316269639"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="316269639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644893929"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2022 02:38:46 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nScfV-0006G3-Bz; Fri, 11 Mar 2022 10:38:45 +0000
Date:   Fri, 11 Mar 2022 18:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 123/346]
 fs/xfs/libxfs/xfs_rmap.c:783:1: error: expected identifier or '('
Message-ID: <202203111813.2n44ZvrR-lkp@intel.com>
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
commit: e0be8b1f630bd6eda5845896af660c5cc1b43831 [123/346] xfs: hook live rmap operations during a repair operation
config: hexagon-randconfig-r025-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111813.2n44ZvrR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=e0be8b1f630bd6eda5845896af660c5cc1b43831
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout e0be8b1f630bd6eda5845896af660c5cc1b43831
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_rmap.c:783:1: error: expected identifier or '('
   XFS_HOOKS_SWITCH_DEFINE(xfs_rmap_hooks_switch);
   ^
   fs/xfs/xfs_mount.h:78:42: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                             ^
>> fs/xfs/libxfs/xfs_rmap.c:783:1: error: expected ')'
   fs/xfs/xfs_mount.h:78:42: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                             ^
   fs/xfs/libxfs/xfs_rmap.c:783:1: note: to match this '('
   fs/xfs/xfs_mount.h:78:41: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                            ^
>> fs/xfs/libxfs/xfs_rmap.c:783:1: error: expected ')'
   XFS_HOOKS_SWITCH_DEFINE(xfs_rmap_hooks_switch);
   ^
   fs/xfs/xfs_mount.h:78:47: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                                  ^
   fs/xfs/libxfs/xfs_rmap.c:783:1: note: to match this '('
   fs/xfs/xfs_mount.h:78:40: note: expanded from macro 'XFS_HOOKS_SWITCH_DEFINE'
   # define XFS_HOOKS_SWITCH_DEFINE(name)  ((void)0)
                                           ^
   3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OMAP_GPMC
   Depends on MEMORY && OF_ADDRESS
   Selected by
   - MTD_NAND_OMAP2 && MTD && MTD_RAW_NAND && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST && HAS_IOMEM


vim +783 fs/xfs/libxfs/xfs_rmap.c

   781	
   782	#ifdef CONFIG_XFS_LIVE_HOOKS
 > 783	XFS_HOOKS_SWITCH_DEFINE(xfs_rmap_hooks_switch);
   784	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

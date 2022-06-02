Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E253B1F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiFBDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFBDFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:05:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B92233E9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654139153; x=1685675153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l5gRczfoKuL7G9zBFQQ2SXtbNbxh9vF8M0U/nuU3QH4=;
  b=kFsoFf6L6+05DJ2n7HviMZ4LaMEa7lx+zHfvcbo4ZAgz8TZZOHlweQah
   2XKcamBLnEvD/x9Be1dcZdPxca6CjL4nqFrMxS3pI0Q8+CIeXALXQ1zqF
   DzUFuJXBAQABJepLxcstrTWm6ZiyWw70O6G5tCvy21nX8gBRF6YiUvkEC
   Z46dxczBnD0ViefZ6cNrx9Qh9zLNzAtfG4Z40BusV/WPdeIrOWKDVJTYo
   pc79spzvEyNpRwsveXnsjOzYhk5wsZf2zR1dUjpY7gFMX2Q6PlakMlSeK
   D+AnlOsV/gMFzP2r0ASJrv/iEKx/tUTM8NCzgU4qz1G+L2bZ3LllSNwq7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275877983"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275877983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 20:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="606607359"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2022 20:05:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwb9j-0004gM-7p;
        Thu, 02 Jun 2022 03:05:51 +0000
Date:   Thu, 2 Jun 2022 11:04:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 172/401]
 fs/xfs/libxfs/xfs_btree.c:140:9: error: call to undeclared function
 'xfs_daddr_to_xfo'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202206021050.LdxdyOWk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1fcd9cea011a657d62ee332d161966c1ec92ffd5
commit: 737a5536fdb7ee845a8a656e14ec1c4554be6dec [172/401] xfs: support in-memory btrees
config: hexagon-randconfig-r041-20220601 (https://download.01.org/0day-ci/archive/20220602/202206021050.LdxdyOWk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=737a5536fdb7ee845a8a656e14ec1c4554be6dec
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 737a5536fdb7ee845a8a656e14ec1c4554be6dec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_btree.c:140:9: error: call to undeclared function 'xfs_daddr_to_xfo'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   fsb = xfs_daddr_to_xfo(xfs_buf_daddr(bp));
                         ^
   fs/xfs/libxfs/xfs_btree.c:140:9: note: did you mean 'xfs_daddr_to_agno'?
   fs/xfs/xfs_mount.h:590:1: note: 'xfs_daddr_to_agno' declared here
   xfs_daddr_to_agno(struct xfs_mount *mp, xfs_daddr_t d)
   ^
   fs/xfs/libxfs/xfs_btree.c:210:11: error: call to undeclared function 'xfs_daddr_to_xfo'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   agbno = xfs_daddr_to_xfo(xfs_buf_daddr(bp));
                           ^
   2 errors generated.


vim +/xfs_daddr_to_xfo +140 fs/xfs/libxfs/xfs_btree.c

   103	
   104	/*
   105	 * Check a long btree block header.  Return the address of the failing check,
   106	 * or NULL if everything is ok.
   107	 */
   108	xfs_failaddr_t
   109	__xfs_btree_check_lblock(
   110		struct xfs_btree_cur	*cur,
   111		struct xfs_btree_block	*block,
   112		int			level,
   113		struct xfs_buf		*bp)
   114	{
   115		struct xfs_mount	*mp = cur->bc_mp;
   116		xfs_btnum_t		btnum = cur->bc_btnum;
   117		int			crc = xfs_has_crc(mp);
   118		xfs_failaddr_t		fa;
   119		xfs_fsblock_t		fsb = NULLFSBLOCK;
   120	
   121		if (crc) {
   122			if (!uuid_equal(&block->bb_u.l.bb_uuid, &mp->m_sb.sb_meta_uuid))
   123				return __this_address;
   124			if (block->bb_u.l.bb_blkno !=
   125			    cpu_to_be64(bp ? xfs_buf_daddr(bp) : XFS_BUF_DADDR_NULL))
   126				return __this_address;
   127			if (block->bb_u.l.bb_pad != cpu_to_be32(0))
   128				return __this_address;
   129		}
   130	
   131		if (be32_to_cpu(block->bb_magic) != xfs_btree_magic(crc, btnum))
   132			return __this_address;
   133		if (be16_to_cpu(block->bb_level) != level)
   134			return __this_address;
   135		if (be16_to_cpu(block->bb_numrecs) >
   136		    cur->bc_ops->get_maxrecs(cur, level))
   137			return __this_address;
   138	
   139		if ((cur->bc_flags & XFS_BTREE_IN_MEMORY) && bp)
 > 140			fsb = xfs_daddr_to_xfo(xfs_buf_daddr(bp));
   141		else if (bp)
   142			fsb = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
   143	
   144		fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
   145				be64_to_cpu(block->bb_u.l.bb_leftsib));
   146		if (!fa)
   147			fa = xfs_btree_check_lblock_siblings(mp, cur, level, fsb,
   148					be64_to_cpu(block->bb_u.l.bb_rightsib));
   149		return fa;
   150	}
   151	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

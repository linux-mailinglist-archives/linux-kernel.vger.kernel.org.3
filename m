Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270953B0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiFBBKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiFBBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:10:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683227F888
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654132233; x=1685668233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KrdIbRbmRLLRWI/cK2bpf4TRwJK5Nb/IfEswB6l/4P0=;
  b=FePX4JKj2T+ZsPO3l7eL2GIJNYjy/X0zwA7SWRgNyFElQYPlDjCDrA+v
   yIEq68mMz/0jvefOuxQTgjqq1m6pX+qQQFuLeJOYpe6GDePL2uDuEv0/j
   68N0KGDgaJuYpVmD9ffoIAdW30PluQRMm05SGzcBE34joAcHi/E0y0zZl
   3k+1WX/bTD1z5CAVZVlMRSvM2886Tua6AwYWfMZ8cnpRujKp4BVUSud4+
   qNRWPdQElHeLsrpzhzrMVoXwZ/Hn6aFYNcWoRJgchWoYkrsT58Kotspmz
   KQnYF1PLUGjM3SdAVG9GToriAk5JQHcpyqHW4cgvYujbn/6QxFMBUuCST
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275789785"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275789785"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 18:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="756724542"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 18:10:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwZM7-0004bg-Cu;
        Thu, 02 Jun 2022 01:10:31 +0000
Date:   Thu, 2 Jun 2022 09:09:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 172/401]
 fs/xfs/libxfs/xfs_btree.c:140:23: error: implicit declaration of function
 'xfs_daddr_to_xfo'; did you mean 'xfs_daddr_to_agno'?
Message-ID: <202206020920.2x0m0E4y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220602/202206020920.2x0m0E4y-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=737a5536fdb7ee845a8a656e14ec1c4554be6dec
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 737a5536fdb7ee845a8a656e14ec1c4554be6dec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_btree.c: In function '__xfs_btree_check_lblock':
>> fs/xfs/libxfs/xfs_btree.c:140:23: error: implicit declaration of function 'xfs_daddr_to_xfo'; did you mean 'xfs_daddr_to_agno'? [-Werror=implicit-function-declaration]
     140 |                 fsb = xfs_daddr_to_xfo(xfs_buf_daddr(bp));
         |                       ^~~~~~~~~~~~~~~~
         |                       xfs_daddr_to_agno
   cc1: some warnings being treated as errors


vim +140 fs/xfs/libxfs/xfs_btree.c

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

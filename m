Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E273509824
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385323AbiDUGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385049AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4915E15718
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523434; x=1682059434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8tWgVrG70LhrCzeC9sVCAwYoCUofkqWkWkOd3PY5Ui4=;
  b=ZU7kYmLDKXzHBlRr1xkYuJO8/0lHljc4+6TudlvF+LbfQ1TqsrEqIeMH
   chsIwrEpXP6Y2pDx5UVNzgeOF++IvadvpQeSkKiFptdWGLuaBp76FAPmo
   IQAVn+e/oBnQujPQVnzEE7Xd/6R4bXGagNnsBizpDh8yns8JZdvEErru1
   Pr8Zvx84VCpfOH4Pvy9jHzpw7JO0Qjj7PJGfgn3i0cDj01c9C1pVs3yik
   Ixae/sOR73usD4UywqvZ7WlTIUqZeYAZFQpBit4I5UdNrujmpM/qfhWBk
   MLpdHcG0P0p9Lw9uhsyH49Ei1Y8YkDAnijzvoIhW3LRnRHVJIEH32zVRb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246151684"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246151684"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="562448731"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-00080q-29;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: fs/xfs/xfs_reflink.c:992:12: warning: variable 'qdelta' set but not
 used
Message-ID: <202204210738.BXsozdsV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: f273387b048543f2b8b2d809cc65fca28e7788a1 xfs: refactor reflink functions to use xfs_trans_alloc_inode
date:   1 year, 2 months ago
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220421/202204210738.BXsozdsV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f273387b048543f2b8b2d809cc65fca28e7788a1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f273387b048543f2b8b2d809cc65fca28e7788a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/gvt/ drivers/mfd/ fs/xfs/ init/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/xfs_reflink.c:992:12: warning: variable 'qdelta' set but not used [-Wunused-but-set-variable]
           int64_t                 qdelta = 0;
                                   ^
   1 warning generated.


vim +/qdelta +992 fs/xfs/xfs_reflink.c

   977	
   978	/*
   979	 * Remap the given extent into the file.  The dmap blockcount will be set to
   980	 * the number of blocks that were actually remapped.
   981	 */
   982	STATIC int
   983	xfs_reflink_remap_extent(
   984		struct xfs_inode	*ip,
   985		struct xfs_bmbt_irec	*dmap,
   986		xfs_off_t		new_isize)
   987	{
   988		struct xfs_bmbt_irec	smap;
   989		struct xfs_mount	*mp = ip->i_mount;
   990		struct xfs_trans	*tp;
   991		xfs_off_t		newlen;
 > 992		int64_t			qdelta = 0;
   993		unsigned int		resblks;
   994		bool			smap_real;
   995		bool			dmap_written = xfs_bmap_is_written_extent(dmap);
   996		int			iext_delta = 0;
   997		int			nimaps;
   998		int			error;
   999	
  1000		/*
  1001		 * Start a rolling transaction to switch the mappings.
  1002		 *
  1003		 * Adding a written extent to the extent map can cause a bmbt split,
  1004		 * and removing a mapped extent from the extent can cause a bmbt split.
  1005		 * The two operations cannot both cause a split since they operate on
  1006		 * the same index in the bmap btree, so we only need a reservation for
  1007		 * one bmbt split if either thing is happening.  However, we haven't
  1008		 * locked the inode yet, so we reserve assuming this is the case.
  1009		 */
  1010		resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
  1011		error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, resblks, 0,
  1012				false, &tp);
  1013		if (error)
  1014			goto out;
  1015	
  1016		/*
  1017		 * Read what's currently mapped in the destination file into smap.
  1018		 * If smap isn't a hole, we will have to remove it before we can add
  1019		 * dmap to the destination file.
  1020		 */
  1021		nimaps = 1;
  1022		error = xfs_bmapi_read(ip, dmap->br_startoff, dmap->br_blockcount,
  1023				&smap, &nimaps, 0);
  1024		if (error)
  1025			goto out_cancel;
  1026		ASSERT(nimaps == 1 && smap.br_startoff == dmap->br_startoff);
  1027		smap_real = xfs_bmap_is_real_extent(&smap);
  1028	
  1029		/*
  1030		 * We can only remap as many blocks as the smaller of the two extent
  1031		 * maps, because we can only remap one extent at a time.
  1032		 */
  1033		dmap->br_blockcount = min(dmap->br_blockcount, smap.br_blockcount);
  1034		ASSERT(dmap->br_blockcount == smap.br_blockcount);
  1035	
  1036		trace_xfs_reflink_remap_extent_dest(ip, &smap);
  1037	
  1038		/*
  1039		 * Two extents mapped to the same physical block must not have
  1040		 * different states; that's filesystem corruption.  Move on to the next
  1041		 * extent if they're both holes or both the same physical extent.
  1042		 */
  1043		if (dmap->br_startblock == smap.br_startblock) {
  1044			if (dmap->br_state != smap.br_state)
  1045				error = -EFSCORRUPTED;
  1046			goto out_cancel;
  1047		}
  1048	
  1049		/* If both extents are unwritten, leave them alone. */
  1050		if (dmap->br_state == XFS_EXT_UNWRITTEN &&
  1051		    smap.br_state == XFS_EXT_UNWRITTEN)
  1052			goto out_cancel;
  1053	
  1054		/* No reflinking if the AG of the dest mapping is low on space. */
  1055		if (dmap_written) {
  1056			error = xfs_reflink_ag_has_free_space(mp,
  1057					XFS_FSB_TO_AGNO(mp, dmap->br_startblock));
  1058			if (error)
  1059				goto out_cancel;
  1060		}
  1061	
  1062		/*
  1063		 * Increase quota reservation if we think the quota block counter for
  1064		 * this file could increase.
  1065		 *
  1066		 * If we are mapping a written extent into the file, we need to have
  1067		 * enough quota block count reservation to handle the blocks in that
  1068		 * extent.  We log only the delta to the quota block counts, so if the
  1069		 * extent we're unmapping also has blocks allocated to it, we don't
  1070		 * need a quota reservation for the extent itself.
  1071		 *
  1072		 * Note that if we're replacing a delalloc reservation with a written
  1073		 * extent, we have to take the full quota reservation because removing
  1074		 * the delalloc reservation gives the block count back to the quota
  1075		 * count.  This is suboptimal, but the VFS flushed the dest range
  1076		 * before we started.  That should have removed all the delalloc
  1077		 * reservations, but we code defensively.
  1078		 */
  1079		if (!smap_real && dmap_written) {
  1080			error = xfs_trans_reserve_quota_nblks(tp, ip,
  1081					dmap->br_blockcount, 0, false);
  1082			if (error)
  1083				goto out_cancel;
  1084		}
  1085	
  1086		if (smap_real)
  1087			++iext_delta;
  1088	
  1089		if (dmap_written)
  1090			++iext_delta;
  1091	
  1092		error = xfs_iext_count_may_overflow(ip, XFS_DATA_FORK, iext_delta);
  1093		if (error)
  1094			goto out_cancel;
  1095	
  1096		if (smap_real) {
  1097			/*
  1098			 * If the extent we're unmapping is backed by storage (written
  1099			 * or not), unmap the extent and drop its refcount.
  1100			 */
  1101			xfs_bmap_unmap_extent(tp, ip, &smap);
  1102			xfs_refcount_decrease_extent(tp, &smap);
  1103			qdelta -= smap.br_blockcount;
  1104		} else if (smap.br_startblock == DELAYSTARTBLOCK) {
  1105			xfs_filblks_t	len = smap.br_blockcount;
  1106	
  1107			/*
  1108			 * If the extent we're unmapping is a delalloc reservation,
  1109			 * we can use the regular bunmapi function to release the
  1110			 * incore state.  Dropping the delalloc reservation takes care
  1111			 * of the quota reservation for us.
  1112			 */
  1113			error = __xfs_bunmapi(NULL, ip, smap.br_startoff, &len, 0, 1);
  1114			if (error)
  1115				goto out_cancel;
  1116			ASSERT(len == 0);
  1117		}
  1118	
  1119		/*
  1120		 * If the extent we're sharing is backed by written storage, increase
  1121		 * its refcount and map it into the file.
  1122		 */
  1123		if (dmap_written) {
  1124			xfs_refcount_increase_extent(tp, dmap);
  1125			xfs_bmap_map_extent(tp, ip, dmap);
  1126			qdelta += dmap->br_blockcount;
  1127		}
  1128	
  1129		xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, qdelta);
  1130	
  1131		/* Update dest isize if needed. */
  1132		newlen = XFS_FSB_TO_B(mp, dmap->br_startoff + dmap->br_blockcount);
  1133		newlen = min_t(xfs_off_t, newlen, new_isize);
  1134		if (newlen > i_size_read(VFS_I(ip))) {
  1135			trace_xfs_reflink_update_inode_size(ip, newlen);
  1136			i_size_write(VFS_I(ip), newlen);
  1137			ip->i_d.di_size = newlen;
  1138			xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
  1139		}
  1140	
  1141		/* Commit everything and unlock. */
  1142		error = xfs_trans_commit(tp);
  1143		goto out_unlock;
  1144	
  1145	out_cancel:
  1146		xfs_trans_cancel(tp);
  1147	out_unlock:
  1148		xfs_iunlock(ip, XFS_ILOCK_EXCL);
  1149	out:
  1150		if (error)
  1151			trace_xfs_reflink_remap_extent_error(ip, error, _RET_IP_);
  1152		return error;
  1153	}
  1154	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

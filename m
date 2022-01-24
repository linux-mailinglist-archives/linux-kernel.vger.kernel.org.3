Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F324979D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiAXHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:55:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:20692 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236059AbiAXHzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643010924; x=1674546924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=exsXbeIdiZkwjjbAw6vukZOVLHCbtD7fpz8QFY0UEzk=;
  b=k8p/+WsRdg6f/+DoREF0dPcoYrsJVxoXWLMVk/ztcWM6AlUH1P7TVjrT
   b/C61kVf/gxQyLYHmiwLPtQP9MtAE2WYzm4Hk8/dSbsg1g0gUt8c6gXj8
   KmXEklN9syzHzXZKw1ScMidNqQ7Sj6dGX8TILqcZ+er+mMZ5XPsWvXYlI
   B7AbjYpVmvHkz2h7n/Vwy5cNEkfgerfJ/S2MkUTijNGY9Azao6GVHA5dy
   PG/ntlLqAVx7eIkGrHk1fj328q73QUuAAGsYHOcCRifzSb+mO/TfsirrB
   JfxQSbqIFg9kT+WitqXW27rtavXiwLWDdHKye/TuzkGW0iQkK6QzPX3Lr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233348208"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233348208"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 23:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695329861"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Jan 2022 23:55:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBuC8-000Hvl-LF; Mon, 24 Jan 2022 07:55:20 +0000
Date:   Mon, 24 Jan 2022 15:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Tinguely <tinguely@sgi.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:delayed_attrs_v26_extended 17/30]
 fs/xfs/libxfs/xfs_attr.c:666:72: warning: bitwise comparison always
 evaluates to true
Message-ID: <202201241531.xVqSa0gQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v26_extended
head:   19459f5cfa422b0a6a9cd3898892e43ecb49f8f3
commit: 721a69ffe0e2561371de01822bef355354eee926 [17/30] xfs: add parent pointer support to attribute code
config: nds32-randconfig-r024-20220124 (https://download.01.org/0day-ci/archive/20220124/202201241531.xVqSa0gQ-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/721a69ffe0e2561371de01822bef355354eee926
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work delayed_attrs_v26_extended
        git checkout 721a69ffe0e2561371de01822bef355354eee926
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_attr.c: In function 'xfs_attr_set':
>> fs/xfs/libxfs/xfs_attr.c:666:72: warning: bitwise comparison always evaluates to true [-Wtautological-compare]
     666 |         rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
         |                                                                        ^~


vim +666 fs/xfs/libxfs/xfs_attr.c

   648	
   649	/*
   650	 * Note: If args->value is NULL the attribute will be removed, just like the
   651	 * Linux ->setattr API.
   652	 */
   653	int
   654	xfs_attr_set(
   655		struct xfs_da_args	*args)
   656	{
   657		struct xfs_inode	*dp = args->dp;
   658		struct xfs_mount	*mp = dp->i_mount;
   659		struct xfs_trans_res	tres;
   660		bool			rsvd;
   661		int			error, local;
   662		int			rmt_blks = 0;
   663		unsigned int		total;
   664		int			delayed = xfs_has_larp(mp);
   665	
 > 666		rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
   667	
   668		if (xfs_is_shutdown(dp->i_mount))
   669			return -EIO;
   670	
   671		error = xfs_qm_dqattach(dp);
   672		if (error)
   673			return error;
   674	
   675		args->geo = mp->m_attr_geo;
   676		args->whichfork = XFS_ATTR_FORK;
   677		args->hashval = xfs_da_hashname(args->name, args->namelen);
   678	
   679		/*
   680		 * We have no control over the attribute names that userspace passes us
   681		 * to remove, so we have to allow the name lookup prior to attribute
   682		 * removal to fail as well.
   683		 */
   684		args->op_flags = XFS_DA_OP_OKNOENT;
   685	
   686		if (args->value) {
   687			XFS_STATS_INC(mp, xs_attr_set);
   688	
   689			args->op_flags |= XFS_DA_OP_ADDNAME;
   690			args->total = xfs_attr_calc_size(args, &local);
   691	
   692			/*
   693			 * If the inode doesn't have an attribute fork, add one.
   694			 * (inode must not be locked when we call this routine)
   695			 */
   696			if (XFS_IFORK_Q(dp) == 0) {
   697				int sf_size = sizeof(struct xfs_attr_sf_hdr) +
   698					xfs_attr_sf_entsize_byname(args->namelen,
   699							args->valuelen);
   700	
   701				error = xfs_bmap_add_attrfork(dp, sf_size, rsvd);
   702				if (error)
   703					return error;
   704			}
   705	
   706			tres.tr_logres = M_RES(mp)->tr_attrsetm.tr_logres +
   707					 M_RES(mp)->tr_attrsetrt.tr_logres *
   708						args->total;
   709			tres.tr_logcount = XFS_ATTRSET_LOG_COUNT;
   710			tres.tr_logflags = XFS_TRANS_PERM_LOG_RES;
   711			total = args->total;
   712	
   713			if (!local)
   714				rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen);
   715		} else {
   716			XFS_STATS_INC(mp, xs_attr_remove);
   717	
   718			tres = M_RES(mp)->tr_attrrm;
   719			total = XFS_ATTRRM_SPACE_RES(mp);
   720			rmt_blks = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
   721		}
   722	
   723		if (delayed) {
   724			error = xfs_attr_use_log_assist(mp);
   725			if (error)
   726				return error;
   727		}
   728	
   729		/*
   730		 * Root fork attributes can use reserved data blocks for this
   731		 * operation if necessary
   732		 */
   733		error = xfs_trans_alloc_inode(dp, &tres, total, 0, rsvd, &args->trans);
   734		if (error)
   735			goto drop_incompat;
   736	
   737		if (args->value || xfs_inode_hasattr(dp)) {
   738			error = xfs_iext_count_may_overflow(dp, XFS_ATTR_FORK,
   739					XFS_IEXT_ATTR_MANIP_CNT(rmt_blks));
   740			if (error)
   741				goto out_trans_cancel;
   742		}
   743	
   744		error = xfs_attr_lookup(args);
   745		if (args->value) {
   746			if (error == -EEXIST && (args->attr_flags & XATTR_CREATE))
   747				goto out_trans_cancel;
   748			if (error == -ENOATTR && (args->attr_flags & XATTR_REPLACE))
   749				goto out_trans_cancel;
   750			if (error != -ENOATTR && error != -EEXIST)
   751				goto out_trans_cancel;
   752	
   753			error = xfs_attr_set_deferred(args);
   754			if (error)
   755				goto out_trans_cancel;
   756	
   757			/* shortform attribute has already been committed */
   758			if (!args->trans)
   759				goto out_unlock;
   760		} else {
   761			if (error != -EEXIST)
   762				goto out_trans_cancel;
   763	
   764			error = xfs_attr_remove_deferred(args);
   765			if (error)
   766				goto out_trans_cancel;
   767		}
   768	
   769		/*
   770		 * If this is a synchronous mount, make sure that the
   771		 * transaction goes to disk before returning to the user.
   772		 */
   773		if (xfs_has_wsync(mp))
   774			xfs_trans_set_sync(args->trans);
   775	
   776		if (!(args->op_flags & XFS_DA_OP_NOTIME))
   777			xfs_trans_ichgtime(args->trans, dp, XFS_ICHGTIME_CHG);
   778	
   779		/*
   780		 * Commit the last in the sequence of transactions.
   781		 */
   782		xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE);
   783		error = xfs_trans_commit(args->trans);
   784	out_unlock:
   785		xfs_iunlock(dp, XFS_ILOCK_EXCL);
   786	drop_incompat:
   787		if (delayed)
   788			xlog_drop_incompat_feat(mp->m_log);
   789		return error;
   790	
   791	out_trans_cancel:
   792		if (args->trans)
   793			xfs_trans_cancel(args->trans);
   794		goto out_unlock;
   795	}
   796	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27851CEFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388322AbiEFCaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387611AbiEFCaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:30:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8475914026
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651803979; x=1683339979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l9ZN2BHYwhvRwx3DfBJAQ+FR4ZEXUk/BfxCucQWDwJQ=;
  b=QHghVQr8/q3/UdTbXgg2Ms7KtdBJ91TIc0V80v2MHTgm4OsnE/sZur/M
   PJOGPt7JPMVemo0o/FwQlCIpdLRnyvvqBq6KzeqGIKJNvWk9sya7T9I0W
   0ogDXK++zTRPXg888eayfA5FApC9p4TMYGhYVXi37UIxx4QCVhmDeeZqz
   alNxLGAjXi/ToKZxjuEGO4wXAr5tmq7S4rzicjO8bwR8aw/hz5NkVMEuL
   kLhLAD4+gn9LF9vBDYD+PncynCTtYLO9TgYstGkHtXwnjP6ZNrwNx6CiO
   TbEGX3r+ffi8bygd66WYQBKzciM4N6esMXR50svlOUq4NmAJmrUeEDuCE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265914270"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265914270"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 19:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="891617598"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 19:26:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmnfd-000Czp-51;
        Fri, 06 May 2022 02:26:17 +0000
Date:   Fri, 6 May 2022 10:25:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Tinguely <tinguely@sgi.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:xfs-5.19-compose_pptrs 21/32]
 fs/xfs/libxfs/xfs_attr.c:816:72: warning: bitwise comparison always
 evaluates to true
Message-ID: <202205061021.aUxzs7xm-lkp@intel.com>
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

tree:   https://github.com/allisonhenderson/xfs_work.git xfs-5.19-compose_pptrs
head:   74ecccf0e89a132c2490f3a63661c535974c6a08
commit: a349b6b3c1b6c2c4bfb53996c7bbe69bf59acf00 [21/32] xfs: add parent pointer support to attribute code
config: arc-randconfig-r001-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061021.aUxzs7xm-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/a349b6b3c1b6c2c4bfb53996c7bbe69bf59acf00
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work xfs-5.19-compose_pptrs
        git checkout a349b6b3c1b6c2c4bfb53996c7bbe69bf59acf00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_attr.c: In function 'xfs_attr_set':
>> fs/xfs/libxfs/xfs_attr.c:816:72: warning: bitwise comparison always evaluates to true [-Wtautological-compare]
     816 |         rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
         |                                                                        ^~
   At top level:
   fs/xfs/libxfs/xfs_attr.c:1469:1: warning: 'xfs_attr_refillstate' defined but not used [-Wunused-function]
    1469 | xfs_attr_refillstate(xfs_da_state_t *state)
         | ^~~~~~~~~~~~~~~~~~~~


vim +816 fs/xfs/libxfs/xfs_attr.c

   798	
   799	/*
   800	 * Note: If args->value is NULL the attribute will be removed, just like the
   801	 * Linux ->setattr API.
   802	 */
   803	int
   804	xfs_attr_set(
   805		struct xfs_da_args	*args)
   806	{
   807		struct xfs_inode	*dp = args->dp;
   808		struct xfs_mount	*mp = dp->i_mount;
   809		struct xfs_trans_res	tres;
   810		bool			rsvd;
   811		int			error, local;
   812		int			rmt_blks = 0;
   813		unsigned int		total;
   814		int			delayed = xfs_has_larp(mp);
   815	
 > 816		rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
   817	
   818		if (xfs_is_shutdown(dp->i_mount))
   819			return -EIO;
   820	
   821		error = xfs_qm_dqattach(dp);
   822		if (error)
   823			return error;
   824	
   825		args->geo = mp->m_attr_geo;
   826		args->whichfork = XFS_ATTR_FORK;
   827		args->hashval = xfs_da_hashname(args->name, args->namelen);
   828	
   829		/*
   830		 * We have no control over the attribute names that userspace passes us
   831		 * to remove, so we have to allow the name lookup prior to attribute
   832		 * removal to fail as well.
   833		 */
   834		args->op_flags = XFS_DA_OP_OKNOENT;
   835	
   836		if (args->value) {
   837			XFS_STATS_INC(mp, xs_attr_set);
   838	
   839			args->op_flags |= XFS_DA_OP_ADDNAME;
   840			args->total = xfs_attr_calc_size(args, &local);
   841	
   842			/*
   843			 * If the inode doesn't have an attribute fork, add one.
   844			 * (inode must not be locked when we call this routine)
   845			 */
   846			if (XFS_IFORK_Q(dp) == 0) {
   847				int sf_size = sizeof(struct xfs_attr_sf_hdr) +
   848					xfs_attr_sf_entsize_byname(args->namelen,
   849							args->valuelen);
   850	
   851				error = xfs_bmap_add_attrfork(dp, sf_size, rsvd);
   852				if (error)
   853					return error;
   854			}
   855	
   856			if (!local)
   857				rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen);
   858		} else {
   859			XFS_STATS_INC(mp, xs_attr_remove);
   860			rmt_blks = xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
   861		}
   862	
   863		if (delayed) {
   864			error = xfs_attr_use_log_assist(mp);
   865			if (error)
   866				return error;
   867		}
   868	
   869		/*
   870		 * Root fork attributes can use reserved data blocks for this
   871		 * operation if necessary
   872		 */
   873		xfs_init_attr_trans(args, &tres, &total);
   874		error = xfs_trans_alloc_inode(dp, &tres, total, 0, rsvd, &args->trans);
   875		if (error)
   876			goto drop_incompat;
   877	
   878		if (args->value || xfs_inode_hasattr(dp)) {
   879			error = xfs_iext_count_may_overflow(dp, XFS_ATTR_FORK,
   880					XFS_IEXT_ATTR_MANIP_CNT(rmt_blks));
   881			if (error == -EFBIG)
   882				error = xfs_iext_count_upgrade(args->trans, dp,
   883						XFS_IEXT_ATTR_MANIP_CNT(rmt_blks));
   884			if (error)
   885				goto out_trans_cancel;
   886		}
   887	
   888		error = xfs_attr_lookup(args);
   889		switch (error) {
   890		case -EEXIST:
   891			/* if no value, we are performing a remove operation */
   892			if (!args->value) {
   893				error = xfs_attr_defer_remove(args);
   894				break;
   895			}
   896			/* Pure create fails if the attr already exists */
   897			if (args->attr_flags & XATTR_CREATE)
   898				goto out_trans_cancel;
   899	
   900			error = xfs_attr_defer_replace(args);
   901			break;
   902		case -ENOATTR:
   903			/* Can't remove what isn't there. */
   904			if (!args->value)
   905				goto out_trans_cancel;
   906	
   907			/* Pure replace fails if no existing attr to replace. */
   908			if (args->attr_flags & XATTR_REPLACE)
   909				goto out_trans_cancel;
   910	
   911			error = xfs_attr_defer_add(args);
   912			break;
   913		default:
   914			goto out_trans_cancel;
   915		}
   916		if (error)
   917			goto out_trans_cancel;
   918	
   919		/*
   920		 * If this is a synchronous mount, make sure that the
   921		 * transaction goes to disk before returning to the user.
   922		 */
   923		if (xfs_has_wsync(mp))
   924			xfs_trans_set_sync(args->trans);
   925	
   926		if (!(args->op_flags & XFS_DA_OP_NOTIME))
   927			xfs_trans_ichgtime(args->trans, dp, XFS_ICHGTIME_CHG);
   928	
   929		/*
   930		 * Commit the last in the sequence of transactions.
   931		 */
   932		xfs_trans_log_inode(args->trans, dp, XFS_ILOG_CORE);
   933		error = xfs_trans_commit(args->trans);
   934	out_unlock:
   935		xfs_iunlock(dp, XFS_ILOCK_EXCL);
   936	drop_incompat:
   937		if (delayed)
   938			xlog_drop_incompat_feat(mp->m_log);
   939		return error;
   940	
   941	out_trans_cancel:
   942		if (args->trans)
   943			xfs_trans_cancel(args->trans);
   944		goto out_unlock;
   945	}
   946	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

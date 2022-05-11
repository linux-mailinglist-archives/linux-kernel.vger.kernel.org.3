Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF85232D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiEKMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiEKMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:17:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC251325
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652271466; x=1683807466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wq5AgkD3c2Ft7Ghx/FLA5zagMyM7Ruibcw3V4PH7YoM=;
  b=EP4PJN9ScOllI4Mn/2IKdHK5G/dBddeF+/fStrl3c/3jRnYvy3rpos3G
   Z7nvKTfdn7gcdX/k0819FeZhnaioxyaM/uZZk2fX9yL85dclbSYXVqoj9
   mSsM6nxjEt2KEAAONWtb5ZD3g7CJim2sUur58ZJc1f2UpGmqcbqlHhxh6
   WiFkiWdkKh6HyXn4DH1dFydq+SFlMEw5mrh2XLM+vehDLg3DriSfHezvn
   ivBhgkC+LipE5AOEWsdQVR6JHdHxhYaYJDt0aN12qrDQAvYimd/pYFmuu
   a7n8tDTJFlmpsd+wpJdJQk3yGz7zJZxECZWrj8idblNR8TWduCTAxIN/r
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250209660"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="250209660"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 05:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="520494741"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2022 05:17:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nolHj-000J5O-WA;
        Wed, 11 May 2022 12:17:44 +0000
Date:   Wed, 11 May 2022 20:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:larp_cleanupv4_pptrs 28/35]
 fs/xfs/libxfs/xfs_attr.c:709:18: warning: unused variable 'forkoff'
Message-ID: <202205112055.mIusyY2I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git larp_cleanupv4_pptrs
head:   3d7771d8177638d5d115404cbee0b9a77cf0bb4c
commit: d8a025407f7fa54df7d250ae011fdd0d9223efa4 [28/35] xfs: parent pointer attribute creation
config: x86_64-randconfig-a003-20220509 (https://download.01.org/0day-ci/archive/20220511/202205112055.mIusyY2I-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/d8a025407f7fa54df7d250ae011fdd0d9223efa4
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work larp_cleanupv4_pptrs
        git checkout d8a025407f7fa54df7d250ae011fdd0d9223efa4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_attr.c:709:18: warning: unused variable 'forkoff' [-Wunused-variable]
           int                             sf_size, forkoff, error = 0;
                                                    ^
>> fs/xfs/libxfs/xfs_attr.c:708:20: warning: unused variable 'bp' [-Wunused-variable]
           struct xfs_buf                  *bp = NULL;
                                            ^
>> fs/xfs/libxfs/xfs_attr.c:707:21: warning: unused variable 'dp' [-Wunused-variable]
           struct xfs_inode                *dp = args->dp;
                                            ^
>> fs/xfs/libxfs/xfs_attr.c:710:21: warning: unused variable 'mp' [-Wunused-variable]
           struct xfs_mount                *mp = args->dp->i_mount;
                                            ^
   fs/xfs/libxfs/xfs_attr.c:723:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           case XFS_DAS_SF_ADD:
           ^
   fs/xfs/libxfs/xfs_attr.c:723:2: note: insert '__attribute__((fallthrough));' to silence this warning
           case XFS_DAS_SF_ADD:
           ^
           __attribute__((fallthrough)); 
   fs/xfs/libxfs/xfs_attr.c:723:2: note: insert 'break;' to avoid fall-through
           case XFS_DAS_SF_ADD:
           ^
           break; 
   5 warnings generated.


vim +/forkoff +709 fs/xfs/libxfs/xfs_attr.c

   693	
   694	/*
   695	 * Run the attribute operation specified in @attr.
   696	 *
   697	 * This routine is meant to function as a delayed operation and will set the
   698	 * state to XFS_DAS_DONE when the operation is complete.  Calling functions will
   699	 * need to handle this, and recall the function until either an error or
   700	 * XFS_DAS_DONE is detected.
   701	 */
   702	int
   703	xfs_attr_set_iter(
   704		struct xfs_attr_item		*attr)
   705	{
   706		struct xfs_da_args              *args = attr->xattri_da_args;
 > 707		struct xfs_inode		*dp = args->dp;
 > 708		struct xfs_buf			*bp = NULL;
 > 709		int				sf_size, forkoff, error = 0;
 > 710		struct xfs_mount		*mp = args->dp->i_mount;
   711	
   712	
   713		/* State machine switch */
   714	next_state:
   715		switch (attr->xattri_dela_state) {
   716		case XFS_DAS_UNINIT:
   717			sf_size = sizeof(struct xfs_attr_sf_hdr) +
   718				  xfs_attr_sf_entsize_byname(args->namelen,
   719								     args->valuelen);
   720			xfs_bmap_set_attrforkoff(args->dp, sf_size, NULL);
   721			args->dp->i_afp = kmem_cache_zalloc(xfs_ifork_cache, 0);
   722			args->dp->i_afp->if_format = XFS_DINODE_FMT_EXTENTS;
   723		case XFS_DAS_SF_ADD:
   724			return xfs_attr_sf_addname(attr);
   725		case XFS_DAS_LEAF_ADD:
   726			return xfs_attr_leaf_addname(attr);
   727		case XFS_DAS_NODE_ADD:
   728			return xfs_attr_node_addname(attr);
   729	
   730		case XFS_DAS_SF_REMOVE:
   731			error = xfs_attr_sf_removename(args);
   732			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   733							xfs_attr_init_add_state(args));
   734			break;
   735		case XFS_DAS_LEAF_REMOVE:
   736			error = xfs_attr_leaf_removename(args);
   737			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   738							xfs_attr_init_add_state(args));
   739			break;
   740		case XFS_DAS_NODE_REMOVE:
   741			error = xfs_attr_node_removename_setup(attr);
   742			if (error == -ENOATTR &&
   743			    (args->op_flags & XFS_DA_OP_RECOVERY)) {
   744				attr->xattri_dela_state = xfs_attr_complete_op(attr,
   745							xfs_attr_init_add_state(args));
   746				error = 0;
   747				break;
   748			}
   749			if (error)
   750				return error;
   751			attr->xattri_dela_state = XFS_DAS_NODE_REMOVE_RMT;
   752			if (args->rmtblkno == 0)
   753				attr->xattri_dela_state++;
   754			break;
   755	
   756		case XFS_DAS_LEAF_SET_RMT:
   757		case XFS_DAS_NODE_SET_RMT:
   758			error = xfs_attr_rmtval_find_space(attr);
   759			if (error)
   760				return error;
   761			attr->xattri_dela_state++;
   762			fallthrough;
   763	
   764		case XFS_DAS_LEAF_ALLOC_RMT:
   765		case XFS_DAS_NODE_ALLOC_RMT:
   766			error = xfs_attr_rmtval_alloc(attr);
   767			if (error)
   768				return error;
   769			if (attr->xattri_dela_state == XFS_DAS_DONE)
   770				break;
   771			goto next_state;
   772	
   773		case XFS_DAS_LEAF_REPLACE:
   774		case XFS_DAS_NODE_REPLACE:
   775			/*
   776			 * We must "flip" the incomplete flags on the "new" and "old"
   777			 * attribute/value pairs so that one disappears and one appears
   778			 * atomically.
   779			 */
   780			error = xfs_attr3_leaf_flipflags(args);
   781			if (error)
   782				return error;
   783			/*
   784			 * We must commit the flag value change now to make it atomic
   785			 * and then we can start the next trans in series at REMOVE_OLD.
   786			 */
   787			attr->xattri_dela_state++;
   788			break;
   789	
   790		case XFS_DAS_LEAF_REMOVE_OLD:
   791		case XFS_DAS_NODE_REMOVE_OLD:
   792			/*
   793			 * If we have a remote attr, start the process of removing it
   794			 * by invalidating any cached buffers.
   795			 *
   796			 * If we don't have a remote attr, we skip the remote block
   797			 * removal state altogether with a second state increment.
   798			 */
   799			xfs_attr_restore_rmt_blk(args);
   800			if (args->rmtblkno) {
   801				error = xfs_attr_rmtval_invalidate(args);
   802				if (error)
   803					return error;
   804			} else {
   805				attr->xattri_dela_state++;
   806			}
   807	
   808			attr->xattri_dela_state++;
   809			goto next_state;
   810	
   811		case XFS_DAS_LEAF_REMOVE_RMT:
   812		case XFS_DAS_NODE_REMOVE_RMT:
   813			error = xfs_attr_rmtval_remove(attr);
   814			if (error == -EAGAIN) {
   815				error = 0;
   816				break;
   817			}
   818			if (error)
   819				return error;
   820	
   821			/*
   822			 * We've finished removing the remote attr blocks, so commit the
   823			 * transaction and move on to removing the attr name from the
   824			 * leaf/node block. Removing the attr might require a full
   825			 * transaction reservation for btree block freeing, so we
   826			 * can't do that in the same transaction where we removed the
   827			 * remote attr blocks.
   828			 */
   829			attr->xattri_dela_state++;
   830			break;
   831	
   832		case XFS_DAS_LEAF_REMOVE_ATTR:
   833			error = xfs_attr_leaf_remove_attr(attr);
   834			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   835							xfs_attr_init_add_state(args));
   836			break;
   837	
   838		case XFS_DAS_NODE_REMOVE_ATTR:
   839			error = xfs_attr_node_remove_attr(attr);
   840			if (!error)
   841				error = xfs_attr_leaf_shrink(args);
   842			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   843							xfs_attr_init_add_state(args));
   844			break;
   845		default:
   846			ASSERT(0);
   847			break;
   848		}
   849	
   850		trace_xfs_attr_set_iter_return(attr->xattri_dela_state, args->dp);
   851		return error;
   852	}
   853	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

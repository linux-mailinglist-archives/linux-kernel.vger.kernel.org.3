Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2735351CF52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388484AbiEFDVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiEFDVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:21:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565524976
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651807055; x=1683343055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kdeCz0yd4ZI6vM/JdgropWQDsZKYrG1FI8NeGzafxBs=;
  b=QfcLyx7vrHKBf6yiowjx/r8m6O0QDj0NvMFNZpHlejj6nSk3X278AuwG
   0/G1Obk0DWSICfKo2CB51VeLQr0ly1OLjxGYZaHO8v7itZYwmNNu4BGJy
   KuVbocfFWptRR9FJ6yDlvzYXweqOvBb+uixGPVtsUHniEBbF7K/sKhrZ0
   tUpwJsVLQBy/czCummafQruhZNjwgaSq7rZbg5UuygI1mYI7TkrQOEZYP
   IYihdgOc3LMC0SOWSINEysGrDoar7QX/nPoSe9C1Ya62gDAdrgICDRtGA
   iBMELwKIb521C0EvZ1E1DDc6PH5nLQtRpKH79Kevv+a5uuETFyDhuCRnx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248868559"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248868559"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709256079"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 20:17:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmoSa-000D21-Vk;
        Fri, 06 May 2022 03:16:52 +0000
Date:   Fri, 6 May 2022 11:16:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [allisonhenderson-xfs-work:xfs-5.19-compose_pptrs 25/32]
 fs/xfs/libxfs/xfs_attr.c:571:44: warning: this statement may fall through
Message-ID: <202205061123.lsXtfPqy-lkp@intel.com>
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

tree:   https://github.com/allisonhenderson/xfs_work.git xfs-5.19-compose_pptrs
head:   74ecccf0e89a132c2490f3a63661c535974c6a08
commit: 7a5d447970de2d3b003b9015e2bce3bf0d15e3db [25/32] xfs: parent pointer attribute creation
config: arc-randconfig-r001-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061123.lsXtfPqy-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/allisonhenderson/xfs_work/commit/7a5d447970de2d3b003b9015e2bce3bf0d15e3db
        git remote add allisonhenderson-xfs-work https://github.com/allisonhenderson/xfs_work.git
        git fetch --no-tags allisonhenderson-xfs-work xfs-5.19-compose_pptrs
        git checkout 7a5d447970de2d3b003b9015e2bce3bf0d15e3db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_attr.c: In function 'xfs_attr_set_iter':
   fs/xfs/libxfs/xfs_attr.c:559:42: warning: unused variable 'mp' [-Wunused-variable]
     559 |         struct xfs_mount                *mp = args->dp->i_mount;
         |                                          ^~
   fs/xfs/libxfs/xfs_attr.c:558:50: warning: unused variable 'forkoff' [-Wunused-variable]
     558 |         int                             sf_size, forkoff, error = 0;
         |                                                  ^~~~~~~
   fs/xfs/libxfs/xfs_attr.c:557:42: warning: unused variable 'bp' [-Wunused-variable]
     557 |         struct xfs_buf                  *bp = NULL;
         |                                          ^~
   fs/xfs/libxfs/xfs_attr.c:556:42: warning: unused variable 'dp' [-Wunused-variable]
     556 |         struct xfs_inode                *dp = args->dp;
         |                                          ^~
   fs/xfs/libxfs/xfs_attr.c: In function 'xfs_attr_set':
   fs/xfs/libxfs/xfs_attr.c:824:72: warning: bitwise comparison always evaluates to true [-Wtautological-compare]
     824 |         rsvd = ((args->attr_filter & XFS_ATTR_ROOT) | XFS_ATTR_PARENT) != 0;
         |                                                                        ^~
   fs/xfs/libxfs/xfs_attr.c: In function 'xfs_attr_set_iter':
>> fs/xfs/libxfs/xfs_attr.c:571:44: warning: this statement may fall through [-Wimplicit-fallthrough=]
     571 |                 args->dp->i_afp->if_format = XFS_DINODE_FMT_EXTENTS;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_attr.c:572:9: note: here
     572 |         case XFS_DAS_SF_ADD:
         |         ^~~~
   At top level:
   fs/xfs/libxfs/xfs_attr.c:1477:1: warning: 'xfs_attr_refillstate' defined but not used [-Wunused-function]
    1477 | xfs_attr_refillstate(xfs_da_state_t *state)
         | ^~~~~~~~~~~~~~~~~~~~
--
>> fs/xfs/libxfs/xfs_parent.c:55:1: warning: no previous prototype for 'xfs_init_parent_name_rec' [-Wmissing-prototypes]
      55 | xfs_init_parent_name_rec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs/xfs/libxfs/xfs_parent.c:70:1: warning: no previous prototype for 'xfs_init_parent_name_irec' [-Wmissing-prototypes]
      70 | xfs_init_parent_name_irec(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +571 fs/xfs/libxfs/xfs_attr.c

   542	
   543	/*
   544	 * Run the attribute operation specified in @attr.
   545	 *
   546	 * This routine is meant to function as a delayed operation and will set the
   547	 * state to XFS_DAS_DONE when the operation is complete.  Calling functions will
   548	 * need to handle this, and recall the function until either an error or
   549	 * XFS_DAS_DONE is detected.
   550	 */
   551	int
   552	xfs_attr_set_iter(
   553		struct xfs_attr_item		*attr)
   554	{
   555		struct xfs_da_args              *args = attr->xattri_da_args;
   556		struct xfs_inode		*dp = args->dp;
   557		struct xfs_buf			*bp = NULL;
   558		int				sf_size, forkoff, error = 0;
   559		struct xfs_mount		*mp = args->dp->i_mount;
   560	
   561	
   562		/* State machine switch */
   563	next_state:
   564		switch (attr->xattri_dela_state) {
   565		case XFS_DAS_UNINIT:
   566			sf_size = sizeof(struct xfs_attr_sf_hdr) +
   567				  xfs_attr_sf_entsize_byname(args->namelen,
   568								     args->valuelen);
   569			xfs_bmap_set_attrforkoff(args->dp, sf_size, NULL);
   570			args->dp->i_afp = kmem_cache_zalloc(xfs_ifork_cache, 0);
 > 571			args->dp->i_afp->if_format = XFS_DINODE_FMT_EXTENTS;
   572		case XFS_DAS_SF_ADD:
   573			return xfs_attr_sf_addname(attr);
   574		case XFS_DAS_LEAF_ADD:
   575			return xfs_attr_leaf_addname(attr);
   576		case XFS_DAS_NODE_ADD:
   577			return xfs_attr_node_addname(attr);
   578	
   579		case XFS_DAS_SF_REMOVE:
   580			error = xfs_attr_sf_removename(args);
   581			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   582							xfs_attr_init_add_state(args));
   583			break;
   584		case XFS_DAS_LEAF_REMOVE:
   585			error = xfs_attr_leaf_removename(args);
   586			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   587							xfs_attr_init_add_state(args));
   588			break;
   589		case XFS_DAS_NODE_REMOVE:
   590			error = xfs_attr_node_removename_setup(attr);
   591			if (error)
   592				return error;
   593			attr->xattri_dela_state = XFS_DAS_NODE_REMOVE_RMT;
   594			if (args->rmtblkno == 0)
   595				attr->xattri_dela_state++;
   596			break;
   597	
   598		case XFS_DAS_LEAF_SET_RMT:
   599		case XFS_DAS_NODE_SET_RMT:
   600			error = xfs_attr_rmtval_find_space(attr);
   601			if (error)
   602				return error;
   603			attr->xattri_dela_state++;
   604			fallthrough;
   605	
   606		case XFS_DAS_LEAF_ALLOC_RMT:
   607		case XFS_DAS_NODE_ALLOC_RMT:
   608			error = xfs_attr_rmtval_alloc(attr);
   609			if (error)
   610				return error;
   611			/*
   612			 * If there is still more to allocate we need to roll the
   613			 * transaction so we have a full transaction reservation for
   614			 * the next allocation.
   615			 */
   616			if (attr->xattri_blkcnt > 0)
   617				break;
   618			if (attr->xattri_dela_state == XFS_DAS_DONE)
   619				break;
   620	
   621			goto next_state;
   622	
   623		case XFS_DAS_LEAF_REPLACE:
   624		case XFS_DAS_NODE_REPLACE:
   625			/*
   626			 * We must "flip" the incomplete flags on the "new" and "old"
   627			 * attribute/value pairs so that one disappears and one appears
   628			 * atomically.
   629			 */
   630			error = xfs_attr3_leaf_flipflags(args);
   631			if (error)
   632				return error;
   633			/*
   634			 * We must commit the flag value change now to make it atomic
   635			 * and then we can start the next trans in series at REMOVE_OLD.
   636			 */
   637			attr->xattri_dela_state++;
   638			break;
   639	
   640		case XFS_DAS_LEAF_REMOVE_OLD:
   641		case XFS_DAS_NODE_REMOVE_OLD:
   642			/*
   643			 * If we have a remote attr, start the process of removing it
   644			 * by invalidating any cached buffers.
   645			 *
   646			 * If we don't have a remote attr, we skip the remote block
   647			 * removal state altogether with a second state increment.
   648			 */
   649			xfs_attr_restore_rmt_blk(args);
   650			if (args->rmtblkno) {
   651				error = xfs_attr_rmtval_invalidate(args);
   652				if (error)
   653					return error;
   654			} else {
   655				attr->xattri_dela_state++;
   656			}
   657	
   658			attr->xattri_dela_state++;
   659			goto next_state;
   660	
   661		case XFS_DAS_LEAF_REMOVE_RMT:
   662		case XFS_DAS_NODE_REMOVE_RMT:
   663			error = xfs_attr_rmtval_remove(attr);
   664			if (error == -EAGAIN) {
   665				error = 0;
   666				break;
   667			}
   668			if (error)
   669				return error;
   670	
   671			/*
   672			 * We've finished removing the remote attr blocks, so commit the
   673			 * transaction and move on to removing the attr name from the
   674			 * leaf/node block. Removing the attr might require a full
   675			 * transaction reservation for btree block freeing, so we
   676			 * can't do that in the same transaction where we removed the
   677			 * remote attr blocks.
   678			 */
   679			attr->xattri_dela_state++;
   680			break;
   681	
   682		case XFS_DAS_LEAF_REMOVE_ATTR:
   683			error = xfs_attr_leaf_remove_attr(attr);
   684			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   685							xfs_attr_init_add_state(args));
   686			break;
   687	
   688		case XFS_DAS_NODE_REMOVE_ATTR:
   689			error = xfs_attr_node_remove_attr(attr);
   690			attr->xattri_dela_state = xfs_attr_complete_op(attr,
   691							xfs_attr_init_add_state(args));
   692			break;
   693		default:
   694			ASSERT(0);
   695			break;
   696		}
   697	
   698		trace_xfs_attr_set_iter_return(attr->xattri_dela_state, args->dp);
   699		return error;
   700	}
   701	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

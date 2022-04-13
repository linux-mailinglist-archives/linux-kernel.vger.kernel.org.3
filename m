Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620194FEEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiDMFoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiDMFoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:44:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710E20BC7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649828515; x=1681364515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dyTlAqstLdDpCJPaC4ZlMY6qT+1gfBkUdgSrTNJiiPc=;
  b=SWjIyBBBjSwCg/ktsbaEGBEc/qMNf0rjkfN2O4ekMAtl+kgNXIyfyKPS
   SxOBl39zqvGjeavgD09amLVk55g7C+3T/AbGJTSDY+bwiCORpS+ddDRkA
   SXmkAR0yRbzR1SGs14j1P2WYJf8oK4H0ZnHbc1QyNVmP7cWctt1GQHYv1
   jtSVg+GEnWr7Dd4SUkNvA5K85KeAJzbicQSWlNgvEaMqtvt5Dm/ZbuFAt
   PynE+L12s0PRkehVIJUTJgv0PcuMZ1DkdKbXWt0wKC7hyajt391OGKNH4
   y1OgPVgNOcbjMwM2flkU/Hpi1pMY8ySEw2ewR1Mf3RhUU6Qjtpqob8znq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="243165001"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="243165001"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 22:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="645033004"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 22:41:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neVlJ-00003z-9U;
        Wed, 13 Apr 2022 05:41:53 +0000
Date:   Wed, 13 Apr 2022 13:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 38/396]
 fs/xfs/scrub/agheader_repair.c:585:9: error: implicit declaration of
 function 'xbitmap_walk'; did you mean 'xbitmap_set'?
Message-ID: <202204131305.VOrAxCN4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   bd756ef7af68274b79308166ee64949d288be861
commit: d8273f3634d00732c204ba1c112bf1b9efcc6e4d [38/396] xfs: make AGFL repair function avoid crosslinked blocks
config: arc-randconfig-r002-20220413 (https://download.01.org/0day-ci/archive/20220413/202204131305.VOrAxCN4-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=d8273f3634d00732c204ba1c112bf1b9efcc6e4d
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout d8273f3634d00732c204ba1c112bf1b9efcc6e4d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the djwong-xfs/vectorized-scrub HEAD bd756ef7af68274b79308166ee64949d288be861 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/xfs/scrub/agheader_repair.c: In function 'xrep_agfl_collect_blocks':
>> fs/xfs/scrub/agheader_repair.c:585:9: error: implicit declaration of function 'xbitmap_walk'; did you mean 'xbitmap_set'? [-Werror=implicit-function-declaration]
     585 |         xbitmap_walk(agfl_extents, xrep_agfl_check_extent, &ra);
         |         ^~~~~~~~~~~~
         |         xbitmap_set
   cc1: some warnings being treated as errors


vim +585 fs/xfs/scrub/agheader_repair.c

   525	
   526	/*
   527	 * Map out all the non-AGFL OWN_AG space in this AG so that we can deduce
   528	 * which blocks belong to the AGFL.
   529	 *
   530	 * Compute the set of old AGFL blocks by subtracting from the list of OWN_AG
   531	 * blocks the list of blocks owned by all other OWN_AG metadata (bnobt, cntbt,
   532	 * rmapbt).  These are the old AGFL blocks, so return that list and the number
   533	 * of blocks we're actually going to put back on the AGFL.
   534	 */
   535	STATIC int
   536	xrep_agfl_collect_blocks(
   537		struct xfs_scrub	*sc,
   538		struct xfs_buf		*agf_bp,
   539		struct xbitmap		*agfl_extents,
   540		xfs_agblock_t		*flcount)
   541	{
   542		struct xrep_agfl	ra;
   543		struct xfs_mount	*mp = sc->mp;
   544		struct xfs_btree_cur	*cur;
   545		int			error;
   546	
   547		ra.sc = sc;
   548		ra.freesp = agfl_extents;
   549		xbitmap_init(&ra.agmetablocks);
   550		xbitmap_init(&ra.crossed);
   551	
   552		/* Find all space used by the free space btrees & rmapbt. */
   553		cur = xfs_rmapbt_init_cursor(mp, sc->tp, agf_bp, sc->sa.pag);
   554		error = xfs_rmap_query_all(cur, xrep_agfl_walk_rmap, &ra);
   555		xfs_btree_del_cursor(cur, error);
   556		if (error)
   557			goto out_bmp;
   558	
   559		/* Find all blocks currently being used by the bnobt. */
   560		cur = xfs_allocbt_init_cursor(mp, sc->tp, agf_bp,
   561				sc->sa.pag, XFS_BTNUM_BNO);
   562		error = xbitmap_set_btblocks(&ra.agmetablocks, cur);
   563		xfs_btree_del_cursor(cur, error);
   564		if (error)
   565			goto out_bmp;
   566	
   567		/* Find all blocks currently being used by the cntbt. */
   568		cur = xfs_allocbt_init_cursor(mp, sc->tp, agf_bp,
   569				sc->sa.pag, XFS_BTNUM_CNT);
   570		error = xbitmap_set_btblocks(&ra.agmetablocks, cur);
   571		xfs_btree_del_cursor(cur, error);
   572		if (error)
   573			goto out_bmp;
   574	
   575		/*
   576		 * Drop the freesp meta blocks that are in use by btrees.
   577		 * The remaining blocks /should/ be AGFL blocks.
   578		 */
   579		error = xbitmap_disunion(agfl_extents, &ra.agmetablocks);
   580		if (error)
   581			goto out_bmp;
   582	
   583		/* Strike out the blocks that are cross-linked. */
   584		ra.rmap_cur = xfs_rmapbt_init_cursor(mp, sc->tp, agf_bp, sc->sa.pag);
 > 585		xbitmap_walk(agfl_extents, xrep_agfl_check_extent, &ra);
   586		xfs_btree_del_cursor(ra.rmap_cur, 0);
   587		error = xbitmap_disunion(agfl_extents, &ra.crossed);
   588		if (error)
   589			goto out_bmp;
   590	
   591		/*
   592		 * Calculate the new AGFL size.  If we found more blocks than fit in
   593		 * the AGFL we'll free them later.
   594		 */
   595		*flcount = min_t(uint64_t, xbitmap_hweight(agfl_extents),
   596				 xfs_agfl_size(mp));
   597	
   598	out_bmp:
   599		xbitmap_destroy(&ra.crossed);
   600		xbitmap_destroy(&ra.agmetablocks);
   601		return error;
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

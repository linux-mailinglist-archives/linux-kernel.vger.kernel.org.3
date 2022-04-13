Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6664FECC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiDMCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiDMCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:14:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E52180C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649815948; x=1681351948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pe87ft1aKaeKaE+04iJ1gZNdhhDhquRrnt/SIy8fEts=;
  b=Av0fk3m47GMHJ50kAg6ZSXBmuhHwNKNrpM3qWb/7YPYZJOZiKY2I/Xqe
   9uJd2aNZolmV0prCHHHGxWUGnlbpcyQ4FRS4Lq7JdqsZj7Fr5drzJjs2V
   vofdtYDuGsR+wY0U+/45eejk5cA+gaTutXEQrgH+uRfPOAy3WaxUX/GPd
   CpWCBoT7Sl+34rydAeb6CapzvpAWXEeT9CrQ45trTvr00ZCvH+maXmRC5
   1nvvlHVYmTsgGz6AUB/5PEzDSZAxJLIkbyne/r4o2y2XvYEImWpGxCEF/
   IEQFnwZmnNaII6y6K4I5JHceNOWmIu9y9K2zTTu/Gdfz9SAYFQcr/gvwV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="243136079"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="243136079"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 19:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="644983140"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 19:12:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neSUb-0003Mc-Se;
        Wed, 13 Apr 2022 02:12:25 +0000
Date:   Wed, 13 Apr 2022 10:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 99/396] fs/xfs/scrub/repair.c:181:1:
 warning: no previous prototype for function 'xrep_defer_finish'
Message-ID: <202204131051.6jCh5cCf-lkp@intel.com>
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
commit: 80bc1e058e807de278cc530a53694879e4f70cb3 [99/396] xfs: implement block reservation accounting for btrees we're staging
config: hexagon-buildonly-randconfig-r001-20220412 (https://download.01.org/0day-ci/archive/20220413/202204131051.6jCh5cCf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=80bc1e058e807de278cc530a53694879e4f70cb3
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 80bc1e058e807de278cc530a53694879e4f70cb3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/scrub/repair.c:181:1: warning: no previous prototype for function 'xrep_defer_finish' [-Wmissing-prototypes]
   xrep_defer_finish(
   ^
   fs/xfs/scrub/repair.c:180:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   1 warning generated.


vim +/xrep_defer_finish +181 fs/xfs/scrub/repair.c

   178	
   179	/* Finish all deferred work attached to the repair transaction. */
   180	int
 > 181	xrep_defer_finish(
   182		struct xfs_scrub	*sc)
   183	{
   184		int			error;
   185	
   186		/* Keep the AG header buffers locked so we can keep going. */
   187		if (sc->sa.agi_bp) {
   188			xfs_ialloc_log_agi(sc->tp, sc->sa.agi_bp, XFS_AGI_MAGICNUM);
   189			xfs_trans_bhold(sc->tp, sc->sa.agi_bp);
   190		}
   191	
   192		if (sc->sa.agf_bp) {
   193			xfs_alloc_log_agf(sc->tp, sc->sa.agf_bp, XFS_AGF_MAGICNUM);
   194			xfs_trans_bhold(sc->tp, sc->sa.agf_bp);
   195		}
   196	
   197		error = xfs_defer_finish(&sc->tp);
   198		if (error)
   199			return error;
   200	
   201		/*
   202		 * The buffer log item (and hence the blf type) can detach from
   203		 * the buffer across the transaction rolls, so ensure that the
   204		 * types are still set on the AG header buffers.  Release the hold
   205		 * that we set above because defer_finish won't do that for us.
   206		 */
   207		if (sc->sa.agi_bp) {
   208			xfs_trans_bhold_release(sc->tp, sc->sa.agi_bp);
   209			xfs_trans_buf_set_type(sc->tp, sc->sa.agi_bp, XFS_BLFT_AGI_BUF);
   210		}
   211		if (sc->sa.agf_bp) {
   212			xfs_trans_bhold_release(sc->tp, sc->sa.agf_bp);
   213			xfs_trans_buf_set_type(sc->tp, sc->sa.agf_bp, XFS_BLFT_AGF_BUF);
   214		}
   215		return 0;
   216	}
   217	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

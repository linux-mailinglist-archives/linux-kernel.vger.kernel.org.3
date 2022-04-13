Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827A24FEC48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiDMBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiDMBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:33:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49540E53
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649813486; x=1681349486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9cQKNkLmhbzSf2E+o2kCsu7pedhma5yOcSaN+DzWIPA=;
  b=gTPF7EZT2SEeGqoeM4G0yeKAyub0BavH3EmuR2rLT80NfZ0DnAaYr2vF
   wI2iJsMfO2y66iEt8K0AXG4iMX6C7t7CH6POrvS+4OYnUANUfS7lmCWqT
   LkLQxkKdb4ejRG9QgD6XHhVkFd+rcvLgeXqiKqrbLJbbwmRuXAkDOeczU
   FFgMUthWSqscF+xboPIN4sUXFGpsOyQCWG4mVvIdy+jWKipIOOUDay8o7
   QYw9GKK+OZzL8sl+P22jBGOBGMzT9dwqSVd0H4vvOvo206tzkXO/2ArPh
   0fKJAeEm8cg3E4pGL7nAplcVVrb5zgTyW5H4mcs/sBEmQjWXTjaPPGMSc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="348983127"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="348983127"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="590570181"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 18:31:24 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neRqt-0003Ju-Ly;
        Wed, 13 Apr 2022 01:31:23 +0000
Date:   Wed, 13 Apr 2022 09:31:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 99/396] fs/xfs/scrub/repair.c:181:1:
 warning: no previous prototype for 'xrep_defer_finish'
Message-ID: <202204130954.KyCjtAyn-lkp@intel.com>
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
config: s390-buildonly-randconfig-r001-20220411 (https://download.01.org/0day-ci/archive/20220413/202204130954.KyCjtAyn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=80bc1e058e807de278cc530a53694879e4f70cb3
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout 80bc1e058e807de278cc530a53694879e4f70cb3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/scrub/repair.c:181:1: warning: no previous prototype for 'xrep_defer_finish' [-Wmissing-prototypes]
     181 | xrep_defer_finish(
         | ^~~~~~~~~~~~~~~~~


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

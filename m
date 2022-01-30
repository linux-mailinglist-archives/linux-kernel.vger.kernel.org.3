Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77A24A3BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 00:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiA3Xn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 18:43:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:16418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357591AbiA3Xny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 18:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643586233; x=1675122233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gZYY5LuTVEz9xOHMxgiC8QQWbczJL1t03Bu7nJ+lJew=;
  b=b0Q67tSIO2XPxpIKJbv908/QeJp1KgyZJz/8JkGVv4owEMRJvwtgIcHb
   OvCr3Hj+cJJWG4mJtSCJE6YsmPciOhCCJyhBEpHoehNRf6LZ3Gnvk9C3p
   JkhNGmDaEHVDhpjCUoaUgh4yijXROiMJ4nWzGiaZ0MCbdhJqtlw6XKGc7
   JWpUjYLLpPE+RFcdjmOR7AV+qZe7y0hDp+SWgYeXrZ/RBvH2I01X6G89p
   sbgLe9VO0vydT5NMVXS+CVf+21YMqh2YmX1outkeYot+qd/iyv7AeB00N
   ydQ9SI6m7eP5xfxDMvQBLW/re+PajXB0HfVTjG1keGDiWk5MXI8z6Qkwd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247599213"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="247599213"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 15:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="481480038"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2022 15:39:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEJnY-000R7K-4e; Sun, 30 Jan 2022 23:39:56 +0000
Date:   Mon, 31 Jan 2022 07:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 29/346] fs/xfs/scrub/agheader.c:741:25:
 sparse: sparse: restricted gfp_t degrades to integer
Message-ID: <202201310744.lVDnY8qA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   81e1a6295557a8263b17d815d60dbcbcd09faa08
commit: ace0a2769c4dcecf591c6ee9dbaf7247ba999eb2 [29/346] xfs: don't track the AGFL buffer in the scrub AG context
config: sparc64-randconfig-s031-20220130 (https://download.01.org/0day-ci/archive/20220131/202201310744.lVDnY8qA-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=ace0a2769c4dcecf591c6ee9dbaf7247ba999eb2
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs vectorized-scrub
        git checkout ace0a2769c4dcecf591c6ee9dbaf7247ba999eb2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/xfs/scrub/agheader.c:741:25: sparse: sparse: restricted gfp_t degrades to integer
>> fs/xfs/scrub/agheader.c:741:34: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted gfp_t [usertype] flags @@     got unsigned int @@
   fs/xfs/scrub/agheader.c:741:34: sparse:     expected restricted gfp_t [usertype] flags
   fs/xfs/scrub/agheader.c:741:34: sparse:     got unsigned int
   fs/xfs/scrub/agheader.c:158:23: sparse: sparse: cast truncates bits from constant value (ffff3f8f becomes 3f8f)

vim +741 fs/xfs/scrub/agheader.c

   701	
   702	/* Scrub the AGFL. */
   703	int
   704	xchk_agfl(
   705		struct xfs_scrub	*sc)
   706	{
   707		struct xchk_agfl_info	sai = {
   708			.sc		= sc,
   709		};
   710		struct xfs_agf		*agf;
   711		xfs_agnumber_t		agno = sc->sm->sm_agno;
   712		unsigned int		i;
   713		int			error;
   714	
   715		/* Lock the AGF and AGI so that nobody can touch this AG. */
   716		error = xchk_ag_read_headers(sc, agno, &sc->sa);
   717		if (!xchk_process_error(sc, agno, XFS_AGFL_BLOCK(sc->mp), &error))
   718			return error;
   719		if (!sc->sa.agf_bp)
   720			return -EFSCORRUPTED;
   721	
   722		/* Try to read the AGFL, and verify its structure if we get it. */
   723		error = xfs_alloc_read_agfl(sc->mp, sc->tp, agno, &sai.agfl_bp);
   724		if (!xchk_process_error(sc, agno, XFS_AGFL_BLOCK(sc->mp), &error))
   725			return error;
   726		xchk_buffer_recheck(sc, sai.agfl_bp);
   727	
   728		xchk_agfl_xref(sc);
   729	
   730		if (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
   731			goto out;
   732	
   733		/* Allocate buffer to ensure uniqueness of AGFL entries. */
   734		agf = sc->sa.agf_bp->b_addr;
   735		sai.agflcount = be32_to_cpu(agf->agf_flcount);
   736		if (sai.agflcount > xfs_agfl_size(sc->mp)) {
   737			xchk_block_set_corrupt(sc, sc->sa.agf_bp);
   738			goto out;
   739		}
   740		sai.entries = kvcalloc(sai.agflcount, sizeof(xfs_agblock_t),
 > 741				GFP_NOFS | ___GFP_RETRY_MAYFAIL);
   742		if (!sai.entries) {
   743			error = -ENOMEM;
   744			goto out;
   745		}
   746	
   747		/* Check the blocks in the AGFL. */
   748		error = xfs_agfl_walk(sc->mp, sc->sa.agf_bp->b_addr, sai.agfl_bp,
   749				xchk_agfl_block, &sai);
   750		if (error == -ECANCELED) {
   751			error = 0;
   752			goto out_free;
   753		}
   754		if (error)
   755			goto out_free;
   756	
   757		if (sai.agflcount != sai.nr_entries) {
   758			xchk_block_set_corrupt(sc, sc->sa.agf_bp);
   759			goto out_free;
   760		}
   761	
   762		/* Sort entries, check for duplicates. */
   763		sort(sai.entries, sai.nr_entries, sizeof(sai.entries[0]),
   764				xchk_agblock_cmp, NULL);
   765		for (i = 1; i < sai.nr_entries; i++) {
   766			if (sai.entries[i] == sai.entries[i - 1]) {
   767				xchk_block_set_corrupt(sc, sc->sa.agf_bp);
   768				break;
   769			}
   770		}
   771	
   772	out_free:
   773		kmem_free(sai.entries);
   774	out:
   775		return error;
   776	}
   777	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

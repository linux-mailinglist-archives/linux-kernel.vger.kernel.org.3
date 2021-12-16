Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC8476B14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhLPHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:35:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:65459 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhLPHfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639640152; x=1671176152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=053M1Zgowlaw3eBaj8zIvJ7gfC32GHrxGx19w3ldZzM=;
  b=JXbZeSv6wUkDpDUP0nAZMM9cv7OzvF/1y5W7iKaVEqa6aGJ+RVjgzRfs
   yqAPs5bcWEYJJoIChsGTf2V4i93UviUkp586h96jtu3SX2r5dDMRhgkb8
   Lx80P8gdFNPxiXw4jpBJeWUeb9NLcX+cgIANgQzPZi7Slz+m5pM6RiI3g
   +BfKLm0BTRMwnpFSLWf15aBhHUMxvhzqx3EZsUBVX8JuHSh2D3tYCQlkU
   hTxYf1hU56JY+l74rAqHFmCJ3bfblLJTb2J4PK6Ej3PYhfI9tltsooLBl
   QNuV+l+lLTpqalcgU3m1JW/WKTZtjHqPgJS8X9Pv80kiI6NFxn91GgG78
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238164852"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="238164852"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 23:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="615050645"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2021 23:35:50 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxlIr-0002tq-HU; Thu, 16 Dec 2021 07:35:49 +0000
Date:   Thu, 16 Dec 2021 15:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 314/325]
 fs/xfs/scrub/xfbtree.h:33:9: error: unknown type name 'xfileoff_t'
Message-ID: <202112161500.kEyBafae-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: a34386e6ec11a8cbaa5e60450a53f2e77ecde76c [314/325] xfs: connect in-memory btrees to xfiles
config: m68k-randconfig-r006-20211214 (https://download.01.org/0day-ci/archive/20211216/202112161500.kEyBafae-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=a34386e6ec11a8cbaa5e60450a53f2e77ecde76c
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout a34386e6ec11a8cbaa5e60450a53f2e77ecde76c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/xfs/xfs_trace.c:45:
>> fs/xfs/scrub/xfbtree.h:33:9: error: unknown type name 'xfileoff_t'
      33 |         xfileoff_t                      xf_used;
         |         ^~~~~~~~~~


vim +/xfileoff_t +33 fs/xfs/scrub/xfbtree.h

    21	
    22	struct xfbtree {
    23		/* buffer cache target for this in-memory btree */
    24		struct xfs_buftarg		*target;
    25	
    26		/* Swappable memory file backing this btree. */
    27		struct xfile			*xfile;
    28	
    29		/* Bitmap of free space from pos to used */
    30		struct xbitmap			*freespace;
    31	
    32		/* Number of xfile blocks actually used by this xfbtree. */
  > 33		xfileoff_t			xf_used;
    34	
    35		/* Owner of this btree. */
    36		unsigned long long		owner;
    37	
    38		/* Minimum and maximum records per block. */
    39		unsigned int			maxrecs[2];
    40		unsigned int			minrecs[2];
    41	};
    42	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

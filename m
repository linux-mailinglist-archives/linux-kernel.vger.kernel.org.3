Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0893247718D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhLPMXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:23:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:30906 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhLPMXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639657381; x=1671193381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P6w5PzE/wKkHWUiFzuGoywg6zD0gv2/BkztHy9dzsX8=;
  b=oImsTsccssRGGP5pRuFm2ylcDzv4MQte1PjQXSYWzJrFnnsdnqBh/ara
   MoqmDUQoSeRSk8n/YqdmSIqHU7FwpUET4wTK6N3Vy0FjZ2lZC8gmVx/cE
   +P7ng/A1LmIjVaKkUKBCJeHS6dvylOE5bUsBcx3pNJ8ox01ax/eQ08i6L
   xVkrcbkdwKigRUKHuX+KGlDwAcneuLkCABPVdtN53N8LT4GVcdE3WKyxu
   P3/Iv8IhlyRrYciDc98rgLuEjXWI4x7hYwvqwSi8kJ9VIqnPA0x7qZabV
   Q3AR1Y61drRurq4CKAptt88HOI41gDS9HF+6pbXpw7e6/sAS8zmyilKxO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325755122"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="325755122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615130967"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 04:22:59 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxpmk-000372-7d; Thu, 16 Dec 2021 12:22:58 +0000
Date:   Thu, 16 Dec 2021 20:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 323/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for
 'xfs_symlink_write_target'
Message-ID: <202112162006.medrsrAU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: 90d15e3e9dcd303fbb36e9a54e7c36457ff9a254 [323/325] xfs: move symlink target write function to libxfs
config: m68k-randconfig-r006-20211214 (https://download.01.org/0day-ci/archive/20211216/202112162006.medrsrAU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=90d15e3e9dcd303fbb36e9a54e7c36457ff9a254
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 90d15e3e9dcd303fbb36e9a54e7c36457ff9a254
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_symlink_remote.c:28:1: warning: no previous prototype for 'xfs_symlink_blocks' [-Wmissing-prototypes]
      28 | xfs_symlink_blocks(
         | ^~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_symlink_remote.c:38:1: warning: no previous prototype for 'xfs_symlink_hdr_set' [-Wmissing-prototypes]
      38 | xfs_symlink_hdr_set(
         | ^~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_symlink_remote.c:68:1: warning: no previous prototype for 'xfs_symlink_hdr_ok' [-Wmissing-prototypes]
      68 | xfs_symlink_hdr_ok(
         | ^~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_symlink_remote.c:167:1: warning: no previous prototype for 'xfs_symlink_local_to_remote' [-Wmissing-prototypes]
     167 | xfs_symlink_local_to_remote(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_symlink_remote.c:206:1: warning: no previous prototype for 'xfs_symlink_shortform_verify' [-Wmissing-prototypes]
     206 | xfs_symlink_shortform_verify(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for 'xfs_symlink_remote_read' [-Wmissing-prototypes]
     239 | xfs_symlink_remote_read(
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for 'xfs_symlink_write_target' [-Wmissing-prototypes]
     311 | xfs_symlink_write_target(
         | ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_symlink_write_target +311 fs/xfs/libxfs/xfs_symlink_remote.c

   308	
   309	/* Write the symlink target into the inode. */
   310	int
 > 311	xfs_symlink_write_target(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

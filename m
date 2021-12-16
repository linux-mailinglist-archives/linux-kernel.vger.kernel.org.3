Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC5477474
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhLPO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:27:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:19074 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhLPO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664829; x=1671200829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5JELJusnv8Os4QhsDNm6ZMGLAYdPDdauaVwcGaHD7Zo=;
  b=Y5OHuAY+G+hYoJ4OLZpTFeI8Rvv3QSiYqOKyM4AUHDnIlhFIRKCrQI0A
   y4IrHMojdC1MRB6S6PlzQ5G1m5N2gavv57zBQQ6Urpcvty5kNZVFbdu1Z
   6ZoERZkKv9/pw3zsRfmkTS1gfv+bcLq76Xy/0jmYqClX+YHZqX52i+t+v
   Ikd6jPpn/yXyRM4dle9fjbZ5wIgC9qMylLeLevPcozFFM21sjhNYOdRWh
   icLuDzCNW4BvJBfM0qkncCuHORLFDy8RfT2blFlRrDkd009xoYJYPM1MJ
   75o41XycpyznXQmh35LG3Jpg2HhEiLphqbikQNYGT0DoxanoTq5zo9iTD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219516181"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219516181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="545996963"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2021 06:27:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxrit-0003KO-3c; Thu, 16 Dec 2021 14:27:07 +0000
Date:   Thu, 16 Dec 2021 22:26:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 325/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:387:1: warning: no previous prototype for
 'xfs_symlink_remote_truncate'
Message-ID: <202112162251.CsRh5Tbt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: 851df07d9599471df909c4ff0e3cf33f4b9619f0 [325/325] xfs: convert symlink repair to use swapext
config: m68k-randconfig-r006-20211214 (https://download.01.org/0day-ci/archive/20211216/202112162251.CsRh5Tbt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=851df07d9599471df909c4ff0e3cf33f4b9619f0
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 851df07d9599471df909c4ff0e3cf33f4b9619f0
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
   fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for 'xfs_symlink_write_target' [-Wmissing-prototypes]
     311 | xfs_symlink_write_target(
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs/xfs/libxfs/xfs_symlink_remote.c:387:1: warning: no previous prototype for 'xfs_symlink_remote_truncate' [-Wmissing-prototypes]
     387 | xfs_symlink_remote_truncate(
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_symlink_remote_truncate +387 fs/xfs/libxfs/xfs_symlink_remote.c

   384	
   385	/* Remove all the blocks from a symlink and invalidate buffers. */
   386	int
 > 387	xfs_symlink_remote_truncate(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

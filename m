Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC7476F24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhLPKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:50:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:5365 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236224AbhLPKt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639651799; x=1671187799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A9czJ+VeUqfwq83fnKcH+RDr3yuDTjI8hwynIr+PedE=;
  b=S48wKLr7qLFXz5X4zii68GozJPOd9T7IBomf2UlEzJBBw6onVYrZFrNp
   IbgO7XAFOrgBZXhInue3vfS+iUyXe9YIbt0d1M6fR/J6sgSzi57YuJRuE
   PbDqgQt6+6T77aeobPVWv6n9+b74SyGiFESdmSTw/nDumVXsqTumn8BEf
   A3fxoGgfnUhdozqMHYLHf17l+YsaW+1s/69DDSDg4XxL54wFgGjGekKw0
   5vAAtQMSVQ4ECgfBczKJw/eZsXNQiHfpBgMy+285s/jjyJh01QzY5dGJT
   TdIp5CGRqXgmlcQ9+/hoO1I7SkAJy6ao5AcCcUlFD0BQDo/Vt5MYEjbP4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="263621361"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="263621361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 02:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="506227852"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 02:49:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxoKi-000321-MD; Thu, 16 Dec 2021 10:49:56 +0000
Date:   Thu, 16 Dec 2021 18:49:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 322/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for
 'xfs_symlink_remote_read'
Message-ID: <202112161839.YK3WPzl5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: b0cad080048a93ceeae93b51a0cab55c85c5a7ec [322/325] xfs: move remote symlink target read function to libxfs
config: m68k-randconfig-r006-20211214 (https://download.01.org/0day-ci/archive/20211216/202112161839.YK3WPzl5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=b0cad080048a93ceeae93b51a0cab55c85c5a7ec
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout b0cad080048a93ceeae93b51a0cab55c85c5a7ec
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
>> fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for 'xfs_symlink_remote_read' [-Wmissing-prototypes]
     239 | xfs_symlink_remote_read(
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +/xfs_symlink_remote_read +239 fs/xfs/libxfs/xfs_symlink_remote.c

   236	
   237	/* Read a remote symlink target into the buffer. */
   238	int
 > 239	xfs_symlink_remote_read(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

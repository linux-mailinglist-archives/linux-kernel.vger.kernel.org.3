Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D037D476D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhLPJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:29:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:57998 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232923AbhLPJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639646949; x=1671182949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e8Xe02CmurKlZgVHuJqNKmF3CkiPchp4egjDv7zpCBk=;
  b=K6CUdYBKpSc086NPasJ5QRgXKeGkNdKLoTRJRLqjnU8TdWFGwJv/4mqP
   OBWARGqBveYuBJfNC2G1bILts1B7MQKUtP0N4sLGfKz604A4xu3vHLOYW
   7atA6A7Quxm8jeGUyNgxaX7AFqMNcUOlNdMNLOgv12N0mQTPrAm5q/Fpk
   9on5dePCrdxiyoYzM9AK3hPgYKFFqWdup8zny4yiRCaVjvqdnB8psMFKp
   laYvagmRzjmavvPK/8HifX9BaZ7m92QaYxZN8lSkjinraNGnzXjONRiyb
   YxXNh9vuH90WMF0tOB+mzE5l5M5TlstDBeyLQRfgNwsWmAh+wIuc+uXYM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236987320"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="236987320"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 01:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="615088695"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 01:28:55 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxn4I-0002yZ-SK; Thu, 16 Dec 2021 09:28:54 +0000
Date:   Thu, 16 Dec 2021 17:28:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 322/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for
 function 'xfs_symlink_remote_read'
Message-ID: <202112161727.ehXN074t-lkp@intel.com>
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
config: riscv-randconfig-r042-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161727.ehXN074t-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=b0cad080048a93ceeae93b51a0cab55c85c5a7ec
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout b0cad080048a93ceeae93b51a0cab55c85c5a7ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/xfs/libxfs/xfs_symlink_remote.c:28:1: warning: no previous prototype for function 'xfs_symlink_blocks' [-Wmissing-prototypes]
   xfs_symlink_blocks(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:27:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   fs/xfs/libxfs/xfs_symlink_remote.c:38:1: warning: no previous prototype for function 'xfs_symlink_hdr_set' [-Wmissing-prototypes]
   xfs_symlink_hdr_set(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:37:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   fs/xfs/libxfs/xfs_symlink_remote.c:68:1: warning: no previous prototype for function 'xfs_symlink_hdr_ok' [-Wmissing-prototypes]
   xfs_symlink_hdr_ok(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:67:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool
   ^
   static 
   fs/xfs/libxfs/xfs_symlink_remote.c:167:1: warning: no previous prototype for function 'xfs_symlink_local_to_remote' [-Wmissing-prototypes]
   xfs_symlink_local_to_remote(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:166:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
   fs/xfs/libxfs/xfs_symlink_remote.c:206:1: warning: no previous prototype for function 'xfs_symlink_shortform_verify' [-Wmissing-prototypes]
   xfs_symlink_shortform_verify(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:205:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   xfs_failaddr_t
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for function 'xfs_symlink_remote_read' [-Wmissing-prototypes]
   xfs_symlink_remote_read(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:238:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   6 warnings generated.


vim +/xfs_symlink_remote_read +239 fs/xfs/libxfs/xfs_symlink_remote.c

   236	
   237	/* Read a remote symlink target into the buffer. */
   238	int
 > 239	xfs_symlink_remote_read(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

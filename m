Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA84477142
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhLPMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:03:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:14858 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234285AbhLPMDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639656180; x=1671192180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iqFtp2U83/P0+3k00NjhK/l7028RUN72TSeB0sy3bG0=;
  b=nKqE7GUfpjLtO0EX60NIveXTEJyeynEE6G4qoozpjJwlhWOOj1Sgjz1Q
   L0v8mLYkGwiv6kQ1viedH3hjd7RFXzVsAmbgH3i7E8MLp5pUtd5TiyjEw
   4HlJ2XCIkqM1ZVWoAJtObxDXiEfEiVtcU52udTiJlMsxYlE/PI8BM9FnD
   uzs5ek05K+36Uqcvt/le9psCMKnz/+p0hJ2qDqr2x5JbETIhoiC7rFSBo
   rHZ4lIlDnFpwc8RcpzXPPOZ810oqmSV38PSTjm5JcwY9et8bFCAM6PV2s
   ZjIecDsiEgw40fMoMgmFgqDu3ALZ+SZDS5RvkxEqzYhHBubbkcBKvH00j
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220151167"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220151167"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="682919096"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 04:02:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxpTN-00035k-RS; Thu, 16 Dec 2021 12:02:57 +0000
Date:   Thu, 16 Dec 2021 20:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 323/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for
 function 'xfs_symlink_write_target'
Message-ID: <202112161930.6u4fjfND-lkp@intel.com>
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
config: riscv-randconfig-r042-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161930.6u4fjfND-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=90d15e3e9dcd303fbb36e9a54e7c36457ff9a254
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 90d15e3e9dcd303fbb36e9a54e7c36457ff9a254
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
   fs/xfs/libxfs/xfs_symlink_remote.c:239:1: warning: no previous prototype for function 'xfs_symlink_remote_read' [-Wmissing-prototypes]
   xfs_symlink_remote_read(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:238:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for function 'xfs_symlink_write_target' [-Wmissing-prototypes]
   xfs_symlink_write_target(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:310:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   7 warnings generated.


vim +/xfs_symlink_write_target +311 fs/xfs/libxfs/xfs_symlink_remote.c

   236	
   237	/* Read a remote symlink target into the buffer. */
   238	int
 > 239	xfs_symlink_remote_read(
   240		struct xfs_inode	*ip,
   241		char			*link)
   242	{
   243		struct xfs_mount	*mp = ip->i_mount;
   244		struct xfs_bmbt_irec	mval[XFS_SYMLINK_MAPS];
   245		struct xfs_buf		*bp;
   246		xfs_daddr_t		d;
   247		char			*cur_chunk;
   248		int			pathlen = ip->i_disk_size;
   249		int			nmaps = XFS_SYMLINK_MAPS;
   250		int			byte_cnt;
   251		int			n;
   252		int			error = 0;
   253		int			fsblocks = 0;
   254		int			offset;
   255	
   256		ASSERT(xfs_isilocked(ip, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
   257	
   258		fsblocks = xfs_symlink_blocks(mp, pathlen);
   259		error = xfs_bmapi_read(ip, 0, fsblocks, mval, &nmaps, 0);
   260		if (error)
   261			goto out;
   262	
   263		offset = 0;
   264		for (n = 0; n < nmaps; n++) {
   265			d = XFS_FSB_TO_DADDR(mp, mval[n].br_startblock);
   266			byte_cnt = XFS_FSB_TO_B(mp, mval[n].br_blockcount);
   267	
   268			error = xfs_buf_read(mp->m_ddev_targp, d, BTOBB(byte_cnt), 0,
   269					&bp, &xfs_symlink_buf_ops);
   270			if (error)
   271				return error;
   272			byte_cnt = XFS_SYMLINK_BUF_SPACE(mp, byte_cnt);
   273			if (pathlen < byte_cnt)
   274				byte_cnt = pathlen;
   275	
   276			cur_chunk = bp->b_addr;
   277			if (xfs_has_crc(mp)) {
   278				if (!xfs_symlink_hdr_ok(ip->i_ino, offset,
   279								byte_cnt, bp)) {
   280					xfs_inode_mark_sick(ip, XFS_SICK_INO_SYMLINK);
   281					error = -EFSCORRUPTED;
   282					xfs_alert(mp,
   283	"symlink header does not match required off/len/owner (0x%x/Ox%x,0x%llx)",
   284						offset, byte_cnt, ip->i_ino);
   285					xfs_buf_relse(bp);
   286					goto out;
   287	
   288				}
   289	
   290				cur_chunk += sizeof(struct xfs_dsymlink_hdr);
   291			}
   292	
   293			memcpy(link + offset, cur_chunk, byte_cnt);
   294	
   295			pathlen -= byte_cnt;
   296			offset += byte_cnt;
   297	
   298			xfs_buf_relse(bp);
   299		}
   300		ASSERT(pathlen == 0);
   301	
   302		link[ip->i_disk_size] = '\0';
   303		error = 0;
   304	
   305	 out:
   306		return error;
   307	}
   308	
   309	/* Write the symlink target into the inode. */
   310	int
 > 311	xfs_symlink_write_target(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

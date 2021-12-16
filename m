Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC9477434
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhLPOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:16:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:8984 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234825AbhLPOQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664174; x=1671200174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=03Pp3795PkDaByss961Zo2I8vg1ZR3c/L2aO1JSm/rU=;
  b=TpchakjqT96FuiRTF5PGoyEqDkK+cfjAH99WPJjyhk1Auh63nKPtWN+6
   NSpV6sN+nA5UpKWCSJz1foivh2eHhGkvyeoEDvCKsddFWCykmol5EkgtC
   xqAmAVi2X2WmkQlNzBt6DF1CgsTa0cnKTl8q0gnXgwOeBYWCe0BasF3Ry
   dlRRlvBiIkIZH6iOIGKOz0XvsXduklNYn8g5xWSFwnMlnnMsp5kKXbs4n
   XuuADPqlh3HF1HNtP1y2BCUQZa5VbsEmXjcbHzwVOh9AJ+ATIDsu+qCDI
   z8amVYwdYt72/7wCvj12/YyaYTbpOQwOUA9egl6tyAl+RxTwFAxl7QgkA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226360803"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="226360803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="482836221"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Dec 2021 06:16:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxrYE-0003JV-Qf; Thu, 16 Dec 2021 14:16:06 +0000
Date:   Thu, 16 Dec 2021 22:15:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 325/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:387:1: warning: no previous prototype for
 function 'xfs_symlink_remote_truncate'
Message-ID: <202112162223.7F9L1svL-lkp@intel.com>
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
config: riscv-randconfig-r042-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162223.7F9L1svL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=851df07d9599471df909c4ff0e3cf33f4b9619f0
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 851df07d9599471df909c4ff0e3cf33f4b9619f0
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
   fs/xfs/libxfs/xfs_symlink_remote.c:311:1: warning: no previous prototype for function 'xfs_symlink_write_target' [-Wmissing-prototypes]
   xfs_symlink_write_target(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:310:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:387:1: warning: no previous prototype for function 'xfs_symlink_remote_truncate' [-Wmissing-prototypes]
   xfs_symlink_remote_truncate(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:386:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   8 warnings generated.


vim +/xfs_symlink_remote_truncate +387 fs/xfs/libxfs/xfs_symlink_remote.c

   308	
   309	/* Write the symlink target into the inode. */
   310	int
 > 311	xfs_symlink_write_target(
   312		struct xfs_trans	*tp,
   313		struct xfs_inode	*ip,
   314		const char		*target_path,
   315		int			pathlen,
   316		xfs_fsblock_t		fs_blocks,
   317		uint			resblks)
   318	{
   319		struct xfs_bmbt_irec	mval[XFS_SYMLINK_MAPS];
   320		struct xfs_mount	*mp = tp->t_mountp;
   321		const char		*cur_chunk;
   322		struct xfs_buf		*bp;
   323		xfs_daddr_t		d;
   324		int			byte_cnt;
   325		int			nmaps;
   326		int			offset = 0;
   327		int			n;
   328		int			error;
   329	
   330		/*
   331		 * If the symlink will fit into the inode, write it inline.
   332		 */
   333		if (pathlen <= XFS_IFORK_DSIZE(ip)) {
   334			xfs_init_local_fork(ip, XFS_DATA_FORK, target_path, pathlen);
   335	
   336			ip->i_disk_size = pathlen;
   337			ip->i_df.if_format = XFS_DINODE_FMT_LOCAL;
   338			xfs_trans_log_inode(tp, ip, XFS_ILOG_DDATA | XFS_ILOG_CORE);
   339			return 0;
   340		}
   341	
   342		nmaps = XFS_SYMLINK_MAPS;
   343		error = xfs_bmapi_write(tp, ip, 0, fs_blocks, XFS_BMAPI_METADATA,
   344				resblks, mval, &nmaps);
   345		if (error)
   346			return error;
   347	
   348		ip->i_disk_size = pathlen;
   349		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
   350	
   351		cur_chunk = target_path;
   352		offset = 0;
   353		for (n = 0; n < nmaps; n++) {
   354			char	*buf;
   355	
   356			d = XFS_FSB_TO_DADDR(mp, mval[n].br_startblock);
   357			byte_cnt = XFS_FSB_TO_B(mp, mval[n].br_blockcount);
   358			error = xfs_trans_get_buf(tp, mp->m_ddev_targp, d,
   359					BTOBB(byte_cnt), 0, &bp);
   360			if (error)
   361				return error;
   362			bp->b_ops = &xfs_symlink_buf_ops;
   363	
   364			byte_cnt = XFS_SYMLINK_BUF_SPACE(mp, byte_cnt);
   365			byte_cnt = min(byte_cnt, pathlen);
   366	
   367			buf = bp->b_addr;
   368			buf += xfs_symlink_hdr_set(mp, ip->i_ino, offset, byte_cnt,
   369					bp);
   370	
   371			memcpy(buf, cur_chunk, byte_cnt);
   372	
   373			cur_chunk += byte_cnt;
   374			pathlen -= byte_cnt;
   375			offset += byte_cnt;
   376	
   377			xfs_trans_buf_set_type(tp, bp, XFS_BLFT_SYMLINK_BUF);
   378			xfs_trans_log_buf(tp, bp, 0, (buf + byte_cnt - 1) -
   379							(char *)bp->b_addr);
   380		}
   381		ASSERT(pathlen == 0);
   382		return 0;
   383	}
   384	
   385	/* Remove all the blocks from a symlink and invalidate buffers. */
   386	int
 > 387	xfs_symlink_remote_truncate(

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6D48BB65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346809AbiAKXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:25:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:9337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346795AbiAKXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641943531; x=1673479531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kwDBkjEpef/ttCiZVTm2X/+pvqmURt+LORrmkKCXvsQ=;
  b=W4nHztYlSWkh5CtkuYD5qjsC/YLde2JlLqy7uLdGcWdb+FRn+rSXmUEM
   G2mrQ0CBfWigNKKoVNUfIiApmQWKDMxgUz2LdWvtmNoPAYD5ktj3rYSkM
   rILYZuP+Kav+J0NcwyQ2YcuUXFiLoHgJttO8HAi+y2Zm7jMP7XTqIHKsv
   Bmbtxqpshj7BIa+rY0ZfA4sxRqemiFOdQcGyHt3s/Adt6yPrkUF2jtzds
   rxjsHJinIh4qVi6/H84frx7aVQazJyjlRvg6RzT2wPFHLn55pOI5fHKFw
   ehdT+gxtfpRzpA3+XyPfXkWrP2uO0cuRgk8PjJo2mM2Cb6XzUjJiIgawT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243410632"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="243410632"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="691170274"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2022 15:24:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7QVX-0005KV-Ne; Tue, 11 Jan 2022 23:24:51 +0000
Date:   Wed, 12 Jan 2022 07:24:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9999/9999] fs/fuse/dir.c:1579:44: error: no member named 'backing_inode' in
 'struct fuse_inode'
Message-ID: <202201120452.MMoH70oo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   34957d1e9236e27df4fc1e4cfbbaf271271f05ff
commit: 34957d1e9236e27df4fc1e4cfbbaf271271f05ff [9999/9999] ANDROID: fuse-bpf: Fix perms on readdir
config: arm-randconfig-c002-20220111 (https://download.01.org/0day-ci/archive/20220112/202201120452.MMoH70oo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 244dd2913a43a200f5a6544d424cdc37b771028b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/34957d1e9236e27df4fc1e4cfbbaf271271f05ff
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 34957d1e9236e27df4fc1e4cfbbaf271271f05ff
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/fuse/dir.c:9:
   In file included from fs/fuse/fuse_i.h:16:
   In file included from include/linux/filter.h:21:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:42:
   In file included from include/net/netprio_cgroup.h:11:
   In file included from include/linux/cgroup.h:29:
   include/linux/cgroup-defs.h:505:16: warning: field 'cgrp' with variable sized type 'struct cgroup' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct cgroup cgrp;
                         ^
>> fs/fuse/dir.c:1579:44: error: no member named 'backing_inode' in 'struct fuse_inode'
           } else if (!(mask & MAY_NOT_BLOCK) && fi->backing_inode) {
                                                 ~~  ^
   1 warning and 1 error generated.


vim +1579 fs/fuse/dir.c

  1508	
  1509	/*
  1510	 * Check permission.  The two basic access models of FUSE are:
  1511	 *
  1512	 * 1) Local access checking ('default_permissions' mount option) based
  1513	 * on file mode.  This is the plain old disk filesystem permission
  1514	 * modell.
  1515	 *
  1516	 * 2) "Remote" access checking, where server is responsible for
  1517	 * checking permission in each inode operation.  An exception to this
  1518	 * is if ->permission() was invoked from sys_access() in which case an
  1519	 * access request is sent.  Execute permission is still checked
  1520	 * locally based on file mode.
  1521	 */
  1522	static int fuse_permission(struct inode *inode, int mask)
  1523	{
  1524		struct fuse_conn *fc = get_fuse_conn(inode);
  1525		bool refreshed = false;
  1526		int err = 0;
  1527		struct fuse_inode *fi = get_fuse_inode(inode);
  1528	
  1529		if (fuse_is_bad(inode))
  1530			return -EIO;
  1531	
  1532		if (!fuse_allow_current_process(fc))
  1533			return -EACCES;
  1534	
  1535		/*
  1536		 * If attributes are needed, refresh them before proceeding
  1537		 */
  1538		if (fc->default_permissions ||
  1539		    ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))) {
  1540			u32 perm_mask = STATX_MODE | STATX_UID | STATX_GID;
  1541	
  1542			if (perm_mask & READ_ONCE(fi->inval_mask) ||
  1543			    time_before64(fi->i_time, get_jiffies_64())) {
  1544				refreshed = true;
  1545	
  1546				err = fuse_perm_getattr(inode, mask);
  1547				if (err)
  1548					return err;
  1549			}
  1550		}
  1551	
  1552		if (fc->default_permissions) {
  1553			err = generic_permission(inode, mask);
  1554	
  1555			/* If permission is denied, try to refresh file
  1556			   attributes.  This is also needed, because the root
  1557			   node will at first have no permissions */
  1558			if (err == -EACCES && !refreshed) {
  1559				err = fuse_perm_getattr(inode, mask);
  1560				if (!err)
  1561					err = generic_permission(inode, mask);
  1562			}
  1563	
  1564			/* Note: the opposite of the above test does not
  1565			   exist.  So if permissions are revoked this won't be
  1566			   noticed immediately, only after the attribute
  1567			   timeout has expired */
  1568		} else if (mask & (MAY_ACCESS | MAY_CHDIR)) {
  1569			err = fuse_access(inode, mask);
  1570		} else if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode)) {
  1571			if (!(inode->i_mode & S_IXUGO)) {
  1572				if (refreshed)
  1573					return -EACCES;
  1574	
  1575				err = fuse_perm_getattr(inode, mask);
  1576				if (!err && !(inode->i_mode & S_IXUGO))
  1577					return -EACCES;
  1578			}
> 1579		} else if (!(mask & MAY_NOT_BLOCK) && fi->backing_inode) {
  1580			err = fuse_access(inode, mask);
  1581		}
  1582		return err;
  1583	}
  1584	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

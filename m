Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1090F49BF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiAYXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:12:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:45473 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbiAYXM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643152347; x=1674688347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1eF+U3lTlNDgsnhZsVSuMSp+qQ9aQknF6OIxl7Mh+Zg=;
  b=lfqjU6uToM2Y8LKW+FAs4VgZNlsZyyVml+Iro+md4hE3wlimiWGrfGYI
   hm4zEWRu/M22veE2omkCty7E+r9diYJsSg8KOwekYCsekRVvX3D1DX6iY
   02b8b8Gdt7DRc2enPXvcdZTKkfgdZJfrAgUrb+uF+tp0JliL18jgtgwTH
   ULsQhNCBqIJG3nzAhq3pBxgaKl5ghpk49tim+g9Mx4K5XrvlRdRkQKYCA
   J9xsE0ITU9c9Jwl/G0I7FJZBn0X/+/4FusK7LbMr1wq0abYyyC99Lloka
   vDgclOoEgoGlzqomkBaWT3ZJt0ZUuwE5MlomS9n9yJITMahVp5zltl8ow
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230010867"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="230010867"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520581207"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 15:12:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCUzA-000KXs-JQ; Tue, 25 Jan 2022 23:12:24 +0000
Date:   Wed, 26 Jan 2022 07:12:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-doc@vger.kernel.org
Subject: [kdave-btrfs-devel:misc-next 149/153] fs/btrfs/tree-log.c:6755:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202201260759.edlA9lHT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git misc-next
head:   8e5d6a5c062f370d4d0b2dace7e95ab40c6ce3dd
commit: 6bfc5d45946acd8286fb026137f20ee8747a50f1 [149/153] btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
config: nds32-allyesconfig (https://download.01.org/0day-ci/archive/20220126/202201260759.edlA9lHT-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/6bfc5d45946acd8286fb026137f20ee8747a50f1
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel misc-next
        git checkout 6bfc5d45946acd8286fb026137f20ee8747a50f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/tree-log.c:6755: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Update the log after adding a new name for an inode.


vim +6755 fs/btrfs/tree-log.c

  6753	
  6754	/**
> 6755	 * Update the log after adding a new name for an inode.
  6756	 *
  6757	 * @trans:              Transaction handle.
  6758	 * @old_dentry:         The dentry associated with the old name and the old
  6759	 *                      parent directory.
  6760	 * @old_dir:            The inode of the previous parent directory for the case
  6761	 *                      of a rename. For a link operation, it must be NULL.
  6762	 * @parent:             The dentry associated with the directory under which the
  6763	 *                      new name is located.
  6764	 *
  6765	 * Call this after adding a new name for an inode, as a result of a link or
  6766	 * rename operation, and it will properly update the log to reflect the new name.
  6767	 */
  6768	void btrfs_log_new_name(struct btrfs_trans_handle *trans,
  6769				struct dentry *old_dentry, struct btrfs_inode *old_dir,
  6770				struct dentry *parent)
  6771	{
  6772		struct btrfs_inode *inode = BTRFS_I(d_inode(old_dentry));
  6773		struct btrfs_log_ctx ctx;
  6774	
  6775		/*
  6776		 * this will force the logging code to walk the dentry chain
  6777		 * up for the file
  6778		 */
  6779		if (!S_ISDIR(inode->vfs_inode.i_mode))
  6780			inode->last_unlink_trans = trans->transid;
  6781	
  6782		/*
  6783		 * if this inode hasn't been logged and directory we're renaming it
  6784		 * from hasn't been logged, we don't need to log it
  6785		 */
  6786		if (!inode_logged(trans, inode) &&
  6787		    (!old_dir || !inode_logged(trans, old_dir)))
  6788			return;
  6789	
  6790		/*
  6791		 * If we are doing a rename (old_dir is not NULL) from a directory that
  6792		 * was previously logged, make sure the next log attempt on the directory
  6793		 * is not skipped and logs the inode again. This is because the log may
  6794		 * not currently be authoritative for a range including the old
  6795		 * BTRFS_DIR_INDEX_KEY key, so we want to make sure after a log replay we
  6796		 * do not end up with both the new and old dentries around (in case the
  6797		 * inode is a directory we would have a directory with two hard links and
  6798		 * 2 inode references for different parents). The next log attempt of
  6799		 * old_dir will happen at btrfs_log_all_parents(), called through
  6800		 * btrfs_log_inode_parent() below, because we have previously set
  6801		 * inode->last_unlink_trans to the current transaction ID, either here or
  6802		 * at btrfs_record_unlink_dir() in case the inode is a directory.
  6803		 */
  6804		if (old_dir)
  6805			old_dir->logged_trans = 0;
  6806	
  6807		btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
  6808		ctx.logging_new_name = true;
  6809		/*
  6810		 * We don't care about the return value. If we fail to log the new name
  6811		 * then we know the next attempt to sync the log will fallback to a full
  6812		 * transaction commit (due to a call to btrfs_set_log_full_commit()), so
  6813		 * we don't need to worry about getting a log committed that has an
  6814		 * inconsistent state after a rename operation.
  6815		 */
  6816		btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
  6817	}
  6818	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

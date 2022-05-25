Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACC5345C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbiEYVac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbiEYVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:30:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B37CB15
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653514219; x=1685050219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=llaEOIe+RcvKHFt8QTbXLxMOgXhwgeIvTd/VHJZYDd4=;
  b=P53sveHZQ9aT3/QgzSRBnZthEbIPztLGJiK1QoFkaceeEORmO+lQfrm3
   4SvF1KrNQKGwMuV+I+vnylGy2/Qk5gT4ZfcfbGou28UOIs7ZZC2nHEgOg
   +TB1vwV8Q1izMWNcvwPF3CrzZEVdQ0z1tk3gQtnho4iPw/ac2RG0EpIBr
   0t6TKDGYkPq62D6WaUpjnHwYQ8A44Dr9LB6lQlFRSgZ2zhK6+quagbcPD
   U99KXA/hIg/oqavoirpGHh0jjhmdXlUQ9VZJ56AA99vrtDASrHzk6EYiu
   m+vbwoWDPwQqDahTiDIrmnZman+1dhwm42G9mm+eCwsD2wAOqfLAK6d+q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="256002974"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256002974"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 14:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="704184846"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2022 14:30:17 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntya8-0003K8-NJ;
        Wed, 25 May 2022 21:30:16 +0000
Date:   Thu, 26 May 2022 05:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: fs/btrfs/ordered-data.c:168: warning: expecting prototype for Add an
 ordered extent to the per(). Prototype was for btrfs_add_ordered_extent()
 instead
Message-ID: <202205260506.35lRvjfA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64e34b50d7aeee7082287ec39f9d34d4e60f3a04
commit: cb36a9bb17c4abf720123dacd449408588247005 btrfs: add ram_bytes and offset to btrfs_ordered_extent
date:   2 months ago
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220526/202205260506.35lRvjfA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb36a9bb17c4abf720123dacd449408588247005
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cb36a9bb17c4abf720123dacd449408588247005
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/ordered-data.c:168: warning: expecting prototype for Add an ordered extent to the per(). Prototype was for btrfs_add_ordered_extent() instead


vim +168 fs/btrfs/ordered-data.c

dc17ff8f11d129d Chris Mason     2008-01-08  145  
cb36a9bb17c4abf Omar Sandoval   2019-11-06  146  /**
cb36a9bb17c4abf Omar Sandoval   2019-11-06  147   * Add an ordered extent to the per-inode tree.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  148   *
cb36a9bb17c4abf Omar Sandoval   2019-11-06  149   * @inode:           Inode that this extent is for.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  150   * @file_offset:     Logical offset in file where the extent starts.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  151   * @num_bytes:       Logical length of extent in file.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  152   * @ram_bytes:       Full length of unencoded data.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  153   * @disk_bytenr:     Offset of extent on disk.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  154   * @disk_num_bytes:  Size of extent on disk.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  155   * @offset:          Offset into unencoded data where file data starts.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  156   * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
cb36a9bb17c4abf Omar Sandoval   2019-11-06  157   * @compress_type:   Compression algorithm used for data.
cb36a9bb17c4abf Omar Sandoval   2019-11-06  158   *
cb36a9bb17c4abf Omar Sandoval   2019-11-06  159   * Most of these parameters correspond to &struct btrfs_file_extent_item. The
cb36a9bb17c4abf Omar Sandoval   2019-11-06  160   * tree is given a single reference on the ordered extent that was inserted.
eb84ae039e10f1f Chris Mason     2008-07-17  161   *
cb36a9bb17c4abf Omar Sandoval   2019-11-06  162   * Return: 0 or -ENOMEM.
eb84ae039e10f1f Chris Mason     2008-07-17  163   */
cb36a9bb17c4abf Omar Sandoval   2019-11-06  164  int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
cb36a9bb17c4abf Omar Sandoval   2019-11-06  165  			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
cb36a9bb17c4abf Omar Sandoval   2019-11-06  166  			     u64 disk_num_bytes, u64 offset, unsigned flags,
bffe633e00fb6b9 Omar Sandoval   2019-12-02  167  			     int compress_type)
dc17ff8f11d129d Chris Mason     2008-01-08 @168  {
da69fea9f785d84 Nikolay Borisov 2020-06-03  169  	struct btrfs_root *root = inode->root;
da69fea9f785d84 Nikolay Borisov 2020-06-03  170  	struct btrfs_fs_info *fs_info = root->fs_info;
da69fea9f785d84 Nikolay Borisov 2020-06-03  171  	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
e6dcd2dc9c48910 Chris Mason     2008-07-17  172  	struct rb_node *node;
e6dcd2dc9c48910 Chris Mason     2008-07-17  173  	struct btrfs_ordered_extent *entry;
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  174  	int ret;
dc17ff8f11d129d Chris Mason     2008-01-08  175  
cb36a9bb17c4abf Omar Sandoval   2019-11-06  176  	if (flags &
cb36a9bb17c4abf Omar Sandoval   2019-11-06  177  	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  178  		/* For nocow write, we can release the qgroup rsv right now */
8b8a979f1fc6905 Nikolay Borisov 2020-06-03  179  		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  180  		if (ret < 0)
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  181  			return ret;
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  182  		ret = 0;
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  183  	} else {
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  184  		/*
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  185  		 * The ordered extent has reserved qgroup space, release now
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  186  		 * and pass the reserved number for qgroup_record to free.
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  187  		 */
72b7d15bf1e1ee7 Nikolay Borisov 2020-06-03  188  		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  189  		if (ret < 0)
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  190  			return ret;
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  191  	}
6352b91da1a2108 Miao Xie        2012-09-06  192  	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
dc17ff8f11d129d Chris Mason     2008-01-08  193  	if (!entry)
dc17ff8f11d129d Chris Mason     2008-01-08  194  		return -ENOMEM;
dc17ff8f11d129d Chris Mason     2008-01-08  195  
e6dcd2dc9c48910 Chris Mason     2008-07-17  196  	entry->file_offset = file_offset;
bffe633e00fb6b9 Omar Sandoval   2019-12-02  197  	entry->num_bytes = num_bytes;
cb36a9bb17c4abf Omar Sandoval   2019-11-06  198  	entry->ram_bytes = ram_bytes;
cb36a9bb17c4abf Omar Sandoval   2019-11-06  199  	entry->disk_bytenr = disk_bytenr;
bffe633e00fb6b9 Omar Sandoval   2019-12-02  200  	entry->disk_num_bytes = disk_num_bytes;
cb36a9bb17c4abf Omar Sandoval   2019-11-06  201  	entry->offset = offset;
bffe633e00fb6b9 Omar Sandoval   2019-12-02  202  	entry->bytes_left = num_bytes;
da69fea9f785d84 Nikolay Borisov 2020-06-03  203  	entry->inode = igrab(&inode->vfs_inode);
261507a02ccba9a Li Zefan        2010-12-17  204  	entry->compress_type = compress_type;
77cef2ec5484564 Josef Bacik     2013-08-29  205  	entry->truncated_len = (u64)-1;
7dbeaad0af7d0a1 Qu Wenruo       2020-06-10  206  	entry->qgroup_rsv = ret;
d8e3fb106f39385 Naohiro Aota    2021-02-04  207  	entry->physical = (u64)-1;
3c198fe064491dc Qu Wenruo       2021-01-21  208  
cb36a9bb17c4abf Omar Sandoval   2019-11-06  209  	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
cb36a9bb17c4abf Omar Sandoval   2019-11-06  210  	entry->flags = flags;
3eaa2885276fd6d Chris Mason     2008-07-24  211  
5deb17e18e27a35 Josef Bacik     2020-10-09  212  	percpu_counter_add_batch(&fs_info->ordered_bytes, num_bytes,
4297ff84dc24d12 Josef Bacik     2019-04-10  213  				 fs_info->delalloc_batch);
5deb17e18e27a35 Josef Bacik     2020-10-09  214  
e6dcd2dc9c48910 Chris Mason     2008-07-17  215  	/* one ref for the tree */
e76edab7f059bc1 Elena Reshetova 2017-03-03  216  	refcount_set(&entry->refs, 1);
e6dcd2dc9c48910 Chris Mason     2008-07-17  217  	init_waitqueue_head(&entry->wait);
e6dcd2dc9c48910 Chris Mason     2008-07-17  218  	INIT_LIST_HEAD(&entry->list);
487781796d30226 Filipe Manana   2020-08-11  219  	INIT_LIST_HEAD(&entry->log_list);
3eaa2885276fd6d Chris Mason     2008-07-24  220  	INIT_LIST_HEAD(&entry->root_extent_list);
9afab8820bb8b55 Miao Xie        2012-10-25  221  	INIT_LIST_HEAD(&entry->work_list);
9afab8820bb8b55 Miao Xie        2012-10-25  222  	init_completion(&entry->completion);
dc17ff8f11d129d Chris Mason     2008-01-08  223  
acbf1dd0fcbd10c Nikolay Borisov 2020-08-31  224  	trace_btrfs_ordered_extent_add(inode, entry);
1abe9b8a138c998 liubo           2011-03-24  225  
5fd02043553b028 Josef Bacik     2012-05-02  226  	spin_lock_irq(&tree->lock);
e6dcd2dc9c48910 Chris Mason     2008-07-17  227  	node = tree_insert(&tree->tree, file_offset,
e6dcd2dc9c48910 Chris Mason     2008-07-17  228  			   &entry->rb_node);
43c04fb1b8c9f45 Jeff Mahoney    2011-10-03  229  	if (node)
511a32b5493f0d0 Nikolay Borisov 2019-11-29  230  		btrfs_panic(fs_info, -EEXIST,
511a32b5493f0d0 Nikolay Borisov 2019-11-29  231  				"inconsistency in ordered tree at offset %llu",
511a32b5493f0d0 Nikolay Borisov 2019-11-29  232  				file_offset);
5fd02043553b028 Josef Bacik     2012-05-02  233  	spin_unlock_irq(&tree->lock);
d397712bcc6a759 Chris Mason     2009-01-05  234  
199c2a9c3d1389d Miao Xie        2013-05-15  235  	spin_lock(&root->ordered_extent_lock);
3eaa2885276fd6d Chris Mason     2008-07-24  236  	list_add_tail(&entry->root_extent_list,
199c2a9c3d1389d Miao Xie        2013-05-15  237  		      &root->ordered_extents);
199c2a9c3d1389d Miao Xie        2013-05-15  238  	root->nr_ordered_extents++;
199c2a9c3d1389d Miao Xie        2013-05-15  239  	if (root->nr_ordered_extents == 1) {
0b246afa62b0cf5 Jeff Mahoney    2016-06-22  240  		spin_lock(&fs_info->ordered_root_lock);
199c2a9c3d1389d Miao Xie        2013-05-15  241  		BUG_ON(!list_empty(&root->ordered_root));
0b246afa62b0cf5 Jeff Mahoney    2016-06-22  242  		list_add_tail(&root->ordered_root, &fs_info->ordered_roots);
0b246afa62b0cf5 Jeff Mahoney    2016-06-22  243  		spin_unlock(&fs_info->ordered_root_lock);
199c2a9c3d1389d Miao Xie        2013-05-15  244  	}
199c2a9c3d1389d Miao Xie        2013-05-15  245  	spin_unlock(&root->ordered_extent_lock);
3eaa2885276fd6d Chris Mason     2008-07-24  246  
8b62f87bad9cf06 Josef Bacik     2017-10-19  247  	/*
8b62f87bad9cf06 Josef Bacik     2017-10-19  248  	 * We don't need the count_max_extents here, we can assume that all of
8b62f87bad9cf06 Josef Bacik     2017-10-19  249  	 * that work has been done at higher layers, so this is truly the
8b62f87bad9cf06 Josef Bacik     2017-10-19  250  	 * smallest the extent is going to get.
8b62f87bad9cf06 Josef Bacik     2017-10-19  251  	 */
da69fea9f785d84 Nikolay Borisov 2020-06-03  252  	spin_lock(&inode->lock);
da69fea9f785d84 Nikolay Borisov 2020-06-03  253  	btrfs_mod_outstanding_extents(inode, 1);
da69fea9f785d84 Nikolay Borisov 2020-06-03  254  	spin_unlock(&inode->lock);
8b62f87bad9cf06 Josef Bacik     2017-10-19  255  
dc17ff8f11d129d Chris Mason     2008-01-08  256  	return 0;
dc17ff8f11d129d Chris Mason     2008-01-08  257  }
dc17ff8f11d129d Chris Mason     2008-01-08  258  

:::::: The code at line 168 was first introduced by commit
:::::: dc17ff8f11d129db9e83ab7244769e4eae05e14d Btrfs: Add data=ordered support

:::::: TO: Chris Mason <chris.mason@oracle.com>
:::::: CC: Chris Mason <chris.mason@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94DA59A78E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352389AbiHSVUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350061AbiHSVUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:20:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A4104452
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660944014; x=1692480014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mrj/zZnFB0lVuGl6pAO/fJqHBXylhTx63pyt7Wg8ckY=;
  b=JAwMvRP8eDXYyvz1GJ7+lU7rg4goY2QzryT9NIj2d4deh/HzvSgp6ODC
   /uEXD5yM75lVIUvr5rnK4hdsDaljvlJ5bS7BMQxjFuREdNG+bVXu05njv
   g/5NtRzucr5Q8yDH37hxVnvUE1vN42qzahtCF04fLKyqnPexcixWTR5A/
   pHnIZe+lyt4wx98maB6E1g1XAP8bFfIbUMk5xQum4IKN2E6/r0oiPxKta
   vH98w/EnDpcEAILSg3P5OI8ffX/wiMgZK1wAe4ACY07AvPAaF8CldPcKL
   PG+JO5beLjoMNbTOzwj26ozg7xeKb7QKZ1IINrzVXQ5KG9uckTKeoQZ+w
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="354835571"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="354835571"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 14:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="676577285"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2022 14:20:12 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP9PX-0001on-1z;
        Fri, 19 Aug 2022 21:20:11 +0000
Date:   Sat, 20 Aug 2022 05:19:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ethan Lien <ethanlien@synology.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Robbie Ko <robbieko@synology.com>
Subject: [kdave:for-next 45/93] fs/btrfs/inode.c:6872:32: warning: unused
 variable 'io_tree'
Message-ID: <202208200531.vKhAsUoT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/btrfs/extent-io-tree.h
fs/btrfs/extent_io.c
fs/btrfs/inode.c
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
head:   c4fe219c58ed555f5215a1b493271d83bc93eca5
commit: a4ae8f42bbcf38a6177a41a0991e5b2d68455b5f [45/93] btrfs: remove unnecessary EXTENT_UPTODATE state in buffered I/O path
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220820/202208200531.vKhAsUoT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?id=a4ae8f42bbcf38a6177a41a0991e5b2d68455b5f
        git remote add kdave https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
        git fetch --no-tags kdave for-next
        git checkout a4ae8f42bbcf38a6177a41a0991e5b2d68455b5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/btrfs/inode.c: In function 'btrfs_get_extent':
>> fs/btrfs/inode.c:6872:32: warning: unused variable 'io_tree' [-Wunused-variable]
    6872 |         struct extent_io_tree *io_tree = &inode->io_tree;
         |                                ^~~~~~~
--
   fs/btrfs/extent_io.c: In function 'btrfs_do_readpage':
>> fs/btrfs/extent_io.c:3613:13: warning: variable 'cur_end' set but not used [-Wunused-but-set-variable]
    3613 |         u64 cur_end;
         |             ^~~~~~~


vim +/io_tree +6872 fs/btrfs/inode.c

c8b978188c9a0f Chris Mason        2008-10-29  6836  
39b07b5d7072f8 Omar Sandoval      2019-12-02  6837  /**
39b07b5d7072f8 Omar Sandoval      2019-12-02  6838   * btrfs_get_extent - Lookup the first extent overlapping a range in a file.
39b07b5d7072f8 Omar Sandoval      2019-12-02  6839   * @inode:	file to search in
39b07b5d7072f8 Omar Sandoval      2019-12-02  6840   * @page:	page to read extent data into if the extent is inline
39b07b5d7072f8 Omar Sandoval      2019-12-02  6841   * @pg_offset:	offset into @page to copy to
39b07b5d7072f8 Omar Sandoval      2019-12-02  6842   * @start:	file offset
39b07b5d7072f8 Omar Sandoval      2019-12-02  6843   * @len:	length of range starting at @start
39b07b5d7072f8 Omar Sandoval      2019-12-02  6844   *
39b07b5d7072f8 Omar Sandoval      2019-12-02  6845   * This returns the first &struct extent_map which overlaps with the given
39b07b5d7072f8 Omar Sandoval      2019-12-02  6846   * range, reading it from the B-tree and caching it if necessary. Note that
39b07b5d7072f8 Omar Sandoval      2019-12-02  6847   * there may be more extents which overlap the given range after the returned
39b07b5d7072f8 Omar Sandoval      2019-12-02  6848   * extent_map.
39b07b5d7072f8 Omar Sandoval      2019-12-02  6849   *
39b07b5d7072f8 Omar Sandoval      2019-12-02  6850   * If @page is not NULL and the extent is inline, this also reads the extent
39b07b5d7072f8 Omar Sandoval      2019-12-02  6851   * data directly into the page and marks the extent up to date in the io_tree.
d352ac68148b69 Chris Mason        2008-09-29  6852   *
39b07b5d7072f8 Omar Sandoval      2019-12-02  6853   * Return: ERR_PTR on error, non-NULL extent_map on success.
d352ac68148b69 Chris Mason        2008-09-29  6854   */
fc4f21b1d8d023 Nikolay Borisov    2017-02-20  6855  struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
39b07b5d7072f8 Omar Sandoval      2019-12-02  6856  				    struct page *page, size_t pg_offset,
39b07b5d7072f8 Omar Sandoval      2019-12-02  6857  				    u64 start, u64 len)
a52d9a8033c454 Chris Mason        2007-08-27  6858  {
3ffbd68c483207 David Sterba       2018-06-29  6859  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6860  	int ret = 0;
a52d9a8033c454 Chris Mason        2007-08-27  6861  	u64 extent_start = 0;
a52d9a8033c454 Chris Mason        2007-08-27  6862  	u64 extent_end = 0;
fc4f21b1d8d023 Nikolay Borisov    2017-02-20  6863  	u64 objectid = btrfs_ino(inode);
7e74e235bb31a1 Linus Torvalds     2019-05-01  6864  	int extent_type = -1;
f421950f86bf96 Chris Mason        2008-07-22  6865  	struct btrfs_path *path = NULL;
fc4f21b1d8d023 Nikolay Borisov    2017-02-20  6866  	struct btrfs_root *root = inode->root;
a52d9a8033c454 Chris Mason        2007-08-27  6867  	struct btrfs_file_extent_item *item;
5f39d397dfbe14 Chris Mason        2007-10-15  6868  	struct extent_buffer *leaf;
5f39d397dfbe14 Chris Mason        2007-10-15  6869  	struct btrfs_key found_key;
a52d9a8033c454 Chris Mason        2007-08-27  6870  	struct extent_map *em = NULL;
fc4f21b1d8d023 Nikolay Borisov    2017-02-20  6871  	struct extent_map_tree *em_tree = &inode->extent_tree;
fc4f21b1d8d023 Nikolay Borisov    2017-02-20 @6872  	struct extent_io_tree *io_tree = &inode->io_tree;
a52d9a8033c454 Chris Mason        2007-08-27  6873  
890871be854b5f Chris Mason        2009-09-02  6874  	read_lock(&em_tree->lock);
d1310b2e0cd98e Chris Mason        2008-01-24  6875  	em = lookup_extent_mapping(em_tree, start, len);
890871be854b5f Chris Mason        2009-09-02  6876  	read_unlock(&em_tree->lock);
d1310b2e0cd98e Chris Mason        2008-01-24  6877  
a52d9a8033c454 Chris Mason        2007-08-27  6878  	if (em) {
e1c4b7451e22f5 Chris Mason        2008-04-22  6879  		if (em->start > start || em->start + em->len <= start)
e1c4b7451e22f5 Chris Mason        2008-04-22  6880  			free_extent_map(em);
e1c4b7451e22f5 Chris Mason        2008-04-22  6881  		else if (em->block_start == EXTENT_MAP_INLINE && page)
70dec8079d7869 Chris Mason        2008-01-29  6882  			free_extent_map(em);
70dec8079d7869 Chris Mason        2008-01-29  6883  		else
a52d9a8033c454 Chris Mason        2007-08-27  6884  			goto out;
a52d9a8033c454 Chris Mason        2007-08-27  6885  	}
172ddd60a662c4 David Sterba       2011-04-21  6886  	em = alloc_extent_map();
a52d9a8033c454 Chris Mason        2007-08-27  6887  	if (!em) {
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6888  		ret = -ENOMEM;
a52d9a8033c454 Chris Mason        2007-08-27  6889  		goto out;
a52d9a8033c454 Chris Mason        2007-08-27  6890  	}
5f39d397dfbe14 Chris Mason        2007-10-15  6891  	em->start = EXTENT_MAP_HOLE;
445a69449994a3 Chris Mason        2008-11-10  6892  	em->orig_start = EXTENT_MAP_HOLE;
d1310b2e0cd98e Chris Mason        2008-01-24  6893  	em->len = (u64)-1;
c8b978188c9a0f Chris Mason        2008-10-29  6894  	em->block_len = (u64)-1;
f421950f86bf96 Chris Mason        2008-07-22  6895  
f421950f86bf96 Chris Mason        2008-07-22  6896  	path = btrfs_alloc_path();
026fd317828500 Josef Bacik        2011-05-13  6897  	if (!path) {
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6898  		ret = -ENOMEM;
026fd317828500 Josef Bacik        2011-05-13  6899  		goto out;
026fd317828500 Josef Bacik        2011-05-13  6900  	}
bee6ec822a6a68 Liu Bo             2018-08-17  6901  
bee6ec822a6a68 Liu Bo             2018-08-17  6902  	/* Chances are we'll be called again, so go ahead and do readahead */
e4058b54d1e442 David Sterba       2015-11-27  6903  	path->reada = READA_FORWARD;
4d7240f0abda6a Josef Bacik        2020-10-23  6904  
4d7240f0abda6a Josef Bacik        2020-10-23  6905  	/*
4d7240f0abda6a Josef Bacik        2020-10-23  6906  	 * The same explanation in load_free_space_cache applies here as well,
4d7240f0abda6a Josef Bacik        2020-10-23  6907  	 * we only read when we're loading the free space cache, and at that
4d7240f0abda6a Josef Bacik        2020-10-23  6908  	 * point the commit_root has everything we need.
4d7240f0abda6a Josef Bacik        2020-10-23  6909  	 */
4d7240f0abda6a Josef Bacik        2020-10-23  6910  	if (btrfs_is_free_space_inode(inode)) {
4d7240f0abda6a Josef Bacik        2020-10-23  6911  		path->search_commit_root = 1;
4d7240f0abda6a Josef Bacik        2020-10-23  6912  		path->skip_locking = 1;
4d7240f0abda6a Josef Bacik        2020-10-23  6913  	}
51899412dd95b2 Josef Bacik        2020-08-20  6914  
5c9a702ed1724f Nikolay Borisov    2017-12-01  6915  	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
a52d9a8033c454 Chris Mason        2007-08-27  6916  	if (ret < 0) {
a52d9a8033c454 Chris Mason        2007-08-27  6917  		goto out;
b8eeab7fced201 Nikolay Borisov    2018-12-17  6918  	} else if (ret > 0) {
a52d9a8033c454 Chris Mason        2007-08-27  6919  		if (path->slots[0] == 0)
a52d9a8033c454 Chris Mason        2007-08-27  6920  			goto not_found;
a52d9a8033c454 Chris Mason        2007-08-27  6921  		path->slots[0]--;
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6922  		ret = 0;
a52d9a8033c454 Chris Mason        2007-08-27  6923  	}
a52d9a8033c454 Chris Mason        2007-08-27  6924  
5f39d397dfbe14 Chris Mason        2007-10-15  6925  	leaf = path->nodes[0];
5f39d397dfbe14 Chris Mason        2007-10-15  6926  	item = btrfs_item_ptr(leaf, path->slots[0],
a52d9a8033c454 Chris Mason        2007-08-27  6927  			      struct btrfs_file_extent_item);
5f39d397dfbe14 Chris Mason        2007-10-15  6928  	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
5f39d397dfbe14 Chris Mason        2007-10-15  6929  	if (found_key.objectid != objectid ||
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6930  	    found_key.type != BTRFS_EXTENT_DATA_KEY) {
25a50341b6269b Josef Bacik        2013-10-14  6931  		/*
25a50341b6269b Josef Bacik        2013-10-14  6932  		 * If we backup past the first extent we want to move forward
25a50341b6269b Josef Bacik        2013-10-14  6933  		 * and see if there is an extent in front of us, otherwise we'll
25a50341b6269b Josef Bacik        2013-10-14  6934  		 * say there is a hole for our whole search range which can
25a50341b6269b Josef Bacik        2013-10-14  6935  		 * cause problems.
25a50341b6269b Josef Bacik        2013-10-14  6936  		 */
25a50341b6269b Josef Bacik        2013-10-14  6937  		extent_end = start;
25a50341b6269b Josef Bacik        2013-10-14  6938  		goto next;
a52d9a8033c454 Chris Mason        2007-08-27  6939  	}
a52d9a8033c454 Chris Mason        2007-08-27  6940  
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6941  	extent_type = btrfs_file_extent_type(leaf, item);
5f39d397dfbe14 Chris Mason        2007-10-15  6942  	extent_start = found_key.offset;
a5eeb3d17b979f Filipe Manana      2020-03-09  6943  	extent_end = btrfs_file_extent_end(path);
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6944  	if (extent_type == BTRFS_FILE_EXTENT_REG ||
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6945  	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6946  		/* Only regular file could have regular/prealloc extent */
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6947  		if (!S_ISREG(inode->vfs_inode.i_mode)) {
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6948  			ret = -EUCLEAN;
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6949  			btrfs_crit(fs_info,
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6950  		"regular/prealloc extent found for non-regular inode %llu",
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6951  				   btrfs_ino(inode));
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6952  			goto out;
6bf9e4bd6a2778 Qu Wenruo          2019-03-13  6953  		}
09ed2f165cb344 Liu Bo             2017-03-10  6954  		trace_btrfs_get_extent_show_fi_regular(inode, leaf, item,
09ed2f165cb344 Liu Bo             2017-03-10  6955  						       extent_start);
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6956  	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
09ed2f165cb344 Liu Bo             2017-03-10  6957  		trace_btrfs_get_extent_show_fi_inline(inode, leaf, item,
09ed2f165cb344 Liu Bo             2017-03-10  6958  						      path->slots[0],
09ed2f165cb344 Liu Bo             2017-03-10  6959  						      extent_start);
9036c10208e1fc Yan Zheng          2008-10-30  6960  	}
25a50341b6269b Josef Bacik        2013-10-14  6961  next:
9036c10208e1fc Yan Zheng          2008-10-30  6962  	if (start >= extent_end) {
9036c10208e1fc Yan Zheng          2008-10-30  6963  		path->slots[0]++;
9036c10208e1fc Yan Zheng          2008-10-30  6964  		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
9036c10208e1fc Yan Zheng          2008-10-30  6965  			ret = btrfs_next_leaf(root, path);
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6966  			if (ret < 0)
9036c10208e1fc Yan Zheng          2008-10-30  6967  				goto out;
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6968  			else if (ret > 0)
b888db2bd7b67f Chris Mason        2007-08-27  6969  				goto not_found;
1028d1c48b95c3 Nikolay Borisov    2020-08-03  6970  
9036c10208e1fc Yan Zheng          2008-10-30  6971  			leaf = path->nodes[0];
a52d9a8033c454 Chris Mason        2007-08-27  6972  		}
9036c10208e1fc Yan Zheng          2008-10-30  6973  		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
9036c10208e1fc Yan Zheng          2008-10-30  6974  		if (found_key.objectid != objectid ||
9036c10208e1fc Yan Zheng          2008-10-30  6975  		    found_key.type != BTRFS_EXTENT_DATA_KEY)
9036c10208e1fc Yan Zheng          2008-10-30  6976  			goto not_found;
9036c10208e1fc Yan Zheng          2008-10-30  6977  		if (start + len <= found_key.offset)
9036c10208e1fc Yan Zheng          2008-10-30  6978  			goto not_found;
e2eca69dc6c09d Wang Shilong       2014-07-17  6979  		if (start > found_key.offset)
e2eca69dc6c09d Wang Shilong       2014-07-17  6980  			goto next;
02a033df7a5ebf Nikolay Borisov    2018-12-17  6981  
02a033df7a5ebf Nikolay Borisov    2018-12-17  6982  		/* New extent overlaps with existing one */
9036c10208e1fc Yan Zheng          2008-10-30  6983  		em->start = start;
70c8a91ce21b83 Josef Bacik        2012-10-11  6984  		em->orig_start = start;
9036c10208e1fc Yan Zheng          2008-10-30  6985  		em->len = found_key.offset - start;
02a033df7a5ebf Nikolay Borisov    2018-12-17  6986  		em->block_start = EXTENT_MAP_HOLE;
02a033df7a5ebf Nikolay Borisov    2018-12-17  6987  		goto insert;
a52d9a8033c454 Chris Mason        2007-08-27  6988  	}
9036c10208e1fc Yan Zheng          2008-10-30  6989  
39b07b5d7072f8 Omar Sandoval      2019-12-02  6990  	btrfs_extent_item_to_extent_map(inode, path, item, !page, em);
7ffbb598a059b7 Filipe Manana      2014-06-09  6991  
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6992  	if (extent_type == BTRFS_FILE_EXTENT_REG ||
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6993  	    extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
a52d9a8033c454 Chris Mason        2007-08-27  6994  		goto insert;
694c12ed9dcb07 Nikolay Borisov    2018-12-17  6995  	} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
5f39d397dfbe14 Chris Mason        2007-10-15  6996  		unsigned long ptr;
a52d9a8033c454 Chris Mason        2007-08-27  6997  		char *map;
3326d1b07c0cb6 Chris Mason        2007-10-15  6998  		size_t size;
3326d1b07c0cb6 Chris Mason        2007-10-15  6999  		size_t extent_offset;
3326d1b07c0cb6 Chris Mason        2007-10-15  7000  		size_t copy_size;
a52d9a8033c454 Chris Mason        2007-08-27  7001  
39b07b5d7072f8 Omar Sandoval      2019-12-02  7002  		if (!page)
689f9346612d96 Yan                2007-10-29  7003  			goto out;
5f39d397dfbe14 Chris Mason        2007-10-15  7004  
e41ca5897489b1 Qu Wenruo          2018-06-06  7005  		size = btrfs_file_extent_ram_bytes(leaf, item);
9036c10208e1fc Yan Zheng          2008-10-30  7006  		extent_offset = page_offset(page) + pg_offset - extent_start;
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  7007  		copy_size = min_t(u64, PAGE_SIZE - pg_offset,
3326d1b07c0cb6 Chris Mason        2007-10-15  7008  				  size - extent_offset);
3326d1b07c0cb6 Chris Mason        2007-10-15  7009  		em->start = extent_start + extent_offset;
0b246afa62b0cf Jeff Mahoney       2016-06-22  7010  		em->len = ALIGN(copy_size, fs_info->sectorsize);
b493968096944a Josef Bacik        2012-12-03  7011  		em->orig_block_len = em->len;
70c8a91ce21b83 Josef Bacik        2012-10-11  7012  		em->orig_start = em->start;
689f9346612d96 Yan                2007-10-29  7013  		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
e49aabd973fd0b Liu Bo             2018-08-25  7014  
bf46f52db96795 Edmund Nadolski    2017-11-20  7015  		if (!PageUptodate(page)) {
261507a02ccba9 Li Zefan           2010-12-17  7016  			if (btrfs_file_extent_compression(leaf, item) !=
261507a02ccba9 Li Zefan           2010-12-17  7017  			    BTRFS_COMPRESS_NONE) {
e40da0e58a2089 Byongho Lee        2015-05-19  7018  				ret = uncompress_inline(path, page, pg_offset,
c8b978188c9a0f Chris Mason        2008-10-29  7019  							extent_offset, item);
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7020  				if (ret)
166ae5a418756d Zach Brown         2014-05-09  7021  					goto out;
c8b978188c9a0f Chris Mason        2008-10-29  7022  			} else {
58c1a35cd52268 Ira Weiny          2021-02-16  7023  				map = kmap_local_page(page);
70dec8079d7869 Chris Mason        2008-01-29  7024  				read_extent_buffer(leaf, map + pg_offset, ptr,
179e29e488cc74 Chris Mason        2007-11-01  7025  						   copy_size);
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  7026  				if (pg_offset + copy_size < PAGE_SIZE) {
93c82d575055f1 Chris Mason        2009-09-11  7027  					memset(map + pg_offset + copy_size, 0,
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  7028  					       PAGE_SIZE - pg_offset -
93c82d575055f1 Chris Mason        2009-09-11  7029  					       copy_size);
93c82d575055f1 Chris Mason        2009-09-11  7030  				}
58c1a35cd52268 Ira Weiny          2021-02-16  7031  				kunmap_local(map);
c8b978188c9a0f Chris Mason        2008-10-29  7032  			}
50b78c24d594e6 Chris Mason        2007-09-20  7033  			flush_dcache_page(page);
179e29e488cc74 Chris Mason        2007-11-01  7034  		}
a52d9a8033c454 Chris Mason        2007-08-27  7035  		goto insert;
a52d9a8033c454 Chris Mason        2007-08-27  7036  	}
a52d9a8033c454 Chris Mason        2007-08-27  7037  not_found:
a52d9a8033c454 Chris Mason        2007-08-27  7038  	em->start = start;
70c8a91ce21b83 Josef Bacik        2012-10-11  7039  	em->orig_start = start;
d1310b2e0cd98e Chris Mason        2008-01-24  7040  	em->len = len;
5f39d397dfbe14 Chris Mason        2007-10-15  7041  	em->block_start = EXTENT_MAP_HOLE;
a52d9a8033c454 Chris Mason        2007-08-27  7042  insert:
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7043  	ret = 0;
b3b4aa74b58bde David Sterba       2011-04-21  7044  	btrfs_release_path(path);
d1310b2e0cd98e Chris Mason        2008-01-24  7045  	if (em->start > start || extent_map_end(em) <= start) {
0b246afa62b0cf Jeff Mahoney       2016-06-22  7046  		btrfs_err(fs_info,
5d163e0e68ce74 Jeff Mahoney       2016-09-20  7047  			  "bad extent! em: [%llu %llu] passed [%llu %llu]",
c1c9ff7c94e83f Geert Uytterhoeven 2013-08-20  7048  			  em->start, em->len, start, len);
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7049  		ret = -EIO;
a52d9a8033c454 Chris Mason        2007-08-27  7050  		goto out;
a52d9a8033c454 Chris Mason        2007-08-27  7051  	}
d1310b2e0cd98e Chris Mason        2008-01-24  7052  
890871be854b5f Chris Mason        2009-09-02  7053  	write_lock(&em_tree->lock);
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7054  	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
890871be854b5f Chris Mason        2009-09-02  7055  	write_unlock(&em_tree->lock);
a52d9a8033c454 Chris Mason        2007-08-27  7056  out:
c64142807f5a4d Liu Bo             2018-08-23  7057  	btrfs_free_path(path);
1abe9b8a138c99 liubo              2011-03-24  7058  
fc4f21b1d8d023 Nikolay Borisov    2017-02-20  7059  	trace_btrfs_get_extent(root, inode, em);
1abe9b8a138c99 liubo              2011-03-24  7060  
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7061  	if (ret) {
a52d9a8033c454 Chris Mason        2007-08-27  7062  		free_extent_map(em);
1028d1c48b95c3 Nikolay Borisov    2020-08-03  7063  		return ERR_PTR(ret);
a52d9a8033c454 Chris Mason        2007-08-27  7064  	}
a52d9a8033c454 Chris Mason        2007-08-27  7065  	return em;
a52d9a8033c454 Chris Mason        2007-08-27  7066  }
a52d9a8033c454 Chris Mason        2007-08-27  7067  

:::::: The code at line 6872 was first introduced by commit
:::::: fc4f21b1d8d023cf0a2b1b050ae18e15dbe7068e btrfs: Make get_extent_t take btrfs_inode

:::::: TO: Nikolay Borisov <nborisov@suse.com>
:::::: CC: David Sterba <dsterba@suse.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

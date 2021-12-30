Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D90481996
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhL3FWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:22:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:3300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231228AbhL3FWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640841760; x=1672377760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+KVsdUaRTKUTFwWrgJc7th2tV0XogMeKC8uZEP+TLIw=;
  b=QX1vnrtqNsMWFZP+NgCa06Md82uGy8xCnjECdEAoXc0ZMdJKzC36dHjS
   lfsT+kXfLb7cmHDTNGD220+lWtjCKCPOlQHazFJBnWuf+52p6aq2fpFph
   /+Vf1fgSPzChdpZrBu5gR6cGz/HPnhp2i6imOVSQ+jEidGWYwlWwI9Fw3
   lK9BY4Ene6lrBbMCaBfNenCjWhvmieDLBJZmfq4rUo8iEIJ6fQGDmRI+d
   qyLfR+N8Cb9crAJeNy26CTiXl1xdAJGsas7+W5/FduAomd31/RGDqwNxd
   rC0NN2YaOQaZCsCMsFyKyV3APHbM52OEeXpQAl/2KM8N/EVzsz5qDoe47
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221614753"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="221614753"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 21:22:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="470548891"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 21:22:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2ntd-0009mt-O6; Thu, 30 Dec 2021 05:22:37 +0000
Date:   Thu, 30 Dec 2021 13:21:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 33/33] fs/btrfs/volumes.c:6893:23: warning: format
 specifies type 'unsigned long' but the argument has type 'size_t' (aka
 'unsigned int')
Message-ID: <202112301331.RT7JMows-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 30c74a8c201365178cae26d0d7aefa120c3245ab [33/33] btrfs: debug patch
config: hexagon-randconfig-r013-20211230 (https://download.01.org/0day-ci/archive/20211230/202112301331.RT7JMows-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project cd284b7ac0615afc6e0f1a30da2777e361de27a3)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/goldwynr/linux/commit/30c74a8c201365178cae26d0d7aefa120c3245ab
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 30c74a8c201365178cae26d0d7aefa120c3245ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/volumes.c:6893:23: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                   ioend->io_offset, ioend->io_size);
                                                     ^~~~~~~~~~~~~~
   include/linux/printk.h:523:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/btrfs/volumes.c:6904:24: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                           ioend->io_offset, ioend->io_size);
                                                             ^~~~~~~~~~~~~~
   include/linux/printk.h:523:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/btrfs/volumes.c:6910:24: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                           ioend->io_offset, ioend->io_size);
                                                             ^~~~~~~~~~~~~~
   include/linux/printk.h:523:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   fs/btrfs/volumes.c:6941:23: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                   ioend->io_offset, ioend->io_size);
                                                     ^~~~~~~~~~~~~~
   include/linux/printk.h:523:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:450:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:422:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   4 warnings generated.


vim +6893 fs/btrfs/volumes.c

  6878	
  6879	blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
  6880				   int mirror_num)
  6881	{
  6882		const u64 orig_logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
  6883		const unsigned int orig_length = bio->bi_iter.bi_size;
  6884		const enum btrfs_map_op op = btrfs_op(bio);
  6885		u64 cur_logical = orig_logical;
  6886		int ret;
  6887		struct iomap_ioend *ioend = bio->bi_private;
  6888	
  6889		if (ioend)
  6890			pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
  6891					__func__, __LINE__,
  6892					(unsigned long)ioend, ioend->io_inode->i_ino,
> 6893					ioend->io_offset, ioend->io_size);
  6894	
  6895		while (cur_logical < orig_logical + orig_length) {
  6896			u64 map_length = orig_logical + orig_length - cur_logical;
  6897			struct btrfs_io_context *bioc = NULL;
  6898			struct bio *cur_bio;
  6899	
  6900			if (ioend)
  6901				pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
  6902						__func__, __LINE__,
  6903						(unsigned long)ioend, ioend->io_inode->i_ino,
  6904						ioend->io_offset, ioend->io_size);
  6905			btrfs_bio_save_iter(btrfs_bio(bio));
  6906			if (ioend)
  6907				pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
  6908						__func__, __LINE__,
  6909						(unsigned long)ioend, ioend->io_inode->i_ino,
  6910						ioend->io_offset, ioend->io_size);
  6911			ret = __btrfs_map_block(fs_info, op, cur_logical, &map_length,
  6912						&bioc, mirror_num, 1);
  6913			if (ret)
  6914				return errno_to_blk_status(ret);
  6915	
  6916			if (cur_logical + map_length < orig_logical + orig_length) {
  6917				/*
  6918				 * For now zoned write should never cross stripe
  6919				 * boundary
  6920				 */
  6921				ASSERT(bio_op(bio) != REQ_OP_ZONE_APPEND);
  6922	
  6923				/* Split the bio */
  6924				cur_bio = btrfs_bio_split(fs_info, bio, map_length);
  6925			} else {
  6926				/* Use the existing bio directly */
  6927				cur_bio = bio;
  6928			}
  6929			btrfs_bio_counter_inc_blocked(fs_info);
  6930			ret = submit_one_mapped_range(fs_info, cur_bio, bioc,
  6931						      map_length, mirror_num);
  6932			btrfs_bio_counter_dec(fs_info);
  6933			if (ret < 0)
  6934				return errno_to_blk_status(ret);
  6935			cur_logical += map_length;
  6936		}
  6937		if (ioend)
  6938			pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
  6939					__func__, __LINE__,
  6940					(unsigned long)ioend, ioend->io_inode->i_ino,
  6941					ioend->io_offset, ioend->io_size);
  6942		return BLK_STS_OK;
  6943	}
  6944	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

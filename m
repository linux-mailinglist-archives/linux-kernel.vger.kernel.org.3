Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31301481982
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhL3FLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:11:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:35537 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhL3FLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640841100; x=1672377100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jGrukeZg0EnufbaBzokUAOG2AsNay8I/4mG6rT6SVeg=;
  b=K3YXWz8uExwg+fh7ehDryyd7mjFCpR7pyIkDBLlIv8TCoi9/2ss7Pv2f
   H2rt5ObseKJoG+6NJajM8swpEcb6aQd1F4VtNYLAm79D3t70Y2W3fK06w
   DejREXULHbmwAmQxbdLzMV5Df7e9g+LpKIcMHDoVTEQ+UR5j0/z89xEW1
   Pq92VTmhhUsnIFk8gBGMmGaGU0raHiHfqwLCGrXTiLUxe7eA7L6b1wdE+
   fb5HSdpCXicX5+TFSkbRuPIgB72SibstlDzYI7UatIf6JLTpxvFlxSixp
   sXr8jawmmrjaIXihszu2oan+q5P67Z7QMmtTqlnA4xGgEFWoAzC7Cesro
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241827313"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241827313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 21:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="619270892"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2021 21:11:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2niz-0009mn-Mz; Thu, 30 Dec 2021 05:11:37 +0000
Date:   Thu, 30 Dec 2021 13:11:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 23/33] fs/btrfs/file.c:1704:29: error: 'bi'
 redeclared as different kind of symbol
Message-ID: <202112301347.2emBGOuh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 31240db6a699e846f0d73f27d4b32d0e95bb08dc [23/33] btrfs: Set extents delalloc in iomap_end
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20211230/202112301347.2emBGOuh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/goldwynr/linux/commit/31240db6a699e846f0d73f27d4b32d0e95bb08dc
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 31240db6a699e846f0d73f27d4b32d0e95bb08dc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the goldwynr/iomap HEAD 30c74a8c201365178cae26d0d7aefa120c3245ab builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   fs/btrfs/file.c: In function 'btrfs_buffered_iomap_end':
>> fs/btrfs/file.c:1704:29: error: 'bi' redeclared as different kind of symbol
    1704 |         struct btrfs_iomap *bi = iomap->private;
         |                             ^~
   fs/btrfs/file.c:1701:69: note: previous definition of 'bi' with type 'struct btrfs_iomap *'
    1701 |                 loff_t length, ssize_t written, struct btrfs_iomap *bi)
         |                                                 ~~~~~~~~~~~~~~~~~~~~^~
>> fs/btrfs/file.c:1704:34: error: 'iomap' undeclared (first use in this function)
    1704 |         struct btrfs_iomap *bi = iomap->private;
         |                                  ^~~~~
   fs/btrfs/file.c:1704:34: note: each undeclared identifier is reported only once for each function it appears in


vim +/bi +1704 fs/btrfs/file.c

  1699	
  1700	static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
  1701			loff_t length, ssize_t written, struct btrfs_iomap *bi)
  1702	{
  1703		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> 1704		struct btrfs_iomap *bi = iomap->private;
  1705		int ret = 0;
  1706		size_t release_bytes = 0;
  1707		u64 start = round_down(pos, fs_info->sectorsize);
  1708		u64 written_block_end = round_up(pos + written, fs_info->sectorsize) - 1;
  1709		u64 block_end = round_up(pos + length, fs_info->sectorsize) - 1;
  1710	
  1711	        int extra_bits = 0;
  1712	
  1713	        if (written == 0) {
  1714	                release_bytes = bi->reserved_bytes;
  1715	        } else if (written < length) {
  1716	                release_bytes = block_end - written_block_end + 1;
  1717	        }
  1718	
  1719	        if (bi->metadata_only)
  1720	                extra_bits |= EXTENT_NORESERVE;
  1721	
  1722	        clear_extent_bit(&BTRFS_I(inode)->io_tree, start, written_block_end,
  1723	                         EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
  1724	                         0, 0, &bi->cached_state);
  1725	
  1726	        ret = btrfs_set_extent_delalloc(BTRFS_I(inode), start,
  1727	                        written_block_end, extra_bits, &bi->cached_state);
  1728	
  1729	        /* In case of error, release everything in btrfs_iomap_release() */
  1730	        if (ret < 0)
  1731	                release_bytes = bi->reserved_bytes;
  1732	
  1733		/*
  1734		 * If we have not locked the extent range, because the range's
  1735		 * start offset is >= i_size, we might still have a non-NULL
  1736		 * cached extent state, acquired while marking the extent range
  1737		 * as delalloc. Therefore free any possible cached extent state
  1738		 * to avoid a memory leak.
  1739		 */
  1740		if (bi->extents_locked)
  1741			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
  1742					bi->lockstart, bi->lockend,
  1743					&bi->cached_state);
  1744		else
  1745			free_extent_state(bi->cached_state);
  1746	
  1747		btrfs_delalloc_release_extents(BTRFS_I(inode), bi->reserved_bytes);
  1748		if (bi->metadata_only)
  1749			btrfs_check_nocow_unlock(BTRFS_I(inode));
  1750	
  1751		btrfs_iomap_release(inode, pos, release_bytes, bi);
  1752	
  1753		return 0;
  1754	}
  1755	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

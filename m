Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0746F3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhLIT0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:26:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:23127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhLIT0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639077759; x=1670613759;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PQnj/CU33YRqXMRNvSTFjqzE2Qeg7Bq4XI2Tm5xfpIQ=;
  b=kp5L99QiaR7xynGlf1QdZw/jRwRJ6wdVbGPFhOFSlxvn68hVCTfOYn1P
   S9YkLNq9d9CksC39JeW5+vtHy1BnWUJx6ZbbvUPrGQWndRhkjEFLTF4YD
   CoZIZUk/6jHMwq5XNL30hA50Ob4JVDdUE9h2GyM1b4gKP+oTT9n3vta5U
   6xJCTprcrPbFMewQHFsKFmjWhpU8TIm/IR0tr/VyupKkBMUBIgrfKLYjj
   Np+L+NJiwA28bSwfEgP7D6xEduysTbwOu1zAly4UPWbmewgOyrablECZo
   4w44QbjqE5CGqIEyOcqQ/e5z5DWCeiPym+8hr069KbLKhMyzHIqrEaUjD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235702085"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="235702085"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="612639591"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2021 11:22:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvP00-0002IC-As; Thu, 09 Dec 2021 19:22:36 +0000
Date:   Fri, 10 Dec 2021 03:22:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: fs/buffer.c:2342:1: warning: the frame size of 2072 bytes is larger
 than 1024 bytes
Message-ID: <202112100307.ewo3JMUl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a987e65025e2b79c6d453b78cb5985ac6e5eb26
commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
date:   10 months ago
config: powerpc-randconfig-r036-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100307.ewo3JMUl-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4eeef098b43242ed145c83fba9989d586d707589
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4eeef098b43242ed145c83fba9989d586d707589
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/buffer.c: In function 'block_read_full_page':
>> fs/buffer.c:2342:1: warning: the frame size of 2072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2342 | }
         | ^
--
   fs/ext4/move_extent.c: In function 'mext_page_mkuptodate':
>> fs/ext4/move_extent.c:227:1: warning: the frame size of 2072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^
--
   fs/fat/dir.c: In function 'fat_add_new_entries':
>> fs/fat/dir.c:1279:1: warning: the frame size of 2088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1279 | }
         | ^
   fs/fat/dir.c: In function 'fat_alloc_new_dir':
   fs/fat/dir.c:1195:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1195 | }
         | ^
--
   fs/fat/fatent.c: In function 'fat_free_clusters':
>> fs/fat/fatent.c:632:1: warning: the frame size of 2096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     632 | }
         | ^
   fs/fat/fatent.c: In function 'fat_alloc_clusters':
   fs/fat/fatent.c:550:1: warning: the frame size of 2128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     550 | }
         | ^


vim +2342 fs/buffer.c

8ab22b9abb5c55 Hisashi Hifumi     2008-07-28  2251  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2252  /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2253   * Generic "read page" function for block devices that have the normal
^1da177e4c3f41 Linus Torvalds     2005-04-16  2254   * get_block functionality. This is most of the block device filesystems.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2255   * Reads the page asynchronously --- the unlock_buffer() and
^1da177e4c3f41 Linus Torvalds     2005-04-16  2256   * set/clear_buffer_uptodate() functions propagate buffer state into the
^1da177e4c3f41 Linus Torvalds     2005-04-16  2257   * page struct once IO has completed.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2258   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2259  int block_read_full_page(struct page *page, get_block_t *get_block)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2260  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2261  	struct inode *inode = page->mapping->host;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2262  	sector_t iblock, lblock;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2263  	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
45bce8f3e3436b Linus Torvalds     2012-11-29  2264  	unsigned int blocksize, bbits;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2265  	int nr, i;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2266  	int fully_mapped = 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2267  
45bce8f3e3436b Linus Torvalds     2012-11-29  2268  	head = create_page_buffers(page, inode, 0);
45bce8f3e3436b Linus Torvalds     2012-11-29  2269  	blocksize = head->b_size;
45bce8f3e3436b Linus Torvalds     2012-11-29  2270  	bbits = block_size_bits(blocksize);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2271  
09cbfeaf1a5a67 Kirill A. Shutemov 2016-04-01  2272  	iblock = (sector_t)page->index << (PAGE_SHIFT - bbits);
45bce8f3e3436b Linus Torvalds     2012-11-29  2273  	lblock = (i_size_read(inode)+blocksize-1) >> bbits;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2274  	bh = head;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2275  	nr = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2276  	i = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2277  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2278  	do {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2279  		if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2280  			continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2281  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2282  		if (!buffer_mapped(bh)) {
c64610ba585fab Andrew Morton      2005-05-16  2283  			int err = 0;
c64610ba585fab Andrew Morton      2005-05-16  2284  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2285  			fully_mapped = 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2286  			if (iblock < lblock) {
b0cf2321c65991 Badari Pulavarty   2006-03-26  2287  				WARN_ON(bh->b_size != blocksize);
c64610ba585fab Andrew Morton      2005-05-16  2288  				err = get_block(inode, iblock, bh, 0);
c64610ba585fab Andrew Morton      2005-05-16  2289  				if (err)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2290  					SetPageError(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2291  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2292  			if (!buffer_mapped(bh)) {
eebd2aa355692a Christoph Lameter  2008-02-04  2293  				zero_user(page, i * blocksize, blocksize);
c64610ba585fab Andrew Morton      2005-05-16  2294  				if (!err)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2295  					set_buffer_uptodate(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2296  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2297  			}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2298  			/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2299  			 * get_block() might have updated the buffer
^1da177e4c3f41 Linus Torvalds     2005-04-16  2300  			 * synchronously
^1da177e4c3f41 Linus Torvalds     2005-04-16  2301  			 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2302  			if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2303  				continue;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2304  		}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2305  		arr[nr++] = bh;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2306  	} while (i++, iblock++, (bh = bh->b_this_page) != head);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2307  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2308  	if (fully_mapped)
^1da177e4c3f41 Linus Torvalds     2005-04-16  2309  		SetPageMappedToDisk(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2310  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2311  	if (!nr) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2312  		/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2313  		 * All buffers are uptodate - we can set the page uptodate
^1da177e4c3f41 Linus Torvalds     2005-04-16  2314  		 * as well. But not if get_block() returned an error.
^1da177e4c3f41 Linus Torvalds     2005-04-16  2315  		 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2316  		if (!PageError(page))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2317  			SetPageUptodate(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2318  		unlock_page(page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2319  		return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  2320  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2321  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2322  	/* Stage two: lock the buffers */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2323  	for (i = 0; i < nr; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2324  		bh = arr[i];
^1da177e4c3f41 Linus Torvalds     2005-04-16  2325  		lock_buffer(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2326  		mark_buffer_async_read(bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2327  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2328  
^1da177e4c3f41 Linus Torvalds     2005-04-16  2329  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  2330  	 * Stage 3: start the IO.  Check for uptodateness
^1da177e4c3f41 Linus Torvalds     2005-04-16  2331  	 * inside the buffer lock in case another process reading
^1da177e4c3f41 Linus Torvalds     2005-04-16  2332  	 * the underlying blockdev brought it uptodate (the sct fix).
^1da177e4c3f41 Linus Torvalds     2005-04-16  2333  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  2334  	for (i = 0; i < nr; i++) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  2335  		bh = arr[i];
^1da177e4c3f41 Linus Torvalds     2005-04-16  2336  		if (buffer_uptodate(bh))
^1da177e4c3f41 Linus Torvalds     2005-04-16  2337  			end_buffer_async_read(bh, 1);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2338  		else
2a222ca992c35a Mike Christie      2016-06-05  2339  			submit_bh(REQ_OP_READ, 0, bh);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2340  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  2341  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16 @2342  }
1fe72eaa0f46a0 H Hartley Sweeten  2009-09-22  2343  EXPORT_SYMBOL(block_read_full_page);
^1da177e4c3f41 Linus Torvalds     2005-04-16  2344  

:::::: The code at line 2342 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

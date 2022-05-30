Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B45388C1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiE3WAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiE3WAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:00:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821116A02B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653948043; x=1685484043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eJxDx1vwuEGTpVEdTNxWSE4/uP//E3MtAqu8k6ILZdc=;
  b=f4hDChVo2JZhiUGNAtjAxBJqZhLopqAJ3dzyvszHZwQFSwgXVn01RiVy
   uqsOo0uA7ZiH/iROSqY0eC+rTFGwr+K4WMC6WtfNSviUXxN8EkvlF5oph
   d9p+piIk5jepLfZl2nTLG8eBJs7AnESR5McN0m95h/01tAWtqLpfo7wpl
   txGC8cYi/p5QR+4n2IB4kjD3dzbliKyhKjL0AUn7lemkZYZIWNbjDzCZY
   KNPh4QZNY6POxLfjR5Lz+PbM8Ny68hZ1/flYpZih6tudcFRsaaRohTg+h
   SxuoNw0SXxwNrfXCVcpdF5BwK563DRnWqhe3pX2zK26mKIVrzE7KL+DB7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="338123244"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="338123244"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 15:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="720043217"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2022 15:00:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvnRH-00021S-UZ;
        Mon, 30 May 2022 22:00:39 +0000
Date:   Tue, 31 May 2022 05:59:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 32/41]
 fs/cifs/fscache.c:112:67: warning: passing argument 2 of 'bset_mem_set_bit'
 makes pointer from integer without a cast
Message-ID: <202205310513.yMZQa9N6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-netfs
head:   1fc71b6b30f6d2a981c163b77c9aee0aecaecb29
commit: ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938 [32/41] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220531/202205310513.yMZQa9N6-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swap.h:5,
                    from fs/cifs/fscache.h:12,
                    from fs/cifs/fscache.c:9:
   fs/cifs/fscache.c: In function 'cifs_fscache_get_inode_cookie':
>> fs/cifs/fscache.c:112:67: warning: passing argument 2 of 'bset_mem_set_bit' makes pointer from integer without a cast [-Wint-conversion]
     112 |                 set_bit(AS_NOTIFY_REMOVING_FOLIO, inode->i_mapping->flags);
         |                                                   ~~~~~~~~~~~~~~~~^~~~~~~
         |                                                                   |
         |                                                                   long unsigned int
   arch/m68k/include/asm/bitops.h:64:54: note: in definition of macro 'set_bit'
      64 |                                 bset_mem_set_bit(nr, vaddr) : \
         |                                                      ^~~~~
   arch/m68k/include/asm/bitops.h:41:69: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      41 | static inline void bset_mem_set_bit(int nr, volatile unsigned long *vaddr)
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
>> fs/cifs/fscache.c:112:67: warning: passing argument 2 of 'bfset_mem_set_bit' makes pointer from integer without a cast [-Wint-conversion]
     112 |                 set_bit(AS_NOTIFY_REMOVING_FOLIO, inode->i_mapping->flags);
         |                                                   ~~~~~~~~~~~~~~~~^~~~~~~
         |                                                                   |
         |                                                                   long unsigned int
   arch/m68k/include/asm/bitops.h:65:55: note: in definition of macro 'set_bit'
      65 |                                 bfset_mem_set_bit(nr, vaddr))
         |                                                       ^~~~~
   arch/m68k/include/asm/bitops.h:50:70: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      50 | static inline void bfset_mem_set_bit(int nr, volatile unsigned long *vaddr)
         |                                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~


vim +/bset_mem_set_bit +112 fs/cifs/fscache.c

    96	
    97	void cifs_fscache_get_inode_cookie(struct inode *inode)
    98	{
    99		struct cifs_fscache_inode_coherency_data cd;
   100		struct cifsInodeInfo *cifsi = CIFS_I(inode);
   101		struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
   102		struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
   103	
   104		cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
   105	
   106		cifsi->netfs_ctx.cache =
   107			fscache_acquire_cookie(tcon->fscache, 0,
   108					       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
   109					       &cd, sizeof(cd),
   110					       i_size_read(&cifsi->vfs_inode));
   111		if (cifsi->netfs_ctx.cache)
 > 112			set_bit(AS_NOTIFY_REMOVING_FOLIO, inode->i_mapping->flags);
   113	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

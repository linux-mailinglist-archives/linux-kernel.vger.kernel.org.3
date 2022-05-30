Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3849E5387BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiE3T2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiE3T2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:28:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8431F38195
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653938909; x=1685474909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8XMYMZ7+BX06AsIT2PFyLa787Inwiq9IjxvwhHoFuGs=;
  b=TrYrWcfmY/DtkRCXLbzinQHFnCXXnvgVL7+GJf6BJCY+A3y2FRbjCxrS
   pO22jH5uzB5xQe/emJYYQAyDmpE91KKQzmHPG8SQGZ4ekYMs+sh2Uv8wC
   FciALkxQFoE/r4rcFZFDZAEIcbrSvhwxZ4OQilbK5tVdCwV4mdWTCj2jR
   dtDQLsDh2m5YPNajuzEFP23hoOul5Z5GfaLLMn2yy3qTIntgbClA2qkZX
   Pct1Ge13+RXW9GokxhBGCdYVfh1tKcHiUy3DYEMXIA3P/P4aYMVvfFGM2
   PC5Qds1Vhq9art3aYJx0TBnUzakymi42l9MIx3ceEh+pODd/KPHDJwmH4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="272639800"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="272639800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 12:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="706262521"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 12:28:27 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvl3y-0001wE-R5;
        Mon, 30 May 2022 19:28:26 +0000
Date:   Tue, 31 May 2022 03:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 32/41]
 fs/cifs/fscache.c:112:67: warning: passing argument 2 of 'set_bit' makes
 pointer from integer without a cast
Message-ID: <202205310312.AaPxpbbh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: powerpc64-randconfig-r003-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310312.AaPxpbbh-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/cifs/fscache.c: In function 'cifs_fscache_get_inode_cookie':
>> fs/cifs/fscache.c:112:67: warning: passing argument 2 of 'set_bit' makes pointer from integer without a cast [-Wint-conversion]
     112 |                 set_bit(AS_NOTIFY_REMOVING_FOLIO, inode->i_mapping->flags);
         |                                                   ~~~~~~~~~~~~~~~~^~~~~~~
         |                                                                   |
         |                                                                   long unsigned int
   In file included from arch/powerpc/include/asm/bitops.h:332,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:22,
                    from arch/powerpc/include/asm/page.h:11,
                    from arch/powerpc/include/asm/mmu.h:149,
                    from arch/powerpc/include/asm/paca.h:18,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swap.h:5,
                    from fs/cifs/fscache.h:12,
                    from fs/cifs/fscache.c:9:
   include/asm-generic/bitops/instrumented-atomic.h:26:70: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      26 | static __always_inline void set_bit(long nr, volatile unsigned long *addr)
         |                                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/set_bit +112 fs/cifs/fscache.c

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

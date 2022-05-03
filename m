Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7F517B87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiECBNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiECBNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:13:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82C4F9F3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651540209; x=1683076209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qln1eOE7PtXZLf4DXtjUFRxKja508JnuDh98umy/EyE=;
  b=MQOSovXN//ZZvc60zGDM2aCv0MGEf5K69zUb+cU4BBN4qrsvgvqk7AXD
   ZQ7Smgy2zs+w+o17ZkdtyJ0lVv50lf2iFwivTqgeOP6nULESdCQ2fry1K
   znutvgLmb+toumVCos8s0tn/h+fzBmMSpV6Vcu0mCrVrZZQUhLERyiwS4
   W81gJOMmKWnlgyU5TD7k5zr0vIu6VMmgd3NJaIAb+dFOhgZNDsT2YWv/q
   q/8dWK9LVSQMv3zflf1brmX9BrkeJFQQkQ7c+Cnz9d9QD5xYaa5VKjoCA
   bsuytDZ2emK06rJ1LDLjlVeLtAHHnGyEUR5GM/sw81XgpS2aEvAvVoSgu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="249350482"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="249350482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 18:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="631315663"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2022 18:06:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlgzQ-000A1v-L1;
        Tue, 03 May 2022 01:06:08 +0000
Date:   Tue, 3 May 2022 09:05:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>
Subject: [samba-ksmbd:for-next 26/26] fs/cifs/fscache.c:112:67: warning:
 passing argument 2 of 'bset_mem_set_bit' makes pointer from integer without
 a cast
Message-ID: <202205030951.b4tycp85-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   422ce10d22e2de32427ff611478747dd27af50f8
commit: 422ce10d22e2de32427ff611478747dd27af50f8 [26/26] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205030951.b4tycp85-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd for-next
        git checkout 422ce10d22e2de32427ff611478747dd27af50f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
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

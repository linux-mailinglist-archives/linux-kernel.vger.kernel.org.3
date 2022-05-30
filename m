Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2D53884E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiE3Utn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiE3Utj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:49:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B47A468
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653943778; x=1685479778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLgUrwmBvYJzRs/dmjYgtmUxC/OOMG1qe2Oil/gEllQ=;
  b=mfnMuW8JOptCO1Vwg/7pFk0G8KLDvFdEMIKu1fro3q/V4k4IKHBUgii+
   e322eitsNnmpHoDw4yBPZi3/oIoquOaGHda/Zmik/RBLx8M4AJC11w4JB
   MImZm+HDhv9sN94nzwBIGoS5i7L9YZNk2RxZLU5xhvWqtmjcoh1+2QxH4
   QMiVk7VuUIXQZ17Qe8lQcUAjmRaddCXZpCN1zm4i5inrMIQBnwUCAXUkA
   pjBzk8DK0aSuvuu+3bjqZCuiIAiEsCBEQuWEMaqFwpBmDsn0/+egxBkkn
   HfDjzPQX2KlKfvloOoe+6tpIIzc6/6xEiB1tKatqH1uA5s3oJuAPffZKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255561770"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="255561770"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 13:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="611553038"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2022 13:49:36 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvmKV-0001yy-PD;
        Mon, 30 May 2022 20:49:35 +0000
Date:   Tue, 31 May 2022 04:48:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 32/41]
 fs/cifs/fscache.c:112:37: warning: incompatible integer to pointer
 conversion passing 'unsigned long' to parameter of type 'volatile unsigned
 long *'; take the address with &
Message-ID: <202205310411.hGi2pWAu-lkp@intel.com>
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
config: x86_64-randconfig-a015-20220530 (https://download.01.org/0day-ci/archive/20220531/202205310411.hGi2pWAu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/fscache.c:112:37: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'volatile unsigned long *'; take the address with & [-Wint-conversion]
                   set_bit(AS_NOTIFY_REMOVING_FOLIO, inode->i_mapping->flags);
                                                     ^~~~~~~~~~~~~~~~~~~~~~~
                                                     &
   include/asm-generic/bitops/instrumented-atomic.h:26:70: note: passing argument to parameter 'addr' here
   static __always_inline void set_bit(long nr, volatile unsigned long *addr)
                                                                        ^
   1 warning generated.


vim +112 fs/cifs/fscache.c

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

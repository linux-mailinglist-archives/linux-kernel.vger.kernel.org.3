Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB34E53A366
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiFALCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiFALCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:02:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295DD5B3DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654081319; x=1685617319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o27PoK76z/NIOmgfM8lrRJiw26PbClfRyIHdLDkCxZM=;
  b=Pjq/xE+Ss0h8QI3F/m2twW2AN5VCNi2cxKL7n5XnOgc1jUIuVQsfHrtQ
   uAOfJALFCNtKbbSUNMLxxAKJBgNSiRHLR3wN64U+NKzrkAvDHrFORpmKp
   moOe8H5+duO9yvTGvlwg736dJIXwvhfxA2+2y8UbdnQnagJDceugZdY0b
   ReM8XVaDfq4HV4tg5on9AoOm1A+eqrqTbHTfKYFbqlmAmnbepaUmw3fQy
   k3GuzV3EfIHv+mRIRFXBMn72iMtNK4kZxAvsbCSJhWwDmCjzoHBVK3cF3
   MPyvQDE8+9PaE/TsS/YfPFdkxtGg2TR69WwLfACajZhrlyDeMnrwwGCC1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257620042"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257620042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="755865426"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 04:01:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwM6u-0003sk-Uw;
        Wed, 01 Jun 2022 11:01:56 +0000
Date:   Wed, 1 Jun 2022 19:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-netfs 32/41]
 fs/cifs/fscache.c:112:67: sparse: sparse: incorrect type in argument 2
 (different base types)
Message-ID: <202206011851.UCwIa18w-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-netfs
head:   1fc71b6b30f6d2a981c163b77c9aee0aecaecb29
commit: ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938 [32/41] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220601/202206011851.UCwIa18w-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-netfs
        git checkout ccc1acdfa787b5bf5c9c2b3f829b18f5a0bb0938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/cifs/fscache.c:112:67: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long volatile *addr @@     got unsigned long flags @@
   fs/cifs/fscache.c:112:67: sparse:     expected unsigned long volatile *addr
   fs/cifs/fscache.c:112:67: sparse:     got unsigned long flags

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

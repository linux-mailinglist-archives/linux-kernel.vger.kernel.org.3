Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DFC52E16E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbiETAyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiETAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:54:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D76132745
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653008091; x=1684544091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5TcrrbYZiWpheXWjKoaejKwiDNI6ovzYC5nyulvvB5k=;
  b=Y4hKgtS5Pt6DRpMMU0ic8u3x+YxuxV8dvYsVdjql44gLUn4V2/mK3mVK
   KTtG7xC5HrHFSogMExNn3Aa3Eaj3HoUyvfu6aujsEKVyOg3b7frZNaYdQ
   w/bbjnyW9MXC24dA1jIaQX+8fkm/Bg1FRaDssOcaLPH2IqSLNp+OgD/Jy
   U+SVEbU4vF653c+PQgkVArna0dzWxC6DiAPtIxGVJslr4r4U3ZlrvPVa+
   X97MgEOx0YKqgKyQ/0SNJ4c95+/PA08Ahh4SNe1FhtimnYsF/KU/HJtOC
   p+QBzczuDC+QuXt6XN1bvnpCWywKS4EkoxOBywhUktPO8gfbeSVz08Awc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="270022962"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="270022962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="818277698"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 May 2022 17:54:49 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqun-000469-Ar;
        Fri, 20 May 2022 00:54:49 +0000
Date:   Fri, 20 May 2022 08:52:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/fscache-next 3/3]
 fs/cifs/fscache.c:106:14: error: 'struct cifsInodeInfo' has no member named
 'netfs_ctx'
Message-ID: <202205200841.opqqxrRq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/fscache-next
head:   a3457aa9c40f99183345cbedd7e0a7404bcc6370
commit: a3457aa9c40f99183345cbedd7e0a7404bcc6370 [3/3] netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220520/202205200841.opqqxrRq-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a3457aa9c40f99183345cbedd7e0a7404bcc6370
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/fscache-next
        git checkout a3457aa9c40f99183345cbedd7e0a7404bcc6370
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/cifs/fscache.c: In function 'cifs_fscache_get_inode_cookie':
>> fs/cifs/fscache.c:106:14: error: 'struct cifsInodeInfo' has no member named 'netfs_ctx'
     106 |         cifsi->netfs_ctx.cache =
         |              ^~
   fs/cifs/fscache.c: In function 'cifs_fscache_release_inode_cookie':
   fs/cifs/fscache.c:134:22: error: 'struct cifsInodeInfo' has no member named 'netfs_ctx'
     134 |                 cifsi->netfs_ctx.cache = NULL;
         |                      ^~


vim +106 fs/cifs/fscache.c

402cb8dda949d9 David Howells    2018-04-04   96  
70431bfd825d9c David Howells    2020-11-17   97  void cifs_fscache_get_inode_cookie(struct inode *inode)
9451a9a52f91a4 Suresh Jayaraman 2010-07-05   98  {
70431bfd825d9c David Howells    2020-11-17   99  	struct cifs_fscache_inode_coherency_data cd;
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  100  	struct cifsInodeInfo *cifsi = CIFS_I(inode);
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  101  	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
96daf2b09178d8 Steve French     2011-05-27  102  	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  103  
a3457aa9c40f99 David Howells    2022-05-19  104  	cifs_fscache_fill_coherency(&cifsi->nic.inode, &cd);
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  105  
bc899ee1c898e5 David Howells    2021-06-29 @106  	cifsi->netfs_ctx.cache =
70431bfd825d9c David Howells    2020-11-17  107  		fscache_acquire_cookie(tcon->fscache, 0,
70431bfd825d9c David Howells    2020-11-17  108  				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
70431bfd825d9c David Howells    2020-11-17  109  				       &cd, sizeof(cd),
a3457aa9c40f99 David Howells    2022-05-19  110  				       i_size_read(&cifsi->nic.inode));
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  111  }
9451a9a52f91a4 Suresh Jayaraman 2010-07-05  112  

:::::: The code at line 106 was first introduced by commit
:::::: bc899ee1c898e520574ff4d99356eb2e724a9265 netfs: Add a netfs inode context

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

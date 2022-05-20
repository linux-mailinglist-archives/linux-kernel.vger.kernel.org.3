Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745C52E0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiETAIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiETAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:08:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92895499
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653005329; x=1684541329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3oJVd2uNaGfr914y+xcrWjasG+1vP5j565ik4JIiVL4=;
  b=MVEDS8ZGWPsyRInJZPK7mKWKP8KKOpuYr2q4gNnBUu+7JxCcnwp0JbNX
   q0i/2iEWabhiqE8jP8I8gsRIsUnLyHBMxEs3ujtASu6KVJeKrbKGKsmjc
   c4QwVbRn6XwqGXHT4g3vwmMsc4zoX3qkq3R6qSUShNZdx8/7ujGE/hfot
   3CMoptAoreLbrMyiVEAQoiazwyjG2BfrsuDYYohzN6nk2Esr8F0QNmGvp
   mrwIfTNM6UUHDpcMEt/tH9ynIEHaIuSIrFLggTkLKdUBRzFq9dJdg1UoK
   eGee5vwNuT4h+0MayUabAuj5pL1H1KvQ6wYM84DY6hBEPMdhXWGeMcgwV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272554777"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272554777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="674331932"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2022 17:08:47 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqCE-00044P-Mr;
        Fri, 20 May 2022 00:08:46 +0000
Date:   Fri, 20 May 2022 08:08:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [ammarfaizi2-block:dhowells/linux-fs/fscache-next 3/3]
 fs/cifs/fscache.c:106:9: error: no member named 'netfs_ctx' in 'struct
 cifsInodeInfo'
Message-ID: <202205200739.HeIDHcBH-lkp@intel.com>
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
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220520/202205200739.HeIDHcBH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a3457aa9c40f99183345cbedd7e0a7404bcc6370
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/fscache-next
        git checkout a3457aa9c40f99183345cbedd7e0a7404bcc6370
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/cifs/fscache.c:106:9: error: no member named 'netfs_ctx' in 'struct cifsInodeInfo'
           cifsi->netfs_ctx.cache =
           ~~~~~  ^
   fs/cifs/fscache.c:134:10: error: no member named 'netfs_ctx' in 'struct cifsInodeInfo'
                   cifsi->netfs_ctx.cache = NULL;
                   ~~~~~  ^
   2 errors generated.


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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB456755E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiGERQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGERQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:16:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480BE1CFD0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657041409; x=1688577409;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N5EAGOIV38F3hPe9Tl1vtXqVF7c9ctDvAT7wD3vMM6A=;
  b=YcoYlvllb4Zx7VWhlrb7PKKazjOFH0tGH3m2euZz5eX8X/bsCCXY3jc6
   09VOZ3ae7tA8MijG55m8OFgZuchZt9Q63bqpoN32kZw2oQ1GqphQxb9rR
   futCdr+IexRb4hakY3xE1q1S9ZHva+ZiKcaUATY5uHVw9OADn80DSkmCY
   rtaaiuKVNokzb1CO4gdSXxhqAvJz86TdFB1g1jIdrEsqciPxPlzmrGqZl
   IBvNGgJCrUfQWykdQzQzsn9yl2E4hh8FGgWruSS/TI7HFlw5+rBRtYtBS
   AhkzYVZvJ9UEolNOL+EifwdGpWoe7tUVHfz0VFvOsjvC2tVwRqjxMLsT/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345092170"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="345092170"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="619919100"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2022 10:16:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8mAI-000JPh-PU;
        Tue, 05 Jul 2022 17:16:46 +0000
Date:   Wed, 6 Jul 2022 01:16:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.idmapped.overlay.acl.fix 1/1]
 fs/overlayfs/overlayfs.h:273:65: warning: passing argument 4 of
 'ovl_do_setxattr' discards 'const' qualifier from pointer target type
Message-ID: <202207060143.q3Vlzyev-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block brauner/linux/fs.idmapped.overlay.acl.fix
head:   05bde3ad56201ff691db6d95ea1316983ea82a9c
commit: 05bde3ad56201ff691db6d95ea1316983ea82a9c [1/1] acl: report correct ownership in some ovl use-cases
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060143.q3Vlzyev-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/05bde3ad56201ff691db6d95ea1316983ea82a9c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.idmapped.overlay.acl.fix
        git checkout 05bde3ad56201ff691db6d95ea1316983ea82a9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/overlayfs/super.c:18:
   fs/overlayfs/overlayfs.h: In function 'ovl_setxattr':
>> fs/overlayfs/overlayfs.h:273:65: warning: passing argument 4 of 'ovl_do_setxattr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     273 |         return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
         |                                                                 ^~~~~
   fs/overlayfs/overlayfs.h:259:59: note: expected 'void *' but argument is of type 'const void *'
     259 |                                   const char *name, void *value,
         |                                                     ~~~~~~^~~~~
--
   In file included from fs/overlayfs/inode.c:17:
   fs/overlayfs/overlayfs.h: In function 'ovl_setxattr':
>> fs/overlayfs/overlayfs.h:273:65: warning: passing argument 4 of 'ovl_do_setxattr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     273 |         return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
         |                                                                 ^~~~~
   fs/overlayfs/overlayfs.h:259:59: note: expected 'void *' but argument is of type 'const void *'
     259 |                                   const char *name, void *value,
         |                                                     ~~~~~~^~~~~
   fs/overlayfs/inode.c: In function 'ovl_xattr_set':
>> fs/overlayfs/inode.c:378:62: warning: passing argument 4 of 'ovl_do_setxattr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     378 |                 err = ovl_do_setxattr(ofs, realdentry, name, value, size,
         |                                                              ^~~~~
   In file included from fs/overlayfs/inode.c:17:
   fs/overlayfs/overlayfs.h:259:59: note: expected 'void *' but argument is of type 'const void *'
     259 |                                   const char *name, void *value,
         |                                                     ~~~~~~^~~~~


vim +273 fs/overlayfs/overlayfs.h

c914c0e27eb084 Amir Goldstein 2022-04-04  268  
c914c0e27eb084 Amir Goldstein 2022-04-04  269  static inline int ovl_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
43d193f8440d67 Miklos Szeredi 2020-09-02  270  			       enum ovl_xattr ox, const void *value,
610afc0bd40882 Miklos Szeredi 2020-09-02  271  			       size_t size)
e9be9d5e76e348 Miklos Szeredi 2014-10-24  272  {
c914c0e27eb084 Amir Goldstein 2022-04-04 @273  	return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
e9be9d5e76e348 Miklos Szeredi 2014-10-24  274  }
e9be9d5e76e348 Miklos Szeredi 2014-10-24  275  

:::::: The code at line 273 was first introduced by commit
:::::: c914c0e27eb0843b7cf3bec71d6f34d53a3a671e ovl: use wrappers to all vfs_*xattr() calls

:::::: TO: Amir Goldstein <amir73il@gmail.com>
:::::: CC: Miklos Szeredi <mszeredi@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

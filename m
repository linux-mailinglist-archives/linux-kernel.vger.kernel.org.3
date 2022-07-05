Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAC567941
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiGEVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGEVU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:20:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD414037
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657056057; x=1688592057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LVhKHJvcsZpVg+D2u16dBUS36NkgznVx6ZyI9MaJq6c=;
  b=VAXqHz2cH1gk66hO95UuN/YqRc5KkyKVbbx8QZlueykQFXvplBLzSeca
   Qbe5+j2+IrYCgrCuubBxkrTxwsDdZZO0xmSDPXON3ODKVwpAGf7BwwiuQ
   CGvAj7LMkvuhkl2vpDzTGmdqtINMvIbSeF+9treHQh2KNcPvNsRDtycpm
   6DSF9vpHhMZk+58um7MNasJikmVWDs++wVduWRIgYg+s3vL0ihvs0GMqv
   d0vtANmNFu0lh9H/pdEtcY/nS+zy/1V5YE0WOWK2U+yz83VcxjpLquuTw
   szE4tKVwiqouFigAVHghIlPYz3OHIW409KtUE0KPTuZXNI3dJljr2V2jG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282266816"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282266816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 14:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="919876568"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 14:20:55 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8pyZ-000JaV-63;
        Tue, 05 Jul 2022 21:20:55 +0000
Date:   Wed, 6 Jul 2022 05:20:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.idmapped.overlay.acl.fix 1/1]
 fs/overlayfs/overlayfs.h:273:65: warning: passing argument 4 of
 'ovl_do_setxattr' discards 'const' qualifier from pointer target type
Message-ID: <202207060501.jrxLX8Kn-lkp@intel.com>
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
head:   b74b8feea72cd6eda1f0b673de658db30ca15e7a
commit: b74b8feea72cd6eda1f0b673de658db30ca15e7a [1/1] acl: report correct ownership in some ovl use-cases
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220706/202207060501.jrxLX8Kn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/b74b8feea72cd6eda1f0b673de658db30ca15e7a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.idmapped.overlay.acl.fix
        git checkout b74b8feea72cd6eda1f0b673de658db30ca15e7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/overlayfs/dir.c:17:
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

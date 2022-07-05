Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93856752D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiGERHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiGERHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:07:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37571C911
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657040829; x=1688576829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BcNobYgcJ8hrerWlwpr0trD3hV3HIbQTtEEdQGBF4Jk=;
  b=OIKllflDZ/icNmVeX4M0yTdcV/8r/UpZVLyY572p01PCD/0clc0qSt++
   ojDlRBjxIrtMcNBvHoibZHiptuwbMXgfuQl9g7cLNkYBmENiLQj8SbFMm
   EPy7kgegEVTk3vJ6xCG5EeFtVjJZriCYV9qyuLLHi9+Ofi1KrBczz3OgM
   Y0Vqz2RUVDGjQdqVL/GFkowoXKRpoROzLD38m71mfyYfVqq2hG82I4/wt
   Bp8G78o6hSNoA0gG0oikmS+iZVPNoR1Ion8TaiOLGL7LjTWjuamMqjHei
   SMOaDF4B482GLWv60Xod+uJqa7IwHBXTIhUEoZdfexYXhTBmRugw1+pJQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="308948697"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="308948697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="719799246"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jul 2022 10:06:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8m0c-000JP4-AY;
        Tue, 05 Jul 2022 17:06:46 +0000
Date:   Wed, 6 Jul 2022 01:06:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.idmapped.overlay.acl.fix 1/1]
 fs/overlayfs/overlayfs.h:273:58: error: passing 'const void *' to parameter
 of type 'void *' discards qualifiers
Message-ID: <202207060052.GNVFHePq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block brauner/linux/fs.idmapped.overlay.acl.fix
head:   05bde3ad56201ff691db6d95ea1316983ea82a9c
commit: 05bde3ad56201ff691db6d95ea1316983ea82a9c [1/1] acl: report correct ownership in some ovl use-cases
config: hexagon-randconfig-r045-20220703 (https://download.01.org/0day-ci/archive/20220706/202207060052.GNVFHePq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 142aca7741d5b06207e87bf4880fbe308c8d6823)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/05bde3ad56201ff691db6d95ea1316983ea82a9c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.idmapped.overlay.acl.fix
        git checkout 05bde3ad56201ff691db6d95ea1316983ea82a9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/overlayfs/super.c:18:
>> fs/overlayfs/overlayfs.h:273:58: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
                                                                   ^~~~~
   fs/overlayfs/overlayfs.h:259:31: note: passing argument to parameter 'value' here
                                     const char *name, void *value,
                                                             ^
   1 error generated.
--
   In file included from fs/overlayfs/inode.c:17:
>> fs/overlayfs/overlayfs.h:273:58: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
                                                                   ^~~~~
   fs/overlayfs/overlayfs.h:259:31: note: passing argument to parameter 'value' here
                                     const char *name, void *value,
                                                             ^
>> fs/overlayfs/inode.c:378:48: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   err = ovl_do_setxattr(ofs, realdentry, name, value, size,
                                                                ^~~~~
   fs/overlayfs/overlayfs.h:259:31: note: passing argument to parameter 'value' here
                                     const char *name, void *value,
                                                             ^
   2 errors generated.


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

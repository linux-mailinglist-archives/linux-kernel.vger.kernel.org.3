Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F26567631
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGESI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGESIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:08:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA81A3A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657044532; x=1688580532;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jy4z5L1AMPmQZNqgpGnOFnR1D0ToD/t+WqxkpPwMTq4=;
  b=JbIaSLhX3k4pc27Lpiefgxw9SNbGTAqZ89w4JZWuuSNSyLLbLDG8BG1Z
   z2cyOmWAnEVymRJnkkk1RnZqVcK5p5ydaOrPjciD6YgSxklX5oWPgd8s6
   Wyiyy2YJ0WFzKh+ZyJ6YAxh9rSLFVzV5JWrF5FfdScM10spmBI0f618hI
   y1FBEtmJBnHjqJVoVzhvuoFCOPAtKZoz7qV1/vak7yDeGA3iP7MJaUK4s
   ZodxnCGIxHHNBImXvKlXNYKUhAPiw3hnDWLcI5vQvW5gUtcoMVzUVMFVe
   8QKKCPa/dgPjjtx/B7JpfYFKLbZ8yWxHHlYuts8hM14twwZpTvKbptoFX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="345115843"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="345115843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="567726914"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 11:08:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8myf-000JSP-PY;
        Tue, 05 Jul 2022 18:08:49 +0000
Date:   Wed, 6 Jul 2022 02:07:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.idmapped.overlay.acl.fix 1/1]
 include/linux/posix_acl_xattr.h:55: multiple definition of
 `posix_acl_getxattr_idmapped_mnt';
 mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
Message-ID: <202207060249.m0AwQCFQ-lkp@intel.com>
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
config: microblaze-randconfig-r013-20220703 (https://download.01.org/0day-ci/archive/20220706/202207060249.m0AwQCFQ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/05bde3ad56201ff691db6d95ea1316983ea82a9c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.idmapped.overlay.acl.fix
        git checkout 05bde3ad56201ff691db6d95ea1316983ea82a9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: fs/xattr.o: in function `posix_acl_getxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_getxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
   microblaze-linux-ld: fs/xattr.o: in function `posix_acl_setxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_setxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
   microblaze-linux-ld: fs/overlayfs/super.o: in function `posix_acl_getxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_getxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
   microblaze-linux-ld: fs/overlayfs/super.o: in function `posix_acl_setxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_setxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
   microblaze-linux-ld: fs/overlayfs/dir.o: in function `posix_acl_getxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_getxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here
   microblaze-linux-ld: fs/overlayfs/dir.o: in function `posix_acl_setxattr_idmapped_mnt':
>> include/linux/posix_acl_xattr.h:55: multiple definition of `posix_acl_setxattr_idmapped_mnt'; mm/shmem.o:include/linux/posix_acl_xattr.h:55: first defined here


vim +55 include/linux/posix_acl_xattr.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  34  
2f6f0654ab6196 Eric W. Biederman 2012-02-07  35  #ifdef CONFIG_FS_POSIX_ACL
05bde3ad56201f Christian Brauner 2022-07-04  36  void posix_acl_fix_xattr_from_user(void *value, size_t size);
05bde3ad56201f Christian Brauner 2022-07-04  37  void posix_acl_fix_xattr_to_user(void *value, size_t size);
05bde3ad56201f Christian Brauner 2022-07-04  38  void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
05bde3ad56201f Christian Brauner 2022-07-04  39  				     const struct inode *inode,
e65ce2a50cf6af Christian Brauner 2021-01-21  40  				     void *value, size_t size);
05bde3ad56201f Christian Brauner 2022-07-04  41  void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
05bde3ad56201f Christian Brauner 2022-07-04  42  				     const struct inode *inode,
e65ce2a50cf6af Christian Brauner 2021-01-21  43  				     void *value, size_t size);
2f6f0654ab6196 Eric W. Biederman 2012-02-07  44  #else
05bde3ad56201f Christian Brauner 2022-07-04  45  static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
05bde3ad56201f Christian Brauner 2022-07-04  46  {
05bde3ad56201f Christian Brauner 2022-07-04  47  }
05bde3ad56201f Christian Brauner 2022-07-04  48  static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
05bde3ad56201f Christian Brauner 2022-07-04  49  {
05bde3ad56201f Christian Brauner 2022-07-04  50  }
05bde3ad56201f Christian Brauner 2022-07-04  51  void posix_acl_getxattr_idmapped_mnt(struct user_namespace *mnt_userns,
05bde3ad56201f Christian Brauner 2022-07-04  52  				     const struct inode *inode,
e65ce2a50cf6af Christian Brauner 2021-01-21  53  				     void *value, size_t size)
2f6f0654ab6196 Eric W. Biederman 2012-02-07  54  {
2f6f0654ab6196 Eric W. Biederman 2012-02-07 @55  }
05bde3ad56201f Christian Brauner 2022-07-04  56  void posix_acl_setxattr_idmapped_mnt(struct user_namespace *mnt_userns,
05bde3ad56201f Christian Brauner 2022-07-04  57  				     const struct inode *inode,
e65ce2a50cf6af Christian Brauner 2021-01-21  58  				     void *value, size_t size)
2f6f0654ab6196 Eric W. Biederman 2012-02-07  59  {
2f6f0654ab6196 Eric W. Biederman 2012-02-07  60  }
2f6f0654ab6196 Eric W. Biederman 2012-02-07  61  #endif
2f6f0654ab6196 Eric W. Biederman 2012-02-07  62  

:::::: The code at line 55 was first introduced by commit
:::::: 2f6f0654ab61961fd0f7701fe3be89ea111f0cda userns: Convert vfs posix_acl support to use kuids and kgids

:::::: TO: Eric W. Biederman <ebiederm@xmission.com>
:::::: CC: Eric W. Biederman <ebiederm@xmission.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

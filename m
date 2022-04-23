Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58250CD73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiDWU6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 16:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiDWU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 16:58:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80932135966
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650747352; x=1682283352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2TJiJ9oRbaEGAEuHY1X5Nfq0tmPqGUA2eTfJcZ3JPhE=;
  b=YahCb95B/6bY93c/tZ/ukaob2WUHy77Ui+mVAfPzvHOlyykTQH5VM4MR
   rrKqqEn4pso7rUqqmZdJcYCdp6KEVr0+pt/bdXKyFNkbw6rcqOD1E4aOi
   6hreFlSs6HI/WANVB4ds5fmhwViyZNCTPdc8jJeodg1o0EKHXHBR27eZd
   c/mECXvGiL35CI+MulPZRxhnlKhgBmYbnUuBZ4l21wJT9X6rx/KoYXReW
   x5wqfsnlRX1SrC8TBFDArGw1+TrBf4XOIjHVXP0XYYrXSfnD2MVr6DwKq
   VOkqpY7GwSDiUm0bjXRFeqnz+b0td0A6axIIGeEPhpVzmxNHhnq6SV5Xs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="252295728"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="252295728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 13:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="531423338"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2022 13:55:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niMnG-0000T3-4b;
        Sat, 23 Apr 2022 20:55:50 +0000
Date:   Sun, 24 Apr 2022 04:55:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2441/2579] include/linux/fs_api.h:424:29:
 error: conflicting types for 'file_inode'; have 'struct inode *(const struct
 file *)'
Message-ID: <202204240431.wESdhsIX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5e5b9f1427ab55c511d68e2ee5471cbeabf50830 [2441/2579] headers/deps: mm: Optimize <linux/pagemap.h> dependencies
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220424/202204240431.wESdhsIX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5e5b9f1427ab55c511d68e2ee5471cbeabf50830
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5e5b9f1427ab55c511d68e2ee5471cbeabf50830
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/ubifs/ubifs.h:40,
                    from fs/ubifs/file.c:40:
   include/linux/fscrypt.h: In function 'fscrypt_dio_supported':
   include/linux/fscrypt.h:758:37: error: implicit declaration of function 'file_inode'; did you mean 'folio_inode'? [-Werror=implicit-function-declaration]
     758 |         const struct inode *inode = file_inode(iocb->ki_filp);
         |                                     ^~~~~~~~~~
         |                                     folio_inode
   include/linux/fscrypt.h:758:37: warning: initialization of 'const struct inode *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/backing-dev-api.h:16,
                    from include/linux/writeback_api.h:16,
                    from fs/ubifs/file.c:42:
   include/linux/fs_api.h: At top level:
>> include/linux/fs_api.h:424:29: error: conflicting types for 'file_inode'; have 'struct inode *(const struct file *)'
     424 | static inline struct inode *file_inode(const struct file *f)
         |                             ^~~~~~~~~~
   In file included from fs/ubifs/ubifs.h:40,
                    from fs/ubifs/file.c:40:
   include/linux/fscrypt.h:758:37: note: previous implicit declaration of 'file_inode' with type 'int()'
     758 |         const struct inode *inode = file_inode(iocb->ki_filp);
         |                                     ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +424 include/linux/fs_api.h

0f5d0a0fe62409 Ingo Molnar 2022-04-16  423  
0f5d0a0fe62409 Ingo Molnar 2022-04-16 @424  static inline struct inode *file_inode(const struct file *f)
0f5d0a0fe62409 Ingo Molnar 2022-04-16  425  {
0f5d0a0fe62409 Ingo Molnar 2022-04-16  426  	return f->f_inode;
0f5d0a0fe62409 Ingo Molnar 2022-04-16  427  }
0f5d0a0fe62409 Ingo Molnar 2022-04-16  428  

:::::: The code at line 424 was first introduced by commit
:::::: 0f5d0a0fe6240979a116fdd86cc2997879173bff headers/deps: fs: Split <linux/fs.h> into <linux/fs_types.h> and <linux/fs_api.h>

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

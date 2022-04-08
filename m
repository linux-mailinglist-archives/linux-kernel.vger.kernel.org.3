Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA044F9E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiDHUWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiDHUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:22:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC91236B82
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649449208; x=1680985208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HfbxLTRX6HCcEpWm09lQvPYQKeTAhMCo8cKJT3OJ9BY=;
  b=EpR+GX0gpzV8FZP57JGzy6S3KTCFyDsjaL8MnFQGuOfqbHeN5a10gfxS
   6ssIIQofBT/f2z9z6yIRf6vVDufmcQ6wY42EmrmmUP2xzp3mNBB/gRXI1
   udbugoISMAsbYNj2hBPk1CDe+UMgVvbRM0+1kYSHqnDHdLS2qIMgTbTMR
   JXFOucp1g1JQkfpqrOjTi5ZWWYThIZRJib1XS/DfPX9wcG1yb4Ks6840T
   uUUgivnBpjtPoGiYKQzz/1GB8EGl3bvfVxUn+lUfind7jSvv1Wws6rN7w
   psXeH3DMUZXeEqyzZuU6bS/WF393Ppvn5JZn1VHKBW6om5HjndJ2Cx8yv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="249206805"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="249206805"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 13:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="723514634"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2022 13:20:06 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncv5R-0000bl-Tw;
        Fri, 08 Apr 2022 20:20:05 +0000
Date:   Sat, 9 Apr 2022 04:20:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     popcornmix <popcornmix@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:smsc95xx_5.17 279/888] include/linux/broadcom/vc_mem.h:36:63:
 error: 'compat_ulong_t' undeclared
Message-ID: <202204090406.QmmRJunU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 369c3a505f84640f4c10f4caf67c22bf5f9b1d56 [279/888] char: Add broadcom char drivers back to build files
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204090406.QmmRJunU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/369c3a505f84640f4c10f4caf67c22bf5f9b1d56
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 369c3a505f84640f4c10f4caf67c22bf5f9b1d56
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/ioctl.h:5,
                    from include/uapi/linux/fs.h:14,
                    from include/linux/fs.h:47,
                    from drivers/char/broadcom/vc_mem.c:17:
   drivers/char/broadcom/vc_mem.c: In function 'vc_mem_compat_ioctl':
>> include/linux/broadcom/vc_mem.h:36:63: error: 'compat_ulong_t' undeclared (first use in this function)
      36 | #define VC_MEM_IOC_MEM_PHYS_ADDR32  _IOR(VC_MEM_IOC_MAGIC, 0, compat_ulong_t)
         |                                                               ^~~~~~~~~~~~~~
   arch/sparc/include/uapi/asm/ioctl.h:43:12: note: in definition of macro '_IOC'
      43 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/linux/broadcom/vc_mem.h:36:37: note: in expansion of macro '_IOR'
      36 | #define VC_MEM_IOC_MEM_PHYS_ADDR32  _IOR(VC_MEM_IOC_MAGIC, 0, compat_ulong_t)
         |                                     ^~~~
   drivers/char/broadcom/vc_mem.c:183:14: note: in expansion of macro 'VC_MEM_IOC_MEM_PHYS_ADDR32'
     183 |         case VC_MEM_IOC_MEM_PHYS_ADDR32:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/broadcom/vc_mem.h:36:63: note: each undeclared identifier is reported only once for each function it appears in
      36 | #define VC_MEM_IOC_MEM_PHYS_ADDR32  _IOR(VC_MEM_IOC_MAGIC, 0, compat_ulong_t)
         |                                                               ^~~~~~~~~~~~~~
   arch/sparc/include/uapi/asm/ioctl.h:43:12: note: in definition of macro '_IOC'
      43 |          ((size) << _IOC_SIZESHIFT))
         |            ^~~~
   include/linux/broadcom/vc_mem.h:36:37: note: in expansion of macro '_IOR'
      36 | #define VC_MEM_IOC_MEM_PHYS_ADDR32  _IOR(VC_MEM_IOC_MAGIC, 0, compat_ulong_t)
         |                                     ^~~~
   drivers/char/broadcom/vc_mem.c:183:14: note: in expansion of macro 'VC_MEM_IOC_MEM_PHYS_ADDR32'
     183 |         case VC_MEM_IOC_MEM_PHYS_ADDR32:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/compat_ulong_t +36 include/linux/broadcom/vc_mem.h

bc341020f52eeb popcornmix 2016-10-28  34  
bc341020f52eeb popcornmix 2016-10-28  35  #ifdef CONFIG_COMPAT
bc341020f52eeb popcornmix 2016-10-28 @36  #define VC_MEM_IOC_MEM_PHYS_ADDR32  _IOR(VC_MEM_IOC_MAGIC, 0, compat_ulong_t)
bc341020f52eeb popcornmix 2016-10-28  37  #endif
bc341020f52eeb popcornmix 2016-10-28  38  

:::::: The code at line 36 was first introduced by commit
:::::: bc341020f52eeb5c8b0def11a65bfb79ac6d1e74 vc_mem: Add vc_mem driver for querying firmware memory addresses

:::::: TO: popcornmix <popcornmix@gmail.com>
:::::: CC: Dom Cobley <popcornmix@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

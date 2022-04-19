Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B7506277
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiDSDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbiDSDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:09:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50E2D1FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650337588; x=1681873588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZTQ2BkSAljlujX7kx47isJtu/Mnwl+nLnpdaTCD9+xM=;
  b=DHemygHJ5/rlQYihJDlm0JZu53SNamwmpWHfp4UwmVifqRq516xRZ2vG
   MYQjdqqz3FjU0Dd4OW8rZU+shth5qeVfnfShvpUSWKPZERLJTb+UF5woS
   GW4kwOIQEC5uPZ1IU8Pma9U3cHEKzZ4Py/WaKUWJh6xUQtKQx0W+x2RpK
   iuPP03fxpS2tIgaRpcA0+o1cosXk2Ydwmu9wWGqBiK51Yyb4eQ9+1Z699
   2OGRJ33/B4Guz0PpV3mdMUKPH7ZJo2s4LqTNufiQ2ByaDfAXzjAqL9OiY
   nP8Nc5nFTjCwmGti2bZblgxqP0wFWlu3QBml4zXUhn6Jq4ffY2j9yvB85
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350110703"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350110703"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="625504293"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2022 20:06:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngeBz-0005FU-07;
        Tue, 19 Apr 2022 03:06:15 +0000
Date:   Tue, 19 Apr 2022 11:05:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1637/2356] include/linux/export.h:19:21:
 warning: excess elements in struct initializer
Message-ID: <202204191145.r47XhEcN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 7056b88fee812761b8c015f328951fa1f7522a75 [1637/2356] headers/deps: syscalls: Optimize <linux/syscalls.h> dependencies
config: x86_64-randconfig-a005-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191145.r47XhEcN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=7056b88fee812761b8c015f328951fa1f7522a75
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 7056b88fee812761b8c015f328951fa1f7522a75
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/sgx/ drivers/cxl/core/ drivers/gpu/drm/dp/ drivers/gpu/drm/i915/gvt/ drivers/platform/x86/intel/uncore-frequency/ drivers/virt/ fs/ubifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/sgx/driver.c: In function 'sgx_open':
   arch/x86/kernel/cpu/sgx/driver.c:48:13: error: invalid use of undefined type 'struct file'
      48 |         file->private_data = encl;
         |             ^~
   arch/x86/kernel/cpu/sgx/driver.c: In function 'sgx_release':
   arch/x86/kernel/cpu/sgx/driver.c:55:37: error: invalid use of undefined type 'struct file'
      55 |         struct sgx_encl *encl = file->private_data;
         |                                     ^~
   arch/x86/kernel/cpu/sgx/driver.c: In function 'sgx_mmap':
   arch/x86/kernel/cpu/sgx/driver.c:95:37: error: invalid use of undefined type 'struct file'
      95 |         struct sgx_encl *encl = file->private_data;
         |                                     ^~
   arch/x86/kernel/cpu/sgx/driver.c: At top level:
   arch/x86/kernel/cpu/sgx/driver.c:136:21: error: variable 'sgx_encl_fops' has initializer but incomplete type
     136 | static const struct file_operations sgx_encl_fops = {
         |                     ^~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:137:10: error: 'const struct file_operations' has no member named 'owner'
     137 |         .owner                  = THIS_MODULE,
         |          ^~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/lockdep.h:14,
                    from include/linux/lockdep_api.h:1,
                    from include/linux/timer.h:5,
                    from include/linux/srcu_types.h:19,
                    from include/linux/srcu.h:19,
                    from arch/x86/kernel/cpu/sgx/driver.c:4:
>> include/linux/export.h:19:21: warning: excess elements in struct initializer
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   arch/x86/kernel/cpu/sgx/driver.c:137:35: note: in expansion of macro 'THIS_MODULE'
     137 |         .owner                  = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'sgx_encl_fops')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   arch/x86/kernel/cpu/sgx/driver.c:137:35: note: in expansion of macro 'THIS_MODULE'
     137 |         .owner                  = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:138:10: error: 'const struct file_operations' has no member named 'open'
     138 |         .open                   = sgx_open,
         |          ^~~~
>> arch/x86/kernel/cpu/sgx/driver.c:138:35: warning: excess elements in struct initializer
     138 |         .open                   = sgx_open,
         |                                   ^~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:138:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:139:10: error: 'const struct file_operations' has no member named 'release'
     139 |         .release                = sgx_release,
         |          ^~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:139:35: warning: excess elements in struct initializer
     139 |         .release                = sgx_release,
         |                                   ^~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:139:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:140:10: error: 'const struct file_operations' has no member named 'unlocked_ioctl'
     140 |         .unlocked_ioctl         = sgx_ioctl,
         |          ^~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:140:35: warning: excess elements in struct initializer
     140 |         .unlocked_ioctl         = sgx_ioctl,
         |                                   ^~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:140:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:142:10: error: 'const struct file_operations' has no member named 'compat_ioctl'
     142 |         .compat_ioctl           = sgx_compat_ioctl,
         |          ^~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:142:35: warning: excess elements in struct initializer
     142 |         .compat_ioctl           = sgx_compat_ioctl,
         |                                   ^~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:142:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:144:10: error: 'const struct file_operations' has no member named 'mmap'
     144 |         .mmap                   = sgx_mmap,
         |          ^~~~
   arch/x86/kernel/cpu/sgx/driver.c:144:35: warning: excess elements in struct initializer
     144 |         .mmap                   = sgx_mmap,
         |                                   ^~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:144:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:145:10: error: 'const struct file_operations' has no member named 'get_unmapped_area'
     145 |         .get_unmapped_area      = sgx_get_unmapped_area,
         |          ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:145:35: warning: excess elements in struct initializer
     145 |         .get_unmapped_area      = sgx_get_unmapped_area,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/driver.c:145:35: note: (near initialization for 'sgx_encl_fops')
   arch/x86/kernel/cpu/sgx/driver.c:136:37: error: storage size of 'sgx_encl_fops' isn't known
     136 | static const struct file_operations sgx_encl_fops = {
         |                                     ^~~~~~~~~~~~~


vim +19 include/linux/export.h

b67067f1176df6 Nicholas Piggin 2016-08-24   4  
f50169324df4ad Paul Gortmaker  2011-05-23   5  /*
f50169324df4ad Paul Gortmaker  2011-05-23   6   * Export symbols from the kernel to modules.  Forked from module.h
f50169324df4ad Paul Gortmaker  2011-05-23   7   * to reduce the amount of pointless cruft we feed to gcc when only
f50169324df4ad Paul Gortmaker  2011-05-23   8   * exporting a simple symbol or two.
f50169324df4ad Paul Gortmaker  2011-05-23   9   *
b92021b09df70c Rusty Russell   2013-03-15  10   * Try not to add #includes here.  It slows compilation and makes kernel
b92021b09df70c Rusty Russell   2013-03-15  11   * hackers place grumpy comments in header files.
f50169324df4ad Paul Gortmaker  2011-05-23  12   */
f50169324df4ad Paul Gortmaker  2011-05-23  13  
b92021b09df70c Rusty Russell   2013-03-15  14  #ifndef __ASSEMBLY__
f50169324df4ad Paul Gortmaker  2011-05-23  15  #ifdef MODULE
f50169324df4ad Paul Gortmaker  2011-05-23  16  extern struct module __this_module;
f50169324df4ad Paul Gortmaker  2011-05-23  17  #define THIS_MODULE (&__this_module)
f50169324df4ad Paul Gortmaker  2011-05-23  18  #else
f50169324df4ad Paul Gortmaker  2011-05-23 @19  #define THIS_MODULE ((struct module *)0)
f50169324df4ad Paul Gortmaker  2011-05-23  20  #endif
f50169324df4ad Paul Gortmaker  2011-05-23  21  

:::::: The code at line 19 was first introduced by commit
:::::: f50169324df4ad942e544386d136216c8617636a module.h: split out the EXPORT_SYMBOL into export.h

:::::: TO: Paul Gortmaker <paul.gortmaker@windriver.com>
:::::: CC: Paul Gortmaker <paul.gortmaker@windriver.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

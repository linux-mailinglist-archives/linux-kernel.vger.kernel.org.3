Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69251DFF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392634AbiEFUMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392181AbiEFUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:12:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466561607
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651867698; x=1683403698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KIqzShmVXsj43gKiwEOdjAOxcMQuZmzGq9+Y5qbOiMY=;
  b=HMG6bMPz5Bq/jtHXwn3F5pwviM3SgIMKD8k/uUgJ/EXMw9ZHLJwNPebO
   btkVFsTf2fVjTPuVV586dhxSB9+v5Vc3txCoGnw8RoVO47l0usnG9iQp3
   AeMmCVB7a6pLv819Pwimsna3Xw6nfJF5OuuQUmnXfTrXZ6yIui8znbYX6
   b6vfQTn72zDpAyW1vQmMds90JqVLmuxgzCDW/GVXq6UpVRmehcz8jf7gN
   Q3SMx4ds8e5Fc6qnjxm8XPE9JuoZD6VG5xhvb1brahZcuEOOdujkDvs4N
   rMVNcCs2BbxkAt7dams7QUUv4ztVjdtG/6siVVjm1EFhnoGgvi2TKJfrt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="250569621"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="250569621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="600710059"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2022 13:08:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn4FM-000DqQ-6Q;
        Fri, 06 May 2022 20:08:16 +0000
Date:   Sat, 7 May 2022 04:07:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [krzk-github:n/qcom-ufs-opp-cleanups-v2-drv-owner-wip 7/7]
 include/linux/export.h:19:21: warning: initialization of 'short unsigned
 int' from 'struct module *' makes integer from pointer without a cast
Message-ID: <202205070404.1O60FSb4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/krzk/linux n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
head:   17609caecd53df20f631703ea084a70e7735b5d7
commit: 17609caecd53df20f631703ea084a70e7735b5d7 [7/7] WIP
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220507/202205070404.1O60FSb4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7
        git remote add krzk-github https://github.com/krzk/linux
        git fetch --no-tags krzk-github n/qcom-ufs-opp-cleanups-v2-drv-owner-wip
        git checkout 17609caecd53df20f631703ea084a70e7735b5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/a4000t.c:29:10: error: 'struct scsi_host_template' has no member named 'module'
      29 |         .module         = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/a4000t.c:12:
>> include/linux/export.h:19:21: warning: initialization of 'short unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/a4000t.c:29:27: note: in expansion of macro 'THIS_MODULE'
      29 |         .module         = THIS_MODULE,
         |                           ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'a4000t_scsi_driver_template.sg_tablesize')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/a4000t.c:29:27: note: in expansion of macro 'THIS_MODULE'
      29 |         .module         = THIS_MODULE,
         |                           ^~~~~~~~~~~
--
   drivers/scsi/zorro7xx.c:35:10: error: 'struct scsi_host_template' has no member named 'module'
      35 |         .module         = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/zorro7xx.c:13:
>> include/linux/export.h:19:21: warning: initialization of 'short unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/zorro7xx.c:35:27: note: in expansion of macro 'THIS_MODULE'
      35 |         .module         = THIS_MODULE,
         |                           ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'zorro7xx_scsi_driver_template.sg_tablesize')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/zorro7xx.c:35:27: note: in expansion of macro 'THIS_MODULE'
      35 |         .module         = THIS_MODULE,
         |                           ^~~~~~~~~~~
--
   drivers/scsi/mvme16x_scsi.c:33:10: error: 'struct scsi_host_template' has no member named 'module'
      33 |         .module                 = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/mvme16x_scsi.c:10:
>> include/linux/export.h:19:21: warning: initialization of 'short unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/mvme16x_scsi.c:33:35: note: in expansion of macro 'THIS_MODULE'
      33 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'mvme16x_scsi_driver_template.sg_tablesize')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/mvme16x_scsi.c:33:35: note: in expansion of macro 'THIS_MODULE'
      33 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
--
   drivers/scsi/bvme6000_scsi.c:33:10: error: 'struct scsi_host_template' has no member named 'module'
      33 |         .module                 = THIS_MODULE,
         |          ^~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/bvme6000_scsi.c:10:
>> include/linux/export.h:19:21: warning: initialization of 'short unsigned int' from 'struct module *' makes integer from pointer without a cast [-Wint-conversion]
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/bvme6000_scsi.c:33:35: note: in expansion of macro 'THIS_MODULE'
      33 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~
   include/linux/export.h:19:21: note: (near initialization for 'bvme6000_scsi_driver_template.sg_tablesize')
      19 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/scsi/bvme6000_scsi.c:33:35: note: in expansion of macro 'THIS_MODULE'
      33 |         .module                 = THIS_MODULE,
         |                                   ^~~~~~~~~~~


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

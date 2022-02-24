Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8B4C2237
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiBXDWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBXDWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:22:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBCD19AD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645672922; x=1677208922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=slCI2A+FQGap3O0UeabPWllpv6r7QB3gWd5s/lNuYz0=;
  b=LQaCG0Zw44UscX7Y9JsDSzIuPqp/tr1iUfEwZqbufiDQ2HeCZagCXqt2
   JmG33BTzxtIwxahcszyITqbW/ynilyAdT69JjarS6aAYiVFT8lbmzFVB9
   dzKgogla0ZDZepixuootFjLfGxWzkMQQ+36bTQDxdyFqaSUqukxCHSAn+
   oUg9HR2Urq8SnJ9uJ0khl+fcKZuU88R8o0E7joha4LgrT1luM7VyvVDKJ
   Q0gd0LmAZu++xmxBvdqMUrRtOmMODUAuLUKm/13FDYmMtfJFscGuRweVv
   IB9ibY8ye/KCVuYK9BnEEZaxHFK7eWkT2x74WBzhqoW/fZa35GnV+al3s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276764458"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276764458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628322211"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2022 19:22:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4hc-0002Ak-5j; Thu, 24 Feb 2022 03:22:00 +0000
Date:   Thu, 24 Feb 2022 11:21:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 14/42] arch/x86/include/asm/ibt.h:56:15:
 error: unknown type name 'bool'
Message-ID: <202202241136.iI0FBBxt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 20396b2dbe8963dd71dae05fbc84ffc03a7db435 [14/42] x86/linkage: Add ENDBR to SYM_FUNC_START*()
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241136.iI0FBBxt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=20396b2dbe8963dd71dae05fbc84ffc03a7db435
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 20396b2dbe8963dd71dae05fbc84ffc03a7db435
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from include/linux/tty.h:5,
                    from arch/um/drivers/stdio_console.c:7:
>> arch/x86/include/asm/ibt.h:56:15: error: unknown type name 'bool'
      56 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
--
   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from arch/um/drivers/ssl.c:6:
>> arch/x86/include/asm/ibt.h:56:15: error: unknown type name 'bool'
      56 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
   arch/x86/include/asm/ibt.h: In function 'is_endbr':
>> arch/x86/include/asm/ibt.h:56:56: error: 'false' undeclared (first use in this function)
      56 | static inline bool is_endbr(unsigned int val) { return false; }
         |                                                        ^~~~~
   arch/x86/include/asm/ibt.h:56:56: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from arch/x86/include/asm/linkage.h:6,
                    from include/linux/linkage.h:8,
                    from include/linux/fs.h:5,
                    from fs/proc/meminfo.c:2:
>> arch/x86/include/asm/ibt.h:56:15: error: unknown type name 'bool'
      56 | static inline bool is_endbr(unsigned int val) { return false; }
         |               ^~~~
   arch/x86/include/asm/ibt.h: In function 'is_endbr':
>> arch/x86/include/asm/ibt.h:56:56: error: 'false' undeclared (first use in this function)
      56 | static inline bool is_endbr(unsigned int val) { return false; }
         |                                                        ^~~~~
   arch/x86/include/asm/ibt.h:56:56: note: each undeclared identifier is reported only once for each function it appears in
   fs/proc/meminfo.c: At top level:
   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~


vim +/bool +56 arch/x86/include/asm/ibt.h

69011263a3481b Peter Zijlstra 2021-11-22  55  
69011263a3481b Peter Zijlstra 2021-11-22 @56  static inline bool is_endbr(unsigned int val) { return false; }
69011263a3481b Peter Zijlstra 2021-11-22  57  

:::::: The code at line 56 was first introduced by commit
:::::: 69011263a3481be7b367f61296ebd9a79cd8512e x86: Base IBT bits

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

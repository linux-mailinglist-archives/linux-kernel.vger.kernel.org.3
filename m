Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082B489576
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiAJJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:39:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:52319 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243074AbiAJJj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641807566; x=1673343566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s/RWFzzqwbfMGxk/Eez+XiAdcFU0czVYK/+efkvgPIc=;
  b=bDs3Sztz7qy0Y9I3okvarQkTl4oTrXeZAJY3iI8W78lHwVsyZzH8z1Pz
   3Al5Z4ReJ8NIcfzfczRwpgPWaqNqkdE2dKsoEQB+ZUya6RmBms01tQxPs
   OOQaY4RHYmFxri+MJWRqnNup/sq4hn6orWd5S7cyECzPATQwzR30HpAeU
   QLwQ2y7JglTsuXaWSHIdSpdUTmN1DZGUgHmKGwC8yv9PKm6hFXfj2ukJa
   1JRFVGkFSYI0ZhTfd/etU3BK2mpAV7bKmIfIixkeuF/maoBiqfVDzRFPG
   nMNdk9cNosbwnI6LaEghnj4MorFY3bKwh/bj1oYZn3qC0GFjxoEoNeeAC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223886134"
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="223886134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 01:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,276,1635231600"; 
   d="scan'208";a="622617584"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 01:39:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6r99-0002iO-9Q; Mon, 10 Jan 2022 09:39:23 +0000
Date:   Mon, 10 Jan 2022 17:38:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2225/2375] include/linux/mm_types_task.h:11:10:
 fatal error: generated/bounds.h: No such file or directory
Message-ID: <202201101751.rDcZKbLH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   391ce485ced0e47bf8d2ce8bc32bb87887e16656
commit: 86c0c813105219163a284f01933d35a9a34f36d8 [2225/2375] headers/deps: mm: Optimize <linux/mm_api.h> dependencies, remove <linux/mm_page_address.h> inclusion
config: sparc-randconfig-r016-20220109 (https://download.01.org/0day-ci/archive/20220110/202201101751.rDcZKbLH-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=86c0c813105219163a284f01933d35a9a34f36d8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 86c0c813105219163a284f01933d35a9a34f36d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:7,
                    from include/linux/mm_page_address.h:5,
                    from include/asm-generic/memory_model.h:14,
                    from arch/sparc/include/asm/page_32.h:137,
                    from arch/sparc/include/asm/page.h:10,
                    from arch/sparc/include/asm/string_32.h:13,
                    from arch/sparc/include/asm/string.h:7,
                    from include/linux/string.h:20,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
>> include/linux/mm_types_task.h:11:10: fatal error: generated/bounds.h: No such file or directory
      11 | #include <generated/bounds.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +11 include/linux/mm_types_task.h

2e58f173ab89b2 Ingo Molnar 2017-02-04   4  
9e7d2e44dd88ba Ingo Molnar 2017-02-04   5  /*
9e7d2e44dd88ba Ingo Molnar 2017-02-04   6   * Here are the definitions of the MM data types that are embedded in 'struct task_struct'.
9e7d2e44dd88ba Ingo Molnar 2017-02-04   7   *
9e7d2e44dd88ba Ingo Molnar 2017-02-04   8   * (These are defined separately to decouple sched.h from mm_types.h as much as possible.)
9e7d2e44dd88ba Ingo Molnar 2017-02-04   9   */
9e7d2e44dd88ba Ingo Molnar 2017-02-04  10  
c869d2d00b80c5 Ingo Molnar 2021-11-24 @11  #include <generated/bounds.h>
c869d2d00b80c5 Ingo Molnar 2021-11-24  12  

:::::: The code at line 11 was first introduced by commit
:::::: c869d2d00b80c5c84a6c5b655fb865fa1db70b52 headers/deps: mm: Optimize <linux/mm_types.h> dependencies

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

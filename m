Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8E53B89B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiFBMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiFBMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:03:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2D38AF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654171415; x=1685707415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q9mkvTh5S60FjSe5FSqb32kkfol5w3Mp5LDwfwTITAA=;
  b=LidAJ8KXUiuRpHqxRDkjvwZ36zowPZavTQppzaB/Gdazu+dnDlcOe4kZ
   1aZy9zoX9B1zJXgz8tSjyDaI1p6NfxaQM62jawDXjnWjUfG5xs6fJmGNI
   3SEkIphrHZo1dPG6ikplMZnW4EJJI1Iidkq00gt5Smtty7AJdksXbnF8O
   pPY/h63rC245jEVeclR/Ha5R7IKJ1QtJqOimsNq5YvOEcoDo+db1cM/jA
   07cBuMNd8Z2IroGEqTfi3FExTo9PxAgoQFgvTswOwkt3oEWqE/mcQp0Tu
   hVCF6QCYKRuqeuoo/VKJHt2JaKkRSfeiOyiMzR+DruPWlVC+2EBa6WDBP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="276001297"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="276001297"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="707537769"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2022 05:03:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwjXw-00052v-95;
        Thu, 02 Jun 2022 12:03:24 +0000
Date:   Thu, 2 Jun 2022 20:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.18-rc1 20/31]
 arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier
 'PAGE_OFFSET'
Message-ID: <202206021932.SvXQtG2F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.18-rc1
head:   9083f89a58302e92fad7f144986e307db2350aad
commit: 591e0e614af53ee26dec3179fb3e6e028cecd386 [20/31] Hexagon: Make virt_to_pfn() a static inline
config: hexagon-randconfig-r041-20220531 (https://download.01.org/0day-ci/archive/20220602/202206021932.SvXQtG2F-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=591e0e614af53ee26dec3179fb3e6e028cecd386
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.18-rc1
        git checkout 591e0e614af53ee26dec3179fb3e6e028cecd386
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/power/supply/ds2760_battery.c:22:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:5:
   In file included from include/linux/mm_types_task.h:16:
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PAGE_OFFSET'
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^
   arch/hexagon/include/asm/page.h:86:39: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                         ^
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PHYS_OFFSET'
   arch/hexagon/include/asm/page.h:86:53: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                                       ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/ds2760_battery.c:30:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
--
   In file included from drivers/power/supply/ds2780_battery.c:12:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:5:
   In file included from include/linux/mm_types_task.h:16:
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PAGE_OFFSET'
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^
   arch/hexagon/include/asm/page.h:86:39: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                         ^
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PHYS_OFFSET'
   arch/hexagon/include/asm/page.h:86:53: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                                       ^
   2 errors generated.
--
   In file included from drivers/power/supply/twl4030_charger.c:12:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:5:
   In file included from include/linux/mm_types_task.h:16:
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PAGE_OFFSET'
           return __pa(kaddr) >> PAGE_SHIFT;
                  ^
   arch/hexagon/include/asm/page.h:86:39: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                         ^
>> arch/hexagon/include/asm/page.h:131:9: error: use of undeclared identifier 'PHYS_OFFSET'
   arch/hexagon/include/asm/page.h:86:53: note: expanded from macro '__pa'
   #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
                                                       ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from drivers/power/supply/twl4030_charger.c:17:
   In file included from include/linux/mfd/twl.h:15:
   In file included from include/linux/input/matrix_keypad.h:6:
   In file included from include/linux/input.h:20:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
   _SIG_SET_BINOP(sigorsets, _sig_or)
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:137:8: note: expanded from macro '_SIG_SET_BINOP'
                   a3 = a->sig[3]; a2 = a->sig[2];                         \


vim +/PAGE_OFFSET +131 arch/hexagon/include/asm/page.h

   128	
   129	static inline unsigned long virt_to_pfn(const void *kaddr)
   130	{
 > 131		return __pa(kaddr) >> PAGE_SHIFT;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

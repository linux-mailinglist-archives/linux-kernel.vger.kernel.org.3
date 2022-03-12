Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C34D7194
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiCLXjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiCLXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:39:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274ED50E23
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647128326; x=1678664326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wfDpL34JWZP2o3M5D62E0cqRYwAc/qS/L0wJwawkGxA=;
  b=Qc816E+wePuwpScV57gg7hFL7hbn+cvM3ZC3BKIIjtivWTCfd7sP0X/5
   vU4iY08hkMDtih5WcvpxFrun8wZzB6OF69SErnj6fG0KYkprSOLqa5zIg
   mPwlx+054IFgwDS8YvrO3WarbqANRqSJZ6yyxaUeQrifbFHM+8bFOoLtA
   MSu3PQf2MXhFZ2MMwCVE/N6GQjI7+rWU6hJNUSXg+gwDbpZYi5jgDrjaI
   u0xNn6cRG1SVofWWUe/xJ2WBnUBr6DoSpy8jVybPT7Jq7JCnBHbW47MpR
   RRujODJHcWSqZIq/oyUcUsire213/gt69pG8rOmF1+j8HNFanWLtCcPdE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="254657737"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="254657737"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 15:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="645355744"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2022 15:38:43 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTBJq-0008MU-KH; Sat, 12 Mar 2022 23:38:42 +0000
Date:   Sun, 13 Mar 2022 07:38:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:nfsd-courteous-server 29/39] do_mounts.c:(.text+0x66): multiple
 definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0):
 first defined here
Message-ID: <202203130709.dYmfXVEC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   ca4d8c00bb753707519f438e5286b2349af53054
commit: 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa [29/39] fs/lock: add helper locks_owner_has_blockers to check for blockers
config: m68k-randconfig-r031-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130709.dYmfXVEC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: init/do_mounts.o: in function `locks_owner_has_blockers':
>> do_mounts.c:(.text+0x66): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: init/do_mounts_rd.o: in function `locks_owner_has_blockers':
   do_mounts_rd.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: init/do_mounts_initrd.o: in function `locks_owner_has_blockers':
   do_mounts_initrd.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: init/initramfs.o: in function `locks_owner_has_blockers':
   initramfs.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: init/init_task.o: in function `locks_owner_has_blockers':
   init_task.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/irq.o: in function `locks_owner_has_blockers':
   irq.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/module.o: in function `locks_owner_has_blockers':
   module.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/process.o: in function `locks_owner_has_blockers':
   process.c:(.text+0xe): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/ptrace.o: in function `locks_owner_has_blockers':
   ptrace.c:(.text+0x182): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/setup.o: in function `locks_owner_has_blockers':
   setup.c:(.text+0x102): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/signal.o: in function `locks_owner_has_blockers':
   signal.c:(.text+0x3a0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/sys_m68k.o: in function `locks_owner_has_blockers':
   sys_m68k.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/time.o: in function `locks_owner_has_blockers':
   time.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/traps.o: in function `locks_owner_has_blockers':
   traps.c:(.text+0x12): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/kernel/dma.o: in function `locks_owner_has_blockers':
   dma.c:(.text+0x62): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/mm/init.o: in function `locks_owner_has_blockers':
   init.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/device.o: in function `locks_owner_has_blockers':
   device.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/vectors.o: in function `locks_owner_has_blockers':
   vectors.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/m5206.o: in function `locks_owner_has_blockers':
   m5206.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/reset.o: in function `locks_owner_has_blockers':
   reset.c:(.text+0x14): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/timers.o: in function `locks_owner_has_blockers':
   timers.c:(.text+0x56): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: arch/m68k/coldfire/gpio.o: in function `locks_owner_has_blockers':
   gpio.c:(.text+0x26): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/fork.o: in function `locks_owner_has_blockers':
   fork.c:(.text+0x6b4): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/exec_domain.o: in function `locks_owner_has_blockers':
   exec_domain.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/panic.o: in function `locks_owner_has_blockers':
   panic.c:(.text+0x1d6): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/cpu.o: in function `locks_owner_has_blockers':
   cpu.c:(.text+0x296): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/exit.o: in function `locks_owner_has_blockers':
   exit.c:(.text+0x948): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/softirq.o: in function `locks_owner_has_blockers':
   softirq.c:(.text+0x12e): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/resource.o: in function `locks_owner_has_blockers':
   resource.c:(.text+0x6de): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sysctl.o: in function `locks_owner_has_blockers':
   sysctl.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/capability.o: in function `locks_owner_has_blockers':
   capability.c:(.text+0x288): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/ptrace.o: in function `locks_owner_has_blockers':
   ptrace.c:(.text+0x474): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/signal.o: in function `locks_owner_has_blockers':
   signal.c:(.text+0x9cc): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sys.o: in function `locks_owner_has_blockers':
   sys.c:(.text+0xdd4): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/umh.o: in function `locks_owner_has_blockers':
   umh.c:(.text+0x47a): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/workqueue.o: in function `locks_owner_has_blockers':
   workqueue.c:(.text+0x1e40): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/pid.o: in function `locks_owner_has_blockers':
   pid.c:(.text+0xc6): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/task_work.o: in function `locks_owner_has_blockers':
   task_work.c:(.text+0x24): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/extable.o: in function `locks_owner_has_blockers':
   extable.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/params.o: in function `locks_owner_has_blockers':
   params.c:(.text+0x998): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/kthread.o: in function `locks_owner_has_blockers':
   kthread.c:(.text+0x6c0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/nsproxy.o: in function `locks_owner_has_blockers':
   nsproxy.c:(.text+0x1fc): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/notifier.o: in function `locks_owner_has_blockers':
   notifier.c:(.text+0x12c): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/ksysfs.o: in function `locks_owner_has_blockers':
   ksysfs.c:(.text+0x180): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/cred.o: in function `locks_owner_has_blockers':
   cred.c:(.text+0x11a): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/reboot.o: in function `locks_owner_has_blockers':
   reboot.c:(.text+0x1d2): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/groups.o: in function `locks_owner_has_blockers':
   groups.c:(.text+0x32): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sched/core.o: in function `locks_owner_has_blockers':
   core.c:(.text+0x918): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sched/loadavg.o: in function `locks_owner_has_blockers':
   loadavg.c:(.text+0x38): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sched/clock.o: in function `locks_owner_has_blockers':
   clock.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
   m68k-linux-ld: kernel/sched/cputime.o: in function `locks_owner_has_blockers':
   cputime.c:(.text+0x76): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

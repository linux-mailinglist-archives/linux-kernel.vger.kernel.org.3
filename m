Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332F510D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356448AbiD0Ap2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356425AbiD0Ap0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:45:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF463983B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651020136; x=1682556136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jNsMWjM4vs7Vtp5MZVaIFqJd5qUnOZiY1Aa2iWmJdaU=;
  b=Ej1oxgrNl/o8YO34Ohl1OCG+wLkVv5jAYVfh783Kk0OirYSFDNsvQZcR
   nMj+AyDXSfdXyd5CXwynbEH9U77Zn1gjQ1ClFVpvU2h774tgiSUPxvVEy
   nIkPVXioto6Sb9+f27fGAQNTO2Ix/CO1mAvuYE09TC3MGonOZPNQPTL22
   YQAyS/3xlxcB4h8+TwqCzKBC0nbitibHz+uN9btyUoJBoZiY7KCEV5gr+
   QUSWxVUFSsE3qKs/ZNJuuSuj9BAFF9jADK3UJ4PEJ1efaAAqHsMVRCzEE
   r4r5fODXoB2n4XLladgpGtiW5/q9nEEwdwofrCZQigB5nnFllI9SHkpqG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326257819"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326257819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532939259"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 17:42:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njVkz-00047S-QB;
        Wed, 27 Apr 2022 00:42:13 +0000
Date:   Wed, 27 Apr 2022 08:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/5] (.text+0xcc): multiple definition of
 `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
Message-ID: <202204270859.8vot8qLz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   5630c6957e15ef4902c8635147b35092efd08a0a
commit: 1776d7631a9bec5d7b3f08779be196875fb4eb62 [1/5] kallsyms: Fully export kallsyms_on_each_symbol function
config: parisc-randconfig-r015-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270859.8vot8qLz-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1776d7631a9bec5d7b3f08779be196875fb4eb62
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 1776d7631a9bec5d7b3f08779be196875fb4eb62
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: init/do_mounts.o: in function `kallsyms_on_each_symbol':
>> (.text+0xcc): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: init/noinitramfs.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: init/init_task.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/mm/fault.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/mm/fixmap.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/traps.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/time.o: in function `kallsyms_on_each_symbol':
   (.text+0x10c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/sys_parisc.o: in function `kallsyms_on_each_symbol':
   (.text+0x5e0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/parisc_ksyms.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/process.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/patch.o: in function `kallsyms_on_each_symbol':
   (.text+0xd4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/toc.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: arch/parisc/kernel/smp.o: in function `kallsyms_on_each_symbol':
   (.text+0x34): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/fork.o: in function `kallsyms_on_each_symbol':
   (.text+0xc90): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/exec_domain.o: in function `kallsyms_on_each_symbol':
   (.text+0x30): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/panic.o: in function `kallsyms_on_each_symbol':
   (.text+0x1f4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/cpu.o: in function `kallsyms_on_each_symbol':
   (.text+0x15cc): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/exit.o: in function `kallsyms_on_each_symbol':
   (.text+0xce0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/softirq.o: in function `kallsyms_on_each_symbol':
   (.text+0x3dc): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sysctl.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/capability.o: in function `kallsyms_on_each_symbol':
   (.text+0x314): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/ptrace.o: in function `kallsyms_on_each_symbol':
   (.text+0x8c4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/signal.o: in function `kallsyms_on_each_symbol':
   (.text+0xb5c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sys.o: in function `kallsyms_on_each_symbol':
   (.text+0x1530): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/umh.o: in function `kallsyms_on_each_symbol':
   (.text+0x4c0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/pid.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/extable.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/nsproxy.o: in function `kallsyms_on_each_symbol':
   (.text+0x2d4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/notifier.o: in function `kallsyms_on_each_symbol':
   (.text+0x7c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/cred.o: in function `kallsyms_on_each_symbol':
   (.text+0x128): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/reboot.o: in function `kallsyms_on_each_symbol':
   (.text+0x2e4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/groups.o: in function `kallsyms_on_each_symbol':
   (.text+0x2c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sched/core.o: in function `kallsyms_on_each_symbol':
   (.text+0x1678): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sched/fair.o: in function `kallsyms_on_each_symbol':
   (.text+0x698c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sched/build_policy.o: in function `kallsyms_on_each_symbol':
   (.text+0x5250): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/sched/build_utility.o: in function `kallsyms_on_each_symbol':
   (.text+0x35e4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/locking/semaphore.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/power/qos.o: in function `kallsyms_on_each_symbol':
   (.text+0x78): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/power/process.o: in function `kallsyms_on_each_symbol':
   (.text+0x5c): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/printk/printk.o: in function `kallsyms_on_each_symbol':
   (.text+0x1ac0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/printk/printk_safe.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/rcu/update.o: in function `kallsyms_on_each_symbol':
   (.text+0x2750): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/rcu/tree.o: in function `kallsyms_on_each_symbol':
   (.text+0x4f98): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/kcmp.o: in function `kallsyms_on_each_symbol':
   (.text+0x564): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/freezer.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/stacktrace.o: in function `kallsyms_on_each_symbol':
   (.text+0xfc): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/time/time.o: in function `kallsyms_on_each_symbol':
   (.text+0x0): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/time/timer.o: in function `kallsyms_on_each_symbol':
   (.text+0xdb4): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/time/hrtimer.o: in function `kallsyms_on_each_symbol':
   (.text+0xe90): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/time/timer_list.o: in function `kallsyms_on_each_symbol':
   (.text+0x524): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here
   hppa-linux-ld: kernel/time/posix-timers.o: in function `kallsyms_on_each_symbol':
   (.text+0x1790): multiple definition of `kallsyms_on_each_symbol'; init/main.o:(.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

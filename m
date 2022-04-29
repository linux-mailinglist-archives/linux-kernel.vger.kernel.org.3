Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CD514115
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiD2DLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiD2DLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:11:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB00BF511
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 20:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651201672; x=1682737672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2iHIsrBa2knnJykbFhp1efOf6SAVl4Em/gOza0SzJbY=;
  b=XYiWrTxQrJMtFX46pWqRlYJ83RgHOfweG0wAwB9V1BJ7FkhPZG649uv7
   8kifd63m1fxV6fgbDEpiqlIsrcmQ3vuGdkp9MLrHPXIw98ihU4szC7Qz1
   Xl2xTozQUyQQIbKzZSggY7zMitQz8/Lnuze6q3o7JEawJw+LmuML3Kfs7
   cWNXmcBNZsYIC1g5in3RzS2yXSUimH/jDKxF1piAfhBF6Du00lmZeFgIH
   G7l6wxCjsd/KfpS/zyw+fOQlhcKMQY7bctRVjmkuhULZdJGewCWhOp95o
   nu8FXL0BFTbxwchmWW8Wv1IBXD51bC5omIqRXtLl2cxT45G9BipsN+BIe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="327003975"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="327003975"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="651553327"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Apr 2022 20:07:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkGyz-0005vd-ND;
        Fri, 29 Apr 2022 03:07:49 +0000
Date:   Fri, 29 Apr 2022 11:07:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.freezer 3/7]
 include/linux/sched/jobctl.h:23:2: error: expected identifier or '('
Message-ID: <202204291119.HDMwqfSJ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.freezer
head:   a1b437cfec0d2b0060cf85538c2379c74fb63ad5
commit: 4cb4f3dc01c45f8a1621f13b55705ba4a6844081 [3/7] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
config: hexagon-randconfig-r005-20220428 (https://download.01.org/0day-ci/archive/20220429/202204291119.HDMwqfSJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.freezer
        git checkout 4cb4f3dc01c45f8a1621f13b55705ba4a6844081
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:8:
   include/linux/sched/jobctl.h:23:1: error: unknown type name 'q'
   q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
   ^
>> include/linux/sched/jobctl.h:23:2: error: expected identifier or '('
   q#define JOBCTL_STOPPED_BIT     25      /* do_signal_stop() */
    ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
>> include/linux/sched/signal.h:298:22: error: use of undeclared identifier 'JOBCTL_STOPPED_BIT'
                   current->jobctl |= JOBCTL_STOPPED;
                                      ^
   include/linux/sched/jobctl.h:35:33: note: expanded from macro 'JOBCTL_STOPPED'
   #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
                                           ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   include/linux/sched/signal.h:444:18: error: use of undeclared identifier 'JOBCTL_STOPPED_BIT'
                   t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
                                  ^
   include/linux/sched/jobctl.h:35:33: note: expanded from macro 'JOBCTL_STOPPED'
   #define JOBCTL_STOPPED          (1UL << JOBCTL_STOPPED_BIT)
                                           ^
   4 errors generated.
   make[2]: *** [scripts/Makefile.build:120: arch/hexagon/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +23 include/linux/sched/jobctl.h

    13	
    14	#define JOBCTL_STOP_DEQUEUED_BIT 16	/* stop signal dequeued */
    15	#define JOBCTL_STOP_PENDING_BIT	17	/* task should stop for group stop */
    16	#define JOBCTL_STOP_CONSUME_BIT	18	/* consume group stop count */
    17	#define JOBCTL_TRAP_STOP_BIT	19	/* trap for STOP */
    18	#define JOBCTL_TRAP_NOTIFY_BIT	20	/* trap for NOTIFY */
    19	#define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
    20	#define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
    21	#define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
    22	#define JOBCTL_DELAY_WAKEKILL_BIT	24	/* delay killable wakeups */
  > 23	q#define JOBCTL_STOPPED_BIT	25	/* do_signal_stop() */
    24	#define JOBCTL_TRACED_BIT	26	/* ptrace_stop() */
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

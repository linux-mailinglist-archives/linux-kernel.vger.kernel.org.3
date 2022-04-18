Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41333505F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiDRVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiDRVul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:50:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF851DA4D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650318480; x=1681854480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZ120z60SK3zaU31Z2jdcGz3xjUwHYSrkk4wIo0jFAw=;
  b=m3GqGRRuaWCA6gVsxmTrIY06yvTGhtfkiVUJHAaDLvJY+7qr1C/LzTA8
   racWTH+IDuRcgTjJ5n+1GRtr1j9JOZdoFEwLXfaE+is09a3whlxEH2S0L
   B5iI1f2cBVoLqpo9uWWxHLFH6EcnZogJSSSkL66TSB1RLkq8W0V+9M/4L
   nsetHvGbQ7OncvVeHW8MF94EpYSrwDxT4y+fa/RdetAi8LthVSTEc6KR+
   6n2sOSkoJ240JFuvztXKTcLSsLaeDiIL0pxTgBZ8uvTkfS5C3b+DQaokt
   GOZVhyIFcvcDbIQT3WcmdCqlWQQzQGLtDU8abyUjIf9NHZVOYvGPeKRR0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263792395"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263792395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="592540812"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 14:47:59 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngZDy-00051M-A9;
        Mon, 18 Apr 2022 21:47:58 +0000
Date:   Tue, 19 Apr 2022 05:47:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1943/2356]
 include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h:
 No such file or directory
Message-ID: <202204190533.RhBbw7Jd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 80c0e4074fec30c33ea852116b08b7a37de62224 [1943/2356] headers/deps: Optimize <linux/jump_label.h>, remove the <linux/atomic_api.h> inclusion in the CONFIG_JUMP_LABEL=y case
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220419/202204190533.RhBbw7Jd-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=80c0e4074fec30c33ea852116b08b7a37de62224
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 80c0e4074fec30c33ea852116b08b7a37de62224
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:12,
                    from include/linux/sched/thread_info_api.h:5,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> include/linux/sched/per_task.h:48:11: fatal error: generated/asm-offsets.h: No such file or directory
      48 | # include <generated/asm-offsets.h>
         |           ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:120: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +48 include/linux/sched/per_task.h

dcac6390a2220f Ingo Molnar 2021-09-05  42  
dcac6390a2220f Ingo Molnar 2021-09-05  43  #ifndef __PER_TASK_GEN
dcac6390a2220f Ingo Molnar 2021-09-05  44  /*
dcac6390a2220f Ingo Molnar 2021-09-05  45   * These offsets get generated via the scripts/gen-pertask.sh script,
dcac6390a2220f Ingo Molnar 2021-09-05  46   * and the pertask rules in the top level Kbuild file:
dcac6390a2220f Ingo Molnar 2021-09-05  47   */
dcac6390a2220f Ingo Molnar 2021-09-05 @48  # include <generated/asm-offsets.h>
dcac6390a2220f Ingo Molnar 2021-09-05  49  #endif
dcac6390a2220f Ingo Molnar 2021-09-05  50  

:::::: The code at line 48 was first introduced by commit
:::::: dcac6390a2220f99834d2d14650fb82f2da9136b headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

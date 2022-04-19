Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421150625F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbiDSC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbiDSC55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:57:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D215721
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650336916; x=1681872916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qsv9b4NZJX/flvzAMh6aKCoGU6ZZlcR8myASj0fJAV4=;
  b=lEoBEslwZ+/0axRpE8NDQihxjSD6pFhpF7C98FL/sRfoo3PtF+USVj0d
   ICcL+rINi9eScq4wj0hZvqxvi0EV3RyFk3nS5LM29MzPIXb00doZOM6Bj
   SPsY3OWL/r8XIUIY0fG018WT/M/4gz3WiUqpbnPGIylFqVrRctehKp4ly
   oIhlRHjv4KM8hPZAUI3ZhG47EPxUI2Iyy5vr0doZDZraYXspJYb2L6DGM
   M4fxpTvXx2zCLYomYC/DZI22+LXve/gtaZVQ2ydWQowrsgjzonw+XAaQR
   oo96eNb3w0eE1VZR/ZO3W+EfpVOWnQaXIBnHHN6QWLRC2H7BwZMKsf2Hp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263834784"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263834784"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="702033378"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2022 19:55:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nge1K-0005Eo-Fm;
        Tue, 19 Apr 2022 02:55:14 +0000
Date:   Tue, 19 Apr 2022 10:55:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 84/2356]
 include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h'
 file not found
Message-ID: <202204191032.OSML9oKj-lkp@intel.com>
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
commit: dcac6390a2220f99834d2d14650fb82f2da9136b [84/2356] headers/deps: per_task: Add the per_task infrastructure for x86, arm64, sparc and MIPS
config: s390-randconfig-r044-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191032.OSML9oKj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=dcac6390a2220f99834d2d14650fb82f2da9136b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout dcac6390a2220f99834d2d14650fb82f2da9136b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:9:
   In file included from include/linux/sched.h:12:
>> include/linux/sched/per_task.h:48:11: fatal error: 'generated/asm-offsets.h' file not found
   # include <generated/asm-offsets.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:120: arch/s390/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +48 include/linux/sched/per_task.h

    42	
    43	#ifndef __PER_TASK_GEN
    44	/*
    45	 * These offsets get generated via the scripts/gen-pertask.sh script,
    46	 * and the pertask rules in the top level Kbuild file:
    47	 */
  > 48	# include <generated/asm-offsets.h>
    49	#endif
    50	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

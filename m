Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0898505F22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiDRVJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiDRVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:09:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB42C663
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650316017; x=1681852017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9R0wQrTZvHWCB6+wGqfmiOvTCNP5cqdXP8co6oMGGBU=;
  b=fqEhBX0q8UCLs7ZBplD4fg+CxVL4yN0RyN2USg2Tv0otOHZ9FVBtGTug
   6g7ZCitIrbLVgyTRZkr+XuRG/o9C3Y8gJA26dspU5NUMIAqGBBGJSLWnD
   ECv6cREgqZxikQ8dAh0A0VYhI1dzfhfg2QvXACsBCYO9y2aenhTMb16gR
   6Rw35b9HZhBZSStpYvXSKPUOtAPeEfI2qrIgFKHt4G/GQpdxBT6gyXFzN
   8X8vReyKF5R3C69OdS8jGY+Pk5LVmG1tmmvGrckDFTcmcGixg6Z8kuKR5
   ClQKJRNXAj1Ue90YEgxoHBMH2V1wSWX8UHCFynCEzBlYDwehVEgtJ2Vdf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262471477"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="262471477"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 14:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="804424499"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2022 14:06:56 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngYaF-0004yw-DQ;
        Mon, 18 Apr 2022 21:06:55 +0000
Date:   Tue, 19 Apr 2022 05:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 627/2356]
 include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No
 such file or directory
Message-ID: <202204190507.HPPUYrSc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 8f4012659d7f54036074d08da273cb686c819191 [627/2356] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220419/202204190507.HPPUYrSc-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8f4012659d7f54036074d08da273cb686c819191
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 8f4012659d7f54036074d08da273cb686c819191
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/barrier.h:42,
                    from arch/arc/include/asm/cmpxchg.h:12,
                    from arch/arc/include/asm/atomic.h:13,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:28,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No such file or directory
      16 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:120: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 include/asm-generic/barrier.h

    15	
  > 16	#include <asm/vdso/processor.h>
    17	#include <linux/compiler.h>
    18	#include <linux/kcsan-checks.h>
    19	#include <asm/rwonce.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

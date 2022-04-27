Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74926511127
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358114AbiD0Gbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiD0Gbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:31:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176DBD64DB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651040911; x=1682576911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JLp/BBxMmqRHZ2q0w/Uq5qUy8ba1NPv+DMKzusAEUE0=;
  b=VWH51qZYIGt+5BSuo2q/pxROaYqcy3J/fMqdjrvOP52C+DHrb3JM8RH2
   bRyeso9V+M4lh85b1JJ2TVaZzONN6PgGMOmk+5R11/DRyADQOGNUKQE0D
   oghA7yG5ac107KzBrfnkEyJJVKOUzFg63bBsnuwOv/viEdMwZIxQf90On
   pHVOmeYCKexKchAFV2yxrM93yeDAyXhds5uj8TDZNRq2FhsIltzey5Rx+
   UKYMmnoBmj6lBHsn3m0ZJc2/YmD6ElS9BmC24gy79tC30vafGkjvLPo4L
   sx6XhR4rAc3ngoy0q6OfgjK4QKbGvM3Ia6/vYR6vYXMJ1snHHTRP0K5/I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326321068"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326321068"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596128832"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2022 23:28:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njbA3-0004P0-Qu;
        Wed, 27 Apr 2022 06:28:27 +0000
Date:   Wed, 27 Apr 2022 14:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 18/20]
 arch/riscv/include/asm/signal32.h:10:5: warning: no previous prototype for
 'compat_setup_rt_frame'
Message-ID: <202204271410.2nEyxccE-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   8d05fa26dd28024fc3f915bf06be41ab7c3204ab
commit: 299073d795e482ae6a762105fbc3953ec445badd [18/20] riscv: compat: signal: Add rt_frame implementation
config: riscv-randconfig-r042-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271410.2nEyxccE-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/299073d795e482ae6a762105fbc3953ec445badd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout 299073d795e482ae6a762105fbc3953ec445badd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/signal.c:18:
>> arch/riscv/include/asm/signal32.h:10:5: warning: no previous prototype for 'compat_setup_rt_frame' [-Wmissing-prototypes]
      10 | int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:316:27: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
     316 | asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
         |                           ^~~~~~~~~~~~~~~~


vim +/compat_setup_rt_frame +10 arch/riscv/include/asm/signal32.h

     5	
     6	#if IS_ENABLED(CONFIG_COMPAT)
     7	int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
     8				  struct pt_regs *regs);
     9	#else
  > 10	int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
    11				  struct pt_regs *regs)
    12	{
    13		return -1;
    14	}
    15	#endif
    16	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

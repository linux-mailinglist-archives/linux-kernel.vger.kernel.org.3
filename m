Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C09590790
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiHKUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:51:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AE21838
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660251068; x=1691787068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1guxBjV4L2/kscYiefwYB2PAaUnqMQ49wnw1CGKJhcU=;
  b=C+gnMuErcaq5ZQBIDBmlrbR6WFj7RT7YC/b46Nd74/Ik9WSl7Iza2q6Y
   89pT+eXfyICNB0Y4BbePWKVqBg4JbdK6BRmik713FjzOBaZ/wfkP0yyGC
   sWsnG5f7qoDKPC+/NDTcRCZqvduuPIpztabeU1L9zCx78d19b6y7Gp0oJ
   UGDXWceKZu8+SC+4oGgl7XHlf4c6K98sIskReaq+ceGBcD6SdFQ9/8C7W
   4/+f6XI+AuLGKW6ju7AX2CvWa7Mkdcj4oDL1TcRhXo2eCi9sWXV0Kg8t0
   1sZlUpLuevie933/CzPkPf++VQBzm6g767AbQC0psbTWZDzj1jkPHIxM8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290213103"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290213103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="747961723"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Aug 2022 13:51:06 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMF8z-0000eO-2u;
        Thu, 11 Aug 2022 20:51:05 +0000
Date:   Fri, 12 Aug 2022 04:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [broonie-misc:arm64-sme-fixes 3/4]
 arch/arm64/kernel/fpsimd.c:1394:21: error: too many arguments to function
 call, expected single argument 'task', have 2 arguments
Message-ID: <202208120424.12sjZabd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git arm64-sme-fixes
head:   faced24c84ad18ee30b91d041299519ce6190f28
commit: 6c9a05d1aa66fd95573944dc9bc0f7ce09785129 [3/4] arm64/sme: Don't flush SVE register state when allocating SME storage
config: arm64-randconfig-r026-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120424.12sjZabd-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=6c9a05d1aa66fd95573944dc9bc0f7ce09785129
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sme-fixes
        git checkout 6c9a05d1aa66fd95573944dc9bc0f7ce09785129
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/fpsimd.c:1394:21: error: too many arguments to function call, expected single argument 'task', have 2 arguments
           sve_alloc(current, true);
           ~~~~~~~~~          ^~~~
   arch/arm64/include/asm/fpsimd.h:259:20: note: 'sve_alloc' declared here
   static inline void sve_alloc(struct task_struct *task) { }
                      ^
   arch/arm64/kernel/fpsimd.c:1445:21: error: too many arguments to function call, expected single argument 'task', have 2 arguments
           sve_alloc(current, false);
           ~~~~~~~~~          ^~~~~
   arch/arm64/include/asm/fpsimd.h:259:20: note: 'sve_alloc' declared here
   static inline void sve_alloc(struct task_struct *task) { }
                      ^
   2 errors generated.


vim +/task +1394 arch/arm64/kernel/fpsimd.c

  1374	
  1375	/*
  1376	 * Trapped SVE access
  1377	 *
  1378	 * Storage is allocated for the full SVE state, the current FPSIMD
  1379	 * register contents are migrated across, and the access trap is
  1380	 * disabled.
  1381	 *
  1382	 * TIF_SVE should be clear on entry: otherwise, fpsimd_restore_current_state()
  1383	 * would have disabled the SVE access trap for userspace during
  1384	 * ret_to_user, making an SVE access trap impossible in that case.
  1385	 */
  1386	void do_sve_acc(unsigned long esr, struct pt_regs *regs)
  1387	{
  1388		/* Even if we chose not to use SVE, the hardware could still trap: */
  1389		if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
  1390			force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
  1391			return;
  1392		}
  1393	
> 1394		sve_alloc(current, true);
  1395		if (!current->thread.sve_state) {
  1396			force_sig(SIGKILL);
  1397			return;
  1398		}
  1399	
  1400		get_cpu_fpsimd_context();
  1401	
  1402		if (test_and_set_thread_flag(TIF_SVE))
  1403			WARN_ON(1); /* SVE access shouldn't have trapped */
  1404	
  1405		/*
  1406		 * Even if the task can have used streaming mode we can only
  1407		 * generate SVE access traps in normal SVE mode and
  1408		 * transitioning out of streaming mode may discard any
  1409		 * streaming mode state.  Always clear the high bits to avoid
  1410		 * any potential errors tracking what is properly initialised.
  1411		 */
  1412		sve_init_regs();
  1413	
  1414		put_cpu_fpsimd_context();
  1415	}
  1416	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

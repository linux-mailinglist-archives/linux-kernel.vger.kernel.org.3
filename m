Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9035590824
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiHKVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiHKVcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:32:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5609DB57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660253529; x=1691789529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XknC17ubDdpaD7F1AGFPopxa1YkUMtTBT/cnizLsIHw=;
  b=Fa+iWd0qL14vEYHtVv/Vdp/qNXnmnbmd1inyjAOW2/pQuKmWgqhHcgOm
   vnqkHbTN5M/jXxFFHonityJfSUUKIMqdXE2C0tAxO8DWFsG+bbe6vw0gj
   PcsToEppRoC6N3xwXjbhAvvnfgbCqguIKYc036354jke1f02VJwuE5BFA
   KlrwjzcCRbfdG2aiPk/wJO77BlYLl6unHkhdVLrvjTeZVoY9RLjSsG3cR
   tAfn5umiF2C6wveJqLfubaEukRcVE2W3hLnkJu0R6C5+SC9uVNs70uH4o
   hWHncCtpyCJFWhbvzxcV99bLk+qb8lg1IJczaO75xrsmVWtaJtHupsuX8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290219419"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="290219419"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 14:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="695045596"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2022 14:32:07 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMFmh-0000gl-0h;
        Thu, 11 Aug 2022 21:32:07 +0000
Date:   Fri, 12 Aug 2022 05:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [broonie-misc:arm64-sme-fixes 3/4]
 arch/arm64/kernel/fpsimd.c:1394:9: error: too many arguments to function
 'sve_alloc'
Message-ID: <202208120542.o1cfDXOQ-lkp@intel.com>
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
config: arm64-buildonly-randconfig-r001-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120542.o1cfDXOQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git/commit/?id=6c9a05d1aa66fd95573944dc9bc0f7ce09785129
        git remote add broonie-misc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
        git fetch --no-tags broonie-misc arm64-sme-fixes
        git checkout 6c9a05d1aa66fd95573944dc9bc0f7ce09785129
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/fpsimd.c: In function 'do_sve_acc':
>> arch/arm64/kernel/fpsimd.c:1394:9: error: too many arguments to function 'sve_alloc'
    1394 |         sve_alloc(current, true);
         |         ^~~~~~~~~
   In file included from arch/arm64/include/asm/processor.h:377,
                    from include/asm-generic/qrwlock.h:18,
                    from ./arch/arm64/include/generated/asm/qrwlock.h:1,
                    from arch/arm64/include/asm/spinlock.h:9,
                    from include/linux/spinlock.h:93,
                    from include/linux/ipc.h:5,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/arm64/kernel/fpsimd.c:14:
   arch/arm64/include/asm/fpsimd.h:259:20: note: declared here
     259 | static inline void sve_alloc(struct task_struct *task) { }
         |                    ^~~~~~~~~
   arch/arm64/kernel/fpsimd.c: In function 'do_sme_acc':
   arch/arm64/kernel/fpsimd.c:1445:9: error: too many arguments to function 'sve_alloc'
    1445 |         sve_alloc(current, false);
         |         ^~~~~~~~~
   arch/arm64/include/asm/fpsimd.h:259:20: note: declared here
     259 | static inline void sve_alloc(struct task_struct *task) { }
         |                    ^~~~~~~~~


vim +/sve_alloc +1394 arch/arm64/kernel/fpsimd.c

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

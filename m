Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D556B53DFC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiFFCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFFCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:42:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55E5FAF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654483326; x=1686019326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xVXMcQwY0aJcevRtQjXnp0zA3g1dhniZpoE914+VDE0=;
  b=HuPRImBi2llBydAj9z5nKpl8NMkOu+7LEjnSGM0G8nOoy6VjrN8Vvbtn
   7TpfvX87N2swIuKMwBGGK4ArakBQ+OWSxT5HSjP8siLFQGy4Ly9w4HoJ0
   a6REcNmZ6vH6D5df7pu45CelGO+qv8ruZS9BfbjjnPEOF68V8gbQr0ERs
   YnwLLfozfdLkyycFlwHkXX8RvSu7emKroG3TZw3jc957ZyWWlMV3w7cyn
   G0I4D5RQZjeG8YV3YF3YZFbeRfvuTf/DddzZIi3a/kFFbi4bY5m7iYYog
   Q1UW6sS16HUn/VsvbFV3rk+Gunr3EwbMX4jHzxqYu6/RrBGTiNB/Dw3CH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339753627"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="339753627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 19:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="554268389"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2022 19:42:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny2gt-000CQk-Rk;
        Mon, 06 Jun 2022 02:42:03 +0000
Date:   Mon, 6 Jun 2022 10:41:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/idle 35/37] arch/arm/mach-omap2/pm34xx.c:259:17:
 error: implicit declaration of function 'cpuidle_rcu_enter'
Message-ID: <202206061030.nJjn2zh6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle
head:   e11e56428f57b36930eb0f8eed997a462010aa95
commit: 62afaa7d0110b1859122c56074cdd8ed5758836b [35/37] cpuidle,omap3: Push RCU-idle into omap_sram_idle()
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220606/202206061030.nJjn2zh6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=62afaa7d0110b1859122c56074cdd8ed5758836b
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/idle
        git checkout 62afaa7d0110b1859122c56074cdd8ed5758836b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/mach-omap2/pm34xx.c: In function 'omap_sram_idle':
>> arch/arm/mach-omap2/pm34xx.c:259:17: error: implicit declaration of function 'cpuidle_rcu_enter' [-Werror=implicit-function-declaration]
     259 |                 cpuidle_rcu_enter();
         |                 ^~~~~~~~~~~~~~~~~
>> arch/arm/mach-omap2/pm34xx.c:267:17: error: implicit declaration of function 'rcuidle_rcu_exit'; did you mean 'rcu_idle_exit'? [-Werror=implicit-function-declaration]
     267 |                 rcuidle_rcu_exit();
         |                 ^~~~~~~~~~~~~~~~
         |                 rcu_idle_exit
   cc1: some warnings being treated as errors


vim +/cpuidle_rcu_enter +259 arch/arm/mach-omap2/pm34xx.c

   176	
   177	void omap_sram_idle(bool rcuidle)
   178	{
   179		/* Variable to tell what needs to be saved and restored
   180		 * in omap_sram_idle*/
   181		/* save_state = 0 => Nothing to save and restored */
   182		/* save_state = 1 => Only L1 and logic lost */
   183		/* save_state = 2 => Only L2 lost */
   184		/* save_state = 3 => L1, L2 and logic lost */
   185		int save_state = 0;
   186		int mpu_next_state = PWRDM_POWER_ON;
   187		int per_next_state = PWRDM_POWER_ON;
   188		int core_next_state = PWRDM_POWER_ON;
   189		u32 sdrc_pwr = 0;
   190		int error;
   191	
   192		mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
   193		switch (mpu_next_state) {
   194		case PWRDM_POWER_ON:
   195		case PWRDM_POWER_RET:
   196			/* No need to save context */
   197			save_state = 0;
   198			break;
   199		case PWRDM_POWER_OFF:
   200			save_state = 3;
   201			break;
   202		default:
   203			/* Invalid state */
   204			pr_err("Invalid mpu state in sram_idle\n");
   205			return;
   206		}
   207	
   208		/* NEON control */
   209		if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
   210			pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
   211	
   212		/* Enable IO-PAD and IO-CHAIN wakeups */
   213		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
   214		core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
   215	
   216		pwrdm_pre_transition(NULL);
   217	
   218		/* PER */
   219		if (per_next_state == PWRDM_POWER_OFF) {
   220			error = cpu_cluster_pm_enter();
   221			if (error)
   222				return;
   223		}
   224	
   225		/* CORE */
   226		if (core_next_state < PWRDM_POWER_ON) {
   227			if (core_next_state == PWRDM_POWER_OFF) {
   228				omap3_core_save_context();
   229				omap3_cm_save_context();
   230			}
   231		}
   232	
   233		/* Configure PMIC signaling for I2C4 or sys_off_mode */
   234		omap3_vc_set_pmic_signaling(core_next_state);
   235	
   236		omap3_intc_prepare_idle();
   237	
   238		/*
   239		 * On EMU/HS devices ROM code restores a SRDC value
   240		 * from scratchpad which has automatic self refresh on timeout
   241		 * of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
   242		 * Hence store/restore the SDRC_POWER register here.
   243		 */
   244		if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
   245		    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
   246		     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
   247		    core_next_state == PWRDM_POWER_OFF)
   248			sdrc_pwr = sdrc_read_reg(SDRC_POWER);
   249	
   250		/*
   251		 * omap3_arm_context is the location where some ARM context
   252		 * get saved. The rest is placed on the stack, and restored
   253		 * from there before resuming.
   254		 */
   255		if (save_state)
   256			omap34xx_save_context(omap3_arm_context);
   257	
   258		if (rcuidle)
 > 259			cpuidle_rcu_enter();
   260	
   261		if (save_state == 1 || save_state == 3)
   262			cpu_suspend(save_state, omap34xx_do_sram_idle);
   263		else
   264			omap34xx_do_sram_idle(save_state);
   265	
   266		if (rcuidle)
 > 267			rcuidle_rcu_exit();
   268	
   269		/* Restore normal SDRC POWER settings */
   270		if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
   271		    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
   272		     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
   273		    core_next_state == PWRDM_POWER_OFF)
   274			sdrc_write_reg(sdrc_pwr, SDRC_POWER);
   275	
   276		/* CORE */
   277		if (core_next_state < PWRDM_POWER_ON &&
   278		    pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
   279			omap3_core_restore_context();
   280			omap3_cm_restore_context();
   281			omap3_sram_restore_context();
   282			omap2_sms_restore_context();
   283		} else {
   284			/*
   285			 * In off-mode resume path above, omap3_core_restore_context
   286			 * also handles the INTC autoidle restore done here so limit
   287			 * this to non-off mode resume paths so we don't do it twice.
   288			 */
   289			omap3_intc_resume_idle();
   290		}
   291	
   292		pwrdm_post_transition(NULL);
   293	
   294		/* PER */
   295		if (per_next_state == PWRDM_POWER_OFF)
   296			cpu_cluster_pm_exit();
   297	}
   298	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

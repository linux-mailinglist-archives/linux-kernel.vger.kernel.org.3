Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87948474C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiADR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:58:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:49306 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236002AbiADR6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641319086; x=1672855086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3aHfGis+ADckH+AIMmUjPad6EvZbiJ12lgE/zVKuvY=;
  b=OyMX+yQREn912ex+PXV4iz3hvHwpecbvy2UXNpnBuDdGuR9udfACtxp+
   ijP6uDPWaFz41b3lWxBTE7PAYpBwxbhB6jO0MzGSTG8FweKgOD2sfMYHh
   VIHOvZ1ab4MllNDpcncy0nfLpNdxpD5OV0wWShQUtxHaMpHPb577FRb8t
   KXY5/JAYC2+dCnlwP1RH+Yye3EkIBS8GWH3AepU6h+yedPJmQHcKEbRni
   2y8qfApYNtSLsTI48USoMTciMz7THe2QkuKMeSA4iBKKssbEqPJ5tirKk
   Wz3JdotKsOpjrLM3k83KMJn96Q1Cf1ydTiz3LHuYxHVz9KpqknumpDU1s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="229086952"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="229086952"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 09:58:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="760517793"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 09:58:03 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4o4R-000Fik-8s; Tue, 04 Jan 2022 17:58:03 +0000
Date:   Wed, 5 Jan 2022 01:57:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: undefined reference to `cpu_fa526_suspend_size'
Message-ID: <202201050124.3dKURJnk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: a871be6b8eee13a35a3e8e56c62770ef17ee9220 cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver
date:   1 year, 7 months ago
config: arm-randconfig-r002-20220102 (https://download.01.org/0day-ci/archive/20220105/202201050124.3dKURJnk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a871be6b8eee13a35a3e8e56c62770ef17ee9220
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a871be6b8eee13a35a3e8e56c62770ef17ee9220
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>> (.text+0x60): undefined reference to `cpu_fa526_suspend_size'
   arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>> suspend.c:(.text+0x240): undefined reference to `cpu_fa526_do_suspend'
>> arm-linux-gnueabi-ld: suspend.c:(.text+0x268): undefined reference to `cpu_fa526_do_resume'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
   qcom_scm-smc.c:(.text+0x58): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
   qcom_scm-legacy.c:(.text+0x32c): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   qcom_scm-legacy.c:(.text+0x6b0): undefined reference to `__arm_smccc_smc'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

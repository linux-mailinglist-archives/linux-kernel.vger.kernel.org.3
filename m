Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1556B4AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiGHIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiGHIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:45:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3F82382
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657269939; x=1688805939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0nPjfTvziEOzQO6qKPLQ8317faZJQJoSrVI5pFj51gY=;
  b=aJkE0zBNta9YjAbJfBI1ZmJ/HlkAnhtL1soKqO4mdFyXgtzB8VZjrQN1
   4oH5dBpbEG8RciASNM7Mjd00qyAZHEon60Np/fVTl6v49l56ho4Nlx4GV
   exINExq8hVIdoYnJWi8Lv/GtJuLMj/JMcC0r0hwIHN40uYftdGG35CgWu
   cRZv55UOljjBU2m7AcleSnIq6VRihJn5AdaqpJOJPi1jBbh5s1OaPvSrj
   9ZHnsz5adYnZlwih3h+wE40PLwale+KBkRV2G5UYTphDgbaWS4WhT2SNP
   edHAMZwRTFSAWv5ZmG4tceaFenfL4uAZXffKJLhB6qZftGw2SmHcHfvSm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285360851"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="285360851"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 01:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="920926044"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2022 01:45:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9jcG-000NDC-Qi;
        Fri, 08 Jul 2022 08:45:36 +0000
Date:   Fri, 8 Jul 2022 16:45:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: undefined reference to `cpu_sa110_suspend_size'
Message-ID: <202207081607.gztBTG5X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8a4e1c1bb697b1d9fc48f0e56dc0f50bc024bee
commit: a871be6b8eee13a35a3e8e56c62770ef17ee9220 cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver
date:   2 years, 1 month ago
config: arm-randconfig-r013-20220708 (https://download.01.org/0day-ci/archive/20220708/202207081607.gztBTG5X-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a871be6b8eee13a35a3e8e56c62770ef17ee9220
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a871be6b8eee13a35a3e8e56c62770ef17ee9220
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>> (.text+0x60): undefined reference to `cpu_sa110_suspend_size'
   arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>> suspend.c:(.text+0x1d8): undefined reference to `cpu_sa110_do_suspend'
>> arm-linux-gnueabi-ld: suspend.c:(.text+0x210): undefined reference to `cpu_sa110_do_resume'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
>> qcom_scm-smc.c:(.text+0x58): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
>> qcom_scm-legacy.c:(.text+0x25c): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   qcom_scm-legacy.c:(.text+0x4d0): undefined reference to `__arm_smccc_smc'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

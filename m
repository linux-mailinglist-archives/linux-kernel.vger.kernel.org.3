Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC22474CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhLNUjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:39:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:1085 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234688AbhLNUjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639514371; x=1671050371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PdxDshG3BnxLmtJyl8oB4oJmFU4uoshssKT1Au1peLw=;
  b=O6xlgO17HPu7WIVDlZh+aNyUv2uwlKN7Vt+4rVD6Ny4MYYvZeOUWz64s
   mGlegiGGl9DJbQcZKVlXPtFVDFXgRJmlK3rnowHw1G6q58zBvgyHEhB5J
   hj788F5GX14wa98GDi6Sv/7T1HnzmOMnQ95XfbkAuX6dW72TZXQ9wXyne
   ueNSw8sRlVdQn7f2g5Scuv5CRO7QVLQVfKCThhdXZam9m4wRyiFy/7cCC
   uLYtKlpy6IyX4Vzh5xQ/uHap7Qn8bAw8Pe6irDkehK1+5ttuSvcmGZgfZ
   Ks17GAtcoDQ/O64v9lLUKFjN/kkmUzW7Oyog15fa8hcNC/EUUFlo1scl/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="239302518"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="239302518"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="463947351"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Dec 2021 12:39:28 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxEa7-0000ky-Pu; Tue, 14 Dec 2021 20:39:27 +0000
Date:   Wed, 15 Dec 2021 04:39:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: undefined reference to `cpu_sa110_suspend_size'
Message-ID: <202112150401.4b6Ct9qs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: a871be6b8eee13a35a3e8e56c62770ef17ee9220 cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver
date:   1 year, 7 months ago
config: arm-randconfig-r022-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150401.4b6Ct9qs-lkp@intel.com/config)
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
>> (.text+0x60): undefined reference to `cpu_sa110_suspend_size'
   arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>> suspend.c:(.text+0x214): undefined reference to `cpu_sa110_do_suspend'
>> arm-linux-gnueabi-ld: suspend.c:(.text+0x23c): undefined reference to `cpu_sa110_do_resume'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
   qcom_scm-smc.c:(.text+0x58): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
   qcom_scm-legacy.c:(.text+0x208): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   qcom_scm-legacy.c:(.text+0x568): undefined reference to `__arm_smccc_smc'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

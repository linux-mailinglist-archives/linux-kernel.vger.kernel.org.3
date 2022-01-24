Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57B3497FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiAXMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:48:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:12083 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242419AbiAXMsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643028522; x=1674564522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3nwN0hx21Lx5ZwvsTHcMABim4juwojq3bG2Xylw1ZzQ=;
  b=RSu+u6ysMfQ3kW5fvpVUSIMeVxzXGol1GhEc5QR/bySxNp+TN/AHGng9
   qVpeE8NUMj8xRtN+WeIXZ5ZA+H6ntDHiz6O3ROz+uytDHnXk3894OtrdQ
   +75ACGQko72V3K1q1AIYjc9EhttjxUH+dU43nXHmfnXPFE3pXhEqHyEUw
   AfHFQj6jALkCet+Kuy+CaNTN7T8bHtzHF1WT7kEnz9NdCWWUiHueSDfK2
   KBR6LrmhsoB//FAC5bHHBYipFkOmTz9Et4J26GBzhd3ECbBMnhr6UqR7k
   Z7Q/Sw4DfiYyaVjuqvt7mlW1OY8Ybjjbd76ygUYnDq8e73rJcc4WGVxLj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244870435"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244870435"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627485545"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 04:48:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBylz-000IKT-TW; Mon, 24 Jan 2022 12:48:39 +0000
Date:   Mon, 24 Jan 2022 20:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: undefined reference to `cpu_sa110_suspend_size'
Message-ID: <202201242024.a86cwUlS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: faae6c9f2e68e62687636a7d6e0517b3bf594add cpuidle: tegra: Enable compile testing
date:   4 months ago
config: arm-randconfig-r036-20220123 (https://download.01.org/0day-ci/archive/20220124/202201242024.a86cwUlS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faae6c9f2e68e62687636a7d6e0517b3bf594add
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout faae6c9f2e68e62687636a7d6e0517b3bf594add
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
   arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>> suspend.c:(.text+0x15c): undefined reference to `cpu_sa110_do_suspend'
>> arm-linux-gnueabi-ld: suspend.c:(.text+0x184): undefined reference to `cpu_sa110_do_resume'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64 && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

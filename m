Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C04B0D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiBJMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:35:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiBJMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:35:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B621BB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644496548; x=1676032548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dg3mYH/kxWETIHR59Cu6igjsfuGx8EecWXhf54VEyNg=;
  b=iBLJ3m8l0Qn1TwajhbrIOlP3PEzBJwnGGPH2t/+oqv2I5fnsy6wY75df
   aIqBj1+Ic+PoogK1temcnlwNfXOIOyq2mZjeCL5Nn4oexnisMSkRoxGBN
   6Ce2w7iLyDexBW6EEy9X2JSLjLXRZnoGMMNAfgfhevKog/YF/VFZMh+0M
   Mfy8f4e/zi6m6Kn4G5KaBZeV06TFvwzs8EU4z65stEt6W5DQJBCvKTUfb
   /7/xc+4gbeYl5VV4P8zbiEJb5y1BY4y0hvF4osqK8fGhcA3823YOrx4Uk
   /pYDS2wiGbjeHJRIF6ELZ10hv6kJDXXdV6jhynEz0G4nCc35ABDu5E+r+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248311513"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="248311513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 04:35:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="482750305"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 04:35:45 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI8fl-0003Cl-Tz; Thu, 10 Feb 2022 12:35:41 +0000
Date:   Thu, 10 Feb 2022 20:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: ld.lld: error: undefined symbol: cpu_arm925_suspend_size
Message-ID: <202202102039.wkitu2Mo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed
commit: faae6c9f2e68e62687636a7d6e0517b3bf594add cpuidle: tegra: Enable compile testing
date:   4 months ago
config: arm-buildonly-randconfig-r004-20220210 (https://download.01.org/0day-ci/archive/20220210/202202102039.wkitu2Mo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project aa845d7a245d85c441d0bd44fc7b6c3be8f3de8d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faae6c9f2e68e62687636a7d6e0517b3bf594add
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout faae6c9f2e68e62687636a7d6e0517b3bf594add
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>> ld.lld: error: undefined symbol: cpu_arm925_suspend_size
   >>> referenced by kernel/sleep.o:(.text+0x68) in archive arch/arm/built-in.a
--
>> ld.lld: error: undefined symbol: cpu_arm925_do_suspend
   >>> referenced by suspend.c
   >>> kernel/suspend.o:(__cpu_suspend_save) in archive arch/arm/built-in.a
--
>> ld.lld: error: undefined symbol: cpu_arm925_do_resume
   >>> referenced by suspend.c
   >>> kernel/suspend.o:(__cpu_suspend_save) in archive arch/arm/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64 && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA150CD8B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiDWVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiDWVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:18:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7D2CE08
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650748559; x=1682284559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ghR7zmzRRlZ8AQDiWjZSUUuq015qDScyozYGR7A57rE=;
  b=IsfxPBocjBBlcOjQ/sEISpYoiZBMeiCLvJijFNIl762ond6jAnVXsdPt
   CTff3tf1p+hSa43GViO8dcft4OKOw8mKUvKe38EME3RW8pCpI2Fl2XA2H
   LblfDpMqtqe2BDpeVBQXoLF9uZZv4nl+KAiTEbD6/67OSTX0uz+9CFXNr
   R+FjDVZw7TIcP+Epy3day+ttyFPSgPT6WQdWRJhoraGuEBTyX26dhIdQF
   RPMmFouvW9j10Ir+Ifz51w39dYsFEbGRLwCw3xWAo4OTT0YJG31gQn/bm
   0ZmLCkrRYH1+OvxzoBTzg+WBiJ+g5gIm4OToJugkR+bCVYQgMGV9PkLKA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="246864447"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="246864447"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 14:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="649124969"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2022 14:15:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niN6i-0000U5-S0;
        Sat, 23 Apr 2022 21:15:56 +0000
Date:   Sun, 24 Apr 2022 05:15:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: ld.lld: error: undefined symbol: cpu_sa110_suspend_size
Message-ID: <202204240554.gz9y0hb8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45ab9400e73f34103e73c18a73280c9aa1650e98
commit: faae6c9f2e68e62687636a7d6e0517b3bf594add cpuidle: tegra: Enable compile testing
date:   7 months ago
config: arm-buildonly-randconfig-r006-20220423 (https://download.01.org/0day-ci/archive/20220424/202204240554.gz9y0hb8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=faae6c9f2e68e62687636a7d6e0517b3bf594add
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout faae6c9f2e68e62687636a7d6e0517b3bf594add
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>> ld.lld: error: undefined symbol: cpu_sa110_suspend_size
   >>> referenced by kernel/sleep.o:(.text+0x68) in archive arch/arm/built-in.a
--
>> ld.lld: error: undefined symbol: cpu_sa110_do_suspend
   >>> referenced by suspend.c
   >>> kernel/suspend.o:(__cpu_suspend_save) in archive arch/arm/built-in.a
--
>> ld.lld: error: undefined symbol: cpu_sa110_do_resume
   >>> referenced by suspend.c
   >>> kernel/suspend.o:(__cpu_suspend_save) in archive arch/arm/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64 && MMU

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

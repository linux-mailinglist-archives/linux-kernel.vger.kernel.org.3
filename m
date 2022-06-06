Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10E53DFC3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiFFCmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352198AbiFFCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:42:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200E640E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654483334; x=1686019334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fit8HZMPGvo/+C1wqhHEmiPdAbd1OryM+h5M+okK88U=;
  b=kceVARGhz0X+DYysLzYrqB262E3kUqjYf5u92tmqUh89tKekNwlxE4+4
   jXB58yiU2FI92Dztt3Dau4XlX4lNtovlLpnIgB+Of3WrO1xtKj/kAUwqc
   ml9r58yiVBus8IY8KQl7GUNwh2UG4DpIOvqNT6o7qNPbUm53uzaI22spw
   HwaDZy+5au0GnDP7siulcstEHVJSBmF2d18sOhN+xwx4KQHR/OV9mfelj
   7fIDqDyuhcr1DptmaRV0/V4tadPayeloLlqSRElMd39iSrbNucFVBZRc4
   yXJO0FfxZwBr5APL7yiTRnXmwr+E0Asap29HgP40UnUHv1HodJZO6VvYG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="257059796"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257059796"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 19:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906315383"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2022 19:42:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny2gt-000CQX-Or;
        Mon, 06 Jun 2022 02:42:03 +0000
Date:   Mon, 6 Jun 2022 10:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_pmu 4/4] arch/riscv/include/asm/kvm_host.h:19:10:
 fatal error: 'asm/kvm_vcpu_pmu.h' file not found
Message-ID: <202206061019.MqcefJj0-lkp@intel.com>
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

tree:   https://github.com/atishp04/linux kvm_pmu
head:   9df21c8955e9552aae9109be01c0f910e4023667
commit: 9df21c8955e9552aae9109be01c0f910e4023667 [4/4] RISC-V: KVM: Add skeleton support
config: riscv-buildonly-randconfig-r009-20220605 (https://download.01.org/0day-ci/archive/20220606/202206061019.MqcefJj0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/atishp04/linux/commit/9df21c8955e9552aae9109be01c0f910e4023667
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_pmu
        git checkout 9df21c8955e9552aae9109be01c0f910e4023667
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
>> arch/riscv/include/asm/kvm_host.h:19:10: fatal error: 'asm/kvm_vcpu_pmu.h' file not found
   #include <asm/kvm_vcpu_pmu.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1196: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +19 arch/riscv/include/asm/kvm_host.h

    11	
    12	#include <linux/types.h>
    13	#include <linux/kvm.h>
    14	#include <linux/kvm_types.h>
    15	#include <linux/spinlock.h>
    16	#include <asm/csr.h>
    17	#include <asm/kvm_vcpu_fp.h>
    18	#include <asm/kvm_vcpu_timer.h>
  > 19	#include <asm/kvm_vcpu_pmu.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

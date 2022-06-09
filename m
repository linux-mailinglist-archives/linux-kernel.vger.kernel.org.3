Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A25442FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiFIFOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiFIFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:14:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774A1D33C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654751664; x=1686287664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JhwWV4vhu7Ay/TAEQ+c91OdBzA8eqH3hi6OKy45wrCs=;
  b=fqJ/VOkU8yQiA4S5KaTZx2SGjb45jf/Lf5+OEaLioByUwktPrNWf/3Q2
   YmZBAClg9ocDRuAWpfjCZIAaCi6y2haOTLw/X8oVfnSh8xmUpeTTcz9H1
   YXpdLaCFA6p7ksWP6IS+kaVhSQICDRW6Q1Yf9NF/4BHLzx9GTg2qyj4wT
   ubbi2N7RW6iOAV2etw0XLyky5umiKjIUyKD9x1yn3eBoggnAc5fVbGG7z
   MlTwSjDM+CPNqquI4zBJbBObK5XpNtsPkMz9NGXMr3gdihRAGP+SEL4NP
   fOK66P0gKhSCC0HtS2JcZvpgufsmTLmBFfX+rvHnVrSEF7eW6pwQqi/RT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="257580369"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257580369"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 22:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="670969502"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 22:14:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzAUr-000FWz-Dt;
        Thu, 09 Jun 2022 05:14:17 +0000
Date:   Thu, 9 Jun 2022 13:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_pmu 4/4] arch/riscv/include/asm/kvm_host.h:19:10:
 fatal error: asm/kvm_vcpu_pmu.h: No such file or directory
Message-ID: <202206091219.XaPQOekY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_pmu
head:   9df21c8955e9552aae9109be01c0f910e4023667
commit: 9df21c8955e9552aae9109be01c0f910e4023667 [4/4] RISC-V: KVM: Add skeleton support
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220609/202206091219.XaPQOekY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/9df21c8955e9552aae9109be01c0f910e4023667
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_pmu
        git checkout 9df21c8955e9552aae9109be01c0f910e4023667
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
>> arch/riscv/include/asm/kvm_host.h:19:10: fatal error: asm/kvm_vcpu_pmu.h: No such file or directory
      19 | #include <asm/kvm_vcpu_pmu.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCF5857D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 03:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiG3Blh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 21:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Blf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:41:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985725580
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659145294; x=1690681294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+ZFrWdT5w7fOlmSyxjoJaUmkPG4mqRS2WST55codl+Q=;
  b=dP+J0TrZHWPZ/jwvpkxgHGTbu4xkAyddgFIm0n1xO2SMI3SEd0UCDaQW
   DkE0WYqbW88GxLPx7fft8y3BKM7KowMDSaY9Jo0tfwFEuiZbL0C8S9W0L
   IFhVdn1sVA8keRCxaM7C2ZN3Z3rNiKZsPcUnpIUk4saekKA6mgenfx1pJ
   FoHnHXjESnZ++B5If3dpwVZ8Br9aer/ehGVfsQxntfWotw5a3t17TgB/H
   IeLUYIV52LQ/MPaSQFE+6W1/cV6DmqS+7wfEJPx5UbT5qdSi9tcRuyURk
   2a+eXmn9yNOLOU8UqL/Qe0xxWg+zxmlcjsLmGeuZ4gnbGVOfEQrAsMduo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350585474"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="350585474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 18:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="629581692"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 18:41:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHbTv-000CFh-1X;
        Sat, 30 Jul 2022 01:41:31 +0000
Date:   Sat, 30 Jul 2022 09:41:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc_snapshot 25/25]
 arch/riscv/kernel/vdso.c:22:8: error: redefinition of 'vdso_data'
Message-ID: <202207300903.wVzezhrh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc_snapshot
head:   42182a0a79a8768e22fd70232c3aca2bc1a26a43
commit: 42182a0a79a8768e22fd70232c3aca2bc1a26a43 [25/25] RISC-V: PoC for SBI PMU SNAPSHOT
config: riscv-randconfig-r042-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300903.wVzezhrh-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/atishp04/linux/commit/42182a0a79a8768e22fd70232c3aca2bc1a26a43
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc_snapshot
        git checkout 42182a0a79a8768e22fd70232c3aca2bc1a26a43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/vdso.c:17:
   In file included from arch/riscv/include/asm/vdso/vsyscall.h:8:
   In file included from include/vdso/datapage.h:137:
   arch/riscv/include/asm/vdso/gettimeofday.h:21:31: error: use of undeclared identifier '__NR_gettimeofday'
           register long nr asm("a7") = __NR_gettimeofday;
                                        ^
   arch/riscv/include/asm/vdso/gettimeofday.h:37:31: error: use of undeclared identifier '__NR_clock_gettime'
           register long nr asm("a7") = __NR_clock_gettime;
                                        ^
   arch/riscv/include/asm/vdso/gettimeofday.h:53:31: error: use of undeclared identifier '__NR_clock_getres'
           register long nr asm("a7") = __NR_clock_getres;
                                        ^
>> arch/riscv/kernel/vdso.c:22:8: error: redefinition of 'vdso_data'
   struct vdso_data {
          ^
   include/vdso/datapage.h:90:8: note: previous definition is here
   struct vdso_data {
          ^
   4 errors generated.


vim +/vdso_data +22 arch/riscv/kernel/vdso.c

bb4a23c994aebc Tong Tiangen   2021-09-01  18  
0aa2ec8a475fb5 Guo Ren        2021-01-02  19  #ifdef CONFIG_GENERIC_TIME_VSYSCALL
ad5d1122b82fbd Vincent Chen   2020-06-09  20  #include <vdso/datapage.h>
ad5d1122b82fbd Vincent Chen   2020-06-09  21  #else
bb4a23c994aebc Tong Tiangen   2021-09-01 @22  struct vdso_data {
bb4a23c994aebc Tong Tiangen   2021-09-01  23  };
ad5d1122b82fbd Vincent Chen   2020-06-09  24  #endif
76d2a0493a17d4 Palmer Dabbelt 2017-07-10  25  

:::::: The code at line 22 was first introduced by commit
:::::: bb4a23c994aebcd96c567a0be8e964d516bd4a61 riscv/vdso: Refactor asm/vdso.h

:::::: TO: Tong Tiangen <tongtiangen@huawei.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

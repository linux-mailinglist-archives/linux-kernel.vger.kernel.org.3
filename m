Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671CB515ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382224AbiD3G1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiD3G1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D4CFE4D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651299820; x=1682835820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7uashMg9ZzX8VmjSNIB7rQRnoiyqTWQEXZbjTb2v5Oo=;
  b=a9G+HmtAf69i7HUn/yN9cVPsJ5/5ivpIzaCZsLqdntd6GfEuA2SSpNoS
   LBEk/VjMpR3X8MVBxek2I1+xSOL/fGEwM9vwPFNswnh6D1fFVwOYCejjK
   mcLMu2WqE+jJKy+562tMLBrbn+XGRIRd9aCc+Agq/f9+mYsbFivpEERQ1
   IKq/JdEmtt6/fb+BUdK+Ht1rA1L3irvXrTR/mnwWbsLx8nbLJhk76dhmF
   U0gEjjWXYhl0ppYNjhGb8KpOEID9JU66mMcQxBNQvbxaY90TIHIav1LUS
   sFiuLB9Oj3NEnCAvYFgpe2QXvIBuZsq1LQxaQFz5TeHfIzVM0Ah4YWdvi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="327347277"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="327347277"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 23:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="882526339"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 23:23:37 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkgW1-0006wz-Ao;
        Sat, 30 Apr 2022 06:23:37 +0000
Date:   Sat, 30 Apr 2022 14:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:palmer/linux/riscv-compat 20/20]
 arch/riscv/kernel/compat_syscall_table.o:undefined reference to
 `compat_sys_fadvise64_64'
Message-ID: <202204301415.3MDixdty-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-compat
head:   e2009fdf858d6fe01f0b24e35d8347fc8da3210f
commit: e2009fdf858d6fe01f0b24e35d8347fc8da3210f [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-r001-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301415.3MDixdty-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e2009fdf858d6fe01f0b24e35d8347fc8da3210f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-compat
        git checkout e2009fdf858d6fe01f0b24e35d8347fc8da3210f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: riscv64-linux-ld: DWARF error: could not find abbrev number 714588
>> arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

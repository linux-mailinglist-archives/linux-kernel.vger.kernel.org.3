Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3755454E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiFIT1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFIT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:27:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B8A23144B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654802868; x=1686338868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dwbJ+/CwQE2hq57q29wiq/sY6C/lUcDWuRnCYcuI0R0=;
  b=XWybpE8MVlWJUk8ahQm/j/mYC2+BpWHvUc+ZtxPyxAuHOBngmSvAR6//
   F8Bol2EVJ7lmU84eTeca70T01Rfj25FgwmuJklU9Uh8s4MBUJ8Hz9FO8e
   DraKOPW24vY+AcY5TxQD66gUuJqxofLEri/xCAwn5g5tEWCI79YcPJ6Mc
   nizsToYH+IU9/j2xyLFKVU3VP9OnJyMZJIjAYtx9+fkZNUfF4CIsJxWPM
   fDipSIZ3kJ2QQwJPliitCJ6sccgfOyABHBLZHYpFcheND496dTiyGL0tu
   651JRRPKu8VLIfDbxCKNTqwgP+cfPzxzlrDtKpjMbB04PNfE9/u+OiOER
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257825260"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257825260"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 12:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585763058"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 12:27:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzNoo-000GJZ-2X;
        Thu, 09 Jun 2022 19:27:46 +0000
Date:   Fri, 10 Jun 2022 03:26:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>
Subject: riscv64-linux-ld: kernel/kexec_core.c:962: undefined reference to
 `machine_kexec'
Message-ID: <202206100324.B0KDSd1C-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 6261586e0c91db14c34f894f4bc48f2300cff1d4 RISC-V: Add kexec_file support
date:   3 weeks ago
config: riscv-randconfig-r010-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100324.B0KDSd1C-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6261586e0c91db14c34f894f4bc48f2300cff1d4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6261586e0c91db14c34f894f4bc48f2300cff1d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/kexec_core.o: in function `kimage_free':
>> kernel/kexec_core.c:651: undefined reference to `machine_kexec_cleanup'
   riscv64-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
>> kernel/kexec_core.c:961: undefined reference to `machine_crash_shutdown'
>> riscv64-linux-ld: kernel/kexec_core.c:962: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_core.o: in function `crash_setup_regs':
>> arch/riscv/include/asm/kexec.h:35: undefined reference to `riscv_crash_save_regs'
   riscv64-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
>> kernel/kexec_core.c:1180: undefined reference to `machine_shutdown'
   riscv64-linux-ld: kernel/kexec_core.c:1184: undefined reference to `machine_kexec'
   riscv64-linux-ld: kernel/kexec_file.o: in function `__do_sys_kexec_file_load':
>> kernel/kexec_file.c:397: undefined reference to `machine_kexec_prepare'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

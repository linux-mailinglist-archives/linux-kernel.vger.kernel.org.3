Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E094F563C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446168AbiDFFy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576423AbiDFD7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:59:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481717E360
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649204444; x=1680740444;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K5kbfIDJmlBYIWvqAz/JOBQiUWKwrVzabwOvv99khaU=;
  b=hZ0D2eoldXRWLIKqiI9yZKHgAMs88DM+zavOvBvdMXBD8yJ2WArAT27R
   G1bpGi3soKEUiG5zS+bjf33fd6jvntvvIZ98tXSHDjfq3SHQc+DFcSLW0
   aTrEGBhcvOpflh4hxxY5emLgJQyWOl5ZDAfRmedKzBV6nxq2vdDrmt71i
   AZJtq9fSNjSG8ITW2W1RBrgbL0BoWeHoQTHUu/PcT4nTi58d3zBJlkpn5
   i/g8pvusDNH6jNo0Rb/pX1mo9ellS5lXitb0wjbqyeyrJfK6gFWEdJ57a
   REvSGAUM2D4DWTiPPl8w+55DlXmckGcbnwSPSmrcEf70crczSLIrMZs6/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240835787"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="240835787"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 17:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="524228214"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 17:20:42 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbtPd-0003uH-MZ;
        Wed, 06 Apr 2022 00:20:41 +0000
Date:   Wed, 6 Apr 2022 08:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [csky-linux:riscv_compat_v12 20/20] riscv64-linux-ld:
 arch/riscv/kernel/compat_syscall_table.o:undefined reference to
 `compat_sys_fadvise64_64'
Message-ID: <202204060829.hZRXlFGY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v12
head:   55a9982536831dca39b4334923e5446e870cdfaf
commit: 55a9982536831dca39b4334923e5446e870cdfaf [20/20] riscv: compat: Add COMPAT Kbuild skeletal support
config: riscv-randconfig-c004-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060829.hZRXlFGY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/55a9982536831dca39b4334923e5446e870cdfaf
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v12
        git checkout 55a9982536831dca39b4334923e5446e870cdfaf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8): undefined reference to `compat_sys_fadvise64_64'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

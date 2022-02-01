Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E84A5E15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiBAORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:17:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:53610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239002AbiBAORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643725069; x=1675261069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OZ7gGebmf52cWRB9ws2v3wm4kqouWj3t7yNEm336X+E=;
  b=d8oEaPkC4eTjvGJe7P3hW36SAlRr9Qin1kEXyvCNwDvuro2qtupL6keb
   1xAx83w3rx9Svjr6j0UEy5HQRSJfBys9jH7AGiaHu7Okjy9z+NHRa2ysc
   AUDl9tUgafFGHFiaMpKZ7GrXHLCsPtvIrkMWAbeXsGOYHCpM0YSzBGlFK
   ddqBPgL3maRtuknVntCuMYX9ajNZtxOwa62/6U1svapgs9BhhClgEycOr
   jTU7ZtxBwsVtQw66uFgsb+3YuctjmZY8PLvIgtQk7sF4pcsS8sj2QAYM5
   rl4tNyLpVfxvYX1NQ/IJwjP5ENGdiD/a7Lo3TviUz2BbClAphubvRGRHv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235091232"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235091232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 06:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="482398232"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2022 06:17:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEtya-000TLq-DQ; Tue, 01 Feb 2022 14:17:44 +0000
Date:   Tue, 1 Feb 2022 22:17:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [csky-linux:riscv_compat_v5 6/20]
 arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'struct
 compat_statfs'
Message-ID: <202202012248.krtLYM9t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v5
head:   aa4c02d74aabad67e00439d2cec2e296ab6d451d
commit: ec2542a61a8a75165df0c14f215f6b4f3821ee36 [6/20] asm-generic: compat: Cleanup duplicate definitions
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202012248.krtLYM9t-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/ec2542a61a8a75165df0c14f215f6b4f3821ee36
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v5
        git checkout ec2542a61a8a75165df0c14f215f6b4f3821ee36
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/stat.h:13,
                    from include/linux/stat.h:6,
                    from include/linux/sysfs.h:22,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
>> arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'struct compat_statfs'
      69 | struct compat_statfs {
         |        ^~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/compat.h:18,
                    from arch/arm64/include/asm/stat.h:13,
                    from include/linux/stat.h:6,
                    from include/linux/sysfs.h:22,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   include/asm-generic/compat.h:80:8: note: originally defined here
      80 | struct compat_statfs {
         |        ^~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +69 arch/arm64/include/asm/compat.h

3dd681d944f6d8 Will Deacon 2012-03-05  68  
3dd681d944f6d8 Will Deacon 2012-03-05 @69  struct compat_statfs {
3dd681d944f6d8 Will Deacon 2012-03-05  70  	int		f_type;
3dd681d944f6d8 Will Deacon 2012-03-05  71  	int		f_bsize;
3dd681d944f6d8 Will Deacon 2012-03-05  72  	int		f_blocks;
3dd681d944f6d8 Will Deacon 2012-03-05  73  	int		f_bfree;
3dd681d944f6d8 Will Deacon 2012-03-05  74  	int		f_bavail;
3dd681d944f6d8 Will Deacon 2012-03-05  75  	int		f_files;
3dd681d944f6d8 Will Deacon 2012-03-05  76  	int		f_ffree;
3dd681d944f6d8 Will Deacon 2012-03-05  77  	compat_fsid_t	f_fsid;
3dd681d944f6d8 Will Deacon 2012-03-05  78  	int		f_namelen;	/* SunOS ignores this field. */
3dd681d944f6d8 Will Deacon 2012-03-05  79  	int		f_frsize;
3dd681d944f6d8 Will Deacon 2012-03-05  80  	int		f_flags;
3dd681d944f6d8 Will Deacon 2012-03-05  81  	int		f_spare[4];
3dd681d944f6d8 Will Deacon 2012-03-05  82  };
3dd681d944f6d8 Will Deacon 2012-03-05  83  

:::::: The code at line 69 was first introduced by commit
:::::: 3dd681d944f6d861f12ee03aff17a14342963330 arm64: 32-bit (compat) applications support

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

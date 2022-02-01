Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18D54A6106
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiBAQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:10:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:10547 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240802AbiBAQKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643731836; x=1675267836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=189fYGHJVlj5zOLzKTwYfYzrrePatfGTa6H0kI7Cuf8=;
  b=PNUltdqMVjtkLhRVeHK83K3EvMcixk3rtKxxA/cVyFFKiLt2lDaSqkCg
   tXZ377CBp4VkmaZM9mZs883Qkco+NgGVZp7NR/HPMg4huN5/1G1gxHMc0
   IrzTO7CDkmokYQhN5bXp3QkG4SSCU/D98ng4ih+9PF4y+tq7MINQHhz2h
   Eyc7V+IvDcvRxwB5TLPRf6UwFYHVbryvqmnV2lhBYnBbfygTm40PU+kNx
   xiNgNuCF9N9Jkb5EEqjfJY4+GGd5nvJGcZE2JgAJLKFxk9Bd8wB/UsDOS
   omIDTCUiPnw4ibLb9zLWhIDWuha5DxTy2THelosyeDc5DAk0yzmuv+65m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227695125"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="227695125"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 08:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="523096311"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2022 08:09:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEvj6-000TS5-4Z; Tue, 01 Feb 2022 16:09:52 +0000
Date:   Wed, 2 Feb 2022 00:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [csky-linux:riscv_compat_v5 6/21]
 arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'compat_statfs'
Message-ID: <202202020013.HE3OoT9n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v5
head:   653df84165a3999569804361df88af1a54d58180
commit: ec2542a61a8a75165df0c14f215f6b4f3821ee36 [6/21] asm-generic: compat: Cleanup duplicate definitions
config: arm64-randconfig-r031-20220130 (https://download.01.org/0day-ci/archive/20220202/202202020013.HE3OoT9n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/ec2542a61a8a75165df0c14f215f6b4f3821ee36
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v5
        git checkout ec2542a61a8a75165df0c14f215f6b4f3821ee36
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/irqdomain.h:35:
   In file included from include/linux/of.h:17:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:22:
   In file included from include/linux/stat.h:6:
   In file included from arch/arm64/include/asm/stat.h:13:
>> arch/arm64/include/asm/compat.h:69:8: error: redefinition of 'compat_statfs'
   struct compat_statfs {
          ^
   include/asm-generic/compat.h:80:8: note: previous definition is here
   struct compat_statfs {
          ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1191: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/compat_statfs +69 arch/arm64/include/asm/compat.h

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

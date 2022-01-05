Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23054858CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbiAETDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:03:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:51377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243281AbiAETCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641409371; x=1672945371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6RL6i+995RCk1Eg4QyoHBl8zRiaN8zqrZrNQdGFDY3k=;
  b=APiPNatKkY+YImApBnWR0VUNdw/oTFMEjiM1bgONByM50FQ7wwUKEJXr
   FkgWAaPs8TPm6MjfE96N359VXuth019unPUB50DcrVkx/K5jgU8QZS//a
   5ZO9eJaatQzn+Q3vd56GoO/tr51WGig7f4dZ7/qRJMwU0TpLuCdv0YZr9
   jA0nLnb9KePO0WtWyy+eEKDwJ+0jNnkeQl7SunDw9TsAVJVthVVdeDglp
   ypEwoJyVSv5PR/LucSJ1HA9P4ni0m4u/o86fmkrsikut7Kzd4uEV+1lvf
   RSwTvQ4pl696v11ARZTa0y+vMDToD1oBsTBFgDKFeBP2sgWym98F42iJP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242722705"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242722705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 11:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="513099383"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 11:02:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5BYf-000GyH-Qw; Wed, 05 Jan 2022 19:02:49 +0000
Date:   Thu, 6 Jan 2022 03:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined
 reference to `__clzdi2'
Message-ID: <202201060233.mO6P39bM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   8 weeks ago
config: mips-randconfig-r025-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060233.mO6P39bM-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e0c1b49f5b674cca7b10549c53b3791d0bbc90a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_buildDTable_internal':
>> decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `BIT_initDStream':
   decompress.c:(.text.BIT_initDStream+0x7c): undefined reference to `__clzdi2'
   mips64el-linux-ld: decompress.c:(.text.BIT_initDStream+0x158): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_buildFSETable_body_default.constprop.0':
>> decompress.c:(.text.ZSTD_buildFSETable_body_default.constprop.0+0x2a8): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_readNCount_body_default':
>> decompress.c:(.text.FSE_readNCount_body_default+0x130): undefined reference to `__ctzdi2'
>> mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x1a4): undefined reference to `__ctzdi2'
>> mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x2e4): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `HUF_readStats_body_default':
>> decompress.c:(.text.HUF_readStats_body_default+0x184): undefined reference to `__clzdi2'
>> mips64el-linux-ld: decompress.c:(.text.HUF_readStats_body_default+0x1b4): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_DCtx_getParameter':
>> decompress.c:(.text.ZSTD_DCtx_getParameter+0x60): undefined reference to `__clzdi2'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

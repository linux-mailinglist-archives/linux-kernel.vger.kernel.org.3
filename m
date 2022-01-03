Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC9482F07
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiACIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:33:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:10262 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbiACIdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641198786; x=1672734786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fQMz1hVZEsbaIXYku1j+q/Uy7AByZ5xgs1qh9vL2AkY=;
  b=N+ZtmXfu6IRE8j4cRRYyn2bg30J2PnlxgrHSrVW7eQk3INb1uFR6iJCW
   NZBFb0XCBl+Awhxo+iQ9YNXQpmWjKgjd+E+orj0Piu/SXUxVCiMuslWpE
   B5qIy0IxqotKGt6HCmXaYzRw7DSZIK6WzWfDOAqFx+yW32afcCroRMOD3
   Xlv4BpCYal3YzGtjB8XissfC1BohfReyy2woD6Qu0JPfQaqN5FRpD1ksq
   3yJgjAdDe8xToy4vkMBnRWHz3KGCBX8UY6mM4/GUnHwoeUyNApnQhhkDF
   IWC4BUc1qFBWWDlh6lRi+Os9Vcfav2UgBmGO/O4kbTuLlHir1XwkUGl0V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229342011"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="229342011"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="471584912"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 00:33:02 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4Im5-000E22-HH; Mon, 03 Jan 2022 08:33:01 +0000
Date:   Mon, 3 Jan 2022 16:32:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v2_sv48_v3_xtpbmt 3/32] error:
 include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
Message-ID: <202201031613.GNQ5t0pt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_xtpbmt
head:   ff10a70d2ed4fbef7238b315145d1aa0d137f80f
commit: 838b95dc803e1fba08bd1aca85bb3c40f174548c [3/32] asm-generic: fcntl: compat: Remove duplicate definitions
config: arm-randconfig-c002-20220102 (https://download.01.org/0day-ci/archive/20220103/202201031613.GNQ5t0pt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 104a827ea6de0cbe0f5faef4407552ede31d165c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/c-sky/csky-linux/commit/838b95dc803e1fba08bd1aca85bb3c40f174548c
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_xtpbmt
        git checkout 838b95dc803e1fba08bd1aca85bb3c40f174548c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> error: include/uapi/asm-generic/fcntl.h: leak CONFIG_COMPAT to user-space
   make[2]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/fcntl.h] Error 1
   make[2]: Target '__headers' not remade because of errors.
   make[1]: *** [Makefile:1283: headers] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABB4AA1A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiBDVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:12:54 -0500
Received: from mga17.intel.com ([192.55.52.151]:30136 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240693AbiBDVMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644009171; x=1675545171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nJFBLm/FwqnHzLEEUUpZHXIbCOjQ31o3RLj1kPQYLAA=;
  b=LfR2/lDit5lerH8YW1/BGTXdqcKZhb8v+0xGP5ktASIZwTxqqykMd/T4
   SgH0OtCH+le92TjNkuJl8xiI5cvwPqPMWO0WxCocD12YS4bezJ5UM2VS/
   cBWmYqXk+5R6psSERmLY0Ky9g3z+bWNezS32sYRsSW4J4fmoSY7RrekhY
   wpWiQzTNHXtkq3eRsSj/dhW5PYbQQgmjdEjgUBDtQfirT8MbQxHFGQ85t
   SpUfR2Agw2Z6U4egLkPFwcYbEuF6K2mah2rqld7MFLLHWnyq82NUd4r1D
   X4uNsc6B/Zq+35I7qNnPLn7/bPthhEKP3RYByKRFqv+yMEN/kwMbNFgyf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229093774"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="229093774"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 13:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="699800842"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2022 13:12:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG5su-000YCD-RK; Fri, 04 Feb 2022 21:12:48 +0000
Date:   Sat, 5 Feb 2022 05:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: ld.lld: error: undefined symbol: socfpga_reset_init
Message-ID: <202202050539.Mtk9I4Ef-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
commit: 4483397b03536506535d611b0cb28a81a69e8edf ARM: socfpga: drop ARCH_SOCFPGA
date:   11 months ago
config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220205/202202050539.Mtk9I4Ef-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4483397b03536506535d611b0cb28a81a69e8edf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4483397b03536506535d611b0cb28a81a69e8edf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: socfpga_reset_init
   >>> referenced by socfpga.c
   >>>               socfpga.o:(socfpga_init_irq) in archive arch/arm/mach-socfpga/built-in.a
   >>> referenced by socfpga.c
   >>>               socfpga.o:(socfpga_arria10_init_irq) in archive arch/arm/mach-socfpga/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

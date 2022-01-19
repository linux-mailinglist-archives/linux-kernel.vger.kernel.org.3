Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D549343A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiASFQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:16:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:13228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbiASFQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642569382; x=1674105382;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6eAuxjixhRvHzySmrvd0BLLYLzmc+AToai9hO3eAbPI=;
  b=ROaKQmADSwiQKUgUkuprUpGAtC8BFc3OEOnmRo5eWsQX4PH7hcGwBe+D
   oDAcg55pIMNzdtlqztgmxJ7ailtVHsLQcJxNRj8wmEbjUMk6Xuj49iu1k
   VIY1mVIiepY2iCnCh6mCUWZXfTKhn5MCER/tenB0MCqmKgQpGMtd19v79
   fPWiCZAQSOg9QkN0NPy4oktRjfyhLt7ug49uENY9xgAV4R4bMI1Gceb7j
   M3ZMlm1RYIxMNUiGw6mKmbNutyYCGXg4XVbSYsX+WuLig3r2tFPaLX/Tv
   AGjIFt3UyGG1NGxr231YbgWhzdSeP+oayr1wpYlP40E0lXfSq3jWmDENN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305715664"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305715664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 21:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="475009184"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2022 21:16:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA3KV-000DHm-2u; Wed, 19 Jan 2022 05:16:19 +0000
Date:   Wed, 19 Jan 2022 13:16:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 19/80] ld.lld: error: duplicate symbol: memcpy
Message-ID: <202201191332.VN9sH3bm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 7c451b4efc456af4a20559eb4108b7f21b4c98b2 [19/80] riscv: optimized memcpy
config: riscv-randconfig-r042-20220118 (https://download.01.org/0day-ci/archive/20220119/202201191332.VN9sH3bm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/7c451b4efc456af4a20559eb4108b7f21b4c98b2
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 7c451b4efc456af4a20559eb4108b7f21b4c98b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: memcpy
   >>> defined at shadow.c
   >>>            kasan/shadow.o:(memcpy) in archive mm/built-in.a
   >>> defined at string.c
   >>>            string.o:(.text+0x4DA) in archive lib/lib.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

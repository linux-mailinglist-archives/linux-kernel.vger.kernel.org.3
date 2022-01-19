Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17A74933A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351300AbiASDcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:32:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:43369 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240019AbiASDcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642563137; x=1674099137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NWb6o10YkMR7sZLMPrRdvgZA0dRx9dnvTEsr5v2wEKM=;
  b=nWbPZcdKOoGY++PQaTAoaVfFM26ldHZpfJemSJsoCFV/2PrPsYyTigWf
   gE7dygi4jBryCIgC3SI2badKe4wXo9mmksWhwWxbwm3BKbPrGemzSPYz/
   m3CFmJmfpuBYcOblsdB98e2mgwvGyBu/w6+ULpD17p3TmhcUTDa/jctNE
   JaS7TmVTQOyKfNZRnG4WHcl0HsNzjWlGoPErrSTMglkLJy2bzvtac3erI
   NbtcLrAdS3B5+1kvXq+1GDpttvhC0QXEsm8eYp/v1f6BS0+XO2OsR4hDy
   inG3gFCEqU8XgkN3cgGUu9s/FDElgULMzyhLy+UZ5J/FeNhsQrZjWv2+c
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="243795017"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="243795017"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 19:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="595267684"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2022 19:32:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA1hm-000DCi-TM; Wed, 19 Jan 2022 03:32:14 +0000
Date:   Wed, 19 Jan 2022 11:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [ammarfaizi2-block:palmer/linux/riscv-sv48 7/9] WARNING: modpost:
 vmlinux.o(.text+0xb1ae): Section mismatch in reference from the function
 pt_ops_set_early() to the function .init.text:alloc_pte_early()
Message-ID: <202201191139.HXrwZv5w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-sv48
head:   d87f3297c62644624bcb8efcb519a2e28d684b45
commit: dee563c628683ce1fab7d0267ad96fc7d8503965 [7/9] riscv: Implement sv48 support
config: riscv-randconfig-r042-20220116 (https://download.01.org/0day-ci/archive/20220119/202201191139.HXrwZv5w-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/dee563c628683ce1fab7d0267ad96fc7d8503965
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-sv48
        git checkout dee563c628683ce1fab7d0267ad96fc7d8503965
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xb1ae): Section mismatch in reference from the function pt_ops_set_early() to the function .init.text:alloc_pte_early()
The function pt_ops_set_early() references
the function __init alloc_pte_early().
This is often because pt_ops_set_early lacks a __init
annotation or the annotation of alloc_pte_early is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xb1f8): Section mismatch in reference from the function pt_ops_set_late() to the function .init.text:alloc_pte_late()
The function pt_ops_set_late() references
the function __init alloc_pte_late().
This is often because pt_ops_set_late lacks a __init
annotation or the annotation of alloc_pte_late is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xb1ae): Section mismatch in reference from the function pt_ops_set_early() to the variable .init.data:_pt_ops.1
<< WARNING: modpost: vmlinux.o(.text+0xb208): Section mismatch in reference from the function pt_ops_set_late() to the variable .init.data:_pt_ops.1
<< WARNING: modpost: vmlinux.o(.text+0xb1ae): Section mismatch in reference from the function pt_ops_set_early() to the variable .init.data:_pt_ops.1
<< WARNING: modpost: vmlinux.o(.text+0xb208): Section mismatch in reference from the function pt_ops_set_late() to the variable .init.data:_pt_ops.1

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125EA492DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbiARSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:52:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:26425 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348235AbiARSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642531927; x=1674067927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+klORxsX0yp8ZJQTooOCq8M2oqxHKFaKz44SypuiMpU=;
  b=QSqFR+heXMgdfj2QhRXonWJX4GFkvTZjG+kxw1CZpRlqsSF15yOJVh+g
   2z16v4PquI1f7wsimJlpoGdexGlBztdWmVZ3tkKjGMSBWlQG3slV5iq2i
   3akJ050f65kAM9+SbXzeRIdHUITZ+zHGrtVrYOQGchwsh5mV+VPzuR82J
   wo8eEKnUic7awxoxjG1wgSd8rFtSGPnwPLJBrkLuzIzmGVHJ7daMWy6+m
   mI7QRZJgXXAghtpNB7b1GjG7/g3OItL/DM92Zoi0B14LAPpmTAXUhVq7h
   Qx5nbD9WTaBNhtfDdHtSjkqOZE4+POammAYemWl6lyZn26HritpVr25/G
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="242450916"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="242450916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="517875175"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 10:52:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9taO-000CrM-MW; Tue, 18 Jan 2022 18:52:04 +0000
Date:   Wed, 19 Jan 2022 02:51:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [csky-linux:riscv_compat_v2_sv48_v3_mmind_pbmt 40/44]
 arch/riscv/kernel/cpufeature.c:185:6: warning: variable 'cpu_apply_feature'
 set but not used
Message-ID: <202201190211.LvmwaVLe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v2_sv48_v3_mmind_pbmt
head:   b28a50c03a72c48d3895320bdd0757e0a8acb881
commit: 414a3c26e45780d9f957d3721666dfe099b8643c [40/44] riscv: add cpufeature handling via alternatives
config: riscv-randconfig-r026-20220116 (https://download.01.org/0day-ci/archive/20220119/202201190211.LvmwaVLe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c10cbb243cafc0cf42c3e922cb29183279444432)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/c-sky/csky-linux/commit/414a3c26e45780d9f957d3721666dfe099b8643c
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v2_sv48_v3_mmind_pbmt
        git checkout 414a3c26e45780d9f957d3721666dfe099b8643c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/cpufeature.c:185:6: warning: variable 'cpu_apply_feature' set but not used [-Wunused-but-set-variable]
           u32 cpu_apply_feature = 0;
               ^
   1 warning generated.


vim +/cpu_apply_feature +185 arch/riscv/kernel/cpufeature.c

   180	
   181	void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
   182					 unsigned int stage)
   183	{
   184		u32 cpu_req_feature = cpufeature_probe(stage);
 > 185		u32 cpu_apply_feature = 0;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

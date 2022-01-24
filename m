Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28BB497CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiAXKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:09:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:25263 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbiAXKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643018987; x=1674554987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mzGQhVQDgBYYPhcKKevgCjhvNgROu8zTRBpJZujDBHI=;
  b=N8T0dnjElF/6sIEE9iYKSkGjC28hq0lx6DaPhIDOgLQUDUBHrjdQJOu8
   b3FmR4I2crqmYBmxgXnIaMVA0AtIdUNb/JLeTP1Ek57T679qjB+kxbCu3
   532EBrWjrMWllXrxrAh64b6nz07uhRRz81eoh5RDRr6SiZXiZ5htUO1Tm
   MvOHEaVGjtARo8LVmORdVvnzRCQjmBGYwL+PHUlBHFbtEV2mjyYOswETy
   bLY5T4edDYpR7Ohh5FVY6pZiJYxiBlUtEkUBdVTvQGbX6SCd+zvdb83jM
   zdfKBNob+fV07Vd5wO83g80/OA7882271SPF4dU7JJ7kIZHjcvbaCe0Ht
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309333158"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309333158"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627443321"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 02:09:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBwHx-000IBI-G3; Mon, 24 Jan 2022 10:09:29 +0000
Date:   Mon, 24 Jan 2022 18:09:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>
Subject: arch/riscv/kernel/cpu_ops_sbi.c:24:1: sparse: sparse: symbol
 '__pcpu_scope_boot_data' was not declared. Should it be static?
Message-ID: <202201241842.sQ6Y0PbO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 9a2451f1866344d38b4a1dc20396e3a03954fcd7 RISC-V: Avoid using per cpu array for ordered booting
date:   4 days ago
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220124/202201241842.sQ6Y0PbO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a2451f1866344d38b4a1dc20396e3a03954fcd7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9a2451f1866344d38b4a1dc20396e3a03954fcd7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/cpu_ops_sbi.c:24:1: sparse: sparse: symbol '__pcpu_scope_boot_data' was not declared. Should it be static?

vim +/__pcpu_scope_boot_data +24 arch/riscv/kernel/cpu_ops_sbi.c

    18	
    19	/*
    20	 * Ordered booting via HSM brings one cpu at a time. However, cpu hotplug can
    21	 * be invoked from multiple threads in parallel. Define a per cpu data
    22	 * to handle that.
    23	 */
  > 24	DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
    25	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

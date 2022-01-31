Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90AA4A5340
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiAaXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:31:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:49100 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbiAaXb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643671916; x=1675207916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9lv5dt3N9VvdYZyFib3TnJcZcmZn6Ub2ZHD/YJODUKI=;
  b=oJJ0bcMUWgkolj9aYpgNVkrSsR6MN76iATl7OIL/H68c7fPNUia/JSqR
   +kgx4hR8obiuZK2/u4jskzaYLzTXOC10jNxjQzhxcrl8tMkpo9zTvjtxM
   1KhUttIfR6MD20TlSzQvNbvKeh4UudPSW0eOH+LWZyZ0m2ralQ9OVFiYJ
   rWJ+MVqH6tJlMzry6kYVlW+szqITQii2lRw+DA2xF/msRMZkcaewYjQs7
   G0AoBi75me0Zk/pmcM/ZRnjXL+sD9ctNcwUYUJGLKhdjKwa756JfWW0vA
   FcO8cD3f4Ej16c1WER0N3cOBiicoH/8NOe0pNLfnMh1ZDYyrscUOatSON
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247793737"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="247793737"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="534343258"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2022 15:31:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEg9K-000SSH-15; Mon, 31 Jan 2022 23:31:54 +0000
Date:   Tue, 1 Feb 2022 07:31:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>
Subject: arch/riscv/kernel/cpu_ops_sbi.c:24:1: sparse: sparse: symbol
 '__pcpu_scope_boot_data' was not declared. Should it be static?
Message-ID: <202202010446.o5HT2xk2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26291c54e111ff6ba87a164d85d4a4e134b7315c
commit: 9a2451f1866344d38b4a1dc20396e3a03954fcd7 RISC-V: Avoid using per cpu array for ordered booting
date:   11 days ago
config: riscv-randconfig-s032-20220201 (https://download.01.org/0day-ci/archive/20220201/202202010446.o5HT2xk2-lkp@intel.com/config)
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

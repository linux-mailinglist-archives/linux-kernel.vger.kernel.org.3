Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3598558156E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiGZOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiGZOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:35:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262925D0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658846121; x=1690382121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gb+sg8tX6d1M9RdMwRFdLWI+eSIBAf4IGUSsUVC6yQM=;
  b=P1ViigmvA3HRAt2Nd82Tj6sGM1QfNEvBdpzlHDVYAU6bElEvFkGjUq5C
   YbTnZXuYAGQlYBhwJb7O1w3wcnzBRKmJl/Te/VsPjatTuPJBuhB5y+YA4
   qferm9OTZ+pST1lUEdxZ5nIiXW741NJZh5bWd/be7Qu/dGUkoO4bfPHCS
   hbFr3rwAOOEcUXiuzkwP0wkNjkCXCYeT6ztL8UEl3164AGExJw4/LdQAx
   jQ1+ZcwMs/j+NOCQM49Nxes+tg81VzXpyrIq/9m4Mm2fpZV3CjrF/g8tj
   SCy4ws5KZHqn33JYt67CqSR0beJ65RF3CXtOImcuLpGB3BrKCSAOn9qBs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289157763"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="289157763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 07:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627924138"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2022 07:35:16 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGLeV-0006v2-2W;
        Tue, 26 Jul 2022 14:35:15 +0000
Date:   Tue, 26 Jul 2022 22:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v5 5/6] arch/riscv/include/asm/atomic.h:75:
 undefined reference to `io_dma_unmap'
Message-ID: <202207262203.Z4p6l0Zg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v5
head:   4f4a93bf02dcf20e9a4a3ac0c9cd39d79e9e540e
commit: 1b0c9acb050749ce7ad964cc66eef72779835832 [5/6] io_uring: add support for dma pre-mapping
config: riscv-randconfig-s052-20220726 (https://download.01.org/0day-ci/archive/20220726/202207262203.Z4p6l0Zg-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=1b0c9acb050749ce7ad964cc66eef72779835832
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v5
        git checkout 1b0c9acb050749ce7ad964cc66eef72779835832
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.o: in function `.L0 ':
   include/linux/list.h:292:(.text+0x22): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/main.o: in function `.L0 ':
   init/main.c:185:(.init.text+0x6): relocation truncated to fit: R_RISCV_HI20 against symbol `reset_devices' defined in .sbss section in init/main.o
   init/main.c:1419:(.text.unlikely+0x2a): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/main.c:685:(.ref.text+0xe): relocation truncated to fit: R_RISCV_HI20 against `kernel_init'
   init/do_mounts.o: in function `.L0 ':
   init/do_mounts.c:279:(.text+0x22): relocation truncated to fit: R_RISCV_HI20 against `.LC15'
   init/do_mounts.c:45:(.init.text+0xa): relocation truncated to fit: R_RISCV_HI20 against `.LC0'
   init/do_mounts_initrd.o: in function `.L0 ':
   init/do_mounts_initrd.c:44:(.init.text+0xa): relocation truncated to fit: R_RISCV_HI20 against `.LC0'
   init/initramfs.o: in function `.L0 ':
   init/initramfs.c:739:(.text+0x8): relocation truncated to fit: R_RISCV_HI20 against `initramfs_cookie'
   init/initramfs.c:57:(.init.text+0xa): relocation truncated to fit: R_RISCV_HI20 against `.LC0'
   init/calibrate.o: in function `.L0 ':
   arch/riscv/include/asm/timex.h:20:(.text+0x6): relocation truncated to fit: R_RISCV_HI20 against symbol `clint_time_val' defined in .sbss section in drivers/clocksource/timer-clint.o
   init/calibrate.o: in function `.L0 ':
   init/calibrate.c:19:(.init.text+0x1c): additional relocation overflows omitted from the output
   riscv64-linux-ld: io_uring/rsrc.o: in function `.LVL65':
>> arch/riscv/include/asm/atomic.h:75: undefined reference to `io_dma_unmap'


vim +75 arch/riscv/include/asm/atomic.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  73  
4650d02ad2d9b2 Palmer Dabbelt 2017-11-14  74  ATOMIC_OPS(add, add,  i)
4650d02ad2d9b2 Palmer Dabbelt 2017-11-14 @75  ATOMIC_OPS(sub, add, -i)
4650d02ad2d9b2 Palmer Dabbelt 2017-11-14  76  ATOMIC_OPS(and, and,  i)
4650d02ad2d9b2 Palmer Dabbelt 2017-11-14  77  ATOMIC_OPS( or,  or,  i)
4650d02ad2d9b2 Palmer Dabbelt 2017-11-14  78  ATOMIC_OPS(xor, xor,  i)
fab957c11efe2f Palmer Dabbelt 2017-07-10  79  

:::::: The code at line 75 was first introduced by commit
:::::: 4650d02ad2d9b2c1c7aa36055166db6aee68f72e RISC-V: Remove unused arguments from ATOMIC_OP

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@sifive.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

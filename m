Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A394F5AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbiDFKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354870AbiDFJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:59:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE201E8151
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 23:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649226472; x=1680762472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2uOoFeMNCRJkfiR9nVln0eJV1lFjC+Kyk84cwTYw7pA=;
  b=cX58j+Hlhe7/TUlWVsyGRl1bquneOYckJXcI+wXyKEHt8sMVQ23iqS3Z
   0aT1O2saaK1br1/ZD6OgiHRAb7JrVm5MiwIFe4e6xB27rJ+Smx3QoU1DX
   kpnwz+AYqLZGnXG9xUO3JyPEYG9894rBqdswkEQF/Pjv9MR74668ky8FQ
   Iyy9xrOUpBHpjcdwl4cMkNpAI/dyF/jV0qk7YUBYuL1euBkUOie79mHY3
   5QFU2m8ILz/GMwEpnvcasdPqhvRGN5EOU+cYZUdygbnHkO/yksZgkTvzd
   L38gZUsC5eL6WaXxypQcdJexYG7/aO206T1jL4BFNMFJuUs4vA/Wem3q8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261139060"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261139060"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524328276"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 23:27:50 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbz8w-00048L-2I;
        Wed, 06 Apr 2022 06:27:50 +0000
Date:   Wed, 6 Apr 2022 14:27:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:robh/linux/dt/pop-pci-nodes 2/2]
 arm-linux-gnueabi-ld: drivers/pci/of.c:97: undefined reference to
 `of_attach_node'
Message-ID: <202204061402.HV1VNYZe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block robh/linux/dt/pop-pci-nodes
head:   b9198a9525a97d05b0bb2a7282fede92d7d2d93d
commit: b9198a9525a97d05b0bb2a7282fede92d7d2d93d [2/2] PCI: Create DT nodes if they don't exist
config: arm-buildonly-randconfig-r003-20220405 (https://download.01.org/0day-ci/archive/20220406/202204061402.HV1VNYZe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block robh/linux/dt/pop-pci-nodes
        git checkout b9198a9525a97d05b0bb2a7282fede92d7d2d93d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/softirq.o: in function `cpuhp_setup_state_nocalls':
   include/linux/cpuhotplug.h:324:(.init.text+0x28): relocation truncated to fit: R_ARM_PC24 against symbol `__cpuhp_setup_state' defined in .text section in kernel/cpu.o
   kernel/softirq.o: in function `spawn_ksoftirqd':
   kernel/softirq.c:970:(.init.text+0x30): relocation truncated to fit: R_ARM_PC24 against symbol `smpboot_register_percpu_thread' defined in .text section in kernel/smpboot.o
   kernel/softirq.o: in function `_sub_I_65535_1':
   softirq.c:(.text.startup+0x14): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_register_globals' defined in .text section in mm/kasan/generic.o
   init/main.o: in function `debug_kernel':
   init/main.c:236:(.init.text+0x60): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_store4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.o: in function `quiet_kernel':
   init/main.c:242:(.init.text+0xb8): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_store4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.o: in function `init_setup':
   init/main.c:586:(.init.text+0x134): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_store4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.o: in function `rdinit_setup':
   init/main.c:598:(.init.text+0x1a4): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_store4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.o: in function `do_early_param':
   init/main.c:736:(.init.text+0x268): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_load4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.c:736:(.init.text+0x2c0): relocation truncated to fit: R_ARM_PC24 against symbol `__asan_report_load4_noabort' defined in .text section in mm/kasan/report_generic.o
   init/main.c:736:(.init.text+0x2cc): relocation truncated to fit: R_ARM_PC24 against symbol `parameq' defined in .text section in kernel/params.o
   init/main.c:740:(.init.text+0x308): additional relocation overflows omitted from the output
   arm-linux-gnueabi-ld: drivers/pci/of.o: in function `make_dev_node':
   drivers/pci/of.c:84: undefined reference to `of_attach_node'
   arm-linux-gnueabi-ld: drivers/pci/of.o: in function `make_bus_node':
   drivers/pci/of.c:97: undefined reference to `of_attach_node'
>> arm-linux-gnueabi-ld: drivers/pci/of.c:97: undefined reference to `of_attach_node'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

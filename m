Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F757F59A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiGXPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGXPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:09:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F67FD28
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658675345; x=1690211345;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CMvdx3zpuFz4GNoAm+6N6QS5WVy0bWDsr8QtuQunqSU=;
  b=jkDQeXgKzMkHqrIPLNhlmYpGDd59CPh+JpD2Uu5hzU2NbHQ47qxFwmUs
   W8v4jRxbgdt5CWJzSitfRRVbMbxTKe7qVHhMd6+YVapCi/XJMg1IBL+/K
   l7QsNvF9s6ex1bB0l8thRsI+aZ/z2LKiKLmwU+sNgkaDBC3k0lp9t2Bsf
   bzS2CwlvEf87g+3kSTokRj89Au6dYm7jy8DdNxbZs55+vJou3CMvyZ5mf
   Wbos+iLJoWKqX8lPoTJf0y4W4TenGd9hKxk3Q4gBI+kBO4XD7uYiKbL8S
   u2tHfhEBjKm24J21hsTc0suMAztQJjlZMFWpM1VpS3Rv3MSzDhhc4U8HO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288735016"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288735016"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 08:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926602096"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 08:09:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFdE7-0003wb-1B;
        Sun, 24 Jul 2022 15:09:03 +0000
Date:   Sun, 24 Jul 2022 23:08:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_sbi_dbcn_v1 20/44]
 drivers/clocksource/timer-clint.c:250:31: error: too few arguments to
 function call, expected 2, have 1
Message-ID: <202207242327.0xOXKUOG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_sbi_dbcn_v1
head:   1b3aaa127f01dc1a35b6595c628a38b92832488d
commit: 5cbf32460e4d1f3876930e54e0b4599310c84ea4 [20/44] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20220724/202207242327.0xOXKUOG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/5cbf32460e4d1f3876930e54e0b4599310c84ea4
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_sbi_dbcn_v1
        git checkout 5cbf32460e4d1f3876930e54e0b4599310c84ea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clocksource/timer-clint.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/clocksource/timer-clint.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/clocksource/timer-clint.c:11:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/clocksource/timer-clint.c:250:31: error: too few arguments to function call, expected 2, have 1
           clint_clear_ipi(clint_ipi_irq);
           ~~~~~~~~~~~~~~~              ^
   drivers/clocksource/timer-clint.c:56:13: note: 'clint_clear_ipi' declared here
   static void clint_clear_ipi(unsigned int parent_virq, void *data)
               ^
   7 warnings and 1 error generated.


vim +250 drivers/clocksource/timer-clint.c

   214	
   215		pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
   216	
   217		rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
   218		if (rc) {
   219			pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
   220			goto fail_iounmap;
   221		}
   222	
   223		sched_clock_register(clint_get_cycles64, 64, clint_timer_freq);
   224	
   225		rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
   226					 "clint-timer", &clint_clock_event);
   227		if (rc) {
   228			pr_err("registering percpu irq failed [%d]\n", rc);
   229			goto fail_iounmap;
   230		}
   231	
   232		rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
   233					"clockevents/clint/timer:starting",
   234					clint_timer_starting_cpu,
   235					clint_timer_dying_cpu);
   236		if (rc) {
   237			pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
   238			goto fail_free_irq;
   239		}
   240	
   241		virq = ipi_mux_create(clint_ipi_irq, BITS_PER_BYTE,
   242				      &clint_ipi_ops, NULL);
   243		if (virq <= 0) {
   244			pr_err("unable to create muxed IPIs\n");
   245			rc = (virq < 0) ? virq : -ENODEV;
   246			goto fail_remove_cpuhp;
   247		}
   248	
   249		riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
 > 250		clint_clear_ipi(clint_ipi_irq);
   251	
   252		return 0;
   253	
   254	fail_remove_cpuhp:
   255		cpuhp_remove_state(CPUHP_AP_CLINT_TIMER_STARTING);
   256	fail_free_irq:
   257		free_irq(clint_timer_irq, &clint_clock_event);
   258	fail_iounmap:
   259		iounmap(base);
   260		return rc;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

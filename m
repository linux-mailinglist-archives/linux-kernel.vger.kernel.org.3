Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C858B7CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiHFSsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:48:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82BEE35
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659811688; x=1691347688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Okje35o8zphIxjWYc1UTy0Cy9NZrbkQKNfTcQc3CgoY=;
  b=PGQLa/IsXSIK4Lr+gP1mRfeF+xLuiAaeKSchgLBRSjvIbVPc65Eui9fl
   ByYG9qQQ+izDc6PICCcSJj9zch9neo1Uo2CqJpNXg8LnaNELlj6FEXoNk
   sF00EjE0ln8bhj6UNEhk4YxSviBQFKIRmBk1Cd15ZE/MW3n3fixcRYdek
   KRjNgvLC6HXOGKcjSSj9zPsOzshbGpTQ0wHbdYVZ6UwkqLujenHgwtbBJ
   Y+Wfej/0njG3vNzi2qASxUaR14F7PH8pVcEug+51m6NvCWQHTdGLpN8mc
   fNN08QdPerVtRqoUxyB9frwlwcS+QlKGeK+owJumDvTD+g1CDu0D30A0L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="270771153"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="270771153"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 11:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579856691"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2022 11:48:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKOqC-000Kaj-2o;
        Sat, 06 Aug 2022 18:48:04 +0000
Date:   Sun, 7 Aug 2022 02:47:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongson-pch-lpc.c:151:48: warning: 'struct
 acpi_madt_lpc_pic' declared inside parameter list will not be visible
 outside of this definition or declaration
Message-ID: <202208070241.PSOaN69Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: ee73f14ee9eb7e1a04051b303b56130c4dd6e048 irqchip: Add Loongson PCH LPC controller support
date:   2 weeks ago
config: mips-randconfig-r014-20220806 (https://download.01.org/0day-ci/archive/20220807/202208070241.PSOaN69Y-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee73f14ee9eb7e1a04051b303b56130c4dd6e048
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee73f14ee9eb7e1a04051b303b56130c4dd6e048
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-loongson-pch-lpc.c:151:48: warning: 'struct acpi_madt_lpc_pic' declared inside parameter list will not be visible outside of this definition or declaration
     151 |                                         struct acpi_madt_lpc_pic *acpi_pchlpc)
         |                                                ^~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-loongson-pch-lpc.c:150:12: warning: no previous prototype for 'pch_lpc_acpi_init' [-Wmissing-prototypes]
     150 | int __init pch_lpc_acpi_init(struct irq_domain *parent,
         |            ^~~~~~~~~~~~~~~~~
   In file included from include/linux/io.h:13,
                    from arch/mips/include/asm/mips-cps.h:11,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongson-pch-lpc.c:10:
   drivers/irqchip/irq-loongson-pch-lpc.c: In function 'pch_lpc_acpi_init':
   drivers/irqchip/irq-loongson-pch-lpc.c:164:41: error: invalid use of undefined type 'struct acpi_madt_lpc_pic'
     164 |         priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
         |                                         ^~
   arch/mips/include/asm/io.h:180:23: note: in definition of macro 'ioremap'
     180 |         ioremap_prot((offset), (size), _CACHE_UNCACHED)
         |                       ^~~~~~
   drivers/irqchip/irq-loongson-pch-lpc.c:164:63: error: invalid use of undefined type 'struct acpi_madt_lpc_pic'
     164 |         priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
         |                                                               ^~
   arch/mips/include/asm/io.h:180:33: note: in definition of macro 'ioremap'
     180 |         ioremap_prot((offset), (size), _CACHE_UNCACHED)
         |                                 ^~~~
   drivers/irqchip/irq-loongson-pch-lpc.c:188:38: error: invalid use of undefined type 'struct acpi_madt_lpc_pic'
     188 |         fwspec.param[0] = acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
         |                                      ^~
   drivers/irqchip/irq-loongson-pch-lpc.c:188:50: error: 'GSI_MIN_PCH_IRQ' undeclared (first use in this function)
     188 |         fwspec.param[0] = acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
         |                                                  ^~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-lpc.c:188:50: note: each undeclared identifier is reported only once for each function it appears in


vim +151 drivers/irqchip/irq-loongson-pch-lpc.c

   149	
 > 150	int __init pch_lpc_acpi_init(struct irq_domain *parent,
 > 151						struct acpi_madt_lpc_pic *acpi_pchlpc)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9114D2B59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiCIJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiCIJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:06:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455816AA7B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646816703; x=1678352703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uIZ8jOYY+QeLVW6CFvZL3AkYSNewNYFtYpjIuw+SP1A=;
  b=Z40jMPM9xuD9wJVnnvT+U6xMog0UHwj2eV0LfL14TPRYWEYkBX7F6z1E
   P7EiEmgnILNti+GxrsTdSNJCinTKrDdXRb82zqwVJOKcJrCkEehYcnjzF
   Ooomy/R/ur45Oyc9nFmX7cAGgdm5kWySAMT36pTtWYOkGmtrIZhO9MLVp
   F7CzG+G2myWUAHrtkRmsaeI8w1ba/T0Hm9EPXVcX9WWXyY1xsU6In3bba
   6QJhhuT7iCtttuXyqrxNnE8iHSm4apsUBfuO75oK/zEDvEiyr/1s6tgqT
   kO0YqYCzz2wjO9xnkgVrjdTZhx0nDxkded/4Ji/0VmIYIS2NXrPxX/6Ve
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253757416"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="253757416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="643973204"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2022 01:05:00 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRsFg-0002yI-3H; Wed, 09 Mar 2022 09:05:00 +0000
Date:   Wed, 9 Mar 2022 17:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [lpieralisi-pci:pci/rcar 2/2]
 drivers/pci/controller/pcie-rcar-host.c:139:3: error: instruction requires:
 data-barriers
Message-ID: <202203091741.IetDk7a7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/rcar
head:   9775965dbae50a04f12879179d6d6fb58f240d6b
commit: 9775965dbae50a04f12879179d6d6fb58f240d6b [2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read which triggered an exception
config: arm-randconfig-c002-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091741.IetDk7a7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=9775965dbae50a04f12879179d6d6fb58f240d6b
        git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
        git fetch --no-tags lpieralisi-pci pci/rcar
        git checkout 9775965dbae50a04f12879179d6d6fb58f240d6b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pcie-rcar-host.c:139:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("str")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
   drivers/pci/controller/pcie-rcar-host.c:153:3: error: instruction requires: data-barriers
                   __rcar_pci_rw_reg_workaround("ldr")
                   ^
   drivers/pci/controller/pcie-rcar-host.c:120:4: note: expanded from macro '__rcar_pci_rw_reg_workaround'
                   "2:     isb\n"                                          \
                    ^
   <inline asm>:2:4: note: instantiated into assembly here
   2:      isb
           ^
   2 errors generated.


vim +139 drivers/pci/controller/pcie-rcar-host.c

   132	
   133	static int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val,
   134						 unsigned int reg)
   135	{
   136		int error = PCIBIOS_SUCCESSFUL;
   137	#ifdef CONFIG_ARM
   138		asm volatile(
 > 139			__rcar_pci_rw_reg_workaround("str")
   140		: "+r"(error):"r"(val), "r"(pcie->base + reg) : "memory");
   141	#else
   142		rcar_pci_write_reg(pcie, val, reg);
   143	#endif
   144		return error;
   145	}
   146	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

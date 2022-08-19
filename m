Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0759A345
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbiHSRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354651AbiHSRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:30:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278E9C8E5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660927717; x=1692463717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VBSDfgV6ZSa9UCHQe46xlhoG0QFT0mpo+srVwod7cCM=;
  b=WHd1bJ9gLZwd4jDye6JFvnitIHHim97OwSzIjDM5cUc3nbdrDl/5C/jH
   eEuFcT2HQlmjvlJ+zKa/vST+73dBnHaiY1YrAkJ0hvhqgHorMhcg7lDq8
   evfVbS2qR6FnT/p8ihc5rLIUqJeLJFDwEZK+05c998DmXSTFWfWi22E4A
   Y4MnLwaExrUxxsGcHhZSGb7ALILZP8a6DoOZj4CAAnSp60qipZfVSPxPS
   MW6q4+4jIB5l362NKAsAoeQeGv5lhjIyeNyHSn2akSZzeR6vFNnwnEpv0
   kGXl7wof/ZxpTyG/KGQGs5mNGOK9JaYAPoBEC03O9JVL0aPD08KrBm9cD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="319084575"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="319084575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 09:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="750582261"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2022 09:45:05 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP57I-0001dx-1Q;
        Fri, 19 Aug 2022 16:45:04 +0000
Date:   Sat, 20 Aug 2022 00:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: arch/loongarch/pci/acpi.c:103:29: error: 'loongson_pci_ecam_ops'
 undeclared
Message-ID: <202208200012.mePOXcVS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/loongarch/Makefile
arch/loongarch/include/asm/dma.h
arch/loongarch/include/asm/irq.h
arch/loongarch/include/asm/page.h
arch/loongarch/include/asm/pci.h
arch/loongarch/pci/acpi.c
arch/loongarch/pci/pci.c
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4c2d0b039c5cc0112206a5b22431b577cb1c57ad
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   8 days ago
config: loongarch-randconfig-r021-20220819 (https://download.01.org/0day-ci/archive/20220820/202208200012.mePOXcVS-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/loongarch/pci/acpi.c: In function 'pci_acpi_setup_ecam_mapping':
>> arch/loongarch/pci/acpi.c:103:29: error: 'loongson_pci_ecam_ops' undeclared (first use in this function)
     103 |                 ecam_ops = &loongson_pci_ecam_ops;
         |                             ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/pci/acpi.c:103:29: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PCI_LOONGSON
   Depends on [n]: PCI [=y] && (MACH_LOONGSON64 [=y] || COMPILE_TEST [=y]) && (OF [=y] || ACPI [=y]) && PCI_QUIRKS [=n]
   Selected by [y]:
   - LOONGARCH [=y]


vim +/loongson_pci_ecam_ops +103 arch/loongarch/pci/acpi.c

    84	
    85	/*
    86	 * Lookup the bus range for the domain in MCFG, and set up config space
    87	 * mapping.
    88	 */
    89	static struct pci_config_window *
    90	pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
    91	{
    92		int ret, bus_shift;
    93		u16 seg = root->segment;
    94		struct device *dev = &root->device->dev;
    95		struct resource cfgres;
    96		struct resource *bus_res = &root->secondary;
    97		struct pci_config_window *cfg;
    98		const struct pci_ecam_ops *ecam_ops;
    99	
   100		ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
   101		if (ret < 0) {
   102			dev_err(dev, "%04x:%pR ECAM region not found, use default value\n", seg, bus_res);
 > 103			ecam_ops = &loongson_pci_ecam_ops;
   104			root->mcfg_addr = mcfg_addr_init(0);
   105		}
   106	
   107		bus_shift = ecam_ops->bus_shift ? : 20;
   108	
   109		cfgres.start = root->mcfg_addr + (bus_res->start << bus_shift);
   110		cfgres.end = cfgres.start + (resource_size(bus_res) << bus_shift) - 1;
   111		cfgres.flags = IORESOURCE_MEM;
   112	
   113		cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
   114		if (IS_ERR(cfg)) {
   115			dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res, PTR_ERR(cfg));
   116			return NULL;
   117		}
   118	
   119		return cfg;
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

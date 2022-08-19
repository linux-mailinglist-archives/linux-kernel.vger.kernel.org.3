Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42759A993
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiHSXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:43:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B92714
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660952599; x=1692488599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R0lN6pGXpEKUfS4MmgQCEbpxtUo9KBhatU5DVX+78dE=;
  b=faDHH5bazwZcdFPccAebMv/iUGP+jVLT7NWUUleoieVLEmb40h6uKfUK
   XgPPRFPOOED4ixPWFf0P9LMswH8EDhoiVQIDTfM/BS8XZgfU5/8SBO2jF
   b6bmkSWvzV006n4xiUBtxEZ0qdEYpNaWMbZ98qBKZ5TczyfS0VGYgMNHy
   znHpfln864ip/cBmGWh2lEpeS0NzQtMAHjtVuGDjUmVqxy4Nm60suRB3y
   G7FF1IBGusOlMaL3AgS2G10T8EDy19rB8ym7cr03bkzDIpRlctsBex2Xo
   jCQeM8HeXIjxRECqnxcw9WaZfx2mP//ok8nJhB6L4aNXHl5OPonS8j2oc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="357111837"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="357111837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 16:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="637461192"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2022 16:43:16 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPBdz-0001vL-1L;
        Fri, 19 Aug 2022 23:43:15 +0000
Date:   Sat, 20 Aug 2022 07:42:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 24/36]
 drivers/pci/probe.c:2451:14: error: implicit declaration of function
 'cc_platform_has'
Message-ID: <202208200732.aqYAOVe0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pci/pci.c
drivers/pci/probe.c
tree:   https://github.com/intel/tdx.git guest-hardening-rebased
head:   d941f409a509c084250b50a3b5fc1c3c84a596a0
commit: 9fc8d23dbf6bd3cdb60761d86121008b2335cd74 [24/36] x86/tdx: Disable enhanced PCI parsing for TDX
config: microblaze-buildonly-randconfig-r001-20220820 (https://download.01.org/0day-ci/archive/20220820/202208200732.aqYAOVe0-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/9fc8d23dbf6bd3cdb60761d86121008b2335cd74
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 9fc8d23dbf6bd3cdb60761d86121008b2335cd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from drivers/pci/probe.c:6:
   drivers/pci/probe.c: In function 'pci_init_capabilities':
>> drivers/pci/probe.c:2451:14: error: implicit declaration of function 'cc_platform_has' [-Werror=implicit-function-declaration]
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |              ^~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/pci/probe.c:2451:9: note: in expansion of macro 'if'
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |         ^~
>> drivers/pci/probe.c:2451:30: error: 'CC_ATTR_GUEST_HARDENED' undeclared (first use in this function)
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/pci/probe.c:2451:9: note: in expansion of macro 'if'
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |         ^~
   drivers/pci/probe.c:2451:30: note: each undeclared identifier is reported only once for each function it appears in
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/pci/probe.c:2451:9: note: in expansion of macro 'if'
    2451 |         if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
         |         ^~
   cc1: some warnings being treated as errors


vim +/cc_platform_has +2451 drivers/pci/probe.c

  2448	
  2449	static void pci_init_capabilities(struct pci_dev *dev)
  2450	{
> 2451		if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
  2452			pci_ea_init(dev);	/* Enhanced Allocation */
  2453	
  2454		pci_msi_init(dev);		/* Disable MSI */
  2455		pci_msix_init(dev);		/* Disable MSI-X */
  2456	
  2457		if (cc_platform_has(CC_ATTR_GUEST_HARDENED))
  2458			return;
  2459	
  2460		/* Buffers for saving PCIe and PCI-X capabilities */
  2461		pci_allocate_cap_save_buffers(dev);
  2462	
  2463		pci_pm_init(dev);		/* Power Management */
  2464		pci_vpd_init(dev);		/* Vital Product Data */
  2465		pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
  2466		pci_iov_init(dev);		/* Single Root I/O Virtualization */
  2467		pci_ats_init(dev);		/* Address Translation Services */
  2468		pci_pri_init(dev);		/* Page Request Interface */
  2469		pci_pasid_init(dev);		/* Process Address Space ID */
  2470		pci_acs_init(dev);		/* Access Control Services */
  2471		pci_ptm_init(dev);		/* Precision Time Measurement */
  2472		pci_aer_init(dev);		/* Advanced Error Reporting */
  2473		pci_dpc_init(dev);		/* Downstream Port Containment */
  2474		pci_rcec_init(dev);		/* Root Complex Event Collector */
  2475	
  2476		pcie_report_downtraining(dev);
  2477		pci_init_reset_methods(dev);
  2478	}
  2479	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

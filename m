Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565859A904
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiHSXCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiHSXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:02:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E0E7278
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660950148; x=1692486148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r7qay1+dP6VVlT5JhKkRy2Ccw8Xyj0gBU/jadv5XVwQ=;
  b=iC0bwI9OwCOKFPKHFgdncodj4exP+weDrnEniBPf03HCh9ozKWqJ3Ox2
   3H2pfyIdR6bQUE2Ta7jsXwnlqZkX3NiCkRSJEBVqZwBCwrvUTp60yAsSm
   mZPJvf8VI6zDQkkeF3+sWztSm53A1T2yBDydjWTZi6/Wh0TZRjaROgilN
   RxaqHAmiVLCUIBxH+7btJC50uCd55Awjas1uifcDYRLXFNJC9wiInBCCV
   34sEPBYztKK2Xp2rTLFpBIpPZoNSmeFs4y51Lvg9zNQgTz20Tb8/R656w
   r1E6vhAIeUnMLBbeGXasvrVOBXaEFtaKxCLJ+Gmq3vjwigRjL9bJB+Uc7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="290683591"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="290683591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 16:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="853911497"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2022 16:02:14 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPB0I-0001tM-1J;
        Fri, 19 Aug 2022 23:02:14 +0000
Date:   Sat, 20 Aug 2022 07:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-hardening-rebased 24/36]
 drivers/pci/probe.c:2451:7: error: implicit declaration of function
 'cc_platform_has' is invalid in C99
Message-ID: <202208200603.DlhLITXV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: riscv-randconfig-r036-20220820 (https://download.01.org/0day-ci/archive/20220820/202208200603.DlhLITXV-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 0ac597f3cacf60479ffd36b03766fa7462dabd78)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel/tdx/commit/9fc8d23dbf6bd3cdb60761d86121008b2335cd74
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-hardening-rebased
        git checkout 9fc8d23dbf6bd3cdb60761d86121008b2335cd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/probe.c:2451:7: error: implicit declaration of function 'cc_platform_has' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
                ^
>> drivers/pci/probe.c:2451:23: error: use of undeclared identifier 'CC_ATTR_GUEST_HARDENED'
           if (!cc_platform_has(CC_ATTR_GUEST_HARDENED))
                                ^
   drivers/pci/probe.c:2457:22: error: use of undeclared identifier 'CC_ATTR_GUEST_HARDENED'
           if (cc_platform_has(CC_ATTR_GUEST_HARDENED))
                               ^
   3 errors generated.


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

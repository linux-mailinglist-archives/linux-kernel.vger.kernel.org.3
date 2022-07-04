Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B04565864
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGDOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiGDOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:12:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348A65E3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656943973; x=1688479973;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LEGF7I0MVXcuG5dis5FxYZXp4JXJULB7tfTUkMfrz6w=;
  b=iKL3i4X2dwrT5W/JGYb+zaAmHYs2Cc3LROTNkn5MXgkyauEbbE/hH1Oe
   dHNG4U96vYrDMBFonzS6ugsQ83/4WeEyi/Nbq2mqOZY3Yua8a+XRzo1+V
   HJFZgGVbwBTk2t0689dnIFMAZeuRvfg7/WMBzFPXBffUMfAD4FTLhOe6G
   I8z1W4TKbwh0ziDWL36ISQZCgMkRdhYneV7oaR0n27KVS9Qw4U+yppDzS
   oOkoB7njyxpFf52lFs9G93B4VS67JR3t68lpn2jnsTwPTd5QqFXsJuafU
   cG9h181Miva9Hpx+/mcoQU548A3oAjAah64ETxo4ZUUmRq/k1YiX6qz9d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263562503"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="263562503"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="625068484"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2022 07:12:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8MoF-000Hvl-3B;
        Mon, 04 Jul 2022 14:12:19 +0000
Date:   Mon, 4 Jul 2022 22:11:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 66/68]
 drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for
 function 'intel_vsec_pci_resume'
Message-ID: <202207042202.lFuOlMKZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   530ef2a6e81c74c19f918713e519e85652e53a83
commit: 1039bb2698ab299a1fc30a4fc2df237867c089e0 [66/68] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
config: i386-randconfig-r013-20220704 (https://download.01.org/0day-ci/archive/20220704/202207042202.lFuOlMKZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=1039bb2698ab299a1fc30a4fc2df237867c089e0
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 1039bb2698ab299a1fc30a4fc2df237867c089e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/intel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for function 'intel_vsec_pci_resume' [-Wmissing-prototypes]
   void intel_vsec_pci_resume(struct pci_dev *pdev)
        ^
   drivers/platform/x86/intel/vsec.c:475:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void intel_vsec_pci_resume(struct pci_dev *pdev)
   ^
   static 
   1 warning generated.


vim +/intel_vsec_pci_resume +475 drivers/platform/x86/intel/vsec.c

   474	
 > 475	void intel_vsec_pci_resume(struct pci_dev *pdev)
   476	{
   477		dev_info(&pdev->dev, "Done resuming PCI device\n");
   478	}
   479	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB81591D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiHNAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiHNAwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:52:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629E79EC5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660438357; x=1691974357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g/aVtxwvzv43PLRNj2S3P7jLoKHjjU/AZ1XXd9zCz88=;
  b=JAIfwonkkYSDYH6zGJVmp7zzDeIcSvIt7FYR/NhBQfPoyGiDaOQ3OwUX
   wWxPSmcI0P8BQ0u6f37FpBobNHmxtJ7suSRUccSqW36NltKUe7A8VgAGl
   QrQMeixlygJ5EkfWYi/Jgch7q1ZbXuLDChz6mSIpmBPrjKgsl58vESLMJ
   6wexRPbczTNYXd8POJnIu5l48f4hUS1XT9+1qA3msKfjsNgQSnHJEMbDb
   jkSvpLPER0dXh/sdcE9n9jFVTwGu6Y6MKQ7JLQxkpY/E9a3JNXo/sbmSS
   s048w6TqzMHSIB1r8QxA7znBRkaWDJu88W2WFpMny8QiG0FCg2XeAWImq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272180402"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="272180402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 17:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635070507"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 17:52:35 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN1rn-0002FW-0c;
        Sun, 14 Aug 2022 00:52:35 +0000
Date:   Sun, 14 Aug 2022 08:52:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:fix_port_disable_s4 1/1]
 drivers/usb/core/hcd-pci.c:637:19: error: use of undeclared identifier
 'hcd_pci_poweroff_late'
Message-ID: <202208140802.8IhDwVtx-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_port_disable_s4
head:   a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
commit: a41d3a635cb80d88f6d5fa958ebce3d81abd5c73 [1/1] xhci: pci: disable all xhci ports in hibernate poweroff_late stage,
config: i386-randconfig-a015-20220808 (https://download.01.org/0day-ci/archive/20220814/202208140802.8IhDwVtx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        git remote add mnyman-xhci https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
        git fetch --no-tags mnyman-xhci fix_port_disable_s4
        git checkout a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/core/hcd-pci.c:637:19: error: use of undeclared identifier 'hcd_pci_poweroff_late'
           .poweroff_late  = hcd_pci_poweroff_late,
                             ^
   1 error generated.


vim +/hcd_pci_poweroff_late +637 drivers/usb/core/hcd-pci.c

   626	
   627	const struct dev_pm_ops usb_hcd_pci_pm_ops = {
   628		.suspend	= hcd_pci_suspend,
   629		.suspend_noirq	= hcd_pci_suspend_noirq,
   630		.resume_noirq	= hcd_pci_resume_noirq,
   631		.resume		= hcd_pci_resume,
   632		.freeze		= hcd_pci_suspend,
   633		.freeze_noirq	= check_root_hub_suspended,
   634		.thaw_noirq	= NULL,
   635		.thaw		= hcd_pci_resume,
   636		.poweroff	= hcd_pci_suspend,
 > 637		.poweroff_late	= hcd_pci_poweroff_late,
   638		.poweroff_noirq	= hcd_pci_suspend_noirq,
   639		.restore_noirq	= hcd_pci_resume_noirq,
   640		.restore	= hcd_pci_restore,
   641		.runtime_suspend = hcd_pci_runtime_suspend,
   642		.runtime_resume	= hcd_pci_runtime_resume,
   643	};
   644	EXPORT_SYMBOL_GPL(usb_hcd_pci_pm_ops);
   645	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

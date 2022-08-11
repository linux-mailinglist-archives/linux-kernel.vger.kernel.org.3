Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529F158F67A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiHKDwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiHKDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:52:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14583BCC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660189951; x=1691725951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b14yv4zybEMk92MOe9Nad/0zi8R6E4nAO4ZOGlB6gME=;
  b=Kce8W2+9L8++3/ZQ9YwskGLwR/FBnIHRX6l8KiWRaNZpJAUw3lVAqxBQ
   WwH4rwpZxqrYlcHoFBn/ZVhfmSd/oF340ZuwnkTOSFii85+6nIJc4zNbP
   ekw1GIJVGbUUhfM4kEI0Xi4nkoj7y8lCPCHL/CCRGUNJG5POXrKj8LLWQ
   FtNF9LIE4aQP7HcE/DMscv9Osce+2QJKiKQqubkVq7Yvxw9e+U790+oJa
   /gnBvovVcOovp4mb/uf9EQZC0WWVdA9QzrjWsYraaxYtSuiSAxG6xqTxz
   Sdg7FDORwx5E7+3P/N+djfcXWTdRJYWmU9IsN7TbZ4wIE92bnIrV+dm7S
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="278194409"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="278194409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 20:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638349207"
Received: from lkp-server02.sh.intel.com (HELO cf3507895f13) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 20:52:29 -0700
Received: from kbuild by cf3507895f13 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLzFF-00001B-0b;
        Thu, 11 Aug 2022 03:52:29 +0000
Date:   Thu, 11 Aug 2022 11:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:fix_port_disable_s4 1/1]
 drivers/usb/core/hcd-pci.c:637:27: error: 'hcd_pci_poweroff_late' undeclared
 here (not in a function)
Message-ID: <202208111117.4rp9JQa6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_port_disable_s4
head:   a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
commit: a41d3a635cb80d88f6d5fa958ebce3d81abd5c73 [1/1] xhci: pci: disable all xhci ports in hibernate poweroff_late stage,
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220811/202208111117.4rp9JQa6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        git remote add mnyman-xhci https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
        git fetch --no-tags mnyman-xhci fix_port_disable_s4
        git checkout a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/core/hcd-pci.c:637:27: error: 'hcd_pci_poweroff_late' undeclared here (not in a function)
     637 |         .poweroff_late  = hcd_pci_poweroff_late,
         |                           ^~~~~~~~~~~~~~~~~~~~~


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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F345652C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiGDKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiGDKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:52:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51BB87F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656931930; x=1688467930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OyO5RX3N9pHFqKpmdgLsCfDl2MIXE5RdPgMx+OnzC4w=;
  b=Xhn0ngHUEqN7pofX/qiSsCFd30gTJmZN9uFvPCJ59VUH4JUXKJeti+x+
   xG+VmOHRoi1SKWOhbQGxiCiFKZ+sqAq80LxpYhiOYcEDkSID0u5/Kx+7h
   0eIo9A5v96oxxkV8YZBCdFLq/Rkr4DGyFMa7NCHAFN7HdcRplIVab96px
   csYZBBHWaPVQc6MLX4ltvuXbyUQ9jvwzLmHrvsnZrEJLYr4i4heUe4XDh
   ul7l7qWF75miiP9SjCIjoPKXwmqDx8V87vfko/CpAZB7Y2K78VNHLjeMO
   jLteLAneQmXhMZHSddzA4+NvQ3PPNosFOjkOhlBfCUUMhZHNtZZ0kp61T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283827450"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283827450"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919285000"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2022 03:52:08 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8JgW-000HoZ-AZ;
        Mon, 04 Jul 2022 10:52:08 +0000
Date:   Mon, 4 Jul 2022 18:51:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 66/68]
 drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for
 'intel_vsec_pci_resume'
Message-ID: <202207041814.S03OvoFK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   530ef2a6e81c74c19f918713e519e85652e53a83
commit: 1039bb2698ab299a1fc30a4fc2df237867c089e0 [66/68] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207041814.S03OvoFK-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=1039bb2698ab299a1fc30a4fc2df237867c089e0
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 1039bb2698ab299a1fc30a4fc2df237867c089e0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/intel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for 'intel_vsec_pci_resume' [-Wmissing-prototypes]
     475 | void intel_vsec_pci_resume(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~~~~~~~


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

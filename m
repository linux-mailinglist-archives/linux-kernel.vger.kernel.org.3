Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8A4F4928
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391202AbiDEWE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573213AbiDESY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:24:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A260419A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649182948; x=1680718948;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YCQkJ0iRM6TI/iB59VjFGfFcnXrCeNHW0pUNSI++j60=;
  b=NIFAMvX+dUXsZbm5CRL1je+YuXZyD3EPZYTV8Fa4nRfLngFtouF9S3eU
   +PtX3lJ68thj0Srv6uarlimQvohGbi2uJi0DpauLyd1bLNZItSXf/XVMC
   RTMLgT/iRO9sRFH/oaMfHm2j81xMP20LfqhQt4cQ4zqgcq87Gc7UG5slj
   q/gte5GKZlSqF1wEr/BDza+1NaE7BBlF4WvXlUwhe14h7oRXi4W3MtDC0
   bqwXajqPDZ1LjqGe8IkPUiuVHUBqENJLQ4tQQ6tFSd9Kv7O3Bq1epobl0
   nsVlMBuvsfCxvhq6mC4PBq8gtSOjkoTvoU51lJ2Cv0HkVGo990cF/nCTP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258416608"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258416608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="524115047"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 11:22:25 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbnov-0003et-0b;
        Tue, 05 Apr 2022 18:22:25 +0000
Date:   Wed, 6 Apr 2022 02:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer
 variable [shadowVariable]
Message-ID: <202204060228.GdRDR2Xx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3123109284176b1532874591f7c81f3837bbdc17
commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
date:   8 weeks ago
config: mips-randconfig-p001-20220404 (https://download.01.org/0day-ci/archive/20220406/202204060228.GdRDR2Xx-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=523e594d9cc03db962c741ce02c8a58aab58a123
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 523e594d9cc03db962c741ce02c8a58aab58a123
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: arch/mips/kernel/signal.o: in function `restore_hw_fp_context':
   signal.c:(.text+0x1d8): undefined reference to `_restore_fp_context'
   mips64-linux-ld: arch/mips/kernel/signal.o: in function `save_hw_fp_context':
   signal.c:(.text+0x200): undefined reference to `_save_fp_context'
   mips64-linux-ld: arch/mips/kernel/traps.o: in function `trap_init':
>> (.init.text+0x4f8): undefined reference to `handle_fpe'
   mips64-linux-ld: (.init.text+0x504): undefined reference to `handle_fpe'
   mips64-linux-ld: (.init.text+0x510): undefined reference to `handle_fpe'


cppcheck warnings: (new ones prefixed by >>)
>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
     int rc;
         ^
   drivers/cxl/pci.c:431:6: note: Shadowed declaration
    int rc, i;
        ^
   drivers/cxl/pci.c:439:7: note: Shadow variable
     int rc;
         ^

vim +/rc +439 drivers/cxl/pci.c

   420	
   421	/*
   422	 * Wait up to @mbox_ready_timeout for the device to report memory
   423	 * active.
   424	 */
   425	static int wait_for_media_ready(struct cxl_dev_state *cxlds)
   426	{
   427		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
   428		int d = cxlds->cxl_dvsec;
   429		bool active = false;
   430		u64 md_status;
   431		int rc, i;
   432	
   433		rc = wait_for_valid(cxlds);
   434		if (rc)
   435			return rc;
   436	
   437		for (i = mbox_ready_timeout; i; i--) {
   438			u32 temp;
 > 439			int rc;
   440	
   441			rc = pci_read_config_dword(
   442				pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
   443			if (rc)
   444				return rc;
   445	
   446			active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
   447			if (active)
   448				break;
   449			msleep(1000);
   450		}
   451	
   452		if (!active) {
   453			dev_err(&pdev->dev,
   454				"timeout awaiting memory active after %d seconds\n",
   455				mbox_ready_timeout);
   456			return -ETIMEDOUT;
   457		}
   458	
   459		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
   460		if (!CXLMDEV_READY(md_status))
   461			return -EIO;
   462	
   463		return 0;
   464	}
   465	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

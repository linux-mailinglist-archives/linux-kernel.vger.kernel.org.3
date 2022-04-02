Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8D4F010B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiDBL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbiDBL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:28:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AD1A6E4E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648898809; x=1680434809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOp+AJUKRXP1hfXOGyCNS7pzzJXcGfFAi7u0+ZqSVtg=;
  b=jCmZAJ/nFBbLtRW0Mu+d/bN7HhdrjqN4P3FKbmQ0xV5LQDO3lVrFRpte
   uDZaf5o0YtQZKCUKrT2S7Oe7goqn4iH8KP25GOq8/14R6BNTjZyjUkFVZ
   +uk4sOQPQiUyTJceE3Q9EaMrK5FYLE/CvI3W5/ubVZbXy/Ou/xeH1lFDn
   aUx0oxJ4vJ44TKNf2hh5GKoqz/JW1hI6Z1dUdnmT9WHjksHkdI6/sbD4l
   LiJCFCffzvS16rC2Pbh0NytU10AvbFgepeYvGIjSkkqsWCpPeT9f2kCAY
   UFAnruIy/mHK68JMdwUhAWuOCXQPUuY/AvPFO68qGkEW1WYESZIXH5g5V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240233967"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240233967"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 04:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504440811"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 04:26:47 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nabu2-00005D-FV;
        Sat, 02 Apr 2022 11:26:46 +0000
Date:   Sat, 2 Apr 2022 19:26:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer
 variable [shadowVariable]
Message-ID: <202204021950.bTbpM2Gy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88e6c0207623874922712e162e25d9dafd39661e
commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
date:   7 weeks ago
compiler: alpha-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


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

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
   MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
   ^
--

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

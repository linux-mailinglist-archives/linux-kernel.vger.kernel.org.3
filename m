Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942FC524B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353162AbiELLYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353389AbiELLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:24:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D26246DB1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652354601; x=1683890601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JzFCeH6/9PxY/SD8fyT3PicTWBDSHnH16ews2+Zyo+U=;
  b=IbkkgqcmUi8KF2CxHIghUoHWhQxtKDzRz9wK75cdZcJIX7XHlrrgPqLQ
   nt5fC6paR2oZIS7UbeCdwtZE1jZSRH5k8RmA3PLBX+Lm+pMl7kwyUjB7L
   2vXgJptjEsS5vqeUdhiVDarJ6hLlV/n/3OVDh4Te4cZIlMT5brxlc2m7o
   vxD+YHFDrYXINkeKVDXeNirZ6TWv0ustl4t3iUBBW1ACQ+EdaGcO2gD5O
   K+0T9/qzv/5e1ueqVlnH6DCqAioBj9nCk2HcDnNYvr3FgMXmYkXtpJv6f
   TYnOnOLQCULnBTIN2KFTzXprL4j7FRzXzK/4UAC58BLQxl4NnuZLGM2ny
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295220048"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="295220048"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="895755253"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2022 04:23:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np6uX-000KLT-Ik;
        Thu, 12 May 2022 11:23:13 +0000
Date:   Thu, 12 May 2022 19:23:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 40/67] drivers/cxl/core/pci.c:137:21: error: implicit
 declaration of function 'readq'; did you mean 'readl'?
Message-ID: <202205121947.4e1h4uZF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9c642abd8b31d895f34186bd72b7360083b58492
commit: e7ed4a0688738b1f47a6b500444942d4dfa1035d [40/67] cxl/pci: Move cxl_await_media_ready() to the core
config: powerpc-buildonly-randconfig-r003-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121947.4e1h4uZF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=e7ed4a0688738b1f47a6b500444942d4dfa1035d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout e7ed4a0688738b1f47a6b500444942d4dfa1035d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cxl/core/pci.c: In function 'cxl_await_media_ready':
>> drivers/cxl/core/pci.c:137:21: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     137 |         md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
         |                     ^~~~~
         |                     readl
   cc1: some warnings being treated as errors


vim +137 drivers/cxl/core/pci.c

   103	
   104	/*
   105	 * Wait up to @media_ready_timeout for the device to report memory
   106	 * active.
   107	 */
   108	int cxl_await_media_ready(struct cxl_dev_state *cxlds)
   109	{
   110		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
   111		int d = cxlds->cxl_dvsec;
   112		bool active = false;
   113		u64 md_status;
   114		int rc, i;
   115	
   116		for (i = media_ready_timeout; i; i--) {
   117			u32 temp;
   118	
   119			rc = pci_read_config_dword(
   120				pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
   121			if (rc)
   122				return rc;
   123	
   124			active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
   125			if (active)
   126				break;
   127			msleep(1000);
   128		}
   129	
   130		if (!active) {
   131			dev_err(&pdev->dev,
   132				"timeout awaiting memory active after %d seconds\n",
   133				media_ready_timeout);
   134			return -ETIMEDOUT;
   135		}
   136	
 > 137		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

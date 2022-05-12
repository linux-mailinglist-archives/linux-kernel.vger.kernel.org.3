Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB15248D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbiELJWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351925AbiELJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:22:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E1D50453
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652347332; x=1683883332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y4aqSKG+Qdhrrlw+VzjpUHVoxZf0QQKL3LP5SMTVV2c=;
  b=NUQgOhEvD366kC+kxDh3auIQg1u0UbHpqXsY2TT2JEOlPKJ2/Y5DwLVb
   +91csG9kNEYyJpcOmNCFiU7ZSVVvgU2wnNT2NmKgVRf4cuVkirb6f7s04
   usjOltXHCKx3RBpmPeCRwKLHYHMUYGnL7WUliP+ax6IzY+wwCa2gDeQvT
   5hnkJ5i1CmwM7ZgPOqkITvcQ3PbrGghMvhQtiTCitYjAvNzjecRT6G1j6
   kjYK5mPWaAvmr83jwsd/SsUfr9PnDnpXktDvMUIH6FxAY5ViLuV9LT1dp
   BO1052T9ILJj+YvCZFLGwH0zAWIw/ykZknfchUD5MGZQE0LHg4q7m23wW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="251999724"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="251999724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="603301156"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 02:22:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np51M-000KFI-Gu;
        Thu, 12 May 2022 09:22:08 +0000
Date:   Thu, 12 May 2022 17:21:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 40/67] drivers/cxl/core/pci.c:137:14: error: call to
 undeclared function 'readq'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202205121731.lbcgjrP6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9c642abd8b31d895f34186bd72b7360083b58492
commit: e7ed4a0688738b1f47a6b500444942d4dfa1035d [40/67] cxl/pci: Move cxl_await_media_ready() to the core
config: i386-randconfig-c001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121731.lbcgjrP6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=e7ed4a0688738b1f47a6b500444942d4dfa1035d
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout e7ed4a0688738b1f47a6b500444942d4dfa1035d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cxl/core/pci.c:137:14: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
                       ^
   1 error generated.


vim +/readq +137 drivers/cxl/core/pci.c

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

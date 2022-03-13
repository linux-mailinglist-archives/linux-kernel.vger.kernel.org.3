Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E64D724F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 04:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiCMDY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 22:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 22:24:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B878338A2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 19:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647141830; x=1678677830;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QxzSg/ExOjoNxVR/c+Gby77e69Ru2zDejgWV0j8Qr70=;
  b=nh8H9K830dDV1/Bn2aKlyWcT0GNoonhiHHmspZHwzwWNMXt6wZbNlUnl
   5jxi9DMPyL5+P7FVtBYCOHm7Dz+Qf+HJcD6PsMplk/Cuxbo1vAhQRP00g
   75N7G6wUzAAu4wizlrz+gFgx5HLWC789+q1YUiafN723KxxymMjOivHRC
   Xtf/2McZS5r7BMdfW2kaMCugJssbrnlpXn4ihmTWVFrujqyA7l5Znyam+
   17hiPaNPKQbckPm9GqQCJPNjfy2ytJd5ePCtJmoGXqGMPsAcvli42Lkj3
   oMdxyJJW6/NWgxQnMQIO4LIN+MPBIex/Pi1hEj4OUBOQdU/jF7ebxJucE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="253397961"
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="253397961"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 19:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,177,1643702400"; 
   d="scan'208";a="539504323"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2022 19:23:48 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTEpf-0008YR-Sv; Sun, 13 Mar 2022 03:23:47 +0000
Date:   Sun, 13 Mar 2022 11:22:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:audio/testing 28/167] drivers/nvme/host/apple.c:255:
 undefined reference to `apple_sart_add_allowed_region'
Message-ID: <202203131109.2etgybVw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux audio/testing
head:   878d09efcd811ce17adb15d9ee32a5b7130320b5
commit: 73ad3599aa16b102655fbd9aa1576ae3c63466a3 [28/167] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: openrisc-buildonly-randconfig-r003-20220313 (https://download.01.org/0day-ci/archive/20220313/202203131109.2etgybVw-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/73ad3599aa16b102655fbd9aa1576ae3c63466a3
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux audio/testing
        git checkout 73ad3599aa16b102655fbd9aa1576ae3c63466a3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
>> drivers/nvme/host/apple.c:255: undefined reference to `apple_sart_add_allowed_region'
   drivers/nvme/host/apple.c:255:(.text+0x13c0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_sart_add_allowed_region'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> drivers/nvme/host/apple.c:800: undefined reference to `apple_rtkit_is_crashed'
   drivers/nvme/host/apple.c:800:(.text+0x19dc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_crashed'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> drivers/nvme/host/apple.c:1436: undefined reference to `apple_rtkit_is_running'
   drivers/nvme/host/apple.c:1436:(.text+0x1be4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_running'
>> or1k-linux-ld: drivers/nvme/host/apple.c:1437: undefined reference to `apple_rtkit_shutdown'
   drivers/nvme/host/apple.c:1437:(.text+0x1c00): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_shutdown'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   drivers/nvme/host/apple.c:1425: undefined reference to `apple_rtkit_is_running'
   drivers/nvme/host/apple.c:1425:(.text+0x1c84): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_running'
   or1k-linux-ld: drivers/nvme/host/apple.c:1426: undefined reference to `apple_rtkit_shutdown'
   drivers/nvme/host/apple.c:1426:(.text+0x1ca0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_shutdown'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   drivers/nvme/host/apple.c:899: undefined reference to `apple_rtkit_is_crashed'
   drivers/nvme/host/apple.c:899:(.text+0x1e58): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_crashed'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   drivers/nvme/host/apple.c:984: undefined reference to `apple_rtkit_is_crashed'
   drivers/nvme/host/apple.c:984:(.text+0x2020): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_crashed'
>> or1k-linux-ld: drivers/nvme/host/apple.c:995: undefined reference to `apple_rtkit_is_running'
   drivers/nvme/host/apple.c:995:(.text+0x20e4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_is_running'
>> or1k-linux-ld: drivers/nvme/host/apple.c:1009: undefined reference to `apple_rtkit_reinit'
   drivers/nvme/host/apple.c:1009:(.text+0x2130): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `apple_rtkit_reinit'
>> or1k-linux-ld: drivers/nvme/host/apple.c:1020: undefined reference to `apple_rtkit_boot'
   drivers/nvme/host/apple.c:1020:(.text+0x2170): additional relocation overflows omitted from the output
   or1k-linux-ld: drivers/nvme/host/apple.c:997: undefined reference to `apple_rtkit_shutdown'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
>> drivers/nvme/host/apple.c:272: undefined reference to `apple_sart_remove_allowed_region'
   or1k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> drivers/nvme/host/apple.c:1341: undefined reference to `apple_sart_get'
>> or1k-linux-ld: drivers/nvme/host/apple.c:1393: undefined reference to `devm_apple_rtkit_init'


vim +255 drivers/nvme/host/apple.c

   241	
   242	static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
   243					     dma_addr_t iova, size_t size)
   244	{
   245		struct apple_nvme *anv = cookie;
   246		int ret;
   247	
   248		if (iova)
   249			return -EINVAL;
   250	
   251		bfr->buffer = dma_alloc_coherent(anv->dev, size, &iova, GFP_KERNEL);
   252		if (!bfr->buffer)
   253			return -ENOMEM;
   254	
 > 255		ret = apple_sart_add_allowed_region(anv->sart, iova, size);
   256		if (ret) {
   257			dma_free_coherent(anv->dev, size, bfr->buffer, iova);
   258			bfr->buffer = NULL;
   259			return -ENOMEM;
   260		}
   261	
   262		bfr->size = size;
   263		bfr->iova = iova;
   264	
   265		return 0;
   266	}
   267	
   268	static void apple_nvme_sart_dma_destroy(void *cookie, struct apple_rtkit_shmem *bfr)
   269	{
   270		struct apple_nvme *anv = cookie;
   271	
 > 272		apple_sart_remove_allowed_region(anv->sart, bfr->iova, bfr->size);
   273		dma_free_coherent(anv->dev, bfr->size, bfr->buffer, bfr->iova);
   274	}
   275	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

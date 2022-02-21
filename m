Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AD4BD2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiBUAv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:51:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBUAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:51:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B234B416
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 16:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645404662; x=1676940662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tirtIr9lbqCJif/NfdKGb5++F93PVzk3zi3EPMJRwTI=;
  b=eNgzbkjYf5+XaYIwfR/eoxYpOFZKF9g399TiQf6SLYXDEK6UsC+hSijq
   FBZqMeCc8DZe6pp+1/RVU+VEvtIdxHpsAh17mePxK5uYhsRQ9zRpWG5Yv
   gj6ux2x4xlzeNNHB7vvA3Yx38H/+7xQMU+pX6DHkiJhwb+6JE0DX50uom
   +trGiZHm+ZTfLCVsemkWZV2Fo+8k5EUzcOOF1UCfkEKpvVC5KWgfHzkP9
   mAxUxJ2zsNCxj4yOsQDxZ94yMqJo+gb7DXpzf2CwH5fiz4yVTyXSMQ6rn
   ndq4MzJNQPKtBi1AP5T4nogNyJQr4PxFouOWRFYa9UZXxaNkpsXcQnAI+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251596155"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251596155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="490275818"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 16:51:01 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLwuq-00016m-92; Mon, 21 Feb 2022 00:51:00 +0000
Date:   Mon, 21 Feb 2022 08:49:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: drivers/edac/altera_edac.c:886:28: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202202210837.SSt1wcDZ-lkp@intel.com>
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

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
commit: 4a9a1a5602d82c079325bf37466af0b67d6c0b9e arm64: socfpga: merge Agilex and N5X into ARCH_INTEL_SOCFPGA
date:   11 months ago
config: arm64-randconfig-s032-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210837.SSt1wcDZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4a9a1a5602d82c079325bf37466af0b67d6c0b9e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4a9a1a5602d82c079325bf37466af0b67d6c0b9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/edac/ drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/edac/altera_edac.c:886:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *p @@     got unsigned int const [usertype] *handle @@
   drivers/edac/altera_edac.c:886:28: sparse:     expected restricted __be32 const [usertype] *p
   drivers/edac/altera_edac.c:886:28: sparse:     got unsigned int const [usertype] *handle

vim +886 drivers/edac/altera_edac.c

1166fde93d5b1d Thor Thayer 2016-06-22  878  
1166fde93d5b1d Thor Thayer 2016-06-22  879  static inline int a10_get_irq_mask(struct device_node *np)
1166fde93d5b1d Thor Thayer 2016-06-22  880  {
1166fde93d5b1d Thor Thayer 2016-06-22  881  	int irq;
1166fde93d5b1d Thor Thayer 2016-06-22  882  	const u32 *handle = of_get_property(np, "interrupts", NULL);
1166fde93d5b1d Thor Thayer 2016-06-22  883  
1166fde93d5b1d Thor Thayer 2016-06-22  884  	if (!handle)
1166fde93d5b1d Thor Thayer 2016-06-22  885  		return -ENODEV;
1166fde93d5b1d Thor Thayer 2016-06-22 @886  	irq = be32_to_cpup(handle);
1166fde93d5b1d Thor Thayer 2016-06-22  887  	return irq;
1166fde93d5b1d Thor Thayer 2016-06-22  888  }
1166fde93d5b1d Thor Thayer 2016-06-22  889  

:::::: The code at line 886 was first introduced by commit
:::::: 1166fde93d5b1d7267992edc7e2c8ee129d6667e EDAC, altera: Add Arria10 ECC memory init functions

:::::: TO: Thor Thayer <tthayer@opensource.altera.com>
:::::: CC: Borislav Petkov <bp@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

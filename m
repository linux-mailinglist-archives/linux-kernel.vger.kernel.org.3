Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED074C821E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiCAETd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiCAET3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:19:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327DE0A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108329; x=1677644329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kYk0NIeN07oIgNEFzajamTRQ277JdfYIBg6vulnaCQo=;
  b=MhkyrT4Y9fblLuvcIg2PcaabNkRkRlSZgu02748Oce/Pv7WEvng1o3F5
   DetqL2i8x8rFH4bzFMLNQ7iDKYy/vub5w+uOwtzz7Bjz9vrk5dW5ZFdYN
   OFo7WSASzqXCRleSmsAuSQycx9RCDkbt1kQNyEwhtgk9HgyhuK5FART+I
   wHrhfsWLhjIL64JOdhwdulNnBd9VabmduCbk9xKOv5oSpulf0XmmDBlne
   ZZKs/S1FC1XV7RGOZoYeXZCDm2gt5pxhPMOYx3fpCn2xBXu0NPnkcmQS4
   OoCDaBViieJ6dWYYZnLoi7BHGLx3c9chAfTRvTp7D23AQDXA1lgw9WSUo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252784682"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252784682"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="778326839"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2022 20:18:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtyI-00086J-J2; Tue, 01 Mar 2022 04:18:46 +0000
Date:   Tue, 1 Mar 2022 12:18:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous
 prototype for 'xintc_get_irq'
Message-ID: <202203011058.VcuVhghd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   719fce7539cd3e186598e2aed36325fe892150cf
commit: debf69cfd4c618c7036a13cc4edd1faf87ce7d53 irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP
date:   10 months ago
config: arm64-randconfig-r031-20220227 (https://download.01.org/0day-ci/archive/20220301/202203011058.VcuVhghd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=debf69cfd4c618c7036a13cc4edd1faf87ce7d53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout debf69cfd4c618c7036a13cc4edd1faf87ce7d53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/tegra/ drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-xilinx-intc.c:127:14: warning: no previous prototype for 'xintc_get_irq' [-Wmissing-prototypes]
     127 | unsigned int xintc_get_irq(void)
         |              ^~~~~~~~~~~~~


vim +/xintc_get_irq +127 drivers/irqchip/irq-xilinx-intc.c

67862a3c47fcfc9 Mubin Sayyed 2020-03-17  126  
4cea749d56bec94 Marc Zyngier 2020-03-30 @127  unsigned int xintc_get_irq(void)
4cea749d56bec94 Marc Zyngier 2020-03-30  128  {
4cea749d56bec94 Marc Zyngier 2020-03-30  129  	unsigned int irq = -1;
4cea749d56bec94 Marc Zyngier 2020-03-30  130  	u32 hwirq;
4cea749d56bec94 Marc Zyngier 2020-03-30  131  
4cea749d56bec94 Marc Zyngier 2020-03-30  132  	hwirq = xintc_read(primary_intc, IVR);
4cea749d56bec94 Marc Zyngier 2020-03-30  133  	if (hwirq != -1U)
4cea749d56bec94 Marc Zyngier 2020-03-30  134  		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
4cea749d56bec94 Marc Zyngier 2020-03-30  135  
4cea749d56bec94 Marc Zyngier 2020-03-30  136  	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
4cea749d56bec94 Marc Zyngier 2020-03-30  137  
4cea749d56bec94 Marc Zyngier 2020-03-30  138  	return irq;
4cea749d56bec94 Marc Zyngier 2020-03-30  139  }
4cea749d56bec94 Marc Zyngier 2020-03-30  140  

:::::: The code at line 127 was first introduced by commit
:::::: 4cea749d56bec9409f3bd126d2b2f949dc6c66e2 Revert "irqchip/xilinx: Enable generic irq multi handler"

:::::: TO: Marc Zyngier <maz@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

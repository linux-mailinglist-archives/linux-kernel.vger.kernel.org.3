Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D66587C48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiHBMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiHBMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:20:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC18BE5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659442819; x=1690978819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2xp3qtulm79Mx89SQH8hG0Y/Weam2Tt2Mqcm9mRtNGI=;
  b=dT2hrtplCywYsj5Va4os46C8lmY0qutAy1aUWybfLi7UCHDAVsNQt4Am
   g7dT0qiHghhsXP/fcS9mXWvJSH9f6iVptKInHUMuoN7lYd+ZqGbVN/z1a
   WIx3kLreXHHtep8s+eaiF297/uw6Vn4njOk4WbUf3bDhfvb9zsV4+HA9u
   tJ42FZamWOqTsKFb6p5bGSFnuqGh4aeQ9FNe8voGDO7qJq4LQpHUOMVrv
   ElAbmGfs3FFLmmVzzMJsbhen7tkYrCxQ3qwix4VKRQHjdCVZdPxMGcR6S
   oBUuEJlFHuKOb3Ga1bPUCtH2/hJAXTCvY4/J0gJtLwAdUvtFLWsh1SqQ/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="315236308"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="315236308"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 05:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="929949112"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 05:20:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIqsj-000G1j-0x;
        Tue, 02 Aug 2022 12:20:17 +0000
Date:   Tue, 2 Aug 2022 20:20:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-loongarch-cpu.c:35: undefined reference to
 `liointc_handle'
Message-ID: <202208022031.9hRlPwUl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: e8bba72b396cef7c919c73710f3c5884521adb4e irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch
date:   13 days ago
config: loongarch-randconfig-s053-20220801 (https://download.01.org/0day-ci/archive/20220802/202208022031.9hRlPwUl-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8bba72b396cef7c919c73710f3c5884521adb4e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8bba72b396cef7c919c73710f3c5884521adb4e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `lpic_get_gsi_domain_id':
>> drivers/irqchip/irq-loongarch-cpu.c:35: undefined reference to `liointc_handle'
>> loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.c:35: undefined reference to `liointc_handle'
>> loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.c:35: undefined reference to `liointc_handle'
   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `liointc_parse_madt':
   drivers/irqchip/irq-loongarch-cpu.c:101: undefined reference to `liointc_acpi_init'


vim +35 drivers/irqchip/irq-loongarch-cpu.c

    27	
    28	static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
    29	{
    30		int id;
    31		struct fwnode_handle *domain_handle = NULL;
    32	
    33		switch (gsi) {
    34		case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
  > 35			if (liointc_handle)
    36				domain_handle = liointc_handle;
    37			break;
    38	
    39		case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
    40			if (pch_lpc_handle)
    41				domain_handle = pch_lpc_handle;
    42			break;
    43	
    44		case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
    45			id = find_pch_pic(gsi);
    46			if (id >= 0 && pch_pic_handle[id])
    47				domain_handle = pch_pic_handle[id];
    48			break;
    49		}
    50	
    51		return domain_handle;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEC57258F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiGLTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiGLTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:19:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA7EB027
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652200; x=1689188200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L3YWiRyoHmtipORofSE0Xgk/p4XOFMZ98aVUEGrrz3w=;
  b=U8bbTW3CqPBuqhaTnVJ8iNWVQtMJ4m4DNU0o1cjmEgxBxdjZTYJR3Y0F
   aw/BNek9T3c36ODUgBuCYlvxLkyq6ni3HN4/+vcZ9i0yxV34nZ9y8PSBE
   OaepwJSQ14rvQ6LM+A59PJWke5B2gUMJD0vgfgQxkYp+8Ai7qBilkXIEr
   LutIn/iYuwGE4yx5eZOr8SdWDa6IgeqnuheWHj/y9zLvTIaGi939kIa7S
   Ml+Y6xroZsUzYVg5p/AexgILYmJxfP116RMcmscBGCdFPVcPwC8+5Qn+6
   /22ZKl7t00HsDjkS0xt7+BnqNCZjfYykJ17PFlRPhpINhXmGI+hBXPr94
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283772928"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="283772928"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 11:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="771981263"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2022 11:56:30 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBL3d-0002az-Rp;
        Tue, 12 Jul 2022 18:56:29 +0000
Date:   Wed, 13 Jul 2022 02:56:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202207130219.0wWooaZN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72a8e05d4f66b5af7854df4490e3135168694b6b
commit: 3c816d950a494ae6e16b1fa017af29bc53cb7791 ARM: pxa: move clk register definitions to driver
date:   9 weeks ago
config: arm-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220713/202207130219.0wWooaZN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c816d950a494ae6e16b1fa017af29bc53cb7791
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3c816d950a494ae6e16b1fa017af29bc53cb7791
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-iop32x/ arch/arm/mach-mmp/ arch/arm/mach-mv78xx0/ arch/arm/mach-omap1/ arch/arm/mach-orion5x/ arch/arm/mach-spear/ arch/arm/mm/ drivers/clk/pxa/ drivers/clk/spear/ drivers/isdn/hardware/mISDN/ drivers/net/ethernet/google/gve/ drivers/scsi/ drivers/usb/host/ sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain integer as NULL pointer

vim +167 drivers/clk/pxa/clk-pxa3xx.c

   159	
   160	void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask)
   161	{
   162		u32 accr = readl(clk_regs + ACCR);
   163	
   164		accr &= ~disable;
   165		accr |= enable;
   166	
 > 167		writel(accr, ACCR);
   168		if (xclkcfg)
   169			__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
   170	
   171		while ((readl(clk_regs + ACSR) & mask) != (accr & mask))
   172			cpu_relax();
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

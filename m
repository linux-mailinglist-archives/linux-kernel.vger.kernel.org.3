Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5456588E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiGDOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiGDOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:24:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC81E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656944662; x=1688480662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WL+6GPK3ve5Wh1Qdb4CVc1LVVl849WDzZGW2h+GQ/Vs=;
  b=HEPx0z2Zd+x0FMhajMn4Cx0WaisJZoRG2A5cCoycPx1gmLvFVXjnKpfi
   kDYj5yMQ6FHLwh1ouNk2uBDePeAn6RCHN0aWKd+aE1qUNYD6oOpQpESvD
   clWaf+BmHsLRAPVv5te2XeZMKCpppRurvyeVoPWxGiQyhBpRo5kPTU0FH
   dq/c0T6MfuvP9SCJw8k3XeawINiBvy2zIFC2PGf0T8Cu7yv6FcFnj8Ltz
   8xB6k6YFAsxyDdYPyCs+kx8M6cwBKVLrgCy5Ibw5y2Ea1rKFBfcjA1XJU
   2ftzn4xja5v1XpbalE1/D91F+CXLKb7orYf5V/uOQIsdSexZBgYdjg6cR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281900221"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281900221"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="682214249"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2022 07:24:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Mzs-000HwR-Em;
        Mon, 04 Jul 2022 14:24:20 +0000
Date:   Mon, 4 Jul 2022 22:23:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [lee-mfd:for-mfd-next 25/34] drivers/mfd/axp20x.c:634:3: error:
 field designator 'get_irq_reg' does not refer to any field in type 'const
 struct regmap_irq_chip'
Message-ID: <202207042259.N64LQuw0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
head:   e0d1c4b1c0a80d4ae9f9bfcc15d048629f096928
commit: 8c7d8aa029a3cac42a468cd458adde840d2c5a06 [25/34] mfd: axp20x: Add support for AXP192
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220704/202207042259.N64LQuw0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=8c7d8aa029a3cac42a468cd458adde840d2c5a06
        git remote add lee-mfd https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
        git fetch --no-tags lee-mfd for-mfd-next
        git checkout 8c7d8aa029a3cac42a468cd458adde840d2c5a06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mfd/axp20x.c:634:3: error: field designator 'get_irq_reg' does not refer to any field in type 'const struct regmap_irq_chip'
           .get_irq_reg            = axp192_get_irq_reg,
            ^
   1 error generated.


vim +634 drivers/mfd/axp20x.c

   623	
   624	static const struct regmap_irq_chip axp192_regmap_irq_chip = {
   625		.name			= "axp192_irq_chip",
   626		.status_base		= AXP192_IRQ1_STATE,
   627		.ack_base		= AXP192_IRQ1_STATE,
   628		.mask_base		= AXP192_IRQ1_EN,
   629		.mask_invert		= true,
   630		.init_ack_masked	= true,
   631		.irqs			= axp192_regmap_irqs,
   632		.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
   633		.num_regs		= 5,
 > 634		.get_irq_reg		= axp192_get_irq_reg,
   635	};
   636	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

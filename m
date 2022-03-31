Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066804EE1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiCaTa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbiCaTaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:30:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643351586
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648754916; x=1680290916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RVAbYwRGd01Y+ARF8ixUcvPNeMUJ+DUVVbLHPMeTvPw=;
  b=HGw+vhSue5uks3j/yuewzJzxoGtMKGmtPaX3f4RPdR739hc19SlgWqPu
   BYvNzDKBNf81faS9Mo541fDGxJtbh2VKigjlIYPe6mvPZgYAtYNBB67E4
   28AiC8kCpmLgs28H+dPESW/pBPVKxhYNPvgwtLTh52+hWssQq62dLzkeU
   GBhw38Nt2Ba6zhMmQZlC6ZB18FyQ33iWaeyrwRaT26x4Jh49VYQ6xMiSA
   Y1dw+VC+NwA+MBAiMQCvaEhGTWRYpmbDjN/0UjoD52cBMl4fCOTEAuUxf
   oQdkpiK/L6bOnNIDJKBBEDcGbCLn/7iTrjxh5oYm6d/khFGPuHPdR5v3Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259643100"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259643100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 12:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="655015500"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 12:28:13 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na0Sq-0000ag-ML;
        Thu, 31 Mar 2022 19:28:12 +0000
Date:   Fri, 1 Apr 2022 03:27:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: drivers/pinctrl/samsung/pinctrl-exynos-arm64.c:773:31: sparse:
 sparse: symbol 'fsd_pin_ctrl' was not declared. Should it be static?
Message-ID: <202204010337.mR35sknO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: 0d1b662c374c54bcf68bbcff3b71e6d6e945a7cf pinctrl: samsung: add FSD SoC specific data
date:   9 weeks ago
config: nios2-randconfig-s032-20220330 (https://download.01.org/0day-ci/archive/20220401/202204010337.mR35sknO-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d1b662c374c54bcf68bbcff3b71e6d6e945a7cf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0d1b662c374c54bcf68bbcff3b71e6d6e945a7cf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash arch/nios2/ drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/pinctrl/samsung/pinctrl-exynos-arm64.c:773:31: sparse: sparse: symbol 'fsd_pin_ctrl' was not declared. Should it be static?

vim +/fsd_pin_ctrl +773 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c

   772	
 > 773	const struct samsung_pin_ctrl fsd_pin_ctrl[] __initconst = {
   774		{
   775			/* pin-controller instance 0 FSYS0 data */
   776			.pin_banks	= fsd_pin_banks0,
   777			.nr_banks	= ARRAY_SIZE(fsd_pin_banks0),
   778			.eint_gpio_init = exynos_eint_gpio_init,
   779			.suspend	= exynos_pinctrl_suspend,
   780			.resume		= exynos_pinctrl_resume,
   781		}, {
   782			/* pin-controller instance 1 PERIC data */
   783			.pin_banks	= fsd_pin_banks1,
   784			.nr_banks	= ARRAY_SIZE(fsd_pin_banks1),
   785			.eint_gpio_init = exynos_eint_gpio_init,
   786			.suspend	= exynos_pinctrl_suspend,
   787			.resume		= exynos_pinctrl_resume,
   788		}, {
   789			/* pin-controller instance 2 PMU data */
   790			.pin_banks	= fsd_pin_banks2,
   791			.nr_banks	= ARRAY_SIZE(fsd_pin_banks2),
   792		},
   793	};
   794	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

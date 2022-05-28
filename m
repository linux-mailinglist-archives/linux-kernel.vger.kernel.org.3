Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64F536E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiE1U7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiE1U7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:59:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665B43EEC
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653771542; x=1685307542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yN5YDcxj3Ho14KwIoLaitkshSlE88JSd1qIKqmxTByw=;
  b=DTeJAFEyNrhZgjxWc0KAF7WB7SGcjYGBFabVE9R6D8sSowENa5GKNfdm
   Ww1u3MFRsdPsl+8xk/K1M2WgO5uiNsIuQn2uAJSFkmonF3j64iI8fSHAN
   I6NpyZKBi5KUsQTZO3nGePfIpQ9WaAadKmGU+SE5JndylsNt6ffAL0WA8
   OSGPmK3OmRpW8PB9TSpdTHqrDSTTVHEbeL/fYHH+wK4Ol9FUx4MlIsXLQ
   uRD+MZSC+0gYu4qP3g7LAdRbbSS7Hf1Ry5c3sA6vbTml89F7vEIx71+j4
   O9wJ8MGxHVipY9zrZGxyFTohv6OvjaeQ6ZGICES95Hbwa6ytInJdlZqcC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="361095865"
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="361095865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 13:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="528660938"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2022 13:58:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nv3WT-0000Wy-VC;
        Sat, 28 May 2022 20:58:58 +0000
Date:   Sun, 29 May 2022 04:58:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused
 variable 'ssd130x_spi_table'
Message-ID: <202205290422.eoxGqDMR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: 74373977d2ca26e5735377f8874be70bc2f030f5 drm/solomon: Add SSD130x OLED displays SPI support
date:   5 weeks ago
config: hexagon-randconfig-r033-20220529 (https://download.01.org/0day-ci/archive/20220529/202205290422.eoxGqDMR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74373977d2ca26e5735377f8874be70bc2f030f5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 74373977d2ca26e5735377f8874be70bc2f030f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/solomon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused variable 'ssd130x_spi_table' [-Wunused-const-variable]
   static const struct spi_device_id ssd130x_spi_table[] = {
                                     ^
   1 warning generated.


vim +/ssd130x_spi_table +154 drivers/gpu/drm/solomon/ssd130x-spi.c

   145	
   146	/*
   147	 * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
   148	 * if the device was registered via OF. This means that the module will not be
   149	 * auto loaded, unless it contains an alias that matches the MODALIAS reported.
   150	 *
   151	 * To workaround this issue, add a SPI device ID table. Even when this should
   152	 * not be needed for this driver to match the registered SPI devices.
   153	 */
 > 154	static const struct spi_device_id ssd130x_spi_table[] = {
   155		{ "sh1106",  SH1106_ID },
   156		{ "ssd1305", SSD1305_ID },
   157		{ "ssd1306", SSD1306_ID },
   158		{ "ssd1307", SSD1307_ID },
   159		{ "ssd1309", SSD1309_ID },
   160		{ /* sentinel */ }
   161	};
   162	MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

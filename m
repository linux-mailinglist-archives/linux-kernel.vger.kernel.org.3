Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D924FA115
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiDIB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbiDIB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960FE1262
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649467615; x=1681003615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WY5TLp39ZsMX3T43dPF1MIRnvIZX39gu4wEr1mMLVis=;
  b=OYa/aS8C3gOEqvvWooaSKgiNWPNcpjQxI3YCsbK+RFcwP13RKGOW44Dv
   sPiYKTZa1366NfvHf2YKtIHPYeQjyiTdmJ6OyOtZgu9zzfCUjsEtGuZzM
   R/k3DKQQlm5Mi57SR78uFjQVQnzkMa/7YlKZyR35+po4Rj8AAGngMYyJE
   ZyCeXI6m270xM7LLm6m0c+KlaZDFFGVTii5Un2iwIqYJIhbUzI8D+YbWE
   tpc9za/rv8KSRsjhLO5nZKKxBKZQ9KYiPV5Zq15wys3c24InjBEYWKyqQ
   ZOZ7FMTXnNPl0w+ftr07Ub5ml3Wfw6jCm3yJUEswB1CcVHu5cgObOXN96
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="348177145"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="348177145"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="621889748"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 18:26:52 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nczsJ-0000m5-QT;
        Sat, 09 Apr 2022 01:26:51 +0000
Date:   Sat, 9 Apr 2022 09:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 578/888] panel-sitronix-st7701.c:undefined
 reference to `spi_sync'
Message-ID: <202204090901.hb9uqZRT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   240f56c27361c195cd502d95aba51c6b8e5b808c
commit: 72c355c6c7656888e6124c1356c3f68cb9cf5b35 [578/888] drm/panel/panel-sitronix-st7701: Support SPI config and RGB data
config: nios2-randconfig-s032-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090901.hb9uqZRT-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/l1k/linux/commit/72c355c6c7656888e6124c1356c3f68cb9cf5b35
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 72c355c6c7656888e6124c1356c3f68cb9cf5b35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_disable.part.0':
>> panel-sitronix-st7701.c:(.text+0x230): undefined reference to `spi_sync'
   panel-sitronix-st7701.c:(.text+0x230): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_enable.part.0':
   panel-sitronix-st7701.c:(.text+0x2a0): undefined reference to `spi_sync'
   panel-sitronix-st7701.c:(.text+0x2a0): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `txw210001b0_init_sequence':
   panel-sitronix-st7701.c:(.text+0x3a4): undefined reference to `spi_sync'
   panel-sitronix-st7701.c:(.text+0x3a4): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
>> nios2-linux-ld: panel-sitronix-st7701.c:(.text+0x408): undefined reference to `spi_sync'
   panel-sitronix-st7701.c:(.text+0x408): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   nios2-linux-ld: panel-sitronix-st7701.c:(.text+0x45c): undefined reference to `spi_sync'
   panel-sitronix-st7701.c:(.text+0x45c): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o:panel-sitronix-st7701.c:(.text+0x4b0): more undefined references to `spi_sync' follow
   drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `txw210001b0_init_sequence':
   panel-sitronix-st7701.c:(.text+0x4b0): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   panel-sitronix-st7701.c:(.text+0x500): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   panel-sitronix-st7701.c:(.text+0x54c): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   panel-sitronix-st7701.c:(.text+0x59c): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   panel-sitronix-st7701.c:(.text+0x5ec): relocation truncated to fit: R_NIOS2_CALL26 against `spi_sync'
   panel-sitronix-st7701.c:(.text+0x63c): additional relocation overflows omitted from the output
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_spi_probe':
>> panel-sitronix-st7701.c:(.text+0x116c): undefined reference to `spi_setup'
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_unprepare':
   panel-sitronix-st7701.c:(.text+0x134c): undefined reference to `spi_sync'
   nios2-linux-ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `panel_st7701_init':
>> panel-sitronix-st7701.c:(.init.text+0x18): undefined reference to `__spi_register_driver'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

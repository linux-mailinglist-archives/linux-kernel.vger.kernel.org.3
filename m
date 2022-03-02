Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5E4CB330
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiCBXzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCBXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:55:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D70C1301A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646265303; x=1677801303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J0QbwjCwDYXvMNsZ5InVMIU+FlQX9LNCp20z66s3YCI=;
  b=N4KbMYvwgrFi/8qP6Tw5HqLC/XwJ+wyccsyU5sM+m8BPWcCwsllCKJZx
   5guFVOTmWr+rgmXX0r/vd78fDy4GOxikGmf1qEX704K6JmrwZXd+oD3oV
   eCZz7wqOwqy9AMZx81wJqbnsXFNqxoeIc7/URdhuuZvBS9U2kWhAW5zpk
   1v87AqZQkZD6KRSYorUji7clalee7uf2YZq5oZWjDsYZzGZlgEznZXSlJ
   nE+toLG/dCGVMt1TmUbtmG39jovB+4ajYcAuOIDKuFsCS9nxbMoO1ThZs
   qirNeQokavNL4OE72OQ6y9Rt3M92k/Ua5tVc1IpYFVpal0RzkWMwPgaZY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253459978"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253459978"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="709698415"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 15:33:00 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPYSp-00024t-Kg; Wed, 02 Mar 2022 23:32:59 +0000
Date:   Thu, 3 Mar 2022 07:32:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/050-nvme 9/15] m68k-linux-ld: apple.c:undefined
 reference to `devm_apple_rtkit_init'
Message-ID: <202203030728.ft88aFTm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   fa98fe78deae80c3ca00451876f72fd38b2b3ee9
commit: 27dce760587c8c88aef9a2ef877a92df348075a6 [9/15] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220303/202203030728.ft88aFTm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/27dce760587c8c88aef9a2ef877a92df348075a6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout 27dce760587c8c88aef9a2ef877a92df348075a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
   apple.c:(.text+0x51e): undefined reference to `apple_sart_remove_allowed_region'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
   apple.c:(.text+0x5c2): undefined reference to `apple_sart_add_allowed_region'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text+0x1332): undefined reference to `apple_sart_get'
>> m68k-linux-ld: apple.c:(.text+0x152e): undefined reference to `devm_apple_rtkit_init'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
   apple.c:(.text+0x17a4): undefined reference to `apple_rtkit_is_crashed'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x1a1e): undefined reference to `apple_rtkit_is_running'
>> m68k-linux-ld: apple.c:(.text+0x1a30): undefined reference to `apple_rtkit_shutdown'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x1ad6): undefined reference to `apple_rtkit_is_running'
   m68k-linux-ld: apple.c:(.text+0x1ae6): undefined reference to `apple_rtkit_shutdown'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x1b4e): undefined reference to `apple_rtkit_is_crashed'
>> m68k-linux-ld: apple.c:(.text+0x1b94): undefined reference to `apple_rtkit_is_running'
   m68k-linux-ld: apple.c:(.text+0x1bec): undefined reference to `apple_rtkit_shutdown'
>> m68k-linux-ld: apple.c:(.text+0x1c00): undefined reference to `apple_rtkit_reinit'
>> m68k-linux-ld: apple.c:(.text+0x1c3c): undefined reference to `apple_rtkit_boot'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x2280): undefined reference to `apple_rtkit_is_crashed'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

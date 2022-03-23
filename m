Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05B4E5973
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbiCWT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCWT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:57:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892498BF49
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648065364; x=1679601364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ce7OYUFrgzrZStoAkM1C5QCjHmLPx7qs2Q9Ms+pJfc4=;
  b=RNONu0AYRshtFuleK39ZUw6wCoDRjggKeGsQk2CyBJb5qv0IuZLLidmx
   pgu/QxLu1EjzNWyvY//9LxncjmRpMPOYRFdlwejV4MFVL5fE+dRsKLYg4
   L3gfkCCGJOWz0RYEOonk9B5Ai8KhAq+IfLwrRsYm/Rr7UpLg9PW3BRNa4
   G18F1nsTbQ4HJ4F+ZMSdjxP0d5SzkKx1SCnR1y43+f5MzE340wztkbBu+
   EX/gZDDk/T3w/OBWsddcVRHl2fXMeSyE7tn9TMIbJZvMA0vm9k4Kxkmkj
   9wsiXx7fruCzvntpYM/kWMVGc5ZmmKRjIfzHxPZehKci6KSw042qqLtKx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="344647126"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="344647126"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 12:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="649576648"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2022 12:56:02 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nX75O-000KLw-1S; Wed, 23 Mar 2022 19:56:02 +0000
Date:   Thu, 24 Mar 2022 03:55:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme-rfc 6/9] s390-linux-ld: apple.c:undefined reference
 to `apple_rtkit_is_crashed'
Message-ID: <202203240342.RFvSPhFG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-rfc
head:   38f95567a5c591f8d41b2f166fa0e1d2d81eeeb0
commit: f2339fc0db4ef9cec9e427790a23621744059f4e [6/9] nvme-apple: Add initial Apple SoC NVMe driver
config: s390-randconfig-c024-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240342.RFvSPhFG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/f2339fc0db4ef9cec9e427790a23621744059f4e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-rfc
        git checkout f2339fc0db4ef9cec9e427790a23621744059f4e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
   apple.c:(.text+0x4e6): undefined reference to `apple_sart_remove_allowed_region'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
   apple.c:(.text+0x66a): undefined reference to `apple_sart_add_allowed_region'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
   apple.c:(.text+0x2cee): undefined reference to `apple_rtkit_is_crashed'
>> s390-linux-ld: apple.c:(.text+0x2d7e): undefined reference to `apple_rtkit_is_crashed'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x30d4): undefined reference to `apple_rtkit_is_running'
>> s390-linux-ld: apple.c:(.text+0x310c): undefined reference to `apple_rtkit_shutdown'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x31d0): undefined reference to `apple_rtkit_is_running'
   s390-linux-ld: apple.c:(.text+0x3202): undefined reference to `apple_rtkit_shutdown'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x331a): undefined reference to `apple_rtkit_is_crashed'
>> s390-linux-ld: apple.c:(.text+0x334c): undefined reference to `apple_rtkit_is_running'
   s390-linux-ld: apple.c:(.text+0x33a4): undefined reference to `apple_rtkit_shutdown'
>> s390-linux-ld: apple.c:(.text+0x343c): undefined reference to `apple_rtkit_reinit'
>> s390-linux-ld: apple.c:(.text+0x34be): undefined reference to `apple_rtkit_boot'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x40de): undefined reference to `apple_rtkit_is_crashed'
   s390-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text+0x4552): undefined reference to `apple_sart_get'
>> s390-linux-ld: apple.c:(.text+0x4bd0): undefined reference to `devm_apple_rtkit_init'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

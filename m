Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614994D2DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiCILKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiCILKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:10:05 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCAC127D6D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646824147; x=1678360147;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J0YY95aE/Id7lJdSP/3jCRc5QFoNIt2d2lg8BvEmkHQ=;
  b=WvnnrIm3NG6qciDz8KQnLQT19HmLgk4j7hUCUvw8mUM0o8XDG14pbfWq
   XM24HDyB1oT3zUQiRcNHZA7uOE9ycCRxlsN0Zycuahq4uVrAIQkrNCtNg
   n2RlYrLe0xSmH3DC4A+gUmLaSbtAazRL0SPXZidiAS5OfQgVEbZEpLqkZ
   m521BLFXAOlCUJDMtRgaOUL7W6vodsny1g3G5UWZ/wMtZJKnFE9g/KEQA
   a8Spp1UbUOAoqdn8g4QbzyiUqToDTpWqQ9tV16JysuD7o+ZbOkdmQQkrz
   yugQakM3B4xdR9qicbh0MTMI6Et9QQaexeVicT/nS7bF9e0S75hcEGq32
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253780327"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="253780327"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 03:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="513489052"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 03:09:05 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRuBk-000397-NP; Wed, 09 Mar 2022 11:09:04 +0000
Date:   Wed, 9 Mar 2022 19:08:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Divya Koppera <Divya.Koppera@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/master 34/177] ld.lld: error:
 undefined symbol: ptp_clock_register
Message-ID: <202203091943.vWYw7yEQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   d82a6c5ef9dc0aab296936e1aa4ad28fd5162a55
commit: ece19502834d84ece2e056db28257ca2aa6e4d48 [34/177] net: phy: micrel: 1588 support for LAN8814 phy
config: hexagon-randconfig-r041-20220308 (https://download.01.org/0day-ci/archive/20220309/202203091943.vWYw7yEQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ece19502834d84ece2e056db28257ca2aa6e4d48
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout ece19502834d84ece2e056db28257ca2aa6e4d48
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ptp_clock_register
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_probe) in archive drivers/built-in.a
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: ptp_clock_index
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_ts_info) in archive drivers/built-in.a
   >>> referenced by micrel.c
   >>> net/phy/micrel.o:(lan8814_ts_info) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

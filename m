Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C9520B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiEJCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 22:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiEJCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 22:32:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D2017EC00
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652149706; x=1683685706;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dlB5MTx2ZXI2dQXqV+azNgC3+AD2rChCKzMArvkB4r0=;
  b=ahlXwGaGq2fc8KFIZW66fRB+R6b7eEt1chr7/wEH9VIA1bPCLxJSVqmX
   hTlZ0np99afJPICCfRWc3/TCxDFiklHqk/3T8IMq+oVwA8JDd5C26ZF2x
   J7NLAZvtg+UFK+ikq7GGjrpb1Rw287APn9tG7HVv0UxpasC1VwATYRFqt
   CUPvlwP3/rT+bRjMupulDPIxvUQfBdt3aNrpOv3qSGzV2aM/85ye0Va9L
   MqBxNY0vFRU6YlrX/3PC+gKkjUJQCB/Lzih2qdeCDx72WpNmjqvqRCrWR
   D2kQkbkI5MBEESLLZRwenOIRX4rW+sKi4t0b7pRV5VAcFBCh5T2bq8tA0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251282036"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="251282036"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 19:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="657427856"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 19:28:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noFbr-000HBo-RE;
        Tue, 10 May 2022 02:28:23 +0000
Date:   Tue, 10 May 2022 10:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/crypto/atmel-sha204a.c:135:34: warning:
 'atmel_sha204a_dt_ids' defined but not used
Message-ID: <202205101001.UUeWDJtR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9be9ed2612b5aedb52a2c240edb1630b6b743cb6
commit: da001fb651b00e1deeaf24767dd691ae8152a4f5 crypto: atmel-i2c - add support for SHA204A random number generator
date:   2 years, 11 months ago
config: i386-randconfig-r026-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101001.UUeWDJtR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=da001fb651b00e1deeaf24767dd691ae8152a4f5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout da001fb651b00e1deeaf24767dd691ae8152a4f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/atmel-sha204a.c:135:34: warning: 'atmel_sha204a_dt_ids' defined but not used [-Wunused-const-variable=]
     135 | static const struct of_device_id atmel_sha204a_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/crypto/atmel-sha204a.c:19:
   drivers/crypto/atmel-i2c.h:67:3: warning: 'error_list' defined but not used [-Wunused-const-variable=]
      67 | } error_list[] = {
         |   ^~~~~~~~~~


vim +/atmel_sha204a_dt_ids +135 drivers/crypto/atmel-sha204a.c

   134	
 > 135	static const struct of_device_id atmel_sha204a_dt_ids[] = {
   136		{ .compatible = "atmel,atsha204a", },
   137		{ /* sentinel */ }
   138	};
   139	MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
   140	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

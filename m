Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924344B8078
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiBPGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:12:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiBPGMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:12:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC913197B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 22:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644991949; x=1676527949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AZwoeDLTGFvcy8p8IRLuB0Jkc5gMcMQq1Sm4/d51HS4=;
  b=aJ1zsHQLO2Ne/WC6ImkVfiJ6ndHBNbT3EO9Jw30PaKjxZ2w9QZm4vFp9
   CNkyT5J9yb3phbz8TbWYstlwZ4AwjZ9o2oeDcRbXwdyyn9Fiw0prVjkoh
   VOxbJaz0gRoOFpMbqMp/SqqI1Gjbdw3hzlJtgvR8rsi0zjAUvtXKCBMLi
   HRomNeO6KMmw9a6g+4NftJkPLH4KbJAoNQ8BEaeEsb5SGq5Y4XLf725Jn
   oOFmb1A0hVCypoChlAgq8ler8QXflALAQFFWZJGnIL4xlxwy1/xRIet7e
   G8WUZfjPEP/QR581Gf9vBCy/1FkRo6Jk72769XjZrKaHyt2VXkHCxzg6e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230495812"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="230495812"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636347620"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 22:12:27 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKDYA-000AV5-Sf; Wed, 16 Feb 2022 06:12:26 +0000
Date:   Wed, 16 Feb 2022 14:12:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [ammarfaizi2-block:axboe/linux-block/m1-test 248/382]
 apple.c:undefined reference to `apple_rtkit_is_crashed'
Message-ID: <202202161415.O3r14xmk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1-test
head:   5adfbb595194191bad98c47447ddbee7d3b60b8f
commit: 4af74948141263ed097ad48f8845871d16410b08 [248/382] WIP: nvme-apple: add initial Apple SoC NVMe driver
config: arm64-randconfig-r016-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161415.O3r14xmk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4af74948141263ed097ad48f8845871d16410b08
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1-test
        git checkout 4af74948141263ed097ad48f8845871d16410b08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable.constprop.0':
>> apple.c:(.text+0x7c0): undefined reference to `apple_rtkit_is_crashed'
   aarch64-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
>> apple.c:(.text+0xa8c): undefined reference to `apple_rtkit_is_running'
>> aarch64-linux-ld: apple.c:(.text+0xab8): undefined reference to `apple_rtkit_shutdown'
   aarch64-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0xb1c): undefined reference to `apple_rtkit_is_running'
   aarch64-linux-ld: apple.c:(.text+0xb44): undefined reference to `apple_rtkit_shutdown'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

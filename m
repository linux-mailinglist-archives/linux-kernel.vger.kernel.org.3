Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BED5870A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiHAS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiHAS6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:58:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EBA26568
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659380324; x=1690916324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q9OfXtbNXN0omVmu1roF+hahKAFgpQhJ7fggdE8Xz5g=;
  b=n3/GnbQOTsXaXYWs4nfF/cE8jHSjYl/w+wKkOR3VGkQcZ25PKmcRkN9F
   9FtpeHgvPpcsh6BblghXeDCw4Z4/ubN3hWPiMrSDUNukldcbEhsygE6CF
   dTNLA/HfKbUSP7tqb2K4+I1syEz0fMleuUA2W9jEn2VAxGomLaBUGDamt
   Ejrc4XLqxmEtuRjjcS3k7H94W53X7bxkFXMD7upT0J1iYSuKicg86PjB8
   QI2WQaJfxNI3knE5y/vpVnnkXfISuPvAVE/nSSa2NbPOlaH1t2E4t5SYK
   meKSu3hXM46nzynl2xyUIh5n5pqy/s+wsz4SBGiTDx8TDFmMklURgovK4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289235043"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="289235043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 11:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="630366487"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 11:58:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIack-000FEN-0o;
        Mon, 01 Aug 2022 18:58:42 +0000
Date:   Tue, 2 Aug 2022 02:58:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol
 'sa1100dog_driver' was not declared. Should it be static?
Message-ID: <202208020222.fEWtlI3i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cec3f24a7cedc726f8790d693aaff2c535dc4ce
commit: e86bd43bcfc579cf8935c1913e92cb76b4ba81c2 watchdog: sa1100: use platform device registration
date:   3 months ago
config: arm-randconfig-s051-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020222.fEWtlI3i-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e86bd43bcfc579cf8935c1913e92cb76b4ba81c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver' was not declared. Should it be static?

vim +/sa1100dog_driver +241 drivers/watchdog/sa1100_wdt.c

   240	
 > 241	struct platform_driver sa1100dog_driver = {
   242		.driver.name = "sa1100_wdt",
   243		.probe	  = sa1100dog_probe,
   244		.remove	  = sa1100dog_remove,
   245	};
   246	module_platform_driver(sa1100dog_driver);
   247	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

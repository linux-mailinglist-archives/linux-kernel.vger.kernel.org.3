Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210B24C9B82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiCBCwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiCBCwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:52:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F9AA2FD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189496; x=1677725496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xXN//8hcWbodgT33696THMiyt6mL7D9oELHGnSqahGg=;
  b=O+kKacMospmnZHVMQoXjr/dhKDMwfGzY9kaOwHG/WEGQrI9m/yqM4WDi
   6vE6wHzkTeB81KppFPkhUmJEHHfpltOlIgbxBzVMKLpNXhe2jnqhzjvMm
   j2judqw2KktyZaZ4sPkzkhLHPYx4QnPqV9psPVC5+aTLKGbLDK4vJ0JpZ
   L16gktdKadJEwM8WdvH8uuylpF4gPG2YQX8kbZWNvv7/vaf+87k4Dpm59
   PYyOyLaCmfmh9VRTxVanvqECDe6YrIGdL0W1sORoHgklyRNke64DjvlhD
   E0VAqLo5SH7uDHUfsVwiLl0SweU+x1VIsno4nr4mgQZgnw1hYYrA0yvG9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240707894"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="240707894"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="685984123"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2022 18:51:34 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF5R-0000wd-Ln; Wed, 02 Mar 2022 02:51:33 +0000
Date:   Wed, 2 Mar 2022 10:51:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-03-01 255/355]
 drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function
 'FIELD_PREP'
Message-ID: <202203020738.Na1cRAnn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-03-01
head:   d7cc9472c1c5430d7caa806e8180d2359ea46266
commit: 64fbe30aba627660bfb6947d960bdd180830d322 [255/355] clk: clk-apple-nco: Add driver for Apple NCO
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220302/202203020738.Na1cRAnn-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/64fbe30aba627660bfb6947d960bdd180830d322
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-03-01
        git checkout 64fbe30aba627660bfb6947d960bdd180830d322
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/clk/ drivers/dma/ drivers/platform/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate':
>> drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     139 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:147:27: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
     147 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
         |                           FOLL_GET
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +139 drivers/clk/clk-apple-nco.c

   131	
   132	static u32 applnco_div_translate(struct applnco_tables *tbl, unsigned int div)
   133	{
   134		unsigned int coarse = div / 4;
   135	
   136		if (WARN_ON(applnco_div_out_of_range(div)))
   137			return 0;
   138	
 > 139		return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
   140				FIELD_PREP(DIV_FINE, div % 4);
   141	}
   142	
   143	static unsigned int applnco_div_translate_inv(struct applnco_tables *tbl, u32 regval)
   144	{
   145		unsigned int coarse, fine;
   146	
 > 147		coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
   148		fine = FIELD_GET(DIV_FINE, regval);
   149	
   150		return coarse * 4 + fine;
   151	}
   152	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

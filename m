Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00284BE8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350549AbiBUJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:35:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350001AbiBUJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:27:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D2116
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645434673; x=1676970673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+sMSFdBUf/9LvW63UTt/8rXrHUw2YlFgt4UKqrVoN7s=;
  b=JrV1JDUdwhHQpGhwUvwIkMQ2xEygKVcJ3vlBkasCMoBYUHRv6MduTp4z
   aDmBe+mUbi64tr/ByNKUW7dLaVy64lR2BPt/qYgHyd0U96QhrLddgvoG5
   gXrZwDNcQ3TOMKn/HbrfXlOTqTHJ5SHyEcWQVoXjjjpS52d9x+wwk0Ahf
   J+HJOONITFQ/CJA+f5daeC4h1CUiaTdSLL1n2TrqJru4xl/pzJanxox1U
   i/Lzuj/grdQr8/lLD1seOGLj5E3lzBXyVBySpvS4Dk16K3vfOf9dvbrrF
   Z3szmYiFQ5aAgPIz7X6iN7jaOKLKwLphOBcGDzzg+eYCntqnoGsp9GpbF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231439306"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="231439306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 01:11:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="775938345"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 01:11:10 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM4ir-0001S6-E0; Mon, 21 Feb 2022 09:11:09 +0000
Date:   Mon, 21 Feb 2022 17:11:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-02-19 517/552]
 drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function
 'FIELD_PREP'
Message-ID: <202202211707.LrS0JBhZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-02-19
head:   b781e0ccdc0c9a931571d15db09d45b7258b9905
commit: 276bb3ac97d54e2461f27705391a3b87750a390e [517/552] clk: clk-apple-nco: Add driver for Apple NCO
config: arm-randconfig-r026-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211707.LrS0JBhZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/276bb3ac97d54e2461f27705391a3b87750a390e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-02-19
        git checkout 276bb3ac97d54e2461f27705391a3b87750a390e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate':
>> drivers/clk/clk-apple-nco.c:139:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     139 |         return FIELD_PREP(DIV_COARSE, tbl->fwd[coarse - COARSE_DIV_OFFSET]) |
         |                ^~~~~~~~~~
   drivers/clk/clk-apple-nco.c: In function 'applnco_div_translate_inv':
>> drivers/clk/clk-apple-nco.c:147:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     147 |         coarse = tbl->inv[FIELD_GET(DIV_COARSE, regval)] + COARSE_DIV_OFFSET;
         |                           ^~~~~~~~~
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

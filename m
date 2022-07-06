Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C4568931
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiGFNRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiGFNRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A31A3B1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657113432; x=1688649432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tB0wesIpPv7WkXhLfFT7yuaEmztcFD3TXUo9yujrw6A=;
  b=jf+jOU3J+xkfLtgAyfIq7pYCVLLf5ZCJMobybFom6I1pqvs5TZeiynzd
   oIwipsNP8h5MtoCB9RfPey7yhSKhmGRTn3C/MnCRXMm2QkX6tc92qX1O3
   gk1m9jphV3InfKKH5ep+WYOTBeK1YGYvVgs4OqgyeubRAdA8xLiYMT76P
   bLxLC/4ou30YmOSTN4vJTD0PdqTX6i5NGsHwb3MpDMTWQhipjmjvi+L1w
   bbs1dO7IT3JBwraB4ZCHw42agGCuLvN4u7CM9Y08OkhZk74tAwny4+fIb
   4GJ6qX6dY4/+glxrqXtWU7u5HYnOdrV++J2wJxh6YeYuKuhzQStkKA09M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284864516"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="284864516"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 06:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="682917323"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2022 06:17:05 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o94ts-000Kbn-Ec;
        Wed, 06 Jul 2022 13:17:04 +0000
Date:   Wed, 6 Jul 2022 21:16:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 328/350]
 sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but not used
Message-ID: <202207062130.ZOiHtbFz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   b182f4804a456b4ffdef1da14aef92c8d4cfda4a
commit: f94fa84058014f81ad526641f1b1f583ca2cf32f [328/350] ASoC: amd: enable machine driver build for Jadeite platform
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207062130.ZOiHtbFz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f94fa84058014f81ad526641f1b1f583ca2cf32f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout f94fa84058014f81ad526641f1b1f583ca2cf32f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/amd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/amd/acp-es8336.c: In function 'st_es8336_late_probe':
>> sound/soc/amd/acp-es8336.c:200:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     200 |         int ret;
         |             ^~~


vim +/ret +200 sound/soc/amd/acp-es8336.c

02527c3f2300100 Vijendar Mukunda 2022-07-01  196  
02527c3f2300100 Vijendar Mukunda 2022-07-01  197  static int st_es8336_late_probe(struct snd_soc_card *card)
02527c3f2300100 Vijendar Mukunda 2022-07-01  198  {
02527c3f2300100 Vijendar Mukunda 2022-07-01  199  	struct acpi_device *adev;
02527c3f2300100 Vijendar Mukunda 2022-07-01 @200  	int ret;
02527c3f2300100 Vijendar Mukunda 2022-07-01  201  
02527c3f2300100 Vijendar Mukunda 2022-07-01  202  	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
02527c3f2300100 Vijendar Mukunda 2022-07-01  203  	if (adev)
02527c3f2300100 Vijendar Mukunda 2022-07-01  204  		put_device(&adev->dev);
02527c3f2300100 Vijendar Mukunda 2022-07-01  205  	codec_dev = acpi_get_first_physical_node(adev);
02527c3f2300100 Vijendar Mukunda 2022-07-01  206  	if (!codec_dev)
02527c3f2300100 Vijendar Mukunda 2022-07-01  207  		dev_err(card->dev, "can not find codec dev\n");
02527c3f2300100 Vijendar Mukunda 2022-07-01  208  
02527c3f2300100 Vijendar Mukunda 2022-07-01  209  	ret = devm_acpi_dev_add_driver_gpios(codec_dev, acpi_es8336_gpios);
02527c3f2300100 Vijendar Mukunda 2022-07-01  210  
02527c3f2300100 Vijendar Mukunda 2022-07-01  211  	gpio_pa = gpiod_get_optional(codec_dev, "pa-enable", GPIOD_OUT_LOW);
02527c3f2300100 Vijendar Mukunda 2022-07-01  212  	if (IS_ERR(gpio_pa)) {
02527c3f2300100 Vijendar Mukunda 2022-07-01  213  		ret = dev_err_probe(card->dev, PTR_ERR(gpio_pa),
02527c3f2300100 Vijendar Mukunda 2022-07-01  214  				    "could not get pa-enable GPIO\n");
02527c3f2300100 Vijendar Mukunda 2022-07-01  215  		gpiod_put(gpio_pa);
02527c3f2300100 Vijendar Mukunda 2022-07-01  216  		put_device(codec_dev);
02527c3f2300100 Vijendar Mukunda 2022-07-01  217  	}
02527c3f2300100 Vijendar Mukunda 2022-07-01  218  	return 0;
02527c3f2300100 Vijendar Mukunda 2022-07-01  219  }
02527c3f2300100 Vijendar Mukunda 2022-07-01  220  

:::::: The code at line 200 was first introduced by commit
:::::: 02527c3f2300100a25524c8c020d98c7957e485e ASoC: amd: add Machine driver for Jadeite platform

:::::: TO: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

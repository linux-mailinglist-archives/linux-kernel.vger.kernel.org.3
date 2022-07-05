Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5090F567A96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiGEXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiGEXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:13:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C23C14032
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062783; x=1688598783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ONUzRAeEvM//0wIzEJNyjBMEp5VuDPoDaLlsfhpATSU=;
  b=KAOvxGvY+465xBrmMgiK1FZXIUnjn5WqyOZSJgZyoiXOtkrvJAtHLq+8
   S6g4MpNceBcXnC/+gTZpPm1C4UJIJDIs/V58Lu8gIOHV46EebTud7gERo
   fRSIWFidURNiU7TPkFDGPahwHFjdJ+bCV/iZMggmmP8WxwVnj8iVwujHJ
   66nn7sgj20h5/Im49UJVtNC2qVrTjVaECpTEPZbNtKJqhjYAyFBw8zpIm
   rRG2WuXTB/KScv83cng+QntRRLLZUVo3DKjNyW6ug1BEwBZbqBhjVvoKA
   i5DuO93x69Zis4eBp1Bp/L3DZXMJKyiUA8aSc49RFa7TsGefSNDUnKpz9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263350199"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="263350199"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="660728808"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2022 16:13:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8rj2-000JhS-Lv;
        Tue, 05 Jul 2022 23:13:00 +0000
Date:   Wed, 6 Jul 2022 07:12:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [ammarfaizi2-block:broonie/sound/for-next 324/326]
 sound/soc/intel/avs/boards/i2s_test.c:130:60: warning: format '%ld' expects
 argument of type 'long int', but argument 4 has type 'int'
Message-ID: <202207060734.OWDl2z9f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   4fbea41e3404788d05a013841431abd07d307255
commit: f4ba35b79bd0104f00e8e21e400b980bfaa2f17e [324/326] ASoC: Intel: avs: correct config reference for I2S test board
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060734.OWDl2z9f-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/f4ba35b79bd0104f00e8e21e400b980bfaa2f17e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout f4ba35b79bd0104f00e8e21e400b980bfaa2f17e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/intel/avs/boards/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/intel/avs/boards/i2s_test.c: In function 'avs_i2s_test_probe':
>> sound/soc/intel/avs/boards/i2s_test.c:130:60: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
     130 |         card->name = devm_kasprintf(dev, GFP_KERNEL, "ssp%ld-loopback", ssp_port);
         |                                                          ~~^            ~~~~~~~~
         |                                                            |            |
         |                                                            long int     int
         |                                                          %d


vim +130 sound/soc/intel/avs/boards/i2s_test.c

e39acc4cfd9250 Cezary Rojewski 2022-05-11  109  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  110  static int avs_i2s_test_probe(struct platform_device *pdev)
e39acc4cfd9250 Cezary Rojewski 2022-05-11  111  {
e39acc4cfd9250 Cezary Rojewski 2022-05-11  112  	struct snd_soc_dapm_widget *widgets;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  113  	struct snd_soc_dapm_route *routes;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  114  	struct snd_soc_dai_link *dai_link;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  115  	struct snd_soc_acpi_mach *mach;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  116  	struct snd_soc_card *card;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  117  	struct device *dev = &pdev->dev;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  118  	const char *pname;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  119  	int num_routes, num_widgets;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  120  	int ssp_port, ret;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  121  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  122  	mach = dev_get_platdata(dev);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  123  	pname = mach->mach_params.platform;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  124  	ssp_port = __ffs(mach->mach_params.i2s_link_mask);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  125  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  126  	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  127  	if (!card)
e39acc4cfd9250 Cezary Rojewski 2022-05-11  128  		return -ENOMEM;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  129  
e39acc4cfd9250 Cezary Rojewski 2022-05-11 @130  	card->name = devm_kasprintf(dev, GFP_KERNEL, "ssp%ld-loopback", ssp_port);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  131  	if (!card->name)
e39acc4cfd9250 Cezary Rojewski 2022-05-11  132  		return -ENOMEM;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  133  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  134  	ret = avs_create_dai_link(dev, pname, ssp_port, &dai_link);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  135  	if (ret) {
e39acc4cfd9250 Cezary Rojewski 2022-05-11  136  		dev_err(dev, "Failed to create dai link: %d\n", ret);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  137  		return ret;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  138  	}
e39acc4cfd9250 Cezary Rojewski 2022-05-11  139  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  140  	ret = avs_create_dapm_routes(dev, ssp_port, &routes, &num_routes);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  141  	if (ret) {
e39acc4cfd9250 Cezary Rojewski 2022-05-11  142  		dev_err(dev, "Failed to create dapm routes: %d\n", ret);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  143  		return ret;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  144  	}
e39acc4cfd9250 Cezary Rojewski 2022-05-11  145  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  146  	ret = avs_create_dapm_widgets(dev, ssp_port, &widgets, &num_widgets);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  147  	if (ret) {
e39acc4cfd9250 Cezary Rojewski 2022-05-11  148  		dev_err(dev, "Failed to create dapm widgets: %d\n", ret);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  149  		return ret;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  150  	}
e39acc4cfd9250 Cezary Rojewski 2022-05-11  151  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  152  	card->dev = dev;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  153  	card->owner = THIS_MODULE;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  154  	card->dai_link = dai_link;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  155  	card->num_links = 1;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  156  	card->dapm_routes = routes;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  157  	card->num_dapm_routes = num_routes;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  158  	card->dapm_widgets = widgets;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  159  	card->num_dapm_widgets = num_widgets;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  160  	card->fully_routed = true;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  161  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  162  	ret = snd_soc_fixup_dai_links_platform_name(card, pname);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  163  	if (ret)
e39acc4cfd9250 Cezary Rojewski 2022-05-11  164  		return ret;
e39acc4cfd9250 Cezary Rojewski 2022-05-11  165  
e39acc4cfd9250 Cezary Rojewski 2022-05-11  166  	return devm_snd_soc_register_card(dev, card);
e39acc4cfd9250 Cezary Rojewski 2022-05-11  167  }
e39acc4cfd9250 Cezary Rojewski 2022-05-11  168  

:::::: The code at line 130 was first introduced by commit
:::::: e39acc4cfd9250e7b8ec01897570f3009659c3d6 ASoC: Intel: avs: Add I2S-test machine board

:::::: TO: Cezary Rojewski <cezary.rojewski@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

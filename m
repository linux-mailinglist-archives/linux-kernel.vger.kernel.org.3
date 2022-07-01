Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A03562875
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiGABkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGABkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:40:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DA38182
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656639621; x=1688175621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jX7xPGDwDi41D8pnYzuWwHrBHEssl5bRQJ4eFbIFPmY=;
  b=j/0UNqfCBq9T7q98heiODEFobnNmx6hlg6iTO3oxFnXgooRuiicFEUxN
   XnlhZsaycg9/I8qVhem/Z022WqVujRl4F9+ujScFxXJ2x7icxmab/hn0e
   hu3S5eomkvnJWnbZ7h1F4yNdCWxABgXDRpjApeTsFfsXXuoMtrPbx9RdB
   ZZYdNXHH8cjgsqqE6N1EFDbhAhrK5Kpg0p+f9TKrunXWthXb4rowPf+zI
   4o562CQDj3eZ2VcTWjLlly+/5tswCs1+XTMbIGAXXO7iNoyG0iSPpUU8T
   hrDt72MjqKGZvoRdkpY4Rts0GYWPxfpj9/j7lIWKMgJiGwtFXM03bEqjS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262921915"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262921915"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 18:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="837843154"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 18:40:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o75dq-000DOM-R2;
        Fri, 01 Jul 2022 01:40:18 +0000
Date:   Fri, 1 Jul 2022 09:39:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-next 301/310]
 sound/soc/codecs/wsa883x.c:1207:3: warning: unannotated fall-through between
 switch labels
Message-ID: <202207010956.ILHXPPwl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   fc86afe3634e75cf3b5abe053a3404e344f679b3
commit: cdb09e6231433b65e31c40fbe298099db6513a7f [301/310] ASoC: codecs: wsa883x: add control, dapm widgets and map
config: arm-randconfig-r024-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010956.ILHXPPwl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/cdb09e6231433b65e31c40fbe298099db6513a7f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout cdb09e6231433b65e31c40fbe298099db6513a7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/wsa883x.c:1207:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   sound/soc/codecs/wsa883x.c:1207:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   1 warning generated.


vim +1207 sound/soc/codecs/wsa883x.c

  1178	
  1179	static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
  1180				      struct snd_kcontrol *kcontrol, int event)
  1181	{
  1182		struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
  1183		struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
  1184	
  1185		switch (event) {
  1186		case SND_SOC_DAPM_POST_PMU:
  1187			switch (wsa883x->dev_mode) {
  1188			case RECEIVER:
  1189				snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
  1190							      WSA883X_RXD_MODE_MASK,
  1191							      WSA883X_RXD_MODE_HIFI);
  1192				snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
  1193							      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
  1194							      WSA883X_SPKR_PWM_FREQ_F600KHZ);
  1195				snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
  1196							       WSA883X_DRE_PROG_DELAY_MASK, 0x0);
  1197				break;
  1198			case SPEAKER:
  1199				snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
  1200							      WSA883X_RXD_MODE_MASK,
  1201							      WSA883X_RXD_MODE_NORMAL);
  1202				snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
  1203							      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
  1204							      WSA883X_SPKR_PWM_FREQ_F300KHZ);
  1205				snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
  1206							       WSA883X_DRE_PROG_DELAY_MASK, 0x9);
> 1207			default:
  1208				break;
  1209			}
  1210	
  1211			snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
  1212						      WSA883X_DRE_GAIN_EN_MASK,
  1213						      WSA883X_DRE_GAIN_FROM_CSR);
  1214			if (wsa883x->port_enable[WSA883X_PORT_COMP])
  1215				snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
  1216							      WSA883X_DRE_OFFSET_MASK,
  1217							      wsa883x->comp_offset);
  1218			snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
  1219						      WSA883X_VBAT_ADC_COEF_SEL_MASK,
  1220						      WSA883X_VBAT_ADC_COEF_F_1DIV16);
  1221			snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
  1222						      WSA883X_VBAT_ADC_FLT_EN_MASK, 0x1);
  1223			snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
  1224						      WSA883X_PDM_EN_MASK,
  1225						      WSA883X_PDM_ENABLE);
  1226			snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
  1227						      WSA883X_GLOBAL_PA_EN_MASK,
  1228						      WSA883X_GLOBAL_PA_ENABLE);
  1229	
  1230			break;
  1231		case SND_SOC_DAPM_PRE_PMD:
  1232			snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
  1233						      WSA883X_VBAT_ADC_FLT_EN_MASK, 0x0);
  1234			snd_soc_component_write_field(component, WSA883X_VBAT_ADC_FLT_CTL,
  1235						      WSA883X_VBAT_ADC_COEF_SEL_MASK,
  1236						      WSA883X_VBAT_ADC_COEF_F_1DIV2);
  1237			snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
  1238						      WSA883X_GLOBAL_PA_EN_MASK, 0);
  1239			snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
  1240						      WSA883X_PDM_EN_MASK, 0);
  1241			break;
  1242		}
  1243		return 0;
  1244	}
  1245	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

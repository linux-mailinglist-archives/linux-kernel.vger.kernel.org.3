Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84B4D53A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiCJVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbiCJVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:32:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AEA192E2C;
        Thu, 10 Mar 2022 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646947873; x=1678483873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RGNlWOxbgI16WpvZrVCQjPfVySv652dMFOKfh08ofHM=;
  b=Puec7REf5ewZEpetYErCYepIwnTEmHctJvmy3aZVGsXPjSK0sLzNizrf
   KFzr2RBMyNznoFUU5rjHxLNr69mKFHooeQto45hO+orDzodD8HwUZ1PFx
   MWohPaan8UVWIFLijMbKRjszNp0ZD3rpl8vScnm6U228OnEakdlCBeoSA
   +kHCDJ8rGDjQXa9Eey1N6URRHpEMJp9GSiLqubHWTlhDiS0wUjvbvUe4Z
   S5gTZLXh4YsFZDFDw7WvEsLvBAZ3v8HWujUnsQ31WvrdBZ+I+Zg8TY+Fd
   Q8UWsEQSmp00juKjI4+l5G3jpycxFsS4sipYidrsRUy5VuUEq/sKeMgiZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254212620"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254212620"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:31:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554856683"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 13:31:08 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSQNC-0005Q5-Ql; Thu, 10 Mar 2022 21:31:02 +0000
Date:   Fri, 11 Mar 2022 05:30:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, tzungbi@google.com,
        linmq006@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v2 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <202203110529.Y6LSPpwn-lkp@intel.com>
References: <20220310153707.29722-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310153707.29722-3-jiaxin.yu@mediatek.com>
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

Hi Jiaxin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on next-20220310]
[cannot apply to broonie-spi/for-next robh/for-next v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiaxin-Yu/ASoC-mediatek-mt8192-support-rt1015p_rt5682s/20220310-233935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220311/202203110529.Y6LSPpwn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/0342dabf16890d0fa839ccbedcb3fee8936cd749
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiaxin-Yu/ASoC-mediatek-mt8192-support-rt1015p_rt5682s/20220310-233935
        git checkout 0342dabf16890d0fa839ccbedcb3fee8936cd749
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/mediatek/mt8192/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:1170:21: warning: data argument not used by format string [-Wformat-extra-args]
                                         __func__, dai_link->name);
                                                   ^
   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:1177:21: warning: data argument not used by format string [-Wformat-extra-args]
                                         __func__, dai_link->name);
                                                   ^
   2 warnings generated.


vim +1170 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c

  1115	
  1116	static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
  1117	{
  1118		struct snd_soc_card *card;
  1119		struct device_node *platform_node, *hdmi_codec, *headset_codec, *speaker_codec;
  1120		int ret, i;
  1121		struct snd_soc_dai_link *dai_link;
  1122		struct mt8192_mt6359_priv *priv;
  1123		struct device *dev;
  1124	
  1125		card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
  1126		if (!card)
  1127			return -EINVAL;
  1128		card->dev = &pdev->dev;
  1129		dev = &pdev->dev;
  1130	
  1131		if (of_device_is_compatible(dev->of_node, RT1015P_RT5682_OF_NAME))
  1132			card->name = RT1015P_RT5682_CARD_NAME;
  1133		else if (of_device_is_compatible(dev->of_node, RT1015P_RT5682S_OF_NAME))
  1134			card->name = RT1015P_RT5682S_CARD_NAME;
  1135		else
  1136			dev_dbg(dev, "No need to set card name\n");
  1137	
  1138		platform_node = of_parse_phandle(dev->of_node, "mediatek,platform", 0);
  1139		if (!platform_node) {
  1140			ret = -EINVAL;
  1141			dev_err_probe(dev, ret, "Property 'platform' missing or invalid\n");
  1142			goto err_platform_node;
  1143		}
  1144	
  1145		hdmi_codec = of_parse_phandle(dev->of_node, "mediatek,hdmi-codec", 0);
  1146		if (!hdmi_codec) {
  1147			ret = -EINVAL;
  1148			dev_err_probe(dev, ret, "Property 'hdmi-codec' missing or invalid\n");
  1149			goto err_hdmi_codec;
  1150		}
  1151	
  1152		speaker_codec = of_get_child_by_name(dev->of_node, "mediatek,speaker-codec");
  1153		if (!speaker_codec) {
  1154			ret = -EINVAL;
  1155			dev_err_probe(dev, ret, "Property 'speaker_codec' missing or invalid\n");
  1156			goto err_speaker_codec;
  1157		}
  1158	
  1159		headset_codec = of_get_child_by_name(dev->of_node, "mediatek,headset-codec");
  1160		if (!headset_codec) {
  1161			ret = -EINVAL;
  1162			dev_err_probe(dev, ret, "Property 'headset_codec' missing or invalid\n");
  1163			goto err_headset_codec;
  1164		}
  1165	
  1166		for_each_card_prelinks(card, i, dai_link) {
  1167			ret = mt8192_mt6359_card_set_be_link(card, dai_link, speaker_codec, "I2S3");
  1168			if (ret) {
  1169				dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
> 1170					      __func__, dai_link->name);
  1171				goto err_probe;
  1172			}
  1173	
  1174			ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S8");
  1175			if (ret) {
  1176				dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
  1177					      __func__, dai_link->name);
  1178				goto err_probe;
  1179			}
  1180	
  1181			ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S9");
  1182			if (ret) {
  1183				dev_err_probe(&pdev->dev, ret, "%s set %s headset_codec fail\n",
  1184					      __func__, dai_link->name);
  1185				goto err_probe;
  1186			}
  1187	
  1188			if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0) {
  1189				dai_link->codecs->of_node = hdmi_codec;
  1190				dai_link->ignore = 0;
  1191			}
  1192	
  1193			if (strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
  1194				dai_link->ops = &mt8192_rt1015_i2s_ops;
  1195	
  1196			if (!dai_link->platforms->name)
  1197				dai_link->platforms->of_node = platform_node;
  1198		}
  1199	
  1200		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  1201		if (!priv) {
  1202			ret = -ENOMEM;
  1203			goto err_probe;
  1204		}
  1205		snd_soc_card_set_drvdata(card, priv);
  1206	
  1207		ret = mt8192_afe_gpio_init(&pdev->dev);
  1208		if (ret) {
  1209			dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
  1210			goto err_probe;
  1211		}
  1212	
  1213		ret = devm_snd_soc_register_card(&pdev->dev, card);
  1214		if (ret)
  1215			dev_err_probe(&pdev->dev, ret,
  1216				      "%s snd_soc_register_card fail\n", __func__);
  1217	
  1218	err_probe:
  1219		of_node_put(headset_codec);
  1220	err_headset_codec:
  1221		of_node_put(speaker_codec);
  1222	err_speaker_codec:
  1223		of_node_put(hdmi_codec);
  1224	err_hdmi_codec:
  1225		of_node_put(platform_node);
  1226	err_platform_node:
  1227	
  1228		return ret;
  1229	}
  1230	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

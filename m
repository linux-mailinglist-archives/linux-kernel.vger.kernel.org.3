Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184CC517267
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385730AbiEBPYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385769AbiEBPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:24:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6955B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651504833; x=1683040833;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+skAkhDg06hvLMrJWFmLdWZ0pxA6nwrAmG1HffehxzM=;
  b=TxaG3NhwKkzJ6Go/i53Q/OIe0UpvoY8iNRT0b3oRVE1xsZR8Sn5TxqKV
   rlfO+61rs9dtyQAhOBy+noP7i4kdMRZA4RUEAr1P/0Nvr1WIPgl3nRIB/
   DJh1pOdf1k6F3FxovI5OnkELqlul25s29GOp+yo16+xM7wT4rGiMfLbsZ
   w8JG7u2v7cmvGAJnGSCCrH2lnLNwrbwoZmXQifURe8YwOPq5oBETFk36Z
   AC+ZlHOYKK2RShuXVMrLpcPEniCR6iAkeBYxtZ95d7UvqtgclsPaI6GU2
   MtKDBUpdOf8n5HddgRHs3ZngNA9EO0bnA0jbiKvUUOBLMpxxPlymOGgTG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247146167"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="247146167"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 08:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="516144562"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 08:20:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlXqg-0009dr-LS;
        Mon, 02 May 2022 15:20:30 +0000
Date:   Mon, 2 May 2022 23:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 15/20] sound/soc/codecs/tas2764.c:683:20:
 warning: cast to smaller integer type 'enum tas2764_devid' from 'const void
 *'
Message-ID: <202205022313.dZqidUBY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   91b81123719d8b742da188f01ee3d897e0fac92b
commit: 29756799398dae179e17370b2e5d2a397b683440 [15/20] ASoC: tas2764: Extend driver to SN012776
config: arm64-randconfig-r005-20220501 (https://download.01.org/0day-ci/archive/20220502/202205022313.dZqidUBY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/29756799398dae179e17370b2e5d2a397b683440
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 29756799398dae179e17370b2e5d2a397b683440
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2764.c:683:20: warning: cast to smaller integer type 'enum tas2764_devid' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   tas2764->devid = (enum tas2764_devid) of_id->data;
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +683 sound/soc/codecs/tas2764.c

   666	
   667	static int tas2764_i2c_probe(struct i2c_client *client,
   668				const struct i2c_device_id *id)
   669	{
   670		struct tas2764_priv *tas2764;
   671		const struct of_device_id *of_id = NULL;
   672		int result;
   673	
   674		tas2764 = devm_kzalloc(&client->dev, sizeof(struct tas2764_priv),
   675				       GFP_KERNEL);
   676		if (!tas2764)
   677			return -ENOMEM;
   678	
   679		if (client->dev.of_node)
   680			of_id = of_match_device(tas2764_of_match, &client->dev);	
   681	
   682		if (of_id)
 > 683			tas2764->devid = (enum tas2764_devid) of_id->data;
   684		else
   685			tas2764->devid = DEVID_TAS2764;
   686	
   687		tas2764->dev = &client->dev;
   688		i2c_set_clientdata(client, tas2764);
   689		dev_set_drvdata(&client->dev, tas2764);
   690	
   691		tas2764->regmap = devm_regmap_init_i2c(client, &tas2764_i2c_regmap);
   692		if (IS_ERR(tas2764->regmap)) {
   693			result = PTR_ERR(tas2764->regmap);
   694			dev_err(&client->dev, "Failed to allocate register map: %d\n",
   695						result);
   696			return result;
   697		}
   698	
   699		if (client->dev.of_node) {
   700			result = tas2764_parse_dt(&client->dev, tas2764);
   701			if (result) {
   702				dev_err(tas2764->dev, "%s: Failed to parse devicetree\n",
   703					__func__);
   704				return result;
   705			}
   706		}
   707	
   708		return devm_snd_soc_register_component(tas2764->dev,
   709						       &soc_component_driver_tas2764,
   710						       tas2764_dai_driver,
   711						       ARRAY_SIZE(tas2764_dai_driver));
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

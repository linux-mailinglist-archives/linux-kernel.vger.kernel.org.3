Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF459598E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiHPLK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiHPLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:10:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0218E1F60C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660639192; x=1692175192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=haZJJ6qIsp18u5JMSxLBwZ3xo8DIn7m1qKopIr+1Xfg=;
  b=OK1hXaQncULTuYAnDR9zKW5Q4r5ylVMlZC6PCFy+l0VptTqLDdeo5xuT
   TAPlh76221rPFoDZl8si7DJLjYxkKQxq0LP+IUNs9QHF+6mkf8EjnKCDZ
   EW2ru12vddDJFzRF2z2IXxTTkO55J2nXXLhPU6G8RegMxQnvy0/m/Rzqr
   O0wv2fV15qgycSKSJkURu1AhyBqUgaDX3IO7eUeHzQfKrLB44ucWXdB41
   3WN0YeAJqezHIX5kUaeVF2KlS7vMlwkEHoVsVvYGhOxgAYgWhj5psEV+/
   KEl9uCwy2OWXyAl4ps/iYneIzMLJjTx12cGWpEhGdy5XSftDbbJslGFWp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289733824"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="289733824"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="610189582"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2022 01:39:51 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNs74-0001e1-2d;
        Tue, 16 Aug 2022 08:39:50 +0000
Date:   Tue, 16 Aug 2022 16:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 4/16] sound/soc/codecs/tas2764.c:681:20:
 warning: cast to smaller integer type 'enum tas2764_devid' from 'const void
 *'
Message-ID: <202208161624.BKESkCXj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   51024ef467ff6c288e679bc72d0e3fcdd54d9b39
commit: e8c4eabb2252a8ee21269737e90c57973ab36269 [4/16] ASoC: tas2764: Extend driver to SN012776
config: arm64-randconfig-r022-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161624.BKESkCXj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/AsahiLinux/linux/commit/e8c4eabb2252a8ee21269737e90c57973ab36269
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout e8c4eabb2252a8ee21269737e90c57973ab36269
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2764.c:681:20: warning: cast to smaller integer type 'enum tas2764_devid' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   tas2764->devid = (enum tas2764_devid) of_id->data;
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +681 sound/soc/codecs/tas2764.c

   665	
   666	static int tas2764_i2c_probe(struct i2c_client *client)
   667	{
   668		struct tas2764_priv *tas2764;
   669		const struct of_device_id *of_id = NULL;
   670		int result;
   671	
   672		tas2764 = devm_kzalloc(&client->dev, sizeof(struct tas2764_priv),
   673				       GFP_KERNEL);
   674		if (!tas2764)
   675			return -ENOMEM;
   676	
   677		if (client->dev.of_node)
   678			of_id = of_match_device(tas2764_of_match, &client->dev);	
   679	
   680		if (of_id)
 > 681			tas2764->devid = (enum tas2764_devid) of_id->data;
   682		else
   683			tas2764->devid = DEVID_TAS2764;
   684	
   685		tas2764->dev = &client->dev;
   686		i2c_set_clientdata(client, tas2764);
   687		dev_set_drvdata(&client->dev, tas2764);
   688	
   689		tas2764->regmap = devm_regmap_init_i2c(client, &tas2764_i2c_regmap);
   690		if (IS_ERR(tas2764->regmap)) {
   691			result = PTR_ERR(tas2764->regmap);
   692			dev_err(&client->dev, "Failed to allocate register map: %d\n",
   693						result);
   694			return result;
   695		}
   696	
   697		if (client->dev.of_node) {
   698			result = tas2764_parse_dt(&client->dev, tas2764);
   699			if (result) {
   700				dev_err(tas2764->dev, "%s: Failed to parse devicetree\n",
   701					__func__);
   702				return result;
   703			}
   704		}
   705	
   706		return devm_snd_soc_register_component(tas2764->dev,
   707						       &soc_component_driver_tas2764,
   708						       tas2764_dai_driver,
   709						       ARRAY_SIZE(tas2764_dai_driver));
   710	}
   711	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

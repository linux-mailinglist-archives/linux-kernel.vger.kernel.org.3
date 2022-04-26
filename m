Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C036E50F195
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbiDZHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiDZHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:01:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66C5E75C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650956330; x=1682492330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5MCxt4YaDTywAcdqc4CDGtzAybUBOnEglVaY8ogqPRc=;
  b=XNq914r/PwpbJkWGJBtheXwJxPzC35bo7d2lVD0jgLsU7sOiCn7G26OZ
   jGR3Mat0UjGldhwYvX2+v3cQQPgO6rD0u8lKIlu/r7xi5rVZPen+lYBZg
   WGJk3dmLt4zRCoRg/M4bi1nYRnm6hxkctvr2iSUHCuvT9S5cnkq/NGbM/
   5y+jVNIS6rpDdrO+KxPB1MW63zK2c2/ID0Dsld2P1E1z8atISZBzNPQ00
   KryulIc4iR8oY80NL0pTOgdW7hVJeeg9lP4Rh44P5U2sfbfQv/d/k2XzL
   s58478UnKn/gM4wgnmjQK7RmSAHtiQV+Hv0DG2iEPqiZLjeIrrwVG0vt2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265281567"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265281567"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="564440338"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Apr 2022 23:58:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njF9r-0003J9-QB;
        Tue, 26 Apr 2022 06:58:47 +0000
Date:   Tue, 26 Apr 2022 14:58:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/22 154/189] sound/soc/codecs/tas2764.c:683:20:
 warning: cast to smaller integer type 'enum tas2764_devid' from 'const void
 *'
Message-ID: <202204261404.u4PHBAns-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: cb66939651e8850d34306205ef68cc749355bfa0 [154/189] ASoC: tas2764: Extend driver to SN012776
config: x86_64-randconfig-a003-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261404.u4PHBAns-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/cb66939651e8850d34306205ef68cc749355bfa0
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout cb66939651e8850d34306205ef68cc749355bfa0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/codecs/

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

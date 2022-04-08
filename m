Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB994F9042
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiDHIDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiDHICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:02:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B661689CB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649404815; x=1680940815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KvL9M/Aobbu4WDZHRar3IKI+VVs7fNAYzCpS0bvdhfQ=;
  b=LfeBXyb9dZVYXenZIBS6bzzDQozZiyxK9qnXZq5IONycRaqkfmQwWyho
   dCEaLnl/lLKVhb5AnqtWy4ovUH+0qVfMmWA6vatvahwIqCakXTJfOsECd
   YZ4xIDyG6FZG5OtWMtq7fcdrupUEJq1XcWxYJ2DOuk9ziJfNSPBYhTJWf
   PjqB9gLUag7gYUnkE/UTNnsjFJgQuPMQL3XO4wH0JNcEHVSDiU791KUTT
   qiQGcCid7NbQfQgftRslPsCkknc+88W7HLJVxPofif8njrmjq9TyK09pD
   3RT6ujUdiY15zB/xcyF77fE6IkIu+AHdq3pxXpLkkDHIxWDkRnA+rb/IN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241473207"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="241473207"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 01:00:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="642807624"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 01:00:08 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncjXL-00001l-An;
        Fri, 08 Apr 2022 08:00:07 +0000
Date:   Fri, 8 Apr 2022 15:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Meier <florian.meier@koalo.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        DigitalDreamtime <clive.messer@digitaldreamtime.co.uk>,
        Matthias Reichl <hias@horus.com>,
        Daniel Matuschek <daniel@hifiberry.com>,
        Hui Wang <hui.wang@canonical.com>,
        Waldemar Brodkorb <wbrodkorb@conet.de>,
        Baswaraj K <jaikumar@cem-solutions.net>,
        "Vijay Kumar B." <vijaykumar@zilogic.com>,
        Raashid Muhammed <raashidmuhammed@zilogic.com>,
        allocom <sparky-dev@allo.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Deepak <deepak@zilogic.com>,
        BabuSubashChandar <babusubashchandar@zilogic.com>,
        Giedrius Trainavicius <giedrius@blokas.io>,
        Miquel Blauw <info@dionaudio.nl>, Henry Kupis <fe-pi@cox.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jaikumar <jaikumar@cem-solutions.com>,
        Sudeep Kumar <sudeepkumar@cem-solutions.net>,
        Tim Gover <tim.gover@raspberrypi.org>,
        b-ak <anur.bhargav@gmail.com>,
        Audiophonics <contact@audiophonics.fr>,
        Gordon <gordon@iqaudio.com>, JoergSchambacherjoerg@i2audio.com,
        Johannes Krude <johannes@krude.de>,
        Matt Flax <flatmax@flatmax.org>,
        AMuszkat <ariel.muszkat@gmail.com>,
        Paul Hermann <paul@picoreplayer.org>
Subject: [l1k:smsc95xx_5.17 77/887] drivers/clk/clk-allo-dac.c:39: warning:
 expecting prototype for struct allo_dac_clk. Prototype was for struct
 clk_allo_hw instead
Message-ID: <202204081509.Ka45tMQ4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 4229d24ff83b7ba2f2ffd9b0dfbd9216ed69496e [77/887] Add support for all the downstream rpi sound card drivers
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220408/202204081509.Ka45tMQ4-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/4229d24ff83b7ba2f2ffd9b0dfbd9216ed69496e
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 4229d24ff83b7ba2f2ffd9b0dfbd9216ed69496e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/broadcom/ drivers/clk/ drivers/gpio/ drivers/gpu/drm/vc4/ drivers/media/platform/rockchip/rkisp1/ drivers/staging/vc04_services/ sound/soc/bcm/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-allo-dac.c:39: warning: expecting prototype for struct allo_dac_clk. Prototype was for struct clk_allo_hw instead
--
>> drivers/clk/clk-hifiberry-dacpro.c:38: warning: expecting prototype for struct hifiberry_dacpro_clk. Prototype was for struct clk_hifiberry_hw instead
--
   sound/soc/bcm/allo-boss2-dac.c: In function 'cs43130_pcm_pdn':
>> sound/soc/bcm/allo-boss2-dac.c:261:27: warning: variable 'pdn_int' set but not used [-Wunused-but-set-variable]
     261 |         unsigned int reg, pdn_int;
         |                           ^~~~~~~
>> sound/soc/bcm/allo-boss2-dac.c:260:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     260 |         int ret;
         |             ^~~
   sound/soc/bcm/allo-boss2-dac.c: In function 'cs43130_hw_params':
   sound/soc/bcm/allo-boss2-dac.c:665:36: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     665 |         unsigned int required_clk, ret;
         |                                    ^~~
>> sound/soc/bcm/allo-boss2-dac.c:665:22: warning: variable 'required_clk' set but not used [-Wunused-but-set-variable]
     665 |         unsigned int required_clk, ret;
         |                      ^~~~~~~~~~~~
   sound/soc/bcm/allo-boss2-dac.c: At top level:
   sound/soc/bcm/allo-boss2-dac.c:955:35: warning: initialized field overwritten [-Woverride-init]
     955 |         .idle_bias_on           = 1,
         |                                   ^
   sound/soc/bcm/allo-boss2-dac.c:955:35: note: (near initialization for 'cs43130_component_driver.idle_bias_on')
   In file included from sound/soc/bcm/allo-boss2-dac.c:46:
   sound/soc/bcm/../codecs/cs43130.h:485:26: warning: 'cs43130_supply_names' defined but not used [-Wunused-const-variable=]
     485 | static const char *const cs43130_supply_names[CS43130_NUM_SUPPLIES] = {
         |                          ^~~~~~~~~~~~~~~~~~~~
--
>> sound/soc/bcm/allo-katana-codec.c:249:5: warning: no previous prototype for 'katana_codec_dai_mute_stream' [-Wmissing-prototypes]
     249 | int katana_codec_dai_mute_stream(struct snd_soc_dai *dai, int mute,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   sound/soc/bcm/pifi-40.c: In function 'snd_pifi_40_hw_params':
>> sound/soc/bcm/pifi-40.c:143:22: warning: variable 'sample_bits' set but not used [-Wunused-but-set-variable]
     143 |         unsigned int sample_bits;
         |                      ^~~~~~~~~~~
--
   sound/soc/codecs/tas5713.c: In function 'tas5713_remove':
>> sound/soc/codecs/tas5713.c:165:30: warning: variable 'tas5713' set but not used [-Wunused-but-set-variable]
     165 |         struct tas5713_priv *tas5713;
         |                              ^~~~~~~
   sound/soc/codecs/tas5713.c: In function 'tas5713_probe':
   sound/soc/codecs/tas5713.c:173:30: warning: variable 'tas5713' set but not used [-Wunused-but-set-variable]
     173 |         struct tas5713_priv *tas5713;
         |                              ^~~~~~~
--
   sound/soc/codecs/ma120x0p.c: In function 'ma120x0p_mute_stream':
>> sound/soc/codecs/ma120x0p.c:976:31: warning: variable 'ma120x0p' set but not used [-Wunused-but-set-variable]
     976 |         struct ma120x0p_priv *ma120x0p;
         |                               ^~~~~~~~
   sound/soc/codecs/ma120x0p.c: In function 'ma120x0p_clear_err':
   sound/soc/codecs/ma120x0p.c:1016:31: warning: variable 'ma120x0p' set but not used [-Wunused-but-set-variable]
    1016 |         struct ma120x0p_priv *ma120x0p;
         |                               ^~~~~~~~
   sound/soc/codecs/ma120x0p.c: In function 'ma120x0p_remove':
   sound/soc/codecs/ma120x0p.c:1040:31: warning: variable 'ma120x0p' set but not used [-Wunused-but-set-variable]
    1040 |         struct ma120x0p_priv *ma120x0p;
         |                               ^~~~~~~~
   sound/soc/codecs/ma120x0p.c: In function 'ma120x0p_probe':
   sound/soc/codecs/ma120x0p.c:1047:31: warning: variable 'ma120x0p' set but not used [-Wunused-but-set-variable]
    1047 |         struct ma120x0p_priv *ma120x0p;
         |                               ^~~~~~~~
   sound/soc/codecs/ma120x0p.c: In function 'ma120x0p_set_bias_level':
   sound/soc/codecs/ma120x0p.c:1133:31: warning: variable 'ma120x0p' set but not used [-Wunused-but-set-variable]
    1133 |         struct ma120x0p_priv *ma120x0p;
         |                               ^~~~~~~~


vim +39 drivers/clk/clk-allo-dac.c

    30	
    31	/**
    32	 * struct allo_dac_clk - Common struct to the Allo DAC
    33	 * @hw: clk_hw for the common clk framework
    34	 * @mode: 0 => CLK44EN, 1 => CLK48EN
    35	 */
    36	struct clk_allo_hw {
    37		struct clk_hw hw;
    38		uint8_t mode;
  > 39	};
    40	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6865228F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiEKBan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiEKBaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:30:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5CC246D9A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652232634; x=1683768634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UW71ROxh/GRIENA4xUhIZy4ExcjISc8wvAjEj5jPNTE=;
  b=GLI8qlvoOtHaArf7qA98vUc53Ifvbn0DsF070pQPg9rQfsFjWYw/q5Vp
   SYn2uxztk6xvM2rq5pcpojBvCHjZob+2SfgTt6zhDXO8jroc4fzmMat3c
   GQ5f//7GZMU9W7/6BLWeWSjP4BTfiheldiZ9tlKVXL7Vm8Dht2Xaup0ZD
   O+XbntprSEecaxdJpAIky3FKqzPtIy9v8yuuBCDKMvT7WRT32W899v9aY
   RYZ78klcEALWuneX97WCOW5j3pUiA2pUuh4VXPRXHg8l6EvqNQt0D57gF
   odFDpesof2aTnYV1qh1jGSqBPyBgjhUgF1SRJitE9JTQfqe6RgyeafHLr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267140088"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="267140088"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 18:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="738988213"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2022 18:30:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nobBN-000IZB-CU;
        Wed, 11 May 2022 01:30:29 +0000
Date:   Wed, 11 May 2022 09:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 1/3] ALSA: hda/cs8409: Support new Odin Variants
Message-ID: <202205110948.6wfXVVvs-lkp@intel.com>
References: <20220510161701.851260-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510161701.851260-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on v5.18-rc6 next-20220510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/ALSA-hda-cs8409-Add-support-for-Odin-Laptop-Variants/20220511-001936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: i386-randconfig-c001-20220509 (https://download.01.org/0day-ci/archive/20220511/202205110948.6wfXVVvs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e834cdf9c71c45212904ba82b5b7e49d45810deb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/ALSA-hda-cs8409-Add-support-for-Odin-Laptop-Variants/20220511-001936
        git checkout e834cdf9c71c45212904ba82b5b7e49d45810deb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/pci/hda/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/pci/hda/patch_cs8409.c:1033:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   sound/pci/hda/patch_cs8409.c:1033:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +1033 sound/pci/hda/patch_cs8409.c

8c70461bbb83cf Lucas Tanure   2021-08-11   996  
8c70461bbb83cf Lucas Tanure   2021-08-11   997  /* Vendor specific HW configuration
8c70461bbb83cf Lucas Tanure   2021-08-11   998   * PLL, ASP, I2C, SPI, GPIOs, DMIC etc...
8c70461bbb83cf Lucas Tanure   2021-08-11   999   */
8c70461bbb83cf Lucas Tanure   2021-08-11  1000  static void cs8409_cs42l42_hw_init(struct hda_codec *codec)
8c70461bbb83cf Lucas Tanure   2021-08-11  1001  {
8c70461bbb83cf Lucas Tanure   2021-08-11  1002  	const struct cs8409_cir_param *seq = cs8409_cs42l42_hw_cfg;
8c70461bbb83cf Lucas Tanure   2021-08-11  1003  	const struct cs8409_cir_param *seq_bullseye = cs8409_cs42l42_bullseye_atn;
8c70461bbb83cf Lucas Tanure   2021-08-11  1004  	struct cs8409_spec *spec = codec->spec;
24f7ac3d3b6b70 Lucas Tanure   2021-08-11  1005  	struct sub_codec *cs42l42 = spec->scodecs[CS8409_CODEC0];
8c70461bbb83cf Lucas Tanure   2021-08-11  1006  
8c70461bbb83cf Lucas Tanure   2021-08-11  1007  	if (spec->gpio_mask) {
ccff0064a7ce8e Stefan Binding 2021-08-11  1008  		snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_MASK,
ccff0064a7ce8e Stefan Binding 2021-08-11  1009  			spec->gpio_mask);
ccff0064a7ce8e Stefan Binding 2021-08-11  1010  		snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DIRECTION,
ccff0064a7ce8e Stefan Binding 2021-08-11  1011  			spec->gpio_dir);
ccff0064a7ce8e Stefan Binding 2021-08-11  1012  		snd_hda_codec_write(codec, CS8409_PIN_AFG, 0, AC_VERB_SET_GPIO_DATA,
ccff0064a7ce8e Stefan Binding 2021-08-11  1013  			spec->gpio_data);
8c70461bbb83cf Lucas Tanure   2021-08-11  1014  	}
8c70461bbb83cf Lucas Tanure   2021-08-11  1015  
8c70461bbb83cf Lucas Tanure   2021-08-11  1016  	for (; seq->nid; seq++)
8c70461bbb83cf Lucas Tanure   2021-08-11  1017  		cs8409_vendor_coef_set(codec, seq->cir, seq->coeff);
8c70461bbb83cf Lucas Tanure   2021-08-11  1018  
24f7ac3d3b6b70 Lucas Tanure   2021-08-11  1019  	if (codec->fixup_id == CS8409_BULLSEYE) {
8c70461bbb83cf Lucas Tanure   2021-08-11  1020  		for (; seq_bullseye->nid; seq_bullseye++)
8c70461bbb83cf Lucas Tanure   2021-08-11  1021  			cs8409_vendor_coef_set(codec, seq_bullseye->cir, seq_bullseye->coeff);
24f7ac3d3b6b70 Lucas Tanure   2021-08-11  1022  	}
8c70461bbb83cf Lucas Tanure   2021-08-11  1023  
6581a045d54c6a Stefan Binding 2022-03-28  1024  	switch (codec->fixup_id) {
6581a045d54c6a Stefan Binding 2022-03-28  1025  	case CS8409_CYBORG:
6581a045d54c6a Stefan Binding 2022-03-28  1026  	case CS8409_WARLOCK_MLK_DUAL_MIC:
8c70461bbb83cf Lucas Tanure   2021-08-11  1027  		/* DMIC1_MO=00b, DMIC1/2_SR=1 */
8a7724535bacbb Stefan Binding 2022-03-28  1028  		cs8409_vendor_coef_set(codec, CS8409_DMIC_CFG, 0x0003);
6581a045d54c6a Stefan Binding 2022-03-28  1029  		break;
e834cdf9c71c45 Stefan Binding 2022-05-10  1030  	case CS8409_ODIN:
e834cdf9c71c45 Stefan Binding 2022-05-10  1031  		/* ASP1/2_xxx_EN=1, ASP1/2_MCLK_EN=0, DMIC1_SCL_EN=0 */
e834cdf9c71c45 Stefan Binding 2022-05-10  1032  		cs8409_vendor_coef_set(codec, CS8409_PAD_CFG_SLW_RATE_CTRL, 0xfc00);
6581a045d54c6a Stefan Binding 2022-03-28 @1033  	default:
6581a045d54c6a Stefan Binding 2022-03-28  1034  		break;
6581a045d54c6a Stefan Binding 2022-03-28  1035  	}
8c70461bbb83cf Lucas Tanure   2021-08-11  1036  
24f7ac3d3b6b70 Lucas Tanure   2021-08-11  1037  	cs42l42_resume(cs42l42);
8c70461bbb83cf Lucas Tanure   2021-08-11  1038  
8c70461bbb83cf Lucas Tanure   2021-08-11  1039  	/* Enable Unsolicited Response */
8c70461bbb83cf Lucas Tanure   2021-08-11  1040  	cs8409_enable_ur(codec, 1);
8c70461bbb83cf Lucas Tanure   2021-08-11  1041  }
8c70461bbb83cf Lucas Tanure   2021-08-11  1042  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FA51B3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382082AbiEDXr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381194AbiEDXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:16:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E395419E;
        Wed,  4 May 2022 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651705772; x=1683241772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=viWWezEGudsdbLy/fRq7EwiMWwIaZsmyJG8Q+HHJWzE=;
  b=hMH9DmkEI3OmceNvFXU5LlSEeHnpbp43jUjfXniTp0BbO5FVjmxbxdJK
   FU2EPHFhq6raFbSPfVdwVF4CCBRP933vVOqD/Fkia5WEP+sJc8XjaFzxq
   UMluuI5sEcCoUiP7BxKP11gkFyBhNgrhgRPxeae9RjImbdlYCmzFPzQ6A
   KbOkpwY9L/PrXoCQedorAkHk9lt88B3RT+KJw4Dd3w6B0xR3IAq/acYUX
   8V2rvR0wny2GxaYX2CjrzXuqyKICzDBQPV7UsYwlJdnAM09oN+LyjhIf6
   fHZ++5f5b0+Pea+mm8To1FgmEqDFnWW8gnqFgDCLZZg7JC5ITBsthdStQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="293121901"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="293121901"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="599749810"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2022 16:09:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmO7Q-000Bsd-1h;
        Wed, 04 May 2022 23:09:16 +0000
Date:   Thu, 5 May 2022 07:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Chen <justinpopo6@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     kbuild-all@lists.01.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: Re: [PATCH 1/2] gpio: pca953xx: Add support for pca6408
Message-ID: <202205050612.1bwSZpER-lkp@intel.com>
References: <1651685100-44687-2-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651685100-44687-2-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.18-rc5]
[also build test ERROR on next-20220504]
[cannot apply to linusw-gpio/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Chen/Add-support-for-NXP-PCA6408/20220505-020844
base:    672c0c5173427e6b3e2a9bbb7be51ceeec78093a
config: microblaze-randconfig-r031-20220501 (https://download.01.org/0day-ci/archive/20220505/202205050612.1bwSZpER-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d45d7c84e1613b51cb1eb90ef6d92f4112a45925
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Justin-Chen/Add-support-for-NXP-PCA6408/20220505-020844
        git checkout d45d7c84e1613b51cb1eb90ef6d92f4112a45925
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpio/gpio-pca953x.c:74:27: error: 'PCA953x_TYPE' undeclared here (not in a function); did you mean 'PCA953X_TYPE'?
      74 |         { "pca6408", 8  | PCA953x_TYPE | PCA_INT, },
         |                           ^~~~~~~~~~~~
         |                           PCA953X_TYPE


vim +74 drivers/gpio/gpio-pca953x.c

    72	
    73	static const struct i2c_device_id pca953x_id[] = {
  > 74		{ "pca6408", 8  | PCA953x_TYPE | PCA_INT, },
    75		{ "pca6416", 16 | PCA953X_TYPE | PCA_INT, },
    76		{ "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
    77		{ "pca9506", 40 | PCA953X_TYPE | PCA_INT, },
    78		{ "pca9534", 8  | PCA953X_TYPE | PCA_INT, },
    79		{ "pca9535", 16 | PCA953X_TYPE | PCA_INT, },
    80		{ "pca9536", 4  | PCA953X_TYPE, },
    81		{ "pca9537", 4  | PCA953X_TYPE | PCA_INT, },
    82		{ "pca9538", 8  | PCA953X_TYPE | PCA_INT, },
    83		{ "pca9539", 16 | PCA953X_TYPE | PCA_INT, },
    84		{ "pca9554", 8  | PCA953X_TYPE | PCA_INT, },
    85		{ "pca9555", 16 | PCA953X_TYPE | PCA_INT, },
    86		{ "pca9556", 8  | PCA953X_TYPE, },
    87		{ "pca9557", 8  | PCA953X_TYPE, },
    88		{ "pca9574", 8  | PCA957X_TYPE | PCA_INT, },
    89		{ "pca9575", 16 | PCA957X_TYPE | PCA_INT, },
    90		{ "pca9698", 40 | PCA953X_TYPE, },
    91	
    92		{ "pcal6416", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
    93		{ "pcal6524", 24 | PCA953X_TYPE | PCA_LATCH_INT, },
    94		{ "pcal9535", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
    95		{ "pcal9554b", 8  | PCA953X_TYPE | PCA_LATCH_INT, },
    96		{ "pcal9555a", 16 | PCA953X_TYPE | PCA_LATCH_INT, },
    97	
    98		{ "max7310", 8  | PCA953X_TYPE, },
    99		{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
   100		{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
   101		{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
   102		{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
   103		{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
   104		{ "tca6408", 8  | PCA953X_TYPE | PCA_INT, },
   105		{ "tca6416", 16 | PCA953X_TYPE | PCA_INT, },
   106		{ "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
   107		{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
   108		{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
   109		{ "xra1202", 8  | PCA953X_TYPE },
   110		{ }
   111	};
   112	MODULE_DEVICE_TABLE(i2c, pca953x_id);
   113	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

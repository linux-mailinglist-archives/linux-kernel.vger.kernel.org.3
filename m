Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF19512938
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiD1CEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiD1CD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:03:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3160D92;
        Wed, 27 Apr 2022 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111242; x=1682647242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CO5cvb+z/yjB+nM8Ln/vy0hVuoUGRL4PMtaR135Sw/E=;
  b=GZghvFKnVnjDY+SIYN4UEGAecGqHGFzeauDkhy+vNK46HSBvHJ3zPrYd
   gI8J62cYaE4PnULr833mKrmiF1r6ixUhpmEtc2XIMvqBe6X0CYHP5pdYW
   yJVUe+1YXnwmYimXFuAVZpXyHWJ00PROMG3Q4RJMVXLHYHbvC/zF5dF1L
   jvEa9l9STe/ro4gs4BbWCWpoNQ9f46olZOqlU3LaYVXMIpe814PdDHdoN
   svLgKrjQyJgnUXpvwvOc2bE9aJjIzydMeKXcjsO35p1r1xGxVXUnTlltU
   CA3s2IQMxU9VWezMyAycE2MhOB5NiYsfjeaiwuJVJsYJ9RwJuR9B2zprl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263717029"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="263717029"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="580964147"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2022 19:00:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtSB-0004y1-PB;
        Thu, 28 Apr 2022 02:00:23 +0000
Date:   Thu, 28 Apr 2022 09:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rric@kernel.org, cchavva@marvell.com, wsadowski@marvell.com,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: Re: [PATCH 3/5] gpio: thunderx: Configure GPIO pins at probe
Message-ID: <202204280405.DMzMLx60-lkp@intel.com>
References: <20220427144620.9105-4-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427144620.9105-4-pmalgujar@marvell.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piyush,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on linusw-gpio/for-next linux/master v5.18-rc4 next-20220427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Piyush-Malgujar/gpio-thunderx-Marvell-GPIO-changes/20220427-225001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
config: alpha-randconfig-r005-20220427 (https://download.01.org/0day-ci/archive/20220428/202204280405.DMzMLx60-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/31a85ad65112e3ed61aa418772670eb96a881a4f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Piyush-Malgujar/gpio-thunderx-Marvell-GPIO-changes/20220427-225001
        git checkout 31a85ad65112e3ed61aa418772670eb96a881a4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-thunderx.c: In function 'thunderx_gpio_pinsel':
>> drivers/gpio/gpio-thunderx.c:448:23: error: implicit declaration of function 'of_read_number' [-Werror=implicit-function-declaration]
     448 |                 pin = of_read_number(pinsel++, 1);
         |                       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/of_read_number +448 drivers/gpio/gpio-thunderx.c

   428	
   429	static void thunderx_gpio_pinsel(struct device *dev,
   430					 struct thunderx_gpio *txgpio)
   431	{
   432		struct device_node *node;
   433		const __be32 *pinsel;
   434		int npins, rlen, i;
   435		u32 pin, sel;
   436	
   437		node = dev_of_node(dev);
   438		if (!node)
   439			return;
   440	
   441		pinsel = of_get_property(node, "pin-cfg", &rlen);
   442		if (!pinsel || rlen % 2)
   443			return;
   444	
   445		npins = rlen / sizeof(__be32) / 2;
   446	
   447		for (i = 0; i < npins; i++) {
 > 448			pin = of_read_number(pinsel++, 1);
   449			sel = of_read_number(pinsel++, 1);
   450			dev_dbg(dev, "Set GPIO pin %d CFG register to %x\n", pin, sel);
   451			writeq(sel, txgpio->register_base + bit_cfg_reg(pin));
   452		}
   453	}
   454	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

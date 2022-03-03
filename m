Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D784CBFCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiCCORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCCORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:17:44 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAFE18CC31;
        Thu,  3 Mar 2022 06:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646317019; x=1677853019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yN2G/1s3nnRhWNWBfpygstYHT/OoQNrY04dyYU6iFzI=;
  b=j4aLbsPxrfe2dsafGwICVLSD/0b26+YscArYa7x9FsVamQj4WQHN0xAG
   mTs8jdogXYBtLvyMzcVZuavrOAqItbsASlRpfYIKMp9PE2fcurX9FZven
   asYmxHl6j1aOXbyHyYpvPU1vwvAxX5auD1uSIW6Ijo8N4tUf47vPmY6C8
   LPk2tjM77wg+IJG4y9grKhvZEqNDKjxjjKOHK6ZPanOkoQEMTLI0bWp4T
   kyj1C/bhjdWQRxGrsFj2L35iJBtfU11akM43sirYoCHi6EpvgziOMBvC7
   g6/uJD9OrXL3do60fcZwDJGDbSrXcMQ5I2R6fWQpE+KABmRI+/9susWeS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233648377"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="233648377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 06:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="576499289"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 06:16:55 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPmGF-0000bs-39; Thu, 03 Mar 2022 14:16:55 +0000
Date:   Thu, 3 Mar 2022 22:16:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: Add Apple eFuse driver
Message-ID: <202203032219.gDn8cX7m-lkp@intel.com>
References: <20220227115743.69059-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227115743.69059-2-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

I love your patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v5.17-rc6]
[cannot apply to robh/for-next next-20220303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sven-Peter/dt-bindings-nvmem-Add-apple-efuses/20220227-195847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: ia64-randconfig-s031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203032219.gDn8cX7m-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e47f957c24fcbc9f99a972b1b7c802eec04ed40a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sven-Peter/dt-bindings-nvmem-Add-apple-efuses/20220227-195847
        git checkout e47f957c24fcbc9f99a972b1b7c802eec04ed40a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/nvmem/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvmem/apple-efuses.c:17:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *fuses @@     got void *context @@
   drivers/nvmem/apple-efuses.c:17:31: sparse:     expected void [noderef] __iomem *fuses
   drivers/nvmem/apple-efuses.c:17:31: sparse:     got void *context
>> drivers/nvmem/apple-efuses.c:42:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/nvmem/apple-efuses.c:42:21: sparse:     expected void *priv
   drivers/nvmem/apple-efuses.c:42:21: sparse:     got void [noderef] __iomem *
   drivers/nvmem/apple-efuses.c: note: in included file (through arch/ia64/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:267:16: sparse: sparse: cast to restricted __le32

vim +17 drivers/nvmem/apple-efuses.c

    13	
    14	static int apple_efuses_read(void *context, unsigned int offset, void *val,
    15				     size_t bytes)
    16	{
  > 17		void __iomem *fuses = context;
    18		u32 *dst = val;
    19	
    20		while (bytes >= sizeof(u32)) {
    21			*dst++ = readl_relaxed(fuses + offset);
    22			bytes -= sizeof(u32);
    23			offset += sizeof(u32);
    24		}
    25	
    26		return 0;
    27	}
    28	
    29	static int apple_efuses_probe(struct platform_device *pdev)
    30	{
    31		struct resource *res;
    32		struct nvmem_config config = {
    33			.dev = &pdev->dev,
    34			.read_only = true,
    35			.reg_read = apple_efuses_read,
    36			.stride = sizeof(u32),
    37			.word_size = sizeof(u32),
    38			.name = "apple_efuses_nvmem",
    39			.id = NVMEM_DEVID_AUTO,
    40		};
    41	
  > 42		config.priv = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
    43		if (IS_ERR(config.priv))
    44			return PTR_ERR(config.priv);
    45	
    46		config.size = resource_size(res);
    47	
    48		return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
    49	}
    50	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

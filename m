Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D44C9DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiCBG03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbiCBG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:26:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDEA939EB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 22:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646202346; x=1677738346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0VIe8WyCJS/Ms5x3JftesJY8omECnu1DkvqkoNbsuUU=;
  b=m7wtAWDlSl87ZQddHVqDo5Um1takib4bPQMIzs6aA+sIHczSi3pKOLOg
   XtBaGV3SpwRwaGMVq+L+3HDisSXncx2tFyD61/qcCYTFJy0jB46/BKG6p
   5CG4LYl6QrhchQa/rtj/+oMvEZZ5c0lLI+tz6OLC9CukdZYKu+SFUJhHZ
   0ZwaG4LyzWSvXOJhL8nXEDcJ55VH1T8DDy7dyXetOM67/v9wwm/rZZl8L
   fB9nJb41SjBZr68r6O2kktmZs5B+HeRn0F/lsSMtA/kfLeN4GiU8/DdNY
   8N2uMfC85je1rNti9DZn0LucXqbX/F9gXqSgHmDT/thut4J8bUjessyvr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="277993823"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="277993823"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 22:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="641580876"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2022 22:25:43 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPIQh-00018S-8R; Wed, 02 Mar 2022 06:25:43 +0000
Date:   Wed, 2 Mar 2022 14:25:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/m1/2022-03-01 259/355]
 sound/soc/apple/mca.c:294:23: error: implicit declaration of function
 'FIELD_PREP'
Message-ID: <202203021406.vHQV63U1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/m1/2022-03-01
head:   d7cc9472c1c5430d7caa806e8180d2359ea46266
commit: 9442abe28eca738b4e48277746d2bb67e4ede8c5 [259/355] ASoC: apple-mca: Add platform driver for Apple SoCs
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220302/202203021406.vHQV63U1-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9442abe28eca738b4e48277746d2bb67e4ede8c5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/m1/2022-03-01
        git checkout 9442abe28eca738b4e48277746d2bb67e4ede8c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/platform/ sound/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/apple/mca.c: In function 'mca_configure_serdes':
>> sound/soc/apple/mca.c:294:23: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     294 |         serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
         |                       ^~~~~~~~~~
   sound/soc/apple/mca.c: At top level:
   sound/soc/apple/mca.c:776:6: warning: no previous prototype for 'apple_mca_release_dma_chans' [-Wmissing-prototypes]
     776 | void apple_mca_release_dma_chans(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/apple/mca.c:791:6: warning: no previous prototype for 'apple_mca_put_clks' [-Wmissing-prototypes]
     791 | void apple_mca_put_clks(struct mca_data *mca)
         |      ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c: In function 'apple_mca_probe':
   sound/soc/apple/mca.c:917:45: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long int' [-Wformat=]
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:917:25: note: in expansion of macro 'dev_err'
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                         ^~~~~~~
   sound/soc/apple/mca.c:917:74: note: format string is defined here
     917 |                         dev_err(&pdev->dev, "unable to obtain clock %s: %d\n",
         |                                                                         ~^
         |                                                                          |
         |                                                                          int
         |                                                                         %ld
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c:951:61: warning: format '%d' expects argument of type 'int', but argument 4 has type 'struct device_node *' [-Wformat=]
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:951:41: note: in expansion of macro 'dev_err'
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                         ^~~~~~~
   sound/soc/apple/mca.c:951:82: note: format string is defined here
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                                                 ~^
         |                                                                                  |
         |                                                                                  int
   In file included from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from sound/soc/apple/mca.c:9:
   sound/soc/apple/mca.c:951:61: warning: too many arguments for format [-Wformat-extra-args]
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/soc/apple/mca.c:951:41: note: in expansion of macro 'dev_err'
     951 |                                         dev_err(&pdev->dev, "no %s DMA channel: %d\n",
         |                                         ^~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +294 sound/soc/apple/mca.c

   288	
   289	static int mca_configure_serdes(struct mca_data *mca, int cluster, int serdes_unit,
   290					unsigned int mask, int slots, int slot_width, bool is_tx, int port)
   291	{
   292		u32 serdes_conf;
   293	
 > 294		serdes_conf = FIELD_PREP(SERDES_CONF_NCHANS, max(slots, 1) - 1);
   295	
   296		switch (slot_width) {
   297		case 16:
   298			serdes_conf |= SERDES_CONF_WIDTH_16BIT;
   299			break;
   300		case 20:
   301			serdes_conf |= SERDES_CONF_WIDTH_20BIT;
   302			break;
   303		case 24:
   304			serdes_conf |= SERDES_CONF_WIDTH_24BIT;
   305			break;
   306		case 32:
   307			serdes_conf |= SERDES_CONF_WIDTH_32BIT;
   308			break;
   309		default:
   310			goto err;
   311		}
   312	
   313		mca_modify(mca, cluster,
   314			serdes_unit + (is_tx ? REG_TX_SERDES_CONF : REG_RX_SERDES_CONF),
   315			SERDES_CONF_WIDTH_MASK | SERDES_CONF_NCHANS, serdes_conf);
   316		mca_poke(mca, cluster,
   317			serdes_unit + (is_tx ? REG_TX_SERDES_CHANMASK : REG_RX_SERDES_CHANMASK),
   318			~((u32) mask));
   319		mca_poke(mca, cluster,
   320			serdes_unit + (is_tx ? REG_TX_SERDES_CHANMASK : REG_RX_SERDES_CHANMASK) + 0x4,
   321			~((u32) mask));
   322	
   323		if (!is_tx)
   324			mca_poke(mca, cluster,
   325				serdes_unit + REG_RX_SERDES_PORT,
   326				1 << port);
   327	
   328		return 0;
   329	
   330	err:
   331		dev_err(mca->dev, "unsupported SERDES configuration requested (mask=0x%x slots=%d slot_width=%d)\n",
   332				mask, slots, slot_width);
   333		return -EINVAL;
   334	}
   335	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

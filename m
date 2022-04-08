Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419384F98F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiDHPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiDHPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:05:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137C2F067E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649430215; x=1680966215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TyHB4nU/NMc9NlsQonWb1XUCFEXJdeRo+A0VKe0eQPo=;
  b=Wn3gR44AFtYiLFoeytk8N3TZKOtudXHyzZaGZJmTECNs6cGXMZhFaO2t
   Qnm2vsEx4GMsXT/69bWl+LvqerWjPDXODMKysWur3tjkECWIahSc7sEPq
   frk0HD9vbynmnFVdpWTQjnyLQZQn8ia1FspywkahJhLpRxnI6gHMd7IgG
   QlkT0riAEzrM/GkhqmPNFlU2gMm7VXYq8Ebrv7xopQZBFFzFv5mmise/L
   d7epEA6+Wanu2F6kzJDscUHCCyru/kJQibTEJ2fuWtay42Wk6GXkW0UPa
   J8vWU+hW0iocgzkWvJ9yB29J00A7n+cmrLKFA63qlJxrA/jNlm+X8n14p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261605226"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261605226"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="653293425"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 08:03:32 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncq96-0000NZ-DJ;
        Fri, 08 Apr 2022 15:03:32 +0000
Date:   Fri, 8 Apr 2022 23:02:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 578/887]
 drivers/gpu/drm/panel/panel-sitronix-st7701.c:677: undefined reference to
 `spi_setup'
Message-ID: <202204082206.73JkRYwL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 72c355c6c7656888e6124c1356c3f68cb9cf5b35 [578/887] drm/panel/panel-sitronix-st7701: Support SPI config and RGB data
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220408/202204082206.73JkRYwL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/l1k/linux/commit/72c355c6c7656888e6124c1356c3f68cb9cf5b35
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 72c355c6c7656888e6124c1356c3f68cb9cf5b35
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_spi_probe':
>> drivers/gpu/drm/panel/panel-sitronix-st7701.c:677: undefined reference to `spi_setup'
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_disable':
>> drivers/gpu/drm/panel/panel-sitronix-st7701.c:390: undefined reference to `spi_sync'
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_enable':
   drivers/gpu/drm/panel/panel-sitronix-st7701.c:373: undefined reference to `spi_sync'
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `st7701_unprepare':
   drivers/gpu/drm/panel/panel-sitronix-st7701.c:406: undefined reference to `spi_sync'
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `txw210001b0_init_sequence':
   drivers/gpu/drm/panel/panel-sitronix-st7701.c:240: undefined reference to `spi_sync'
>> ld: drivers/gpu/drm/panel/panel-sitronix-st7701.c:244: undefined reference to `spi_sync'
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o:drivers/gpu/drm/panel/panel-sitronix-st7701.c:247: more undefined references to `spi_sync' follow
   ld: drivers/gpu/drm/panel/panel-sitronix-st7701.o: in function `panel_st7701_init':
>> drivers/gpu/drm/panel/panel-sitronix-st7701.c:724: undefined reference to `__spi_register_driver'


vim +677 drivers/gpu/drm/panel/panel-sitronix-st7701.c

   669	
   670	static int st7701_spi_probe(struct spi_device *spi)
   671	{
   672		struct st7701 *st7701;
   673		int ret;
   674	
   675		spi->mode = SPI_MODE_3;
   676		spi->bits_per_word = 9;
 > 677		ret = spi_setup(spi);
   678		if (ret < 0) {
   679			dev_err(&spi->dev, "failed to setup SPI: %d\n", ret);
   680			return ret;
   681		}
   682	
   683		ret = st7701_probe(&spi->dev, &st7701);
   684	
   685		if (ret)
   686			return ret;
   687	
   688		spi_set_drvdata(spi, st7701);
   689		st7701->spi = spi;
   690	
   691		return 0;
   692	}
   693	
   694	static int st7701_spi_remove(struct spi_device *spi)
   695	{
   696		struct st7701 *ctx = spi_get_drvdata(spi);
   697	
   698		drm_panel_remove(&ctx->panel);
   699	
   700		return 0;
   701	}
   702	
   703	static const struct spi_device_id st7701_spi_ids[] = {
   704		{ "txw210001b0", 0 },
   705		{ "hyperpixel2round", 0 },
   706		{ /* sentinel */ }
   707	};
   708	MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
   709	
   710	static struct spi_driver st7701_spi_driver = {
   711		.probe = st7701_spi_probe,
   712		.remove = st7701_spi_remove,
   713		.driver = {
   714			.name = "st7701",
   715			.of_match_table = st7701_spi_of_match,
   716		},
   717		.id_table = st7701_spi_ids,
   718	};
   719	
   720	static int __init panel_st7701_init(void)
   721	{
   722		int err;
   723	
 > 724		err = spi_register_driver(&st7701_spi_driver);
   725		if (err < 0)
   726			return err;
   727	
   728		if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
   729			err = mipi_dsi_driver_register(&st7701_dsi_driver);
   730			if (err < 0)
   731				goto err_did_spi_register;
   732		}
   733	
   734		return 0;
   735	
   736	err_did_spi_register:
   737		spi_unregister_driver(&st7701_spi_driver);
   738	
   739		return err;
   740	}
   741	module_init(panel_st7701_init);
   742	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

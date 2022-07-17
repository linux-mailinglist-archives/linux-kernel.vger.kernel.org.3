Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5076E577756
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiGQQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:43:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15CB7C7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658076237; x=1689612237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GsqvoTJqNJBu9D9hlkqYC42mbwQYda6Nfi22wxNqOzk=;
  b=Z8TXFNLx2bit5eqUT/HXWtydOcIS0rOSgvuzEUwvGb7oURugJfg95pjE
   AdzyCQvPZ4AykQ+ZPH/end/f/GBm3n6oPIaovH+kzcuiSeWp9xHQPtHHq
   jxbCkwCoUjj491KcqDlJhDh01b3CQDncdEsGB5b677lUCDECFKaKclESq
   C7c8K96A7+I6x8woX01SqZ/bBfM4KsqRgOtFcHm+Jl7hut4zeAlJ8Mgeq
   0sRY/UAyp1PrRiCuFzctttIWo3t/DyUXDWov9lg44l2QvfIcl+H4oOY8g
   nqVh8h/DC2iPu5xy3ROpuOr9yhv/2RzbJgp/GQvCy6lcjazsNVND5Kht8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265860337"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="265860337"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 09:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="924066869"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2022 09:43:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD7N5-0003Tl-Fx;
        Sun, 17 Jul 2022 16:43:55 +0000
Date:   Mon, 18 Jul 2022 00:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [kraxel:drm-qemu-next 31/70] drivers/gpu/drm/vc4/vc4_dpi.c:247:18:
 error: implicit declaration of function 'drmm_of_get_bridge'; did you mean
 'devm_drm_of_get_bridge'?
Message-ID: <202207180030.CoXPUpOx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kraxel.org/linux drm-qemu-next
head:   887ddf3251928dc39bfc58c5c62083d38a633c14
commit: 055af0235aef8110a1c44f5fc04c5c206e9e58fb [31/70] drm/vc4: dpi: Switch to drmm_of_get_bridge
config: mips-randconfig-r025-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180030.CoXPUpOx-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add kraxel git://git.kraxel.org/linux
        git fetch --no-tags kraxel drm-qemu-next
        git checkout 055af0235aef8110a1c44f5fc04c5c206e9e58fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/vc4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/vc4/vc4_dpi.c: In function 'vc4_dpi_init_bridge':
>> drivers/gpu/drm/vc4/vc4_dpi.c:247:18: error: implicit declaration of function 'drmm_of_get_bridge'; did you mean 'devm_drm_of_get_bridge'? [-Werror=implicit-function-declaration]
     247 |         bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
         |                  ^~~~~~~~~~~~~~~~~~
         |                  devm_drm_of_get_bridge
>> drivers/gpu/drm/vc4/vc4_dpi.c:247:16: warning: assignment to 'struct drm_bridge *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     247 |         bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
         |                ^
   cc1: some warnings being treated as errors


vim +247 drivers/gpu/drm/vc4/vc4_dpi.c

   237	
   238	/* Sets up the next link in the display chain, whether it's a panel or
   239	 * a bridge.
   240	 */
   241	static int vc4_dpi_init_bridge(struct vc4_dpi *dpi)
   242	{
   243		struct drm_device *drm = dpi->encoder.base.dev;
   244		struct device *dev = &dpi->pdev->dev;
   245		struct drm_bridge *bridge;
   246	
 > 247		bridge = drmm_of_get_bridge(drm, dev->of_node, 0, 0);
   248		if (IS_ERR(bridge)) {
   249			/* If nothing was connected in the DT, that's not an
   250			 * error.
   251			 */
   252			if (PTR_ERR(bridge) == -ENODEV)
   253				return 0;
   254			else
   255				return PTR_ERR(bridge);
   256		}
   257	
   258		return drm_bridge_attach(&dpi->encoder.base, bridge, NULL, 0);
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

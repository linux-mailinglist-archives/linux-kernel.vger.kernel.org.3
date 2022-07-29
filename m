Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950A35855E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiG2UHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiG2UH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:07:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647D7968E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659125247; x=1690661247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3EYJuCImAFppAcSlVnUcEfwImmJRRAzetmU8K028Uo=;
  b=ZJ2znwYdu4xtfmvTw0e/6H7GDv/aKGMf4ueL9XHpaJdVQREQ4ahTdeBy
   LZ+d1roAPeZEUIE3zNR0G6uR/EqELRfhQFxK+YvPrHNyJ1eHRZQfpL9D8
   0Zz3Rqf988cjsjS0HsWz1Lp9FPiv8+N8cCTt101ZeSV7OIS3cz0+ZYjNd
   q4kFa+zzuCYIWvGpmzVfkdXbnXC0ABXwrYTOOPUxrV8Or74XYvazDi1bV
   NRpsmwMOhOn9bP4uye2F2z4svnzYzBL+chOYc6KWWJSCgCGyynMg+sgqh
   0D/ukUzuelobEPNXmh5afk/swOqAQboizyOt0eqrYT/mghL8zSndcATEC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="352843331"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="352843331"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 13:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="605067850"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2022 13:07:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHWGW-000C3P-1J;
        Fri, 29 Jul 2022 20:07:20 +0000
Date:   Sat, 30 Jul 2022 04:06:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 33/35] drm/connector: Remove TV modes property
Message-ID: <202207300305.EGSDOjh4-lkp@intel.com>
References: <20220728-rpi-analog-tv-properties-v1-33-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-33-3d53ae722097@cerno.tech>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I love your patch! Yet something to improve:

[auto build test ERROR on 37b355fdaf31ee18bda9a93c2a438dc1cbf57ec9]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-Analog-TV-Improvements/20220730-004859
base:   37b355fdaf31ee18bda9a93c2a438dc1cbf57ec9
config: hexagon-randconfig-r041-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300305.EGSDOjh4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/83327cd72054a9c8d02b6f632453a8bdc90d3797
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maxime-Ripard/drm-Analog-TV-Improvements/20220730-004859
        git checkout 83327cd72054a9c8d02b6f632453a8bdc90d3797
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i2c/ch7006_drv.c:253:51: error: too many arguments to function call, expected 2, have 3
           drm_mode_create_tv_properties(dev, NUM_TV_NORMS, ch7006_tv_norm_names);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    ^~~~~~~~~~~~~~~~~~~~
   include/drm/drm_connector.h:1807:5: note: 'drm_mode_create_tv_properties' declared here
   int drm_mode_create_tv_properties(struct drm_device *dev,
       ^
   1 error generated.


vim +253 drivers/gpu/drm/i2c/ch7006_drv.c

6ee738610f41b5 Ben Skeggs   2009-12-11  245  
6ee738610f41b5 Ben Skeggs   2009-12-11  246  static int ch7006_encoder_create_resources(struct drm_encoder *encoder,
6ee738610f41b5 Ben Skeggs   2009-12-11  247  					   struct drm_connector *connector)
6ee738610f41b5 Ben Skeggs   2009-12-11  248  {
6ee738610f41b5 Ben Skeggs   2009-12-11  249  	struct ch7006_priv *priv = to_ch7006_priv(encoder);
6ee738610f41b5 Ben Skeggs   2009-12-11  250  	struct drm_device *dev = encoder->dev;
6ee738610f41b5 Ben Skeggs   2009-12-11  251  	struct drm_mode_config *conf = &dev->mode_config;
6ee738610f41b5 Ben Skeggs   2009-12-11  252  
6ee738610f41b5 Ben Skeggs   2009-12-11 @253  	drm_mode_create_tv_properties(dev, NUM_TV_NORMS, ch7006_tv_norm_names);
6ee738610f41b5 Ben Skeggs   2009-12-11  254  
d9bc3c02e36d84 Sascha Hauer 2012-02-06  255  	priv->scale_property = drm_property_create_range(dev, 0, "scale", 0, 2);
44084efc2fd804 Insu Yun     2016-01-28  256  	if (!priv->scale_property)
44084efc2fd804 Insu Yun     2016-01-28  257  		return -ENOMEM;
6ee738610f41b5 Ben Skeggs   2009-12-11  258  
ec61c71d0dba24 Rob Clark    2012-10-11  259  	drm_object_attach_property(&connector->base, conf->tv_select_subconnector_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  260  				      priv->select_subconnector);
ec61c71d0dba24 Rob Clark    2012-10-11  261  	drm_object_attach_property(&connector->base, conf->tv_subconnector_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  262  				      priv->subconnector);
ec61c71d0dba24 Rob Clark    2012-10-11  263  	drm_object_attach_property(&connector->base, conf->tv_left_margin_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  264  				      priv->hmargin);
ec61c71d0dba24 Rob Clark    2012-10-11  265  	drm_object_attach_property(&connector->base, conf->tv_bottom_margin_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  266  				      priv->vmargin);
ec61c71d0dba24 Rob Clark    2012-10-11  267  	drm_object_attach_property(&connector->base, conf->tv_mode_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  268  				      priv->norm);
ec61c71d0dba24 Rob Clark    2012-10-11  269  	drm_object_attach_property(&connector->base, conf->tv_brightness_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  270  				      priv->brightness);
ec61c71d0dba24 Rob Clark    2012-10-11  271  	drm_object_attach_property(&connector->base, conf->tv_contrast_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  272  				      priv->contrast);
ec61c71d0dba24 Rob Clark    2012-10-11  273  	drm_object_attach_property(&connector->base, conf->tv_flicker_reduction_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  274  				      priv->flicker);
ec61c71d0dba24 Rob Clark    2012-10-11  275  	drm_object_attach_property(&connector->base, priv->scale_property,
6ee738610f41b5 Ben Skeggs   2009-12-11  276  				      priv->scale);
6ee738610f41b5 Ben Skeggs   2009-12-11  277  
6ee738610f41b5 Ben Skeggs   2009-12-11  278  	return 0;
6ee738610f41b5 Ben Skeggs   2009-12-11  279  }
6ee738610f41b5 Ben Skeggs   2009-12-11  280  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C34585600
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiG2URd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:17:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EE8AEEC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659125848; x=1690661848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHXzzmsjuJv9AN/O6EtjvRoPXkwz0wGDEtmwwZMap3k=;
  b=oHN4iIRqtP884kTuGUOLzSnJ9WDsBDZtb4U3Nrr/I81+5gsnn3Empp6b
   rvZJIBuvXyMBwhBrtgsrq2xJ6LeSxlZxykDTUJQ/HtYX7Oc+GuXumHwZp
   GFxXUpMbChMwPN0mIFqRwd4Eei7bPdKJ0ajF7QScvgLq/14D5ysN/53b0
   5Nz2qR7fhZMjG2HsXQHEbKJhA+LkMUr9OUS38K27AGOXES6sKz1fDtbKj
   Tg5+N8WRXWzrZoCeZMp1lIdu8Rses+0TfPbzDNpucYlgfHpLBuDDIx00D
   /UbTsXM0HRP6FQ4TMAcaKIHltpeTsMkmBYrcmgw9XVHWLP3B+5IxpieF3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="314648568"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="314648568"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 13:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="598355595"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2022 13:17:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHWQC-000C3x-2S;
        Fri, 29 Jul 2022 20:17:20 +0000
Date:   Sat, 30 Jul 2022 04:16:40 +0800
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
Message-ID: <202207300454.3rIc8wpM-lkp@intel.com>
References: <20220728-rpi-analog-tv-properties-v1-33-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-33-3d53ae722097@cerno.tech>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: riscv-randconfig-r042-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300454.3rIc8wpM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/83327cd72054a9c8d02b6f632453a8bdc90d3797
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maxime-Ripard/drm-Analog-TV-Improvements/20220730-004859
        git checkout 83327cd72054a9c8d02b6f632453a8bdc90d3797
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/nouveau/dispnv04/tvnv17.c:656:51: error: too many arguments to function call, expected 2, have 3
           drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                    ^~~~~~~~~~~~~~~~~~
   include/drm/drm_connector.h:1807:5: note: 'drm_mode_create_tv_properties' declared here
   int drm_mode_create_tv_properties(struct drm_device *dev,
       ^
   1 error generated.


vim +656 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c

6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  633  
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  634  static int nv17_tv_create_resources(struct drm_encoder *encoder,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  635  				    struct drm_connector *connector)
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  636  {
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  637  	struct drm_device *dev = encoder->dev;
77145f1cbdf8d2 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2012-07-31  638  	struct nouveau_drm *drm = nouveau_drm(dev);
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  639  	struct drm_mode_config *conf = &dev->mode_config;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  640  	struct nv17_tv_encoder *tv_enc = to_tv_enc(encoder);
cb75d97e9c7774 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2012-07-11  641  	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  642  	int num_tv_norms = dcb->tvconf.has_component_output ? NUM_TV_NORMS :
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  643  							NUM_LD_TV_NORMS;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  644  	int i;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  645  
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  646  	if (nouveau_tv_norm) {
2574c809d7c0f0 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c YueHaibing 2019-12-30  647  		i = match_string(nv17_tv_norm_names, num_tv_norms,
2574c809d7c0f0 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c YueHaibing 2019-12-30  648  				 nouveau_tv_norm);
2574c809d7c0f0 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c YueHaibing 2019-12-30  649  		if (i < 0)
77145f1cbdf8d2 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2012-07-31  650  			NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  651  				nouveau_tv_norm);
2574c809d7c0f0 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c YueHaibing 2019-12-30  652  		else
2574c809d7c0f0 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c YueHaibing 2019-12-30  653  			tv_enc->tv_norm = i;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  654  	}
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  655  
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11 @656  	drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  657  
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  658  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  659  					conf->tv_select_subconnector_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  660  					tv_enc->select_subconnector);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  661  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  662  					conf->tv_subconnector_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  663  					tv_enc->subconnector);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  664  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  665  					conf->tv_mode_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  666  					tv_enc->tv_norm);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  667  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  668  					conf->tv_flicker_reduction_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  669  					tv_enc->flicker);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  670  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  671  					conf->tv_saturation_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  672  					tv_enc->saturation);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  673  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  674  					conf->tv_hue_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  675  					tv_enc->hue);
2db83827dc7679 drivers/gpu/drm/nouveau/nv17_tv.c         Rob Clark  2012-10-11  676  	drm_object_attach_property(&connector->base,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  677  					conf->tv_overscan_property,
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  678  					tv_enc->overscan);
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  679  
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  680  	return 0;
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  681  }
6ee738610f41b5 drivers/gpu/drm/nouveau/nv17_tv.c         Ben Skeggs 2009-12-11  682  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

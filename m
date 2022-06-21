Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821EC552916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiFUBnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbiFUBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:43:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B71A3AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655775806; x=1687311806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yFc3lUpGmYEg6vmumtcmQFlnoJqIDRJE3hFGfq0FQdg=;
  b=GMJL3jKq/g+tL4R/dz42jMGnnizzrIkppuphaTdNhAp4pmdHcq6sZ11D
   TjI8O3z9iPMAzS7astT1PD4NjMxEZZzY6CSn8hWO9FEViyVnqnCcpydAT
   aQQ5WMVyL9ZSAbTQRJsVxYy25DLR6PkNlq0efCkVwgkVL4xOMSr0/P/t3
   88VRpY/NKk7iEcIlB1lUkhQlF4em67AFd94Wu43dPYWSWl9L8rtxn3RyS
   O2OMmcQcRdJs6dp+ZgqOaFyHyhUDQNO6dmx9LyxSQlKS9owLZxKx9xdhl
   c2FEEqSp0FMEzmx6HB7MBgDAric7o6mSeEJXRqX5LJtuqY0KJJXa6Fb+A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="277551138"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="277551138"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="714797201"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2022 18:43:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3SvL-000XkX-VV;
        Tue, 21 Jun 2022 01:43:23 +0000
Date:   Tue, 21 Jun 2022 09:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 3/4]
 drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:17: error: implicit declaration of
 function 'drm_plane_create_zpos_immutable_property'; did you mean
 'drm_plane_create_scaling_filter_property'?
Message-ID: <202206210906.58kJhAw8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   f16a716621a6edf4eef2ba1409594f5c780ea09b
commit: 90bb087f66745ca48f6f5e43df99a1212d89e712 [3/4] drm: Drop drm_blend.h from drm_crtc.h
config: riscv-randconfig-r042-20220619 (https://download.01.org/0day-ci/archive/20220621/202206210906.58kJhAw8-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 90bb087f66745ca48f6f5e43df99a1212d89e712
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/xlnx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/xlnx/zynqmp_disp.c: In function 'zynqmp_disp_create_planes':
>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:17: error: implicit declaration of function 'drm_plane_create_zpos_immutable_property'; did you mean 'drm_plane_create_scaling_filter_property'? [-Werror=implicit-function-declaration]
    1260 |                 drm_plane_create_zpos_immutable_property(&layer->plane, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 drm_plane_create_scaling_filter_property
>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1262:25: error: implicit declaration of function 'drm_plane_create_alpha_property'; did you mean 'drm_plane_create_color_properties'? [-Werror=implicit-function-declaration]
    1262 |                         drm_plane_create_alpha_property(&layer->plane);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         drm_plane_create_color_properties
   cc1: some warnings being treated as errors


vim +1260 drivers/gpu/drm/xlnx/zynqmp_disp.c

d76271d22694e8 Hyun Kwon        2018-07-07  1226  
d76271d22694e8 Hyun Kwon        2018-07-07  1227  static int zynqmp_disp_create_planes(struct zynqmp_disp *disp)
d76271d22694e8 Hyun Kwon        2018-07-07  1228  {
d76271d22694e8 Hyun Kwon        2018-07-07  1229  	unsigned int i, j;
d76271d22694e8 Hyun Kwon        2018-07-07  1230  	int ret;
d76271d22694e8 Hyun Kwon        2018-07-07  1231  
d76271d22694e8 Hyun Kwon        2018-07-07  1232  	for (i = 0; i < ZYNQMP_DISP_NUM_LAYERS; i++) {
d76271d22694e8 Hyun Kwon        2018-07-07  1233  		struct zynqmp_disp_layer *layer = &disp->layers[i];
d76271d22694e8 Hyun Kwon        2018-07-07  1234  		enum drm_plane_type type;
d76271d22694e8 Hyun Kwon        2018-07-07  1235  		u32 *drm_formats;
d76271d22694e8 Hyun Kwon        2018-07-07  1236  
d76271d22694e8 Hyun Kwon        2018-07-07  1237  		drm_formats = drmm_kcalloc(disp->drm, sizeof(*drm_formats),
d76271d22694e8 Hyun Kwon        2018-07-07  1238  					   layer->info->num_formats,
d76271d22694e8 Hyun Kwon        2018-07-07  1239  					   GFP_KERNEL);
d76271d22694e8 Hyun Kwon        2018-07-07  1240  		if (!drm_formats)
d76271d22694e8 Hyun Kwon        2018-07-07  1241  			return -ENOMEM;
d76271d22694e8 Hyun Kwon        2018-07-07  1242  
d76271d22694e8 Hyun Kwon        2018-07-07  1243  		for (j = 0; j < layer->info->num_formats; ++j)
d76271d22694e8 Hyun Kwon        2018-07-07  1244  			drm_formats[j] = layer->info->formats[j].drm_fmt;
d76271d22694e8 Hyun Kwon        2018-07-07  1245  
d76271d22694e8 Hyun Kwon        2018-07-07  1246  		/* Graphics layer is primary, and video layer is overlay. */
1e42874b0df79a Quanyang Wang    2021-05-18  1247  		type = zynqmp_disp_layer_is_video(layer)
1e42874b0df79a Quanyang Wang    2021-05-18  1248  		     ? DRM_PLANE_TYPE_OVERLAY : DRM_PLANE_TYPE_PRIMARY;
d76271d22694e8 Hyun Kwon        2018-07-07  1249  		ret = drm_universal_plane_init(disp->drm, &layer->plane, 0,
d76271d22694e8 Hyun Kwon        2018-07-07  1250  					       &zynqmp_disp_plane_funcs,
d76271d22694e8 Hyun Kwon        2018-07-07  1251  					       drm_formats,
d76271d22694e8 Hyun Kwon        2018-07-07  1252  					       layer->info->num_formats,
d76271d22694e8 Hyun Kwon        2018-07-07  1253  					       NULL, type, NULL);
d76271d22694e8 Hyun Kwon        2018-07-07  1254  		if (ret)
d76271d22694e8 Hyun Kwon        2018-07-07  1255  			return ret;
d76271d22694e8 Hyun Kwon        2018-07-07  1256  
d76271d22694e8 Hyun Kwon        2018-07-07  1257  		drm_plane_helper_add(&layer->plane,
d76271d22694e8 Hyun Kwon        2018-07-07  1258  				     &zynqmp_disp_plane_helper_funcs);
650f12042b8532 Laurent Pinchart 2021-03-07  1259  
8c772f0b2b8e94 Laurent Pinchart 2021-03-07 @1260  		drm_plane_create_zpos_immutable_property(&layer->plane, i);
650f12042b8532 Laurent Pinchart 2021-03-07  1261  		if (zynqmp_disp_layer_is_gfx(layer))
650f12042b8532 Laurent Pinchart 2021-03-07 @1262  			drm_plane_create_alpha_property(&layer->plane);
d76271d22694e8 Hyun Kwon        2018-07-07  1263  	}
d76271d22694e8 Hyun Kwon        2018-07-07  1264  
d76271d22694e8 Hyun Kwon        2018-07-07  1265  	return 0;
d76271d22694e8 Hyun Kwon        2018-07-07  1266  }
d76271d22694e8 Hyun Kwon        2018-07-07  1267  

:::::: The code at line 1260 was first introduced by commit
:::::: 8c772f0b2b8e94bfd68f9bf19d7aba293332e4bf drm: xlnx: zynqmp_dpsub: Expose plane ordering to userspace

:::::: TO: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
:::::: CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

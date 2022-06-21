Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF72553B90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354044AbiFUUZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiFUUZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:25:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5724F12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655843115; x=1687379115;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7e+ir0VyaDL/t9/cJ3Sqhdxf9f68AWW8rKGLisVcpJ8=;
  b=Hzik7xqGvRZEfgpKnQAWFpPvs02/gWLjMENuRtYsi9H8/fjXz+uwRiQP
   5OXOWNPq8G5c+ov14g2mZwxDo0R3017d6FE2nuMWZQSpRr62iuaL0IhJ1
   ZvLBp09LfSd+bEk7Zkm41QxU3/hZZPlJuFULUQIrL7rQK8usjXZVqBtaI
   ouswc/D6B18E+pIDbKLPOq28wW0WR4wVMXSzXzRvYj/wnEPN2B88oUopT
   B0vSwlpm7oGz2sb0e/8ZyMPBRUvf4kgLf3Pg81zv7b6XSKG8SU/gI/k3Q
   ldYHvrQceTpID6IV8Qj/uWUqCnPgdQU8Ja1KRmN+/sIOB/At503UAt8PV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341912449"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="341912449"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 13:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="591818035"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2022 13:25:13 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3kQy-0000O9-WC;
        Tue, 21 Jun 2022 20:25:12 +0000
Date:   Wed, 22 Jun 2022 04:25:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 3/4]
 drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:3: error: call to undeclared
 function 'drm_plane_create_zpos_immutable_property'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202206220449.j02XFvCg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   87a3451e346be3f9a5d8943ae094888044314631
commit: 90bb087f66745ca48f6f5e43df99a1212d89e712 [3/4] drm: Drop drm_blend.h from drm_crtc.h
config: powerpc-buildonly-randconfig-r002-20220622 (https://download.01.org/0day-ci/archive/20220622/202206220449.j02XFvCg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 90bb087f66745ca48f6f5e43df99a1212d89e712
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/xlnx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the drm-misc/drm-misc-next HEAD 87a3451e346be3f9a5d8943ae094888044314631 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:3: error: call to undeclared function 'drm_plane_create_zpos_immutable_property'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   drm_plane_create_zpos_immutable_property(&layer->plane, i);
                   ^
   drivers/gpu/drm/xlnx/zynqmp_disp.c:1260:3: note: did you mean 'drm_plane_create_scaling_filter_property'?
   include/drm/drm_plane.h:908:5: note: 'drm_plane_create_scaling_filter_property' declared here
   int drm_plane_create_scaling_filter_property(struct drm_plane *plane,
       ^
>> drivers/gpu/drm/xlnx/zynqmp_disp.c:1262:4: error: call to undeclared function 'drm_plane_create_alpha_property'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           drm_plane_create_alpha_property(&layer->plane);
                           ^
   drivers/gpu/drm/xlnx/zynqmp_disp.c:1262:4: note: did you mean 'drm_plane_create_color_properties'?
   include/drm/drm_color_mgmt.h:90:5: note: 'drm_plane_create_color_properties' declared here
   int drm_plane_create_color_properties(struct drm_plane *plane,
       ^
   2 errors generated.


vim +/drm_plane_create_zpos_immutable_property +1260 drivers/gpu/drm/xlnx/zynqmp_disp.c

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

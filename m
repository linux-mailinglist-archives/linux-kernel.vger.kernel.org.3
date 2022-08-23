Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66559DCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355593AbiHWKjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354244AbiHWKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:24:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5CA3D7E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661245487; x=1692781487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9SOYythy7j/MXfRmlQCo9b2tnL50CgZqRYrTw3v6/MI=;
  b=dOMescNLYiHQQA88j7sBMaizavg18RHEIWhzGijQ9RubOe0Q7L7kRtzz
   Fb3MliHjTPF36JGOZjV0sUzo6ejCq5Zsk+B3gV8OBxHMg9xO4RwG+iC93
   3b5eZ9koXRLCVuVjUZAVrt77yjw1zqVZoY1AbxPlNoRAjvcAEEHZoNOPz
   PMB+T9Uq3NJGqTTL8uDSt47sAu6p1SExkp0B6hRl0JfPqefNOSO4QPSHq
   ZDJYjTMQJytRElgoNVL0oGNTJ68VjMbbw+Opvh71SdfaYkWKBptb7M1Ai
   rxEuqHFvm2dHphRf+dd7iwR7bzeKMmTpS6nNyxnRWA/2sEC/K0SO4vYgE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294424186"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294424186"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 02:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="937388230"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2022 02:04:45 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQPq1-00003r-0G;
        Tue, 23 Aug 2022 09:04:45 +0000
Date:   Tue, 23 Aug 2022 17:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: [pdx86-platform-drivers-x86:backlight-detect-refactor-v3 5/31]
 drivers/gpu/drm/nouveau/nouveau_backlight.c:410: undefined reference to
 `acpi_video_backlight_use_native'
Message-ID: <202208231625.icHjRXDI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git backlight-detect-refactor-v3
head:   137c0ecca7db6e41715a3b3506871ef45cec29b4
commit: eeefca542f6b6d7f7b99692aadbd2204b5053d3b [5/31] drm/nouveau: Don't register backlight when another backlight should be used
config: ia64-randconfig-r002-20220821 (https://download.01.org/0day-ci/archive/20220823/202208231625.icHjRXDI-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=eeefca542f6b6d7f7b99692aadbd2204b5053d3b
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 backlight-detect-refactor-v3
        git checkout eeefca542f6b6d7f7b99692aadbd2204b5053d3b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/gpu/drm/nouveau/nouveau_backlight.o: in function `nouveau_backlight_init':
>> drivers/gpu/drm/nouveau/nouveau_backlight.c:410: undefined reference to `acpi_video_backlight_use_native'


vim +410 drivers/gpu/drm/nouveau/nouveau_backlight.c

   352	
   353	int
   354	nouveau_backlight_init(struct drm_connector *connector)
   355	{
   356		struct nouveau_drm *drm = nouveau_drm(connector->dev);
   357		struct nouveau_backlight *bl;
   358		struct nouveau_encoder *nv_encoder = NULL;
   359		struct nvif_device *device = &drm->client.device;
   360		char backlight_name[BL_NAME_SIZE];
   361		struct backlight_properties props = {0};
   362		const struct backlight_ops *ops;
   363		int ret;
   364	
   365		if (apple_gmux_present()) {
   366			NV_INFO_ONCE(drm, "Apple GMUX detected: not registering Nouveau backlight interface\n");
   367			return 0;
   368		}
   369	
   370		if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
   371			nv_encoder = find_encoder(connector, DCB_OUTPUT_LVDS);
   372		else if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
   373			nv_encoder = find_encoder(connector, DCB_OUTPUT_DP);
   374		else
   375			return 0;
   376	
   377		if (!nv_encoder)
   378			return 0;
   379	
   380		bl = kzalloc(sizeof(*bl), GFP_KERNEL);
   381		if (!bl)
   382			return -ENOMEM;
   383	
   384		switch (device->info.family) {
   385		case NV_DEVICE_INFO_V0_CURIE:
   386			ret = nv40_backlight_init(nv_encoder, &props, &ops);
   387			break;
   388		case NV_DEVICE_INFO_V0_TESLA:
   389		case NV_DEVICE_INFO_V0_FERMI:
   390		case NV_DEVICE_INFO_V0_KEPLER:
   391		case NV_DEVICE_INFO_V0_MAXWELL:
   392		case NV_DEVICE_INFO_V0_PASCAL:
   393		case NV_DEVICE_INFO_V0_VOLTA:
   394		case NV_DEVICE_INFO_V0_TURING:
   395		case NV_DEVICE_INFO_V0_AMPERE: //XXX: not confirmed
   396			ret = nv50_backlight_init(bl, nouveau_connector(connector),
   397						  nv_encoder, &props, &ops);
   398			break;
   399		default:
   400			ret = 0;
   401			goto fail_alloc;
   402		}
   403	
   404		if (ret) {
   405			if (ret == -ENODEV)
   406				ret = 0;
   407			goto fail_alloc;
   408		}
   409	
 > 410		if (!acpi_video_backlight_use_native()) {
   411			NV_INFO(drm, "Skipping nv_backlight registration\n");
   412			goto fail_alloc;
   413		}
   414	
   415		if (!nouveau_get_backlight_name(backlight_name, bl)) {
   416			NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
   417			goto fail_alloc;
   418		}
   419	
   420		props.type = BACKLIGHT_RAW;
   421		bl->dev = backlight_device_register(backlight_name, connector->kdev,
   422						    nv_encoder, ops, &props);
   423		if (IS_ERR(bl->dev)) {
   424			if (bl->id >= 0)
   425				ida_free(&bl_ida, bl->id);
   426			ret = PTR_ERR(bl->dev);
   427			goto fail_alloc;
   428		}
   429	
   430		nouveau_connector(connector)->backlight = bl;
   431		if (!bl->dev->props.brightness)
   432			bl->dev->props.brightness =
   433				bl->dev->ops->get_brightness(bl->dev);
   434		backlight_update_status(bl->dev);
   435	
   436		return 0;
   437	
   438	fail_alloc:
   439		kfree(bl);
   440		return ret;
   441	}
   442	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

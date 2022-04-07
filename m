Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E380C4F8AF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiDGXcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiDGXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:32:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5623D1E8CCB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649374200; x=1680910200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vJXzpb4ZlwFlYPis3GHj6JxuMTLuQqiK/0u4xF6cvRA=;
  b=SxE4BaPyOsJykZ0utdjWUWcgLBfI0bR21k+coe1M9qRKD1SWUduoNc5V
   fDBsLFDew3OxqzqOEEp3ZvWzx3l8kSZYyrwt4i+b5IXXG+sewnvq6ooLC
   79hN7SiK1uljiAmZZULQFZvYFIltc0VLi2B64d61i9TSncjCBm5stkPdY
   xbZ5fw9E+atkr8/lSHWlxKBAXia0WSvr0rsw2OIHkugAxulXxNCoCpXJX
   qKHG2NETiOMAz4DeQoXqIuuovOKMSQZfliNC8GlfSZ56sjLRv68b/z1mX
   jkziX36sxOV3acqZqaV/6aNT7F8takPsJVPx5Z2F5NdpkvZIt9tBe0+35
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241396213"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="241396213"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="723164456"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2022 16:29:56 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncbZb-0005rf-T6;
        Thu, 07 Apr 2022 23:29:55 +0000
Date:   Fri, 8 Apr 2022 07:29:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 2/5] include/linux/kallsyms.h:110: multiple
 definition of `kallsyms_lookup_names';
 drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first
 defined here
Message-ID: <202204080736.zX5PlQu0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   baa78873a24a7e0f21b0a01e82214ce9a096e147
commit: 3f047c53b0e7e747b76f0b3d032e476efbe1222f [2/5] kallsyms: Add kallsyms_lookup_names function
config: nios2-buildonly-randconfig-r001-20220407 (https://download.01.org/0day-ci/archive/20220408/202204080736.zX5PlQu0-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=3f047c53b0e7e747b76f0b3d032e476efbe1222f
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 3f047c53b0e7e747b76f0b3d032e476efbe1222f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/gpu/drm/drm_crtc_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_dsc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_encoder_slave.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_flip_work.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_hdcp.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_probe_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_plane_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_atomic_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_kms_helper_common.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_simple_kms_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_modeset_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_gem_atomic_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_gem_framebuffer_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_atomic_state_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_damage_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_self_refresh_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/bridge/panel.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_bridge_connector.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/drm_auth.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_file.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_gem.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_ioctl.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_drv.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_sysfs.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_crtc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_modes.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_edid.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_prime.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_modeset_lock.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_atomic.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_bridge.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_framebuffer.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_connector.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_blend.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_encoder.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_mode_object.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_property.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_plane.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_color_mgmt.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_dumb_buffers.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_mode_config.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_vblank.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_syncobj.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_lease.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_writeback.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_client.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_client_modeset.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_atomic_uapi.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_managed.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_vblank_work.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_panel.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_of.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_debugfs.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_debugfs_crc.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/drm_edid_load.o: in function `kallsyms_lookup_names':
   include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/drm_aperture.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/arm/malidp_hw.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/malidp_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/malidp_planes.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/malidp_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/malidp_crtc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/malidp_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/malidp_mw.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/malidp_drv.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_dev.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_pipeline.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_kms.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_crtc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_plane.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_private_obj.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/komeda_event.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/d71/d71_dev.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/arm/display/komeda/d71/d71_component.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/arm/display/komeda/komeda_drv.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/dp/drm_dp_mst_topology.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/dp/drm_dp.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/dp/drm_dp_aux_dev.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/dp/drm_dp.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/dp/drm_dp_cec.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/dp/drm_dp.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/imx/ipuv3-crtc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/imx/imx-drm-core.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/imx/ipuv3-plane.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/imx/imx-drm-core.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/i2c/ch7006_mode.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/i2c/ch7006_drv.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_reg.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/bridge/analogix/analogix_dp_core.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/bridge/analogix/analogix_dp_core.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-cpmem.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-csi.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-dc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-di.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-dp.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-dmfc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-ic.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-ic-csc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-image-convert.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-smfc.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-vdi.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-pre.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/ipu-v3/ipu-prg.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/ipu-v3/ipu-common.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/selftests/test-drm_damage_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/selftests/test-drm_plane_helper.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/selftests/test-drm_dp_mst_helper.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/selftests/test-drm_plane_helper.o:include/linux/kallsyms.h:110: first defined here
--
   nios2-linux-ld: drivers/gpu/drm/bridge/adv7511/adv7533.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/bridge/adv7511/adv7511_drv.o:include/linux/kallsyms.h:110: first defined here
   nios2-linux-ld: drivers/gpu/drm/bridge/adv7511/adv7511_cec.o: in function `kallsyms_lookup_names':
>> include/linux/kallsyms.h:110: multiple definition of `kallsyms_lookup_names'; drivers/gpu/drm/bridge/adv7511/adv7511_drv.o:include/linux/kallsyms.h:110: first defined here
..


vim +110 include/linux/kallsyms.h

   106	
   107	int kallsyms_lookup_names(const char **syms, u32 cnt, unsigned long *addrs)
   108	{
   109		return -ERANGE;
 > 110	}
   111	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

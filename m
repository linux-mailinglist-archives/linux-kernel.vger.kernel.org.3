Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE75A521239
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiEJKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiEJKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:32:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67868201C0D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652178507; x=1683714507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pQwU2i6bceyAoTP/CIS30qvH7Mv3G1PJylMz6rT+0vI=;
  b=KEMNhdAyAAq/XSIHMTSHffx/z+9wA/Ty9emWNgwpN5S5tAOFPZ2kytAJ
   MDHQ6kxSXV13nG0ua/HAMHG5u/KgL7CxKG5QhqSw6cUd+HGViarmnDxa7
   rejKY1iNgobvMZtkIz+ZNc/lzbxC17TO0AvBkgXsnDZZ0jNEMe61PELvm
   qReIgt2hpdVWYRQeyitv7ZQLfzXXsZcCnO/nSEnTA4hA8yjQ3+dB8VSdt
   Dc4DRUA/NOt46GMUs0406Vv16LvuDiLWH+Q2GAsLbzcjGdpJuBg5V5xEU
   VlpSsEJ0XepKd+nSVR7FM3DejOFZWjVhtQvDXPV2S1l5QwJru3UB1mZEj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332364882"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="332364882"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 03:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="710965058"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 03:28:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noN6O-000Hhn-Bw;
        Tue, 10 May 2022 10:28:24 +0000
Date:   Tue, 10 May 2022 18:27:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1170/6555]
 drivers/gpu/drm/vkms/vkms_drv.h:23:18: warning: 'vkms_cursor_formats'
 defined but not used
Message-ID: <202205101800.K4r0yQWF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: ad949a53c5680265ac89dff6003c02178891e079 [1170/6555] UPSTREAM: drm/vkms: Add cursor plane support
config: i386-randconfig-a001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101800.K4r0yQWF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/ad949a53c5680265ac89dff6003c02178891e079
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout ad949a53c5680265ac89dff6003c02178891e079
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/vkms/vkms_drv.c:8:
   include/linux/module.h:134:13: warning: 'init_module' specifies less restrictive attribute than its target 'vkms_init': 'cold' [-Wmissing-attributes]
     134 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.c:151:1: note: in expansion of macro 'module_init'
     151 | module_init(vkms_init);
         | ^~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.c:90:19: note: 'init_module' target declared here
      90 | static int __init vkms_init(void)
         |                   ^~~~~~~~~
   In file included from drivers/gpu/drm/vkms/vkms_drv.c:8:
   include/linux/module.h:140:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'vkms_exit': 'cold' [-Wmissing-attributes]
     140 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.c:152:1: note: in expansion of macro 'module_exit'
     152 | module_exit(vkms_exit);
         | ^~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.c:138:20: note: 'cleanup_module' target declared here
     138 | static void __exit vkms_exit(void)
         |                    ^~~~~~~~~
   In file included from drivers/gpu/drm/vkms/vkms_drv.c:14:
>> drivers/gpu/drm/vkms/vkms_drv.h:23:18: warning: 'vkms_cursor_formats' defined but not used [-Wunused-const-variable=]
      23 | static const u32 vkms_cursor_formats[] = {
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.h:19:18: warning: 'vkms_formats' defined but not used [-Wunused-const-variable=]
      19 | static const u32 vkms_formats[] = {
         |                  ^~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/vkms/vkms_output.c:9:
>> drivers/gpu/drm/vkms/vkms_drv.h:23:18: warning: 'vkms_cursor_formats' defined but not used [-Wunused-const-variable=]
      23 | static const u32 vkms_cursor_formats[] = {
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.h:19:18: warning: 'vkms_formats' defined but not used [-Wunused-const-variable=]
      19 | static const u32 vkms_formats[] = {
         |                  ^~~~~~~~~~~~
--
   drivers/gpu/drm/vkms/vkms_crtc.c: In function 'vkms_vblank_simulate':
   drivers/gpu/drm/vkms/vkms_crtc.c:47:13: warning: variable 'ret_overrun' set but not used [-Wunused-but-set-variable]
      47 |         int ret_overrun;
         |             ^~~~~~~~~~~
   In file included from drivers/gpu/drm/vkms/vkms_crtc.c:9:
   At top level:
>> drivers/gpu/drm/vkms/vkms_drv.h:23:18: warning: 'vkms_cursor_formats' defined but not used [-Wunused-const-variable=]
      23 | static const u32 vkms_cursor_formats[] = {
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_drv.h:19:18: warning: 'vkms_formats' defined but not used [-Wunused-const-variable=]
      19 | static const u32 vkms_formats[] = {
         |                  ^~~~~~~~~~~~


vim +/vkms_cursor_formats +23 drivers/gpu/drm/vkms/vkms_drv.h

    22	
  > 23	static const u32 vkms_cursor_formats[] = {
    24		DRM_FORMAT_ARGB8888,
    25	};
    26	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

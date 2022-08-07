Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3358BA72
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiHGJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiHGJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:40:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18355A0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659865231; x=1691401231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=89hCtPbI40w4jNVs2PRH7P+86yvqMEqbKLF4cKjJQkE=;
  b=DW5Kfg946MVFEIcp8C2ovzJKwCyzJAuWzCmgjFZ779u5PAovBVw2XugF
   ma6Nt2Y5s8qM94Wbly5+AMkjS2zkE8iweUlKOLNZUnUMmeCEqWhxOMMAj
   jzQ9AHFkFdw2p4gksMxTk/CT5LjYPuUoNK/qMIOKZwrqr1yWjcIxpEfcC
   VZrBPpLLCSxKVkTgll43fyslt0ZHsF8uurwIOv0CuaDxz7pCSv+KEh2j9
   7uZnuPZanT2LQpeR3a3OGrL5Z49rsyqkEyuS8kw50Q/2GP+X+EIsviZJe
   pQKs/I/tE2p/3hRQMqL8498znQWyQMJFCR+YI1NRLwrK0aVDg0WzfNy5S
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="273473345"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="273473345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 02:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="931702114"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 02:40:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKclo-000LCf-22;
        Sun, 07 Aug 2022 09:40:28 +0000
Date:   Sun, 7 Aug 2022 17:40:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c:147:5: warning: no
 previous prototype for 'tinydrm_display_pipe_init'
Message-ID: <202208071706.bgRl6mce-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1612c382ffbdf1f673caec76502b1c00e6d35363
commit: 96f2a9aef5987340d367ab7497ae972a55e6f71c drm/tinydrm: tinydrm_display_pipe_init() don't use tinydrm_device
date:   3 years, 6 months ago
config: parisc-randconfig-r022-20220805 (https://download.01.org/0day-ci/archive/20220807/202208071706.bgRl6mce-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96f2a9aef5987340d367ab7497ae972a55e6f71c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 96f2a9aef5987340d367ab7497ae972a55e6f71c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC4':
>> (.data.rel.ro+0x8): undefined reference to `iosapic_serial_irq'
--
   In file included from arch/parisc/include/asm/io.h:6,
                    from include/linux/fb.h:17,
                    from include/drm/drm_crtc.h:31,
                    from include/drm/drm_atomic_helper.h:31,
                    from drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c:10:
   include/asm-generic/pgtable.h: In function 'pte_clear_not_present_full':
   arch/parisc/include/asm/pgtable.h:60:23: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
      60 |                 pte_t old_pte;                                  \
         |                       ^~~~~~~
   arch/parisc/include/asm/pgtable.h:289:34: note: in expansion of macro 'set_pte_at'
     289 | #define pte_clear(mm, addr, xp)  set_pte_at(mm, addr, xp, __pte(0))
         |                                  ^~~~~~~~~~
   include/asm-generic/pgtable.h:201:9: note: in expansion of macro 'pte_clear'
     201 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
   include/asm-generic/pgtable.h: In function '__ptep_modify_prot_commit':
   arch/parisc/include/asm/pgtable.h:60:23: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
      60 |                 pte_t old_pte;                                  \
         |                       ^~~~~~~
   include/asm-generic/pgtable.h:629:9: note: in expansion of macro 'set_pte_at'
     629 |         set_pte_at(mm, addr, ptep, pte);
         |         ^~~~~~~~~~
   drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c: At top level:
   drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c:85:1: warning: no previous prototype for 'tinydrm_connector_create' [-Wmissing-prototypes]
      85 | tinydrm_connector_create(struct drm_device *drm,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c:147:5: warning: no previous prototype for 'tinydrm_display_pipe_init' [-Wmissing-prototypes]
     147 | int tinydrm_display_pipe_init(struct drm_device *drm,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tinydrm_display_pipe_init +147 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c

    83	
    84	struct drm_connector *
  > 85	tinydrm_connector_create(struct drm_device *drm,
    86				 const struct drm_display_mode *mode,
    87				 int connector_type)
    88	{
    89		struct tinydrm_connector *tconn;
    90		struct drm_connector *connector;
    91		int ret;
    92	
    93		tconn = kzalloc(sizeof(*tconn), GFP_KERNEL);
    94		if (!tconn)
    95			return ERR_PTR(-ENOMEM);
    96	
    97		drm_mode_copy(&tconn->mode, mode);
    98		connector = &tconn->base;
    99	
   100		drm_connector_helper_add(connector, &tinydrm_connector_hfuncs);
   101		ret = drm_connector_init(drm, connector, &tinydrm_connector_funcs,
   102					 connector_type);
   103		if (ret) {
   104			kfree(tconn);
   105			return ERR_PTR(ret);
   106		}
   107	
   108		connector->status = connector_status_connected;
   109	
   110		return connector;
   111	}
   112	
   113	static int tinydrm_rotate_mode(struct drm_display_mode *mode,
   114				       unsigned int rotation)
   115	{
   116		if (rotation == 0 || rotation == 180) {
   117			return 0;
   118		} else if (rotation == 90 || rotation == 270) {
   119			swap(mode->hdisplay, mode->vdisplay);
   120			swap(mode->hsync_start, mode->vsync_start);
   121			swap(mode->hsync_end, mode->vsync_end);
   122			swap(mode->htotal, mode->vtotal);
   123			swap(mode->width_mm, mode->height_mm);
   124			return 0;
   125		} else {
   126			return -EINVAL;
   127		}
   128	}
   129	
   130	/**
   131	 * tinydrm_display_pipe_init - Initialize display pipe
   132	 * @drm: DRM device
   133	 * @pipe: Display pipe
   134	 * @funcs: Display pipe functions
   135	 * @connector_type: Connector type
   136	 * @formats: Array of supported formats (DRM_FORMAT\_\*)
   137	 * @format_count: Number of elements in @formats
   138	 * @mode: Supported mode
   139	 * @rotation: Initial @mode rotation in degrees Counter Clock Wise
   140	 *
   141	 * This function sets up a &drm_simple_display_pipe with a &drm_connector that
   142	 * has one fixed &drm_display_mode which is rotated according to @rotation.
   143	 *
   144	 * Returns:
   145	 * Zero on success, negative error code on failure.
   146	 */
 > 147	int tinydrm_display_pipe_init(struct drm_device *drm,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

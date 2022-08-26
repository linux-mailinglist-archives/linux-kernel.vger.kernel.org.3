Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF085A2BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiHZP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiHZP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:59:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D8D277E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 712E9CE2F92
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B9BC433D6;
        Fri, 26 Aug 2022 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661529549;
        bh=SAd6ICXTA5HHfY/TYT/+LfvaroL3DCccw5EEXd7inzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhrm21KbpsoZ/3r8EStOQwho+ISnuKhiw6UOdmDf+y43MgEQ267BK7GFQgqIKizUS
         qPmwS1aGad4SaiU1RmW7TrH+mlhxjUxwq7IVi2UoohH6Bo8HC+R7g4SdIw9V+dwM/C
         5LslMqIk/FsAkzsX+YjHBOJ5mER9XwwxNWFJ3/+WG5QcQV6nGyP/3xtz3kN5HqPCyI
         PcgGIMy5QVJYWuIIAcNS6w2LmqiFM2GZjTAx3rlvtsCENapC2G75/XLvHNHBPEokZC
         /n6bgva4+10LWj5pyNUu++GENX72yb+RMUoYSbNjBkH7Dobfqxg0i7W1i5ABbbVT7S
         lhYuik83gqqvA==
Date:   Fri, 26 Aug 2022 08:59:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: ld.lld: error: undefined symbol: drm_gem_fb_get_obj
Message-ID: <Ywjty2iSyer5FDS7@dev-arch.thelio-3990X>
References: <202208221506.0Lo051G4-lkp@intel.com>
 <CACRpkdYoesPenQizTc6_MRZ14THBSFwyHb7oWJdR+CYYiJYYpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYoesPenQizTc6_MRZ14THBSFwyHb7oWJdR+CYYiJYYpQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 10:26:43AM +0200, Linus Walleij wrote:
> On Mon, Aug 22, 2022 at 9:27 AM kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1c23f9e627a7b412978b4e852793c5e3c3efc555
> > commit: 57f6190a60ecc19f1ddddac0d7ea6524229271a9 drm/panel: ws2401: Add driver for WideChips WS2401
> > date:   1 year, 1 month ago
> > config: x86_64-randconfig-a002-20220822 (https://download.01.org/0day-ci/archive/20220822/202208221506.0Lo051G4-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57f6190a60ecc19f1ddddac0d7ea6524229271a9
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 57f6190a60ecc19f1ddddac0d7ea6524229271a9
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: undefined symbol: drm_gem_fb_get_obj
> >    >>> referenced by drm_mipi_dbi.c:203 (drivers/gpu/drm/drm_mipi_dbi.c:203)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
> >    >>> referenced by drm_mipi_dbi.c:258 (drivers/gpu/drm/drm_mipi_dbi.c:258)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_fb_dirty) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_fb_swab
> >    >>> referenced by drm_mipi_dbi.c:219 (drivers/gpu/drm/drm_mipi_dbi.c:219)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_atomic_helper_connector_destroy_state
> >    >>> referenced by drm_mipi_dbi.c
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_connector_funcs) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_gem_fb_create_with_dirty
> >    >>> referenced by drm_mipi_dbi.c
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_atomic_helper_check
> >    >>> referenced by drm_mipi_dbi.c
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_atomic_helper_commit
> >    >>> referenced by drm_mipi_dbi.c
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_mode_config_funcs) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_fb_xrgb8888_to_rgb565
> >    >>> referenced by drm_mipi_dbi.c:224 (drivers/gpu/drm/drm_mipi_dbi.c:224)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_fb_memcpy
> >    >>> referenced by drm_mipi_dbi.c:221 (drivers/gpu/drm/drm_mipi_dbi.c:221)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_buf_copy) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_atomic_helper_damage_merged
> >    >>> referenced by drm_mipi_dbi.c:318 (drivers/gpu/drm/drm_mipi_dbi.c:318)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_pipe_update) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_simple_display_pipe_init
> >    >>> referenced by drm_mipi_dbi.c:529 (drivers/gpu/drm/drm_mipi_dbi.c:529)
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_dev_init_with_formats) in archive drivers/built-in.a
> > --
> > >> ld.lld: error: undefined symbol: drm_atomic_helper_connector_reset
> >    >>> referenced by drm_mipi_dbi.c
> >    >>>               gpu/drm/drm_mipi_dbi.o:(mipi_dbi_connector_funcs) in archive drivers/built-in.a
> 
> I don't understand this error report, please robot, analyze further and come
> back with details on what needs to be fixed.

Seems like this might be the fix?

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6c2256e8474b..679ad054ea4b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -31,6 +31,7 @@ menuconfig DRM
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
+	select DRM_KMS_HELPER
 
 config DRM_MIPI_DSI
 	bool
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index a9043eacce97..c68b433c8241 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -165,7 +165,6 @@ config DRM_PANEL_ILITEK_IL9322
 config DRM_PANEL_ILITEK_ILI9341
 	tristate "Ilitek ILI9341 240x320 QVGA panels"
 	depends on OF && SPI
-	depends on DRM_KMS_HELPER
 	depends on DRM_GEM_CMA_HELPER
 	depends on BACKLIGHT_CLASS_DEVICE
 	select DRM_MIPI_DBI

drm_mipi_dbi.c uses several functions from the drm_kms_helper-y files
(drivers/gpu/drm/Makefile) but there is nothing to guarantee that
CONFIG_DRM_KMS_HELPER gets selected with CONFIG_DRM_MIPI_DBI. The
'depends on' drop is to remove a circular dependency failure.

For what it's worth, this error is not clang or ld.lld specific, you
would see the same problem with GCC + GNU binutils.

Cheers,
Nathan


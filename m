Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900635A3EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiH1QzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiH1QzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:55:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB121EAD5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:55:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62D45E5;
        Sun, 28 Aug 2022 18:55:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661705700;
        bh=zEYTsxaYLGnRiDJdJ2laUCl2+VUb2MAeagyzBAbO5jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAgxMEZPrUBFZG9m424Ty19DOW6vRzwN0BOhejMT8FUSE1lmu3m1FN3zzkayXVqtm
         mNxUCfZdyegTdK2u+T6PBXektpzuSIwtZbIYSDsOe1U62CdEu+34RcJdiKqSMfDOCM
         BjelKnKUe7K9VR4/qlPglfSC1PfYHUwYm2P16ifk=
Date:   Sun, 28 Aug 2022 19:54:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [pinchartl-media:drm/du/next 13/14]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous
 prototype for function 'rcar_mipi_dsi_pclk_enable'
Message-ID: <Ywud3DnKFDCyjcBv@pendragon.ideasonboard.com>
References: <202208282000.MtTNOyOx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202208282000.MtTNOyOx-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Sun, Aug 28, 2022 at 08:52:39PM +0800, kernel test robot wrote:
> tree:   git://linuxtv.org/pinchartl/media.git drm/du/next
> head:   1a1ef49313becc3127e3bd2b6cdb27e5fc54f761
> commit: 81c238208c6accde5592851b101986b8b91ec859 [13/14] drm: rcar-du: Fix DSI enable & disable sequence
> config: riscv-randconfig-c006-20220828 (https://download.01.org/0day-ci/archive/20220828/202208282000.MtTNOyOx-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv-linux-gnu
>         git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
>         git fetch --no-tags pinchartl-media drm/du/next
>         git checkout 81c238208c6accde5592851b101986b8b91ec859
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/rcar-du/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:6: warning: no previous prototype for function 'rcar_mipi_dsi_pclk_enable' [-Wmissing-prototypes]
>    void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
>         ^
>    drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:614:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
>    ^
>    static 
> >> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:653:6: warning: no previous prototype for function 'rcar_mipi_dsi_pclk_disable' [-Wmissing-prototypes]
>    void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>         ^
>    drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:653:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>    ^
>    static 
>    2 warnings generated.

I'll squash the following fix in "drm: rcar-du: Fix DSI enable & disable
sequence":

diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
index 90128d5e3d17..a7f2b7f66a17 100644
--- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
@@ -25,6 +25,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>

+#include "rcar_mipi_dsi.h"
 #include "rcar_mipi_dsi_regs.h"

 struct rcar_mipi_dsi {

> vim +/rcar_mipi_dsi_pclk_enable +614 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> 
>    613	
>  > 614	void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
>    615				       struct drm_atomic_state *state)
>    616	{
>    617		struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
>    618		const struct drm_display_mode *mode;
>    619		struct drm_connector *connector;
>    620		struct drm_crtc *crtc;
>    621		int ret;
>    622	
>    623		connector = drm_atomic_get_new_connector_for_encoder(state,
>    624								     bridge->encoder);
>    625		crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
>    626		mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
>    627	
>    628		ret = rcar_mipi_dsi_clk_enable(dsi);
>    629		if (ret < 0) {
>    630			dev_err(dsi->dev, "failed to enable DSI clocks\n");
>    631			return;
>    632		}
>    633	
>    634		ret = rcar_mipi_dsi_startup(dsi, mode);
>    635		if (ret < 0)
>    636			goto err_dsi_startup;
>    637	
>    638		rcar_mipi_dsi_set_display_timing(dsi, mode);
>    639	
>    640		ret = rcar_mipi_dsi_start_hs_clock(dsi);
>    641		if (ret < 0)
>    642			goto err_dsi_start_hs;
>    643	
>    644		return;
>    645	
>    646	err_dsi_start_hs:
>    647		rcar_mipi_dsi_shutdown(dsi);
>    648	err_dsi_startup:
>    649		rcar_mipi_dsi_clk_disable(dsi);
>    650	}
>    651	EXPORT_SYMBOL_GPL(rcar_mipi_dsi_pclk_enable);
>    652	
>  > 653	void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>    654	{
>    655		struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
>    656	
>    657		rcar_mipi_dsi_shutdown(dsi);
>    658		rcar_mipi_dsi_clk_disable(dsi);
>    659	}
>    660	EXPORT_SYMBOL_GPL(rcar_mipi_dsi_pclk_disable);
>    661	

-- 
Regards,

Laurent Pinchart

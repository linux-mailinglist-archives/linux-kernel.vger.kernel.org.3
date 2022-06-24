Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0997355A2D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiFXUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:37:19 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083A828A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=TPfs2QT7MjSlfibpr7aNRy/3mX4Ppd6HsikuuFFfOgI=;
        b=mCmloxF5kRH23rbwRYtYSvI1Qe5ieH0ONv+zMRuknslxW0bEmwZkWsuxNUV+t8z+8fHAU0ydceyGI
         tbaxH/rhESgEYCp/Qyh+UEBPi+TnrIc0Dk9yF0tLWR4GhzFF4Z8DpPkdHgRSwzUByWArNHvzbWYO69
         RLMohu9CxvIraT3ZGAbYlBux5Blh7BFTjagAkufbaeL8PVEN1I9AJ8YSbbCpFdvrzV4Lep7skJIUKZ
         sSe5xOu4pHgRtoDWEZU6JuzsBpSCpfPACwKVlkIVhYMq3IFsahUtGjCOqrKWOfTXLtzGOgP9Q+yu+6
         6xz0ukIZfiSkmQq4jIQcuWA9PgDEBzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=TPfs2QT7MjSlfibpr7aNRy/3mX4Ppd6HsikuuFFfOgI=;
        b=uQqRZTYsBlWT5c/y5rNbmV/ZA4UFvzI9fVUADgwkkLVa/hw/lHbxRbe7ka969fcFsyxKbjCZq1aKq
         rmfWta2Ag==
X-HalOne-Cookie: c9bafe8a4ad68d7eda8a0eaf402083f9e04b9925
X-HalOne-ID: 6f0a39d1-f3fd-11ec-8233-d0431ea8bb10
Received: from mailproxy1.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 6f0a39d1-f3fd-11ec-8233-d0431ea8bb10;
        Fri, 24 Jun 2022 20:37:16 +0000 (UTC)
Date:   Fri, 24 Jun 2022 22:37:14 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Introduce EBBG FT8719 DRM panel driver
Message-ID: <YrYgehpgkIQY0Fqt@ravnborg.org>
References: <BY5PR02MB700961069804230B5AFC5E04D9DF9@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB700961069804230B5AFC5E04D9DF9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Wed, Jun 01, 2022 at 01:54:06PM +0530, Joel Selvaraj wrote:
> Add bindings and DRM panel driver for EBBG FT8719 6.18" 2246x1080 DSI
> video mode panel, which can be found on some Xiaomi Poco F1 phones.
> The panel's backlight is managed through QCOM WLED driver.
> 
> The driver is built using linux-mdss-dsi-panel-driver-generator[1], and
> additionally support for handling regulators and linking external
> backlight is added.
> 
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> 
> Changes in v4: (Linus Walleij's Suggestion)
>  - Introduce mipi_dsi_dcs_write_seq macro in include/drm/drm_mipi_dsi.h
>  - Remove the driver specific dsi_dcs_write_seq macro
>  - Use the newly introduced mipi_dsi_dcs_write_seq macro instead
> 
> Changes in v3: (Mostly Linus Walleij's Suggestions)
>  - Removed ctx->prepared state variable as it's handled by the core
>  - Print error in dsi_dcs_write_seq macro if it fails to write
>  - Removed magic power on sequences as panel works fine without them
> 
> Changes in v2: (Krzysztof Kozlowski's Suggestions)
>  - dt-bindings: specify maxItems for reg
>  - dt-bindings: cleanup and simplify the panel properties
>  - dt-bindings: in example change "|+" to "|' and "dsi0" to "dsi"
> 
> Joel Selvaraj (4):
>   dt-bindings: vendor-prefixes: Add prefix for EBBG
>   dt-bindings: display: Add bindings for EBBG FT8719
>   drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro
>   drm/panel: introduce ebbg,ft8719 panel

All applied to drm-misc (drm-misc-next), thanks!

	Sam

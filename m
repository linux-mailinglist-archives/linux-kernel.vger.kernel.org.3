Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3083C4D2269
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349830AbiCHUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiCHUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:16:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB55130E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:16:00 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5859F488;
        Tue,  8 Mar 2022 21:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646770558;
        bh=vEaa2WFln8MBWhVC2M4cfRmYS4cQsjlmS2QqcmoQUD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWqMXkf8A+ee5bF5lQ8Xv4ICnk8CxZo077VJ9l0tg6FH9WB6ZVnuayp/7aHq3Fnri
         6n1QbXH3HC5SOuoqeuRDoSPMVBcfvCopzvlIxxy8aZdHrcqlcXhQa5xN7/gTcXjb27
         RCgIc9Tnnpy/6TewGmFUvw9lvgp3giNKLvI8Vq2M=
Date:   Tue, 8 Mar 2022 22:15:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/bridge: Add MAINTAINERS entry for DRM drivers
 for bridge chip bindings
Message-ID: <Yie5cBCYjjl/FrPB@pendragon.ideasonboard.com>
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thank you for the patch.

On Tue, Mar 08, 2022 at 11:06:57AM -0800, Douglas Anderson wrote:
> The bindings for bridge chips should also get the same maintainers
> entry so the right people get notified about bindings changes.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0216d2ffe728..a73179d55d00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6403,6 +6403,7 @@ R:	Jonas Karlman <jonas@kwiboo.se>
>  R:	Jernej Skrabec <jernej.skrabec@gmail.com>
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/bridge/
>  F:	drivers/gpu/drm/bridge/
>  
>  DRM DRIVERS FOR EXYNOS

-- 
Regards,

Laurent Pinchart

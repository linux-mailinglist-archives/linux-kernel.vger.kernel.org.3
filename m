Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C8530FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiEWMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiEWMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:50:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73252B0D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:50:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i24so13596971pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YfnB11KMaX602mBm0PnlrHM5pqQzJfF9oigF++xZ/Ks=;
        b=UhKZbD+yQzdUWIBnTy9KAJYJYOuA2+70s+CqllAQ/sfA6KznKV5d+vWr5UMmThRA6t
         CN/wUjyaha4lokAFaS2EjzviEqNjZKn481mxdq73xHsysOXsSs0lN1Ioj0d8S7H3frGY
         zpktXvyQ8PNZz+rQJO4ONjCJNXfrpNMK+f+no0khs0tgm/GH/b91xMVDRll0IBzCL473
         zAd5sg7DTmGDlZUtmyRCDEe0etu0zWfk6hyquG2VAKDuO7UsaWt1MrChSlzBqVYXwWfO
         9T2NuBUhVpWS4KRU3807MP9VlUovGOrfaSusS7L6EAmlHxxZkvZhckWBlgh/VMaYpMIl
         /86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YfnB11KMaX602mBm0PnlrHM5pqQzJfF9oigF++xZ/Ks=;
        b=ofjK4Q7109l9poti25Ia5PvJNz0Ih5ok/1445VxdUlWM8GtAFGMNG1YqVLJxNBj0Aa
         CqYV3z/Guk0JOn4H4ALdoim5/gRUbKnsMFVaHhaGUwhZKrIhnissPCSM9y+wtWAb9de1
         CTRhUE3KN35vQs1afk0ILXmhU26qpHSVs0j/jjQmmOiBuMdbDzw1E++tQOW032WHym69
         TH54iVW9IXYU8xIxNzuVUTUaDqqh707FzaoQPUIjJ7DVs+8kxNgfz+5Kqcj2EHmA4MWG
         nTRniSEdOFHERZb1CQ0oCPeMV8sBAH+lEN9g71DpuIRebrFYTOTPf/PGRw4iRB186KOy
         uZvA==
X-Gm-Message-State: AOAM531oM/9vbO18818+1VCitCf/GENNs0aUSnqTnxdSwqSXsdbRRh8X
        vgd98FokVDvs3NMqRnuOlUGaxhhiuW2euqfJnkZrew==
X-Google-Smtp-Source: ABdhPJwVH/O6Xo9nRgajes4j9eCZ5mpZVShQyUWGA9JFDSxnW70LHrFHFYzJSTkvaEFwySG6g2LXOgM+0tGd1nPpuRs=
X-Received: by 2002:a63:6901:0:b0:3f9:caa5:cffc with SMTP id
 e1-20020a636901000000b003f9caa5cffcmr12543131pgc.324.1653310233085; Mon, 23
 May 2022 05:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220523084615.13510-1-robert.foss@linaro.org>
In-Reply-To: <20220523084615.13510-1-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 14:50:22 +0200
Message-ID: <CAG3jFytkFcmYjj6AHye3imsTDyP1LxHQvAzjswuRBsVVHRTnKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, tzimmermann@suse.de,
        maxime@cerno.tech, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 10:46, Robert Foss <robert.foss@linaro.org> wrote:
>
> This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 01f46d9189c1..53a5da6c49dd 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
>
>         anx7625_get_swing_setting(dev, pdata);
>
> -       pdata->is_dpi = 0; /* default dsi mode */
> +       pdata->is_dpi = 1; /* default dpi mode */
>         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
>         if (!pdata->mipi_host_node) {
>                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
>                 return -ENODEV;
>         }
>
> -       bus_type = 0;
> +       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
>         mipi_lanes = MAX_LANES_SUPPORT;
>         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
>         if (ep0) {
> @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
>                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
>         }
>
> -       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> -               pdata->is_dpi = 1;
> +       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> +               pdata->is_dpi = 0;
>
>         pdata->mipi_lanes = mipi_lanes;
>         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> --
> 2.34.1
>

Signed-off-by: Robert Foss <robert.foss@linaro.org>

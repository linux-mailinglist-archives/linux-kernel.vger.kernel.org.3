Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250585312AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiEWQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiEWQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:17:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6C663F0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c2so13562404plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVNiD7vP0L3vCHj36O4S/xcAq9fOvgGBuSkh3JaXOYE=;
        b=RWk6SuCADsteqryMbQGonZW8ugJLR0+nv3OTEZ1uCbffYsTcSuVqdso5JgZ8W3242o
         RN1FsTLhcwAu5xlb4KXNOCeLVDPBlFEevAR7XmLwMy7o4abbmCcpy1la2E6vng3M96Lb
         rouIWSDIYLek4Q6fi7PFuPDA1gpmlfwrFrcfCjibFVZmYrAIvkOFLNoI/Pu1zGwPTUGC
         LkDNIDxF2KZen43mQpFHQje5nePqY9oZyTrmRO319hMgohKDlrd4cDLJ8WeMWQU+Iiz6
         AqnlZ1W5uQqNDCU2igUpxf8UU+14OqFxspscIsOT3oifv6vUIdf3oP5juMLUKVlx1ERD
         Sg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVNiD7vP0L3vCHj36O4S/xcAq9fOvgGBuSkh3JaXOYE=;
        b=ZKonTYKY0IgtwUBAXZlajp5dD5sTetnpPaFz6R/TyRU5STRMWCzGdaT0PuuXr1khx4
         0dDiTzZqTCa1hZaTrzIcuJ9Ue427n2IVQGrcUxq51I7E4NaQfwcojP23xVuvZzYwD5vv
         8Zbj0UeifUPGaMlgC5ugN3mDaMySWiZmlD0pjPbAtkjtyKhaPmg5VuNqWDPmn9zrjGDi
         Je8xT0DHKm/p1zTbfUHGg52vR2RyvSWmB/pDgXLHoCBUVGNZqC59xzFOiS5IXXy7CCei
         0YgPqKflcI3dDybpGZ2s3PPQHh7wN8vZtRtooJaxe5IDnXp4O4fW4VWLg3xlDGnwK/Ci
         8mSw==
X-Gm-Message-State: AOAM530uXD/BGEIkGwD+w96ohbwINbKy6WVMBzZJc1TfK2xODLpXeh/m
        SHuwRY/6U4qKgDOwCQXSwCSHqCzykvyVh1SmirgqkA==
X-Google-Smtp-Source: ABdhPJyKf5MFfX+ZAnTFHA7p3LFDFK6zdI6kyxKzzlK8T2QiqbCeqyYwWZSaB8q7ekysEndtAEdUUlXRmo7QNdOfVc8=
X-Received: by 2002:a17:90b:380f:b0:1e0:aa6:9e24 with SMTP id
 mq15-20020a17090b380f00b001e00aa69e24mr15998545pjb.232.1653322647652; Mon, 23
 May 2022 09:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220523161520.354687-1-robert.foss@linaro.org>
In-Reply-To: <20220523161520.354687-1-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 18:17:16 +0200
Message-ID: <CAG3jFyv=9xPh58Z2BOA-_t2CCPR4TOM43VuhE-_0C2OOaoUHAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, maxime@cerno.tech,
        tzimmermann@suse.de, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 18:15, Robert Foss <robert.foss@linaro.org> wrote:
>
> This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.
>
> This patch depends on the patches just aplied to the media tree, and will
> not build without them, which leaves drm-misc-next in a broken state.
> Let's revert the two latter patches until rc1 has been branched,
> and rc1 has been backmerged into drm-misc-next.
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 0fab2aa47c67..e92eb4a40745 100644
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
> @@ -1641,8 +1641,8 @@ static int anx7625_parse_dt(struct device *dev,
>                 of_node_put(ep0);
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

Series applied to drm-misc-next.

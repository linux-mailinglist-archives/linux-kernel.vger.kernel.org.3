Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06625789D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiGRSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiGRSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:53:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD302613F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:53:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w12so16553539edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QQCeFWAFeeYdE8AjB15uv+68TOpyaBwb6vwqnHcmGmg=;
        b=OrKeVKLURvey9dO5WC2LaIReRqt7JeYxJsb/rxtAYnzaWF/YswmZK+RmgID5pk5hJ+
         kwlW7xQy+/+uWXFRS9wo4msdp85Hp6C34wrtXKeRwWMqUr2My1sj8+3e3bEjU7jVOQI1
         xktxra0gDL4AEWJ1Mdug6zemBkkhvI9b4OxuaHgQ36ncjSDTjolCYNKJJrsqyYmbuVQG
         fZFtl8bNT1l/QlkNJ4uo65jqgfe+NYJP34lF0uZ2bse8xDLKSOEkBBwhiWWd5f3qIVz7
         l8Ch2Ij6oDNz9+AFTY0Dqd851oN1jQu836XjaboYL3eT0qqK54oz20rGTXwlPP8zMCA7
         /IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QQCeFWAFeeYdE8AjB15uv+68TOpyaBwb6vwqnHcmGmg=;
        b=Q4XaTO8pCHYKrQ2H6Kstc8edPBmqBxy21iU0BACtonSZUOqmpO60eYrkgqte6Fs2mI
         SsmWu7t1DU+0q6vFhk5tcQZsMH1bP2a0116tHiv/muDd/j3RwPqlAa9QOFrUmt6u0CXI
         Jh8ZodHpVnsQx5xv+zGZ2LiE+apts5Gtr0HhKVSL0cCjsO3aT8WXhvnmGg7zVTDPE/AI
         FIyjQZ9SHpYlf98D438HZl2D2+bwIvWLH5hmuIGarJxzosWJAURrnIMqr6CQVN+2skaE
         DNEMN9t307UefXoQvbiLSTv3bzaxRW+yLWadnk+fD3NGO3EWlh37RF/w9hUZ6dNALI9N
         eDHw==
X-Gm-Message-State: AJIora8xhAXigIYbBN1CsRHQtz5SFtYvh9capoQ32KJJxGMyvwCMz5+s
        LWB6u8kSMR79YJZSpkL4YcvuRevAxuooPu2jZjo=
X-Google-Smtp-Source: AGRyM1vFm/q16yDnNmxPJrCn+CGhjdvi5dklwjRveBxeTxdUBq2J0ybUbYU2ZNuqC3neB0Opwn5rrTn1N/7NR2hhiTg=
X-Received: by 2002:a05:6402:2895:b0:43b:1e47:c132 with SMTP id
 eg21-20020a056402289500b0043b1e47c132mr32853099edb.425.1658170421073; Mon, 18
 Jul 2022 11:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net> <20220714164507.561751-3-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-3-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 18 Jul 2022 14:53:29 -0400
Message-ID: <CADnq5_NzUdMWL2Am6hPkZsthMu=ONPvb1Lu85v0f2PoqA5uWNw@mail.gmail.com>
Subject: Re: [PATCH 03/12] drm/amd/display: Remove unused clk_src variable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variable clk_src from the function dcn3_get_pix_clk_dividers.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1279:25: =
warning:
> variable 'clk_src' set but not used [-Wunused-but-set-variable]
>         struct dce110_clk_src *clk_src;
>                                ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 5cc7cc0b2f2d..d55da1ab1ac2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1276,9 +1276,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
>                 struct pll_settings *pll_settings)
>  {
>         unsigned long long actual_pix_clk_100Hz =3D pix_clk_params ? pix_=
clk_params->requested_pix_clk_100hz : 0;
> -       struct dce110_clk_src *clk_src;
>
> -       clk_src =3D TO_DCE110_CLK_SRC(cs);
>         DC_LOGGER_INIT();
>
>         if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
> --
> 2.36.1
>

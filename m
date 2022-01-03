Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB1483117
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiACMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiACMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:39:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06258C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F18B80EB0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52714C36AF2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641213572;
        bh=HA5+7zlAQulQBX2cVKSU6TdiKadRflwBDFVjRsvDYVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y0ULpnBT0g0UDp17/4EORGndRjm7el0EeYgKUeSEw83DwfhCNt1nMc1+vddEL5Ou7
         bPzt+l5Ubr4AcXtgbzR2BlVthJjHVIbjjiKVBipgSb/0/FHfUCBDf82E7v8kyjDZBE
         ZcAgfMZU7Rl9uu+KJt47Ia2y7TwZlhVvinjZFcNyEOGEzbHhuRs5I/GYS0bkHd2qGD
         QYC9v0gfS4sRqkaSPTb3u7JMcgYCecaocxSiV/Zz8/8hWZvtbp3CHPfXljS2yppNS9
         36MXQ0CNl6QApNUwd2jlQ/nf0pUHXluqKjC4asuvc/RdqAEofQgt5AEGU7t8AJdD6A
         D4KMOLZIpkoyw==
Received: by mail-ed1-f48.google.com with SMTP id q14so127614448edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:39:32 -0800 (PST)
X-Gm-Message-State: AOAM530IM65zHlbtyaBtqQW25I5GxEfoWy9KM8El/80FJosjCfv37oVF
        16/QCgTtLedMwhxjwLyxxY7txoL9yOUTAFu61w==
X-Google-Smtp-Source: ABdhPJwwZ/3BPywQvW5Rrs1+664TaJh3FdH4vjHV6vG9LTySPj2+KPJh8eExMszOptrw3vU1ySFcU2qa6PxV5c3PjyU=
X-Received: by 2002:a17:907:629a:: with SMTP id nd26mr37424097ejc.680.1641213570556;
 Mon, 03 Jan 2022 04:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20211022172413.195559-1-markyacoub@chromium.org> <20211229184420.793234-1-markyacoub@chromium.org>
In-Reply-To: <20211229184420.793234-1-markyacoub@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Jan 2022 20:39:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9E71AfKy_poZMA7s++TvzM4=VH0H1o8ZBmDphcz9iXDw@mail.gmail.com>
Message-ID: <CAAOTY_9E71AfKy_poZMA7s++TvzM4=VH0H1o8ZBmDphcz9iXDw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Set default value for Panel Orientation
 connector prop.
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark:

Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:44=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> [Why]
> Creating the prop uses UNKNOWN as the initial value, which is not a
> supported value if the prop is to be supported.
>
> [How]
> Set the panel orientation default value to NORMAL right after creating
> the prop if no DSI panel exists.
> Panels have their own orientations, and panel orientation can't be
> overriden once initialized to a value.
>
> v1:
> Set panel orientation only if DSI panel does not exist.
>
> Tested on Jacuzzi(MTK)
> Fixes IGT@kms_properties@get_properties-sanity-{atomic,non-atomic}
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0ad7157660afa..9d33dd93118e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1040,6 +1040,13 @@ static int mtk_dsi_encoder_init(struct drm_device =
*drm, struct mtk_dsi *dsi)
>                 goto err_cleanup_encoder;
>         }
>
> +       /* A drm_panel can have its own orientation. If there is no panel=
, set the
> +        * orientation to NORMAL. */
> +       if (!dsi->panel) {

Please send patch based on latest kernel version. In latest kernel
version, struct mtk_dsi{} has no member 'panel'.

Regards,
Chun-Kuang.

> +               drm_connector_set_panel_orientation(
> +                       dsi->connector, DRM_MODE_PANEL_ORIENTATION_NORMAL=
);
> +       }
> +
>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
>         return 0;
> --
> 2.34.1.448.ga2b2bfdf31-goog
>

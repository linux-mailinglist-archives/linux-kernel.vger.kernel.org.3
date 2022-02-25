Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7A4C42E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiBYK4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbiBYK4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:56:15 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E71DAC57
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:55:42 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso5778356ooi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kysMFOh8+xcDGXHPPVRwQiPaslPV5k2XuSftAh0IGXM=;
        b=PfiEhsRzmUlc1wRl7CP4cP59K9Lm7uNP+Beg+DIjXFCoCXFJ6hYi3zhDk33axm8PI7
         OX61MA/O4DZS/HoW6kOxIWkvBiMuwlsca/oj02T1KYHGmh7HU8j8l2wGRgmnrZyMrQLS
         kXxVXXDFw3y+zQ+iN14/BLSQrgMsQfSFvHpmNWi95tMVAQyK7aoxcrrPGVyot4GcrsHL
         HqOYh5V6/opTiE2A3eCCw6smo2gMJjIk+78lXh+jd0q4r6SgMWNjwP3t9C0e2BnAVkbd
         NezHGnBxkQSrkIL3dcWMZI3u7OAGkRKDtJNnWZ8R9MWQw71qfg1N3irCviYM2WYS1oUs
         FWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kysMFOh8+xcDGXHPPVRwQiPaslPV5k2XuSftAh0IGXM=;
        b=DqMnsyhT6K9XZNtU/KdHT4gaBCIALzd9QNhYuELjjiIIDNHNEMAGuJD7nJ1dGKfumI
         v2RA09HV6i6jY9yt+dlngSf/DFdxnhTK7jLguwD4Su7gNpFS6u/UPT033yI3/gEyz2dO
         ueefn4pQPqm/k3NQDalpbh1GKEkIaNvid2Q16Zf/s7xv69cq3XU6HxoWWDMMMzTXZwrU
         lMhhV2IAxOgka244dED/P5IwYSfAiVZFkexx9wcTGWoBx5+uCdllmiLgjZ1rn4EniNKE
         LKewioUzlK7lQrbRCLp7vLiLhh/GTCvHYoeYeQCKdWVLd/YEi29G1WXrf5T5HQtigF0k
         Nn9g==
X-Gm-Message-State: AOAM532dBAWkUw3dxjrNUSGeIBeIhEZXC+PbWkiryXnH0PlfsvfYz4Lq
        pRorYOhSzLlDTSBERE0PZIV+TRw7Tw2PXnKHDX+Lzjag9T8=
X-Google-Smtp-Source: ABdhPJyj6wu6NzHc7L+z5p9txi1s1uYfQozYWTw3yryTNIRQzg7lTSsRCXyXFdJgD2WTiJR3FSSONQVrrSY9I5VWBm8=
X-Received: by 2002:a4a:4112:0:b0:319:3eb2:11b with SMTP id
 x18-20020a4a4112000000b003193eb2011bmr2462193ooa.40.1645786542268; Fri, 25
 Feb 2022 02:55:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 02:55:41 -0800
MIME-Version: 1.0
In-Reply-To: <CAAOTY_-5g4fXVTOETDxbn2Cp3MVjFs-Sh9NT1NepfEXUhdJQEw@mail.gmail.com>
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-8-granquet@baylibre.com>
 <CAAOTY_-5g4fXVTOETDxbn2Cp3MVjFs-Sh9NT1NepfEXUhdJQEw@mail.gmail.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 02:55:41 -0800
Message-ID: <CABnWg9vOOcKsGqjZmakX3XrMhHcj5r23AUs77EnLR+xuw0Cg3g@mail.gmail.com>
Subject: Re: [PATCH v8 07/19] drm/mediatek: dpi: implement a swap_input toggle
 in board config
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, deller@gmx.de,
        CK Hu <ck.hu@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Kuang Hu (2022-02-21 03:32:32)
> Hi, Guillaume:
>
> Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Adds a bit of flexibility to support boards without swap_input support
> >
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 545a1337cc899..454f8563efae4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -126,6 +126,7 @@ struct mtk_dpi_conf {
> >         const u32 *output_fmts;
> >         u32 num_output_fmts;
> >         bool is_ck_de_pol;
> > +       bool swap_input_support;
> >         const struct mtk_dpi_yc_limit *limit;
> >  };
> >
> > @@ -378,18 +379,21 @@ static void mtk_dpi_config_color_format(struct mt=
k_dpi *dpi,
> >             (format =3D=3D MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
> >                 mtk_dpi_config_yuv422_enable(dpi, false);
> >                 mtk_dpi_config_csc_enable(dpi, true);
> > -               mtk_dpi_config_swap_input(dpi, false);
> > +               if (dpi->conf->swap_input_support)
> > +                       mtk_dpi_config_swap_input(dpi, false);
> >                 mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SW=
AP_BGR);
> >         } else if ((format =3D=3D MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
> >                    (format =3D=3D MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL))=
 {
> >                 mtk_dpi_config_yuv422_enable(dpi, true);
> >                 mtk_dpi_config_csc_enable(dpi, true);
> > -               mtk_dpi_config_swap_input(dpi, true);
> > +               if (dpi->conf->swap_input_support)
> > +                       mtk_dpi_config_swap_input(dpi, true);
>
> In MT8173, MT2701, MT8183, MT8192, YCBCR_444 would not swap but
> YCBCR_422 would swap. But In MT8195, both YCBCR_444 and YCBCR_422
> would not swap, So I think one of these format would be abnormal in
> MT8195, right? Or would you provide more information about how this
> swap work?
>
> Regards,
> Chun-Kuang.
>

I'm not sure I have access to that level of information... and my
knowledge on mediatek
SoC is rather limited, I will circle back with mediatek engineers to
have a definite
answer.

Thx,
Guillaume
> >                 mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SW=
AP_RGB);
> >         } else {
> >                 mtk_dpi_config_yuv422_enable(dpi, false);
> >                 mtk_dpi_config_csc_enable(dpi, false);
> > -               mtk_dpi_config_swap_input(dpi, false);
> > +               if (dpi->conf->swap_input_support)
> > +                       mtk_dpi_config_swap_input(dpi, false);
> >                 mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SW=
AP_RGB);
> >         }
> >  }
> > @@ -808,6 +812,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> >         .is_ck_de_pol =3D true,
> > +       .swap_input_support =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -819,6 +824,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> >         .is_ck_de_pol =3D true,
> > +       .swap_input_support =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -829,6 +835,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
> >         .output_fmts =3D mt8183_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
> >         .is_ck_de_pol =3D true,
> > +       .swap_input_support =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -839,6 +846,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> >         .is_ck_de_pol =3D true,
> > +       .swap_input_support =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > --
> > 2.34.1
> >

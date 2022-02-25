Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE044C42D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiBYKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiBYKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:53:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295EB18021C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:52:51 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id a6so6912852oid.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lCjS17RFbyRJS2Db4IElIeJl8aSxBOeolv8L7WEpzG0=;
        b=ZxA07RL3mMl2OYCEdKyZ7YMkP6PPrkqbudpFP/Xwrvm3gMcx3tUnhRYv8Yk3mK4v3d
         sc3DR0IdZD37Ua+cviUedxfolPE/qnsdmnqgBHPEpZC1+PgWDASxreISF1P1Ly2Uc/pI
         wggbKGlXSnIWxZJSha4EF2De/dnO0fCLvkz6P5M18Y1PdanigCXjdE+5vkwPuaUO+0B5
         i8GwmlHQgP4H8uSsxRwGBexOwkl/yUqMpcrbIrwN/4uQIhUr84KMQgf0PZk1BG66U7Jy
         YRXGtmHxLmxy1pPqCe3Dtw8ydk2F6cu08Bbhkq7CFcvZxkCQ/X+xb7KWbb1WGerxvfvP
         FsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lCjS17RFbyRJS2Db4IElIeJl8aSxBOeolv8L7WEpzG0=;
        b=29mQYJjIFHW7CLwrcMICOsFDuLZwwrVnyFisEyf1BCbdFtX/KkfYm4HkH/wCTwkqsl
         7Djz0aWOIqNA/jupKUQW5KBRgHB8uYIJS03aEG3VInRYTXJHE0+pNRUuvIsKo75fjgvr
         3h3fnezRN8qEoZ1S28tICV5uuk1sONnrt9AbNCSiJ6j4cWUdJ+2l87c1W9jRrnDCIEh1
         eLPFgrEvgpoQ8pllrKqLizO583JJ+5EQM5qTo6HVs0I4M+36vX+4NkIENeLXykCoec6n
         elhMXOpSNhwq+KbP4aNoF0oRpoujL9/Xhdfs0e4/zh3vzYS7NvKUlDjTUKZMBJuwTLiX
         TAPQ==
X-Gm-Message-State: AOAM530Ke/vn4fnl+u2T/DK5wSX6itkre3Bokj1Ny4NqDjUMUm81/UzV
        UPDn+/KfQopmmnGhLVF9bf0CaUjPQnefWs18N9cCCg==
X-Google-Smtp-Source: ABdhPJyteHJVXwqtREl4MhJz0dVR/k/rAMxVv+BnqtMnsqQSFUKqWOGlNhrZlPQ9P1vmHV6UVPKJuCBvnsGagSVbgHg=
X-Received: by 2002:aca:1b13:0:b0:2d4:b033:450 with SMTP id
 b19-20020aca1b13000000b002d4b0330450mr1231170oib.214.1645786370409; Fri, 25
 Feb 2022 02:52:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 02:52:49 -0800
MIME-Version: 1.0
In-Reply-To: <CAAOTY__AgD_Rc_5TS4v+sBDeN-nd0DbwuERhW=OsvsbMWSsxsA@mail.gmail.com>
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-7-granquet@baylibre.com>
 <CAAOTY__AgD_Rc_5TS4v+sBDeN-nd0DbwuERhW=OsvsbMWSsxsA@mail.gmail.com>
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 02:52:49 -0800
Message-ID: <CABnWg9uUDH7Vo-=HTSjS7HRfdo=SQPk43ujT=jh5Q+VhAA2Hag@mail.gmail.com>
Subject: Re: [PATCH v8 06/19] drm/mediatek: dpi: implement a CK/DE pol toggle
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

Quoting Chun-Kuang Hu (2022-02-21 03:14:02)
> HI, Guillaume:
>
> Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Adds a bit of flexibility to support boards without CK/DE pol support
>
> I'm not sure what the term 'board' mean. Do you mean different board
> with different panel but all with mt8195-dpintf? If so, you should get
> CK/DE support from panel driver not fix this information in dpi
> driver.
>
> Regards,
> Chun-Kuang.
>

Hi Chun-Kuang,

The correct term (as pointed by Angelo) would be 'SoC' instead of
'board' I guess.
My understanding is that every SoC might have or might not have CK/DE suppo=
rt.


I'll try to dig into the documentation I have to understand exactly
where this support
is coming from.

Thx,
Guillaume.

> >
> > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index 4746eb3425674..545a1337cc899 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
> >         bool edge_sel_en;
> >         const u32 *output_fmts;
> >         u32 num_output_fmts;
> > +       bool is_ck_de_pol;
> >         const struct mtk_dpi_yc_limit *limit;
> >  };
> >
> > @@ -211,13 +212,20 @@ static void mtk_dpi_config_pol(struct mtk_dpi *dp=
i,
> >                                struct mtk_dpi_polarities *dpi_pol)
> >  {
> >         unsigned int pol;
> > +       unsigned int mask;
> >
> > -       pol =3D (dpi_pol->ck_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : C=
K_POL) |
> > -             (dpi_pol->de_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : DE_=
POL) |
> > -             (dpi_pol->hsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : =
HSYNC_POL) |
> > +       mask =3D HSYNC_POL | VSYNC_POL;
> > +       pol =3D (dpi_pol->hsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 =
: HSYNC_POL) |
> >               (dpi_pol->vsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : =
VSYNC_POL);
> > -       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol,
> > -                    CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
> > +       if (dpi->conf->is_ck_de_pol) {
> > +               mask |=3D CK_POL | DE_POL;
> > +               pol |=3D (dpi_pol->ck_pol =3D=3D MTK_DPI_POLARITY_RISIN=
G ?
> > +                       0 : CK_POL) |
> > +                      (dpi_pol->de_pol =3D=3D MTK_DPI_POLARITY_RISING =
?
> > +                       0 : DE_POL);
> > +       }
> > +
> > +       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol, mask);
> >  }
> >
> >  static void mtk_dpi_config_3d(struct mtk_dpi *dpi, bool en_3d)
> > @@ -799,6 +807,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
> >         .max_clock_khz =3D 300000,
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> > +       .is_ck_de_pol =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -809,6 +818,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
> >         .max_clock_khz =3D 150000,
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> > +       .is_ck_de_pol =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -818,6 +828,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
> >         .max_clock_khz =3D 100000,
> >         .output_fmts =3D mt8183_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
> > +       .is_ck_de_pol =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > @@ -827,6 +838,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
> >         .max_clock_khz =3D 150000,
> >         .output_fmts =3D mt8173_output_fmts,
> >         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> > +       .is_ck_de_pol =3D true,
> >         .limit =3D &mtk_dpi_limit,
> >  };
> >
> > --
> > 2.34.1
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7034BD392
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbiBUCOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:14:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiBUCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:14:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441BD3204F;
        Sun, 20 Feb 2022 18:14:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E230FB80E3B;
        Mon, 21 Feb 2022 02:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8978EC340F0;
        Mon, 21 Feb 2022 02:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645409656;
        bh=pV8SFKuHUgpAlxXGX/qRMPIw+Kd4bEx8SviHAJcdS/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YiyRpZrPApxVaNDYIvavOjHmK/p4DUAeK7+Tqr9SzP0O7Yfgnjvuyw8qO1REi2RDD
         Phy4Kuly9XfumICficyiVzBcfe/DaRvSiBTX5u/ENtDXdOdFwDWa5ljj6iof4IHs9j
         PwvNupG/A7W8SaN6+pszjxxkNm8ps6klra5cJ94zW1ndONy6OZGOcI6eRR5GkCd54r
         TBwzSdQ+0+zHV/LZEIDpRdVda2/o8kkRB4Cb6OrQhSlr/rV2QP+6PSS21vq1KntrxN
         8YPmtWnLOQQeZjWZ9WtmB9BjdwBDBZ2IFScLqyyer+sDrFL3TwFAkQb64Wcof6TbnV
         Xijrjmx0NtcSg==
Received: by mail-ej1-f48.google.com with SMTP id p14so29128045ejf.11;
        Sun, 20 Feb 2022 18:14:16 -0800 (PST)
X-Gm-Message-State: AOAM533XQAkVLQq7L1VT+Sky+M7B2QsBTKdDDYKVOsMTZI6sn2qDYI39
        PSeCyC+QeRazSfk5u5G5TtAHwVbwnuQ1NAqQMQ==
X-Google-Smtp-Source: ABdhPJzuzbcKzGVGYsB6r6h/Y3EsbKgrTgOGjhQohSFx5+ar+PHYzw42VipVTgZDJCfjawuEm8YsH/Nvkb+0+E4tzns=
X-Received: by 2002:a17:906:a20c:b0:6ce:a87e:5013 with SMTP id
 r12-20020a170906a20c00b006cea87e5013mr13673365ejy.379.1645409654814; Sun, 20
 Feb 2022 18:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-7-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-7-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Feb 2022 10:14:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__AgD_Rc_5TS4v+sBDeN-nd0DbwuERhW=OsvsbMWSsxsA@mail.gmail.com>
Message-ID: <CAAOTY__AgD_Rc_5TS4v+sBDeN-nd0DbwuERhW=OsvsbMWSsxsA@mail.gmail.com>
Subject: Re: [PATCH v8 06/19] drm/mediatek: dpi: implement a CK/DE pol toggle
 in board config
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Guillaume:

Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Adds a bit of flexibility to support boards without CK/DE pol support

I'm not sure what the term 'board' mean. Do you mean different board
with different panel but all with mt8195-dpintf? If so, you should get
CK/DE support from panel driver not fix this information in dpi
driver.

Regards,
Chun-Kuang.

>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 4746eb3425674..545a1337cc899 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -125,6 +125,7 @@ struct mtk_dpi_conf {
>         bool edge_sel_en;
>         const u32 *output_fmts;
>         u32 num_output_fmts;
> +       bool is_ck_de_pol;
>         const struct mtk_dpi_yc_limit *limit;
>  };
>
> @@ -211,13 +212,20 @@ static void mtk_dpi_config_pol(struct mtk_dpi *dpi,
>                                struct mtk_dpi_polarities *dpi_pol)
>  {
>         unsigned int pol;
> +       unsigned int mask;
>
> -       pol =3D (dpi_pol->ck_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : CK_=
POL) |
> -             (dpi_pol->de_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : DE_PO=
L) |
> -             (dpi_pol->hsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : HS=
YNC_POL) |
> +       mask =3D HSYNC_POL | VSYNC_POL;
> +       pol =3D (dpi_pol->hsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : =
HSYNC_POL) |
>               (dpi_pol->vsync_pol =3D=3D MTK_DPI_POLARITY_RISING ? 0 : VS=
YNC_POL);
> -       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol,
> -                    CK_POL | DE_POL | HSYNC_POL | VSYNC_POL);
> +       if (dpi->conf->is_ck_de_pol) {
> +               mask |=3D CK_POL | DE_POL;
> +               pol |=3D (dpi_pol->ck_pol =3D=3D MTK_DPI_POLARITY_RISING =
?
> +                       0 : CK_POL) |
> +                      (dpi_pol->de_pol =3D=3D MTK_DPI_POLARITY_RISING ?
> +                       0 : DE_POL);
> +       }
> +
> +       mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING, pol, mask);
>  }
>
>  static void mtk_dpi_config_3d(struct mtk_dpi *dpi, bool en_3d)
> @@ -799,6 +807,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
>         .max_clock_khz =3D 300000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .is_ck_de_pol =3D true,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -809,6 +818,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .is_ck_de_pol =3D true,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -818,6 +828,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .max_clock_khz =3D 100000,
>         .output_fmts =3D mt8183_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8183_output_fmts),
> +       .is_ck_de_pol =3D true,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -827,6 +838,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .max_clock_khz =3D 150000,
>         .output_fmts =3D mt8173_output_fmts,
>         .num_output_fmts =3D ARRAY_SIZE(mt8173_output_fmts),
> +       .is_ck_de_pol =3D true,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> --
> 2.34.1
>

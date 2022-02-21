Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD24BD43D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbiBUDce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:32:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbiBUDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:32:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D313AA6D;
        Sun, 20 Feb 2022 19:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44196B80E54;
        Mon, 21 Feb 2022 03:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E54C340F8;
        Mon, 21 Feb 2022 03:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645414328;
        bh=sVhTO4V/J+PBVK3PUU1n0L77FQqMLHWUGIXArEdj6Hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GrD9MsKVlxEEDL6YmRcPwp1WtAR+T+rIyZTHF1CRY04eR8LXrlB02NUF1pXyWeva9
         5+bPDk8Htz7TGyTF7naW6y4YY2ps5lVMosh+PciDL4VwstgIuZ0pS/jSQg+hZ5ETIV
         jfqps4qQfhS0yU5TWm2boGxpRb7r0bGlWoyh2dRBZ1aoug6LKaQaw0O4wdHkImTsKV
         BCL9C0GqgFKiiQZZNd1mChx/AIRVKvbf4J41AcePt+JyjjXTib+HG6tfJTR/r8+Zm/
         q8rk62pXdWamoXkxXrqpN3yoLnEf07KXBg1tngNh0qY0ooeVXirAo/SC+dm4/bKk6C
         o4Py35ISBI++w==
Received: by mail-ej1-f50.google.com with SMTP id r13so6551245ejd.5;
        Sun, 20 Feb 2022 19:32:07 -0800 (PST)
X-Gm-Message-State: AOAM531/qvwqKE/0bVTdzMB2tnJXfBNwA1fXoSftBwK/726Jh3akWDug
        C8AfZRiuJlvWgye5bdFZEACktjEgjUv7vaIbUw==
X-Google-Smtp-Source: ABdhPJxfxo0hzxeTqTccLlT0ltYFEr2mGzS6xuefZo7jwVZH88S6M6qDz0iPDAFl7ugWQnJtM4+isexDKT36CBTSYE8=
X-Received: by 2002:a17:906:2a11:b0:69f:286a:66a7 with SMTP id
 j17-20020a1709062a1100b0069f286a66a7mr14319822eje.680.1645414326327; Sun, 20
 Feb 2022 19:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20220218145437.18563-1-granquet@baylibre.com> <20220218145437.18563-12-granquet@baylibre.com>
In-Reply-To: <20220218145437.18563-12-granquet@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Feb 2022 11:31:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Bqo+1JoVJdk7eUEoW3B4ZKhzhuvFEqxxGxweQkQBbKA@mail.gmail.com>
Message-ID: <CAAOTY_-Bqo+1JoVJdk7eUEoW3B4ZKhzhuvFEqxxGxweQkQBbKA@mail.gmail.com>
Subject: Re: [PATCH v8 11/19] drm/mediatek: dpi: move the yuv422_en_bit to
 board config
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

Hi, Guillaume:

Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2022=E5=B9=B42=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add flexibility by moving the yuv422 en bit to board config

After replace 'board' with 'SoC',

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index ec221e24e0fee..fcf88dcd8b89d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -132,6 +132,7 @@ struct mtk_dpi_conf {
>         // Mask used for HSIZE and VSIZE (no shift)
>         u32 hvsize_mask;
>         u32 channel_swap_shift;
> +       u32 yuv422_en_bit;
>         const struct mtk_dpi_yc_limit *limit;
>  };
>
> @@ -356,7 +357,8 @@ static void mtk_dpi_config_channel_swap(struct mtk_dp=
i *dpi,
>
>  static void mtk_dpi_config_yuv422_enable(struct mtk_dpi *dpi, bool enabl=
e)
>  {
> -       mtk_dpi_mask(dpi, DPI_CON, enable ? YUV422_EN : 0, YUV422_EN);
> +       mtk_dpi_mask(dpi, DPI_CON, enable ? dpi->conf->yuv422_en_bit : 0,
> +                    dpi->conf->yuv422_en_bit);
>  }
>
>  static void mtk_dpi_config_csc_enable(struct mtk_dpi *dpi, bool enable)
> @@ -824,6 +826,7 @@ static const struct mtk_dpi_conf mt8173_conf =3D {
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
>         .channel_swap_shift =3D CH_SWAP,
> +       .yuv422_en_bit =3D YUV422_EN,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -839,6 +842,7 @@ static const struct mtk_dpi_conf mt2701_conf =3D {
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
>         .channel_swap_shift =3D CH_SWAP,
> +       .yuv422_en_bit =3D YUV422_EN,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -853,6 +857,7 @@ static const struct mtk_dpi_conf mt8183_conf =3D {
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
>         .channel_swap_shift =3D CH_SWAP,
> +       .yuv422_en_bit =3D YUV422_EN,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> @@ -867,6 +872,7 @@ static const struct mtk_dpi_conf mt8192_conf =3D {
>         .dimension_mask =3D HPW_MASK,
>         .hvsize_mask =3D HSIZE_MASK,
>         .channel_swap_shift =3D CH_SWAP,
> +       .yuv422_en_bit =3D YUV422_EN,
>         .limit =3D &mtk_dpi_limit,
>  };
>
> --
> 2.34.1
>

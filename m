Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2F49FDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350027AbiA1QTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:19:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33990 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiA1QTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:19:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73507B80D74;
        Fri, 28 Jan 2022 16:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EDFC340EB;
        Fri, 28 Jan 2022 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643386754;
        bh=fD5y5+RxVxJbAjwnRL0Gcjwy+JCQgKkKiJKWB/hr9ZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pLdiMamXFvznn4sfU/OlT6PQxSNkbq+I43t+cnGnSl7rkHbBeeBrS4xj5vw5Wwier
         ibfbYtHEtY571/HHJfN5HYd1lYYQCy0xeeBHSHv3oJ02Xb9RfGwXEVnNij4EVuCjIA
         VMD/Qymv6iZSHwLAQn17GO/tVfVeYZxDhRvjraH7Oorby/URhtViJzsCzZfsyUkZk/
         WXVK267uhRyS018W5FNSQwgipjO7fFvLZgnQcnmwfpXhiOzebPUK35NKyyyBIPh6oW
         3waTT2LyyiVQ1xhjTasJt5hBl3prjkaTvsgk0djjvr0Q/xSWeuslNX+ITRPx1NFx/m
         f3YEZLInNlHew==
Received: by mail-ej1-f54.google.com with SMTP id me13so17586900ejb.12;
        Fri, 28 Jan 2022 08:19:14 -0800 (PST)
X-Gm-Message-State: AOAM530P1Btmz1YVAptQ1+vmbM47o1B2vDb1QdYaWMLOLT6qOGMVw9eO
        IXqCVsvDtL6Lyf9ICA9ZLoN7Nk4/AU2C2i8wsw==
X-Google-Smtp-Source: ABdhPJzaVNhN4Lp5kRT0pDrdXP2bqgeUBcLYAhm9wcVbdADCPGfdi9izUodQ5zDtyd7TY5wC8q/EJOif3CkwqnT/Bp0=
X-Received: by 2002:a17:907:a089:: with SMTP id hu9mr7617781ejc.680.1643386752416;
 Fri, 28 Jan 2022 08:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20220128120718.30545-1-yongqiang.niu@mediatek.com> <20220128120718.30545-5-yongqiang.niu@mediatek.com>
In-Reply-To: <20220128120718.30545-5-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 29 Jan 2022 00:19:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8uF1TY9TsP3wUW6gw9M21F9Op9wRc9GDX7edbSa8sQeQ@mail.gmail.com>
Message-ID: <CAAOTY_8uF1TY9TsP3wUW6gw9M21F9Op9wRc9GDX7edbSa8sQeQ@mail.gmail.com>
Subject: Re: [PATCH v1, 4/4] drm/mediatek: add mt8186 display support
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:07=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 6efb423ccc92..754b1be25d0d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -158,6 +158,24 @@ static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext=
[] =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> +static const enum mtk_ddp_comp_id mt8186_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_POSTMASK0,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DSI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt8186_mtk_ddp_ext[] =3D {
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_DPI0,
> +};
> +
>  static const enum mtk_ddp_comp_id mt8192_mtk_ddp_main[] =3D {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
> @@ -221,6 +239,13 @@ static const struct mtk_mmsys_driver_data mt8183_mms=
ys_driver_data =3D {
>         .ext_len =3D ARRAY_SIZE(mt8183_mtk_ddp_ext),
>  };
>
> +static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data =3D {
> +       .main_path =3D mt8186_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt8186_mtk_ddp_main),
> +       .ext_path =3D mt8186_mtk_ddp_ext,
> +       .ext_len =3D ARRAY_SIZE(mt8186_mtk_ddp_ext),
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
>         .main_path =3D mt8192_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt8192_mtk_ddp_main),
> @@ -463,6 +488,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8183-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
> +       { .compatible =3D "mediatek,mt8186-disp-mutex",
> +         .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8192-disp-mutex",
>           .data =3D (void *)MTK_DISP_MUTEX },
>         { .compatible =3D "mediatek,mt8173-disp-od",
> @@ -475,14 +502,20 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8183-disp-ovl",
>           .data =3D (void *)MTK_DISP_OVL },
> +       { .compatible =3D "mediatek,mt8186-disp-ovl",

Add "mediatek,mt8186-disp-ovl" to binding document.

> +         .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8192-disp-ovl",
>           .data =3D (void *)MTK_DISP_OVL },
>         { .compatible =3D "mediatek,mt8183-disp-ovl-2l",
>           .data =3D (void *)MTK_DISP_OVL_2L },
> +       { .compatible =3D "mediatek,mt8186-disp-ovl-2l",

Ditto.

> +         .data =3D (void *)MTK_DISP_OVL_2L },
>         { .compatible =3D "mediatek,mt8192-disp-ovl-2l",
>           .data =3D (void *)MTK_DISP_OVL_2L },
>         { .compatible =3D "mediatek,mt8192-disp-postmask",
>           .data =3D (void *)MTK_DISP_POSTMASK },
> +       { .compatible =3D "mediatek,mt8186-disp-postmask",

Ditto.

> +         .data =3D (void *)MTK_DISP_POSTMASK},
>         { .compatible =3D "mediatek,mt2701-disp-pwm",
>           .data =3D (void *)MTK_DISP_BLS },
>         { .compatible =3D "mediatek,mt8167-disp-pwm",
> @@ -511,12 +544,16 @@ static const struct of_device_id mtk_ddp_comp_dt_id=
s[] =3D {
>           .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt8183-dpi",
>           .data =3D (void *)MTK_DPI },
> +       { .compatible =3D "mediatek,mt8186-dpi",

Ditto.

> +         .data =3D (void *)MTK_DPI },
>         { .compatible =3D "mediatek,mt2701-dsi",
>           .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt8173-dsi",
>           .data =3D (void *)MTK_DSI },
>         { .compatible =3D "mediatek,mt8183-dsi",
>           .data =3D (void *)MTK_DSI },
> +       { .compatible =3D "mediatek,mt8186-dsi",

Ditto.

Regards,
Chun-Kuang.

> +         .data =3D (void *)MTK_DSI },
>         { }
>  };
>
> @@ -533,6 +570,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8173_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8183-mmsys",
>           .data =3D &mt8183_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt8186-mmsys",
> +         .data =3D &mt8186_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8192-mmsys",
>           .data =3D &mt8192_mmsys_driver_data},
>         { }
> --
> 2.25.1
>

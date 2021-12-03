Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83983466E50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbhLCAK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:10:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32868 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhLCAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AE9B82570;
        Fri,  3 Dec 2021 00:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F7CC53FD5;
        Fri,  3 Dec 2021 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638490018;
        bh=hUUGmi1Kxjg4GVMJJk27j4s8CR+5/UrEzujzqqM7DVc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lODZkcZ6BvnOCz4O6iIV8krAEhmKF9YU38giD5x/tcmBjHGC3UagRE9v+yFJwvKCg
         vj6BIa+dluXsClTi/MxisQBtIOISTtvwatHIfILWRDwS17zmq05s5SQqKHNHB4nvNG
         J5JxyfEG+BRwHjpfqF4Hxj4PRPsQ/AbshzYRawqO+P4dJhXlv19pa/4EHR4XseSRsA
         B3ObZEF8xI3U7IwT6l9AUu8peIJdLqzRkud5+SUOpKyn0T+TEhwHhMaynBvaFn8xRq
         6BH/qAfQJ+saTZr6CJWlVOqGhYAWlwJ9fMb4Z8wNYSVxzyALMQZfhrwdwnNdYOdvcF
         dGzEVF5XoTayQ==
Received: by mail-ed1-f54.google.com with SMTP id y12so4359351eda.12;
        Thu, 02 Dec 2021 16:06:58 -0800 (PST)
X-Gm-Message-State: AOAM533T36jn6E+O4qP/th9ASEvUqdQ6IVX+6TU+AoaJiKhJ/KF0z+M/
        1PAiVR9GtU3Nd19/aX3cHcOJePCGlt8JTWNK8Q==
X-Google-Smtp-Source: ABdhPJy/vfyFg8Uq9KjiNMxw9kzU+8NVCXfS+xyKdO85QAO1nUO0e3tnO/OopVm4P79WiTBhXyFZoO0samMN/lsdoo4=
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr19657908ejc.388.1638490017099;
 Thu, 02 Dec 2021 16:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20211129184439.16892-1-jason-jh.lin@mediatek.com> <20211129184439.16892-11-jason-jh.lin@mediatek.com>
In-Reply-To: <20211129184439.16892-11-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 3 Dec 2021 08:06:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-edo+HagSJPxgFyYT2itXk4isbY=fnd=o6YO8kx0Ms=g@mail.gmail.com>
Message-ID: <CAAOTY_-edo+HagSJPxgFyYT2itXk4isbY=fnd=o6YO8kx0Ms=g@mail.gmail.com>
Subject: Re: [PATCH v13 10/15] drm/mediatek: remove unused define in mtk_drm_ddp_comp.c
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>, roy-cw.yeh@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B411=E6=9C=88=
30=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:44=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Remove the unsed define in mtk_drm_ddp_comp.c

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 3704e4b7f3c5..7d3bd6214c15 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -21,8 +21,6 @@
>  #include "mtk_drm_crtc.h"
>
>  #define DISP_OD_EN                             0x0000
> -#define DISP_OD_INTEN                          0x0008
> -#define DISP_OD_INTSTA                         0x000c
>  #define DISP_OD_CFG                            0x0020
>  #define DISP_OD_SIZE                           0x0030
>  #define DISP_DITHER_5                          0x0114
> @@ -39,26 +37,18 @@
>  #define DITHER_ENGINE_EN                       BIT(1)
>  #define DISP_DITHER_SIZE                       0x0030
>
> -#define LUT_10BIT_MASK                         0x03ff
> -
>  #define OD_RELAYMODE                           BIT(0)
>
>  #define UFO_BYPASS                             BIT(2)
>
>  #define DISP_DITHERING                         BIT(2)
>  #define DITHER_LSB_ERR_SHIFT_R(x)              (((x) & 0x7) << 28)
> -#define DITHER_OVFLW_BIT_R(x)                  (((x) & 0x7) << 24)
>  #define DITHER_ADD_LSHIFT_R(x)                 (((x) & 0x7) << 20)
> -#define DITHER_ADD_RSHIFT_R(x)                 (((x) & 0x7) << 16)
>  #define DITHER_NEW_BIT_MODE                    BIT(0)
>  #define DITHER_LSB_ERR_SHIFT_B(x)              (((x) & 0x7) << 28)
> -#define DITHER_OVFLW_BIT_B(x)                  (((x) & 0x7) << 24)
>  #define DITHER_ADD_LSHIFT_B(x)                 (((x) & 0x7) << 20)
> -#define DITHER_ADD_RSHIFT_B(x)                 (((x) & 0x7) << 16)
>  #define DITHER_LSB_ERR_SHIFT_G(x)              (((x) & 0x7) << 12)
> -#define DITHER_OVFLW_BIT_G(x)                  (((x) & 0x7) << 8)
>  #define DITHER_ADD_LSHIFT_G(x)                 (((x) & 0x7) << 4)
> -#define DITHER_ADD_RSHIFT_G(x)                 (((x) & 0x7) << 0)
>
>  #define DISP_POSTMASK_EN                       0x0000
>  #define POSTMASK_EN                                    BIT(0)
> --
> 2.18.0
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266584943CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbiASXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:19:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56328 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiASXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9228BB81C34
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C57CC340EF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642634361;
        bh=/VsvxrK8zyc2yNu4lRcxY8d4fLjYuopTGzFBWIpaZuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WIzZvK3GtHo1SKGL3nZdobAbhHjEPpNeTEfI34CqWXsYRIBuTAruaBZVRj8jcx1Ds
         Y5H5up3k8FgNKOZSpqmDHRlwA4WRfNB8G9XLg0iwICGdDflSawqY+nCV3QY5z9MHVj
         JD313HNVbb+cF0UwToqBEv3Q8ktX1Xy7AEo3wojE/In9rIAbhSyFAn8N90R9qmHuD/
         pGNJsvYU0cD51Ig65oCM1IOfcyBf9uJqeoYzJabOulkddlDz6PHGOMvV320YwxVjOh
         t+116mj9rKdAeAFuce02xdM23Ln1eKKm3lAoxg6cd89Nz4ilJev+5lmaBO4Aldcok7
         QtlizF6lLYTGw==
Received: by mail-ed1-f49.google.com with SMTP id m4so20443310edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 15:19:21 -0800 (PST)
X-Gm-Message-State: AOAM530pDDPOtYakiFm8gl/QWwDA6OvCR3keC2O/PQSWMWqeKRvN+wNV
        tolSYq/+l2a9UFquLGB82ZvQ4GiaDjq+TcoNQA==
X-Google-Smtp-Source: ABdhPJwC0NWnP7oymINNszu43Ouc3/FDCJmqCWPyJrv0Hx/yq+CETJQGIdgZZ3LK4mRd6SWiVqRx6NjLUZo8svP5CpY=
X-Received: by 2002:a17:906:6c1:: with SMTP id v1mr25764169ejb.638.1642634359331;
 Wed, 19 Jan 2022 15:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20220119022543.26093-1-rex-bc.chen@mediatek.com> <20220119022543.26093-3-rex-bc.chen@mediatek.com>
In-Reply-To: <20220119022543.26093-3-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 20 Jan 2022 07:19:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY__xbhyOaL-4BZP0n_HdvYz3f6SZzh-WSw-gVv=Yufjy8A@mail.gmail.com>
Message-ID: <CAAOTY__xbhyOaL-4BZP0n_HdvYz3f6SZzh-WSw-gVv=Yufjy8A@mail.gmail.com>
Subject: Re: [v10,2/3] drm/mediatek: implement the DSI HS packets aligned
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>, andrzej.hajda@intel.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xin Ji <xji@analogixsemi.com>,
        Jitao Shi <jitao.shi@mediatek.com>, xinlei.lee@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Some DSI RX devices (for example, anx7625) require last alignment of
> packets on all lanes after each row of data is sent.
> Otherwise, there will be some issues of shift or scroll for screen.
>
> Take horizontal_sync_active_byte for a example,
> we roundup the HSA packet data to lane number, and the subtraction of 2
> is the packet data value added by the roundup operation, making the
> long packets are integer multiples of lane number.
> This value (2) varies with the lane number, and that is the reason we
> do this operation when the lane number is 4.
>
> In the previous operation of function "mtk_dsi_config_vdo_timing",
> the length of HSA and HFP data packets has been adjusted to an
> integration multiple of lane number.
> Since the number of RGB data packets cannot be guaranteed to be an
> integer multiple of lane number, we modify the data packet length of
> HBP so that the number of HBP + RGB is equal to the lane number.
> So after sending a line of data (HSA + HBP + RGB + HFP), the data
> lanes are aligned.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 5d90d2eb0019..e91b3fff4342 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -500,6 +500,18 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi=
 *dsi)
>                 DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\=
n");
>         }
>
> +       if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
> +           (dsi->lanes =3D=3D 4)) {
> +               horizontal_sync_active_byte =3D
> +                       roundup(horizontal_sync_active_byte, dsi->lanes) =
- 2;
> +               horizontal_frontporch_byte =3D
> +                       roundup(horizontal_frontporch_byte, dsi->lanes) -=
 2;
> +               horizontal_backporch_byte =3D
> +                       roundup(horizontal_backporch_byte, dsi->lanes) - =
2;
> +               horizontal_backporch_byte -=3D
> +                       (vm->hactive * dsi_tmp_buf_bpp + 2) % dsi->lanes;
> +       }
> +
>         writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>         writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
> --
> 2.18.0
>

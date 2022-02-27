Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4629F4C5926
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiB0Dei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiB0Deh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:34:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530B3DDC4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF1C0B80990
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D65C340F4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645932836;
        bh=sINlhUUL3qCCKmllNYIAS6L68awhHaZWumjFZmCkwbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xch1FdbxJomskcGYC0j6vWmaDDUZOoXVKnF0kkvPmVKl/HSsVj5IJVwQSsxNYen12
         zuPpmG9Irkh8aFI0Oo3rVSJIzs5xrkZtZIDJtoYONSovlJrjgERqaK0ZdpsQxRBGwn
         g5ZAIFAb2AAOGwG3l4ltj0tmYCJ+uYQAYNKSGFl4mH9ssHzfv8YuqeL4Yj9IFMMCJk
         TEHwR7xEDAX2YGY+qY2lTfoRFUkb47EOJ/X0NkUAuYpLvi37Pe9hlezfEQ5hxqfRAL
         vLgYb9Lb1/Thp2xDCPh+T01Xd5VujOpGJDmW0EEvVAo5ZJ+Ob8t41Fb6s54eQw0jHQ
         z6ZW/M2QrzZmw==
Received: by mail-ed1-f45.google.com with SMTP id g20so12748646edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:33:56 -0800 (PST)
X-Gm-Message-State: AOAM5337SSXKYfQPQh9w+DSU1uTB+/PxciknCyUlBjoXLv2bbOTgYQvn
        qUcdh/QehTnCIVz8maVxezOcziE1O9mGtRg4DQ==
X-Google-Smtp-Source: ABdhPJzAW6ryJztkKzpfOTbync3l10BoeisdAaTfjrRVJU3ASVjUgrEdyRhZQiMi8L3zCpy9UZ4Vsf9dVHrFb92NAyo=
X-Received: by 2002:aa7:d415:0:b0:410:a0fa:dc40 with SMTP id
 z21-20020aa7d415000000b00410a0fadc40mr13507630edq.46.1645932834417; Sat, 26
 Feb 2022 19:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20211202064039.20797-1-jason-jh.lin@mediatek.com> <20211202064039.20797-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20211202064039.20797-3-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 27 Feb 2022 11:33:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY__rnVMRB=OhkTm4Ojh31yAcYwCQTBGozpGsnC_oC_jqvQ@mail.gmail.com>
Message-ID: <CAAOTY__rnVMRB=OhkTm4Ojh31yAcYwCQTBGozpGsnC_oC_jqvQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/mediatek: add devlink to cmdq dev
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com
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

Hi, Jason:

Build error:

../drivers/gpu/drm/mediatek/mtk_drm_crtc.c: In function =E2=80=98mtk_drm_cr=
tc_create=E2=80=99:
../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:902:26: error: =E2=80=98struct
mtk_drm_private=E2=80=99 has no member named =E2=80=98dev=E2=80=99
  mtk_crtc->drm_dev =3D priv->dev;
                          ^
../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:974:30: error: =E2=80=98struct
mtk_drm_private=E2=80=99 has no member named =E2=80=98dev=E2=80=99
   link =3D device_link_add(priv->dev, mtk_crtc->cmdq_client.chan->mbox->de=
v,
                              ^
In file included from ../include/linux/device.h:15:0,
                 from ../include/linux/dma-mapping.h:7,
                 from ../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:7:
../drivers/gpu/drm/mediatek/mtk_drm_crtc.c:977:16: error: =E2=80=98struct
mtk_drm_private=E2=80=99 has no member named =E2=80=98dev=E2=80=99
    dev_err(priv->dev, "Unable to link dev=3D%s\n",
                ^
Regards,
Chun-Kuang.

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=88=
2=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:41=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add devlink to cmdq to make sure the order of suspend and resume
> is correct.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 43 ++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 0b4012335e7a..612d1d69c16c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -60,6 +60,7 @@ struct mtk_drm_crtc {
>  #endif
>
>         struct device                   *mmsys_dev;
> +       struct device                   *drm_dev;
>         struct mtk_mutex                *mutex;
>         unsigned int                    ddp_comp_nr;
>         struct mtk_ddp_comp             **ddp_comp;
> @@ -159,6 +160,7 @@ static void mtk_drm_crtc_destroy(struct drm_crtc *crt=
c)
>         mtk_drm_cmdq_pkt_destroy(&mtk_crtc->cmdq_handle);
>
>         if (mtk_crtc->cmdq_client.chan) {
> +               device_link_remove(mtk_crtc->drm_dev, mtk_crtc->cmdq_clie=
nt.chan->mbox->dev);
>                 mbox_free_channel(mtk_crtc->cmdq_client.chan);
>                 mtk_crtc->cmdq_client.chan =3D NULL;
>         }
> @@ -902,6 +904,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                 return -ENOMEM;
>
>         mtk_crtc->mmsys_dev =3D priv->mmsys_dev;
> +       mtk_crtc->drm_dev =3D priv->dev;
>         mtk_crtc->ddp_comp_nr =3D path_len;
>         mtk_crtc->ddp_comp =3D devm_kmalloc_array(dev, mtk_crtc->ddp_comp=
_nr,
>                                                 sizeof(*mtk_crtc->ddp_com=
p),
> @@ -969,6 +972,18 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         }
>
>         if (mtk_crtc->cmdq_client.chan) {
> +               struct device_link *link;
> +
> +               /* add devlink to cmdq dev to make sure suspend/resume or=
der is correct */
> +               link =3D device_link_add(priv->dev, mtk_crtc->cmdq_client=
.chan->mbox->dev,
> +                                      DL_FLAG_PM_RUNTIME | DL_FLAG_STATE=
LESS);
> +               if (!link) {
> +                       dev_err(priv->dev, "Unable to link dev=3D%s\n",
> +                               dev_name(mtk_crtc->cmdq_client.chan->mbox=
->dev));
> +                       ret =3D -ENODEV;
> +                       goto cmdq_err;
> +               }
> +
>                 ret =3D of_property_read_u32_index(priv->mutex_node,
>                                                  "mediatek,gce-events",
>                                                  i,
> @@ -976,22 +991,26 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>                 if (ret) {
>                         dev_dbg(dev, "mtk_crtc %d failed to get mediatek,=
gce-events property\n",
>                                 drm_crtc_index(&mtk_crtc->base));
> -                       mbox_free_channel(mtk_crtc->cmdq_client.chan);
> -                       mtk_crtc->cmdq_client.chan =3D NULL;
> -               } else {
> -                       ret =3D mtk_drm_cmdq_pkt_create(&mtk_crtc->cmdq_c=
lient,
> -                                                     &mtk_crtc->cmdq_han=
dle,
> -                                                     PAGE_SIZE);
> -                       if (ret) {
> -                               dev_dbg(dev, "mtk_crtc %d failed to creat=
e cmdq packet\n",
> -                                       drm_crtc_index(&mtk_crtc->base));
> -                               mbox_free_channel(mtk_crtc->cmdq_client.c=
han);
> -                               mtk_crtc->cmdq_client.chan =3D NULL;
> -                       }
> +                       goto cmdq_err;
> +               }
> +
> +               ret =3D mtk_drm_cmdq_pkt_create(&mtk_crtc->cmdq_client,
> +                                             &mtk_crtc->cmdq_handle,
> +                                             PAGE_SIZE);
> +               if (ret) {
> +                       dev_dbg(dev, "mtk_crtc %d failed to create cmdq p=
acket\n",
> +                               drm_crtc_index(&mtk_crtc->base));
> +                       goto cmdq_err;
>                 }
>
>                 /* for sending blocking cmd in crtc disable */
>                 init_waitqueue_head(&mtk_crtc->cb_blocking_queue);
> +
> +cmdq_err:
> +               if (ret) {
> +                       mbox_free_channel(mtk_crtc->cmdq_client.chan);
> +                       mtk_crtc->cmdq_client.chan =3D NULL;
> +               }
>         }
>  #endif
>         return 0;
> --
> 2.18.0
>

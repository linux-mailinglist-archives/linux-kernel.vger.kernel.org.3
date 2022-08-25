Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61255A1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiHYX02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiHYX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C46556E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B0861D45
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A6AC43470
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661469948;
        bh=gANNeo5xFLWx50TpQgTmSD/ajuMSXdn3OaPyPmhxXLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tIjYGOQqVzSB18XFBZDqzuEERpxgkNSETElSZ7o1WjHeCgh94xGTf3IfOLKBp7nQy
         m6mlX1GR5rsIDMZtmYmMNZ3SUcqynZIIk4y8hRuncuizi3nkLoSxICTv2zdsfJBgsS
         HzPnhpI6YM26VGx9LJqNDIS7KyY/fRR6Mf/bOZ9Y3HA2NF6h1/DzzsS29Xq/gURX8W
         +cdfD0P9BFXfz3y61EBOwJ1IrOWto5e+S7QI4LZcowMDFqh2qnZ4mY8e/9ANexfiRP
         hxXdNl/KdlbWLAucLx4NQOk3+rFZXPDZYVFNssN1sfmq2HeT5i6p2VA1xHDGz1o13s
         7sDqb94lT2SEA==
Received: by mail-oi1-f181.google.com with SMTP id a133so74487oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:25:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo0rpN4ijN+sEgMDtyQjHW3rrfHm7xrGewFh8q1yxghXzYRAJrW/
        TynTsDbqfUvF/1CmEcudHa3AE2Uf1IWNZVE8yw==
X-Google-Smtp-Source: AA6agR6/OpIOZrEsWat8SQRwRTVdbJeXbdtydW5Eboufpp739coHjJXCokAIiHdL3oK9fM+r9I0g37gU99hljRaQqhQ=
X-Received: by 2002:a54:4405:0:b0:343:23df:4ac5 with SMTP id
 k5-20020a544405000000b0034323df4ac5mr519363oiw.69.1661469947573; Thu, 25 Aug
 2022 16:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220812205746.609107-1-mairacanal@riseup.net> <20220812205746.609107-3-mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-3-mairacanal@riseup.net>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 26 Aug 2022 07:25:35 +0800
X-Gmail-Original-Message-ID: <CAAOTY__aE+dZ=GDOQN+Yeh9MzDrFnK71E36NGe0gb17hNXgE8w@mail.gmail.com>
Message-ID: <CAAOTY__aE+dZ=GDOQN+Yeh9MzDrFnK71E36NGe0gb17hNXgE8w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/mediatek: Drop of_gpio header
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
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

Hi, Maira:

Ma=C3=ADra Canal <mairacanal@riseup.net> =E6=96=BC 2022=E5=B9=B48=E6=9C=881=
3=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A84:58=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> These drivers include the deprecated OF GPIO header <linux/of_gpio.h>
> yet fail to use symbols from it, so drop the include.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c  | 1 -
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 630a4e301ef6..508a6d994e83 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -11,7 +11,6 @@
>  #include <linux/media-bus-format.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 3196189429bc..4c80b6896dc3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -16,7 +16,6 @@
>  #include <linux/mutex.h>
>  #include <linux/of_platform.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> --
> 2.37.1
>

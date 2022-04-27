Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E305113B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359538AbiD0IrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359533AbiD0IrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:47:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450D8BE0A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:44:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d12so2108603ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TMxK2aQcel/+UWJA0z1eqdZBidlHy7JtAHyoQ82VNGI=;
        b=Ugr1frXBT+AtHa3GNev28FpadJLvReGBPfzm8W/ldKNimUPKPYRv6SxlKgA/ixqEUs
         8kcGJvbfrxx8zY6z5QDbzjQk3WmTHJAWyxt6xped+9yFLnqMSg9UjFLBrb3bKF1KEGIN
         nskq7djOd/KIJozOciUMMmPPavwoXdIboUn9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TMxK2aQcel/+UWJA0z1eqdZBidlHy7JtAHyoQ82VNGI=;
        b=X8eUGFzC2eWNNtv4kkUQFn2hnR4toXgvnKLUxrJmEBmmfo5kqzOuvl3sodhYeI8W7O
         04MJ1+qTWvkb6H97I2mEJrnULWf5hSoj/4c3bBMe2trhyGMALxsQ+tL/lTJpL92nm1eS
         RbvBjBSVdW4/FN6cce2mUHtZdQFxEEGfcOUof+T2J29ZRfb4/wXQiA7OIiioBtq+e6IZ
         ufa23OcjmMWRYVpTbAjbAJzl5BRLtrgMlRZaRlnpyZ0z7GYANUTeEzHo/2c8Wez1cjuL
         riCCypGHmlUTzjmxIUrl5UXEfE5fvzLf03ujC/9R2ddqs4I6vl4zmj7AXJV4Qr6KW3rr
         0LEg==
X-Gm-Message-State: AOAM531WYRd9f07xsPxElxyGSnmp3mEUdXpsNrW1BBEuDKx5pqiooa6S
        0Swq1GAjjE8CHzBFbuNFJhL4Xd/LQWnyQLymJ6nAIg==
X-Google-Smtp-Source: ABdhPJz83pUAtp8fqad7w1dU3n80V4h/UV5lfR51MqjDhb0/CI98QaW9J0vuB8c3BFqGgiw0WY/WcgKZ+WZ4bxX5Lc4=
X-Received: by 2002:a5b:50b:0:b0:645:d576:7699 with SMTP id
 o11-20020a5b050b000000b00645d5767699mr22130922ybp.278.1651049041315; Wed, 27
 Apr 2022 01:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220316151327.564214-1-nfraprado@collabora.com> <20220316151327.564214-2-nfraprado@collabora.com>
In-Reply-To: <20220316151327.564214-2-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 27 Apr 2022 16:43:50 +0800
Message-ID: <CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFduVz82rM=+g@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] arm64: dts: mediatek: Introduce MT8192-based
 Asurada board family
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 16, 2022 at 11:17 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Introduce the MT8192 Asurada Chromebook platform, including the Asurada
> Spherion and Asurada Hayato boards.
>
> This is enough configuration to get serial output working on Spherion
> and Hayato.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> ---
>
>  arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
>  .../dts/mediatek/mt8192-asurada-hayato-r1.dts | 11 ++++++++
>  .../mediatek/mt8192-asurada-spherion-r0.dts   | 13 ++++++++++
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 26 +++++++++++++++++++
>  4 files changed, 52 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1=
.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-=
r0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index 8c1e18032f9f..034cba17276b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -37,5 +37,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-kodama-sk=
u32.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-hayato-r1.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-asurada-spherion-r0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8192-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/=
arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> new file mode 100644
> index 000000000000..e18e14b13d61
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2020 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8192-asurada.dtsi"
> +
> +/ {
> +       model =3D "MediaTek Hayato rev1";

I think this should be "Google Hayato ...", and the one in spherion should
read "Google Spherion" as well?

These are project code names used in Google. Both devices use the common
"Asurada" hardware design, also done by Google.

> +       compatible =3D "google,hayato-rev1", "google,hayato", "mediatek,m=
t8192";

You should add a patch adding this to the DT binding doc
Documentation/devicetree/bindings/arm/mediatek.yaml

Same for Spherion.


Regards
ChenYu

> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts =
b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
> new file mode 100644
> index 000000000000..b5372ce6bd95
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8192-asurada.dtsi"
> +
> +/ {
> +       model =3D "MediaTek Spherion (rev0 - 3)";
> +       compatible =3D "google,spherion-rev3", "google,spherion-rev2",
> +                    "google,spherion-rev1", "google,spherion-rev0",
> +                    "google,spherion", "mediatek,mt8192";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> new file mode 100644
> index 000000000000..277bd38943fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +/dts-v1/;
> +#include "mt8192.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +
> +       memory@40000000 {
> +               device_type =3D "memory";
> +               reg =3D <0 0x40000000 0 0x80000000>;
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> --
> 2.35.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296757D9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiGVFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:54:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590F4599E;
        Thu, 21 Jul 2022 22:54:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so2185971wmj.0;
        Thu, 21 Jul 2022 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtRd1qvdAKI4EiqU/d5bQkZ1Mrj4m7B9tT4Xan5GhTI=;
        b=BDiR6U2zwdJvi1bgWd+EbtZ4G8s3dznN6s7t0FQJCYoSQz8HSSmBb2HTO6UuLVTXkW
         StUgQltjbn1CZPDKFsHKbs71rUcuhk/B0r4kJdlAi0W3A/b9DWFcbUn51Q3P6GoQYT+a
         m+V6vZv/3iAbNONDfOkFdn+5Q33GhIV5hurq0sOyYHDAatcuMy1XHlcQyzlqTBklZ4gG
         /8yGvtOYjtauBPkc8yTRDWAXD12Iqche042qwU4EYH94m0Z7jFq8DuREC8m4lg1ajV/A
         yL3vaxR3TyXnBLqkbL6VGqLSb1jKwYMKsmdvyPMfVarQ1Wk1PMpliIBConM9TW0ybohF
         lrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtRd1qvdAKI4EiqU/d5bQkZ1Mrj4m7B9tT4Xan5GhTI=;
        b=6feF64nuF0oXtj3GnLEUBQn7esmEX8bgh0mnSc21+pBH1UBwKUNG5AsJkM83aIoWZ1
         hw1yg8iI2DDwiQVDsiX9YiQ+wI80KYh2JKNUpVULSCOxus1jkHIToqwFRbTvDYPv5l/U
         lcEsK1IbM0pHfA0cSVub+kbMmXZNwkSf59RjxiqpZZhJCbgesSIayw+5bpzMxnPcpDcW
         ZlK/x6hSMg90zj5FAQ05H5iwbnQyQSHsn5CGOkPl3mq3oTcyeMN1TZl108fyPDe2+9ul
         5SwAyyyzfSAnTwFFr71N7CPbvUTCtvaCmMhU5iASD57W0arI1XevZGnv2TrCUUz/cuOy
         AWVg==
X-Gm-Message-State: AJIora9kkFNbswBF9SKeeJodl/poLcxzAojVeHbol+QxtHcIg5qt9EDN
        V7DC24hBSSmx0U+fJkbnyslKk96JtgOcbaCI4Dg=
X-Google-Smtp-Source: AGRyM1sk5ZU8IaLqqOKTh8qEVRx2CGlK0jDA7F9hx80lQ4G89IRyzzwbhpGCOInmUan1a4J3jx8v3pPF7yFxyL4Fyao=
X-Received: by 2002:a05:600c:6014:b0:3a3:14c9:bef1 with SMTP id
 az20-20020a05600c601400b003a314c9bef1mr10924439wmb.112.1658469279167; Thu, 21
 Jul 2022 22:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220721044307.48641-1-frattaroli.nicolas@gmail.com>
In-Reply-To: <20220721044307.48641-1-frattaroli.nicolas@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 22 Jul 2022 07:54:28 +0200
Message-ID: <CAMdYzYohVLwOu94tv1FV9FVO7TRjBhA0nH6nWOgRCpBrxcujqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Lower sd speed on quartz64-b
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 6:43 AM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> The previously stated speed of sdr-104 is too high for the hardware
> to reliably communicate with some fast SD cards.
>
> Lower this to sd-uhs-sdr50 to fix this.

I can confirm this is necessary. Thanks!

Tested-by: Peter Geis <pgwipeout@gmail.com>

>
> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")
>
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 02d5f5a8ca03..528bb4e8ac77 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -506,7 +506,7 @@ &sdmmc0 {
>         disable-wp;
>         pinctrl-names = "default";
>         pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> -       sd-uhs-sdr104;
> +       sd-uhs-sdr50;
>         vmmc-supply = <&vcc3v3_sd>;
>         vqmmc-supply = <&vccio_sd>;
>         status = "okay";
> --
> 2.37.1
>

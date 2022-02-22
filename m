Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AA4BF5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiBVKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiBVKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:25:05 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A55158DB0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:24:40 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d66f95f1d1so167824277b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69eFH6spOTwBGKABYsbbrmb+Lpi5NbL+IMsR8wV2fQU=;
        b=HcQ+d0ZJ/JtQx+qYGvzS9hVynevZWtI7FbGk/0iwjEZDx6m4lGAAWq+Uw7uz5YW6Po
         /pwn4tDSMF4vCWmjm4DnesJ23mj3CdFloQGFLINcu1Zt+JtAl5MoivJ8wK98sETyfENq
         +pndWzIXS/yLatEpX4NMiOTFLWwKlQBJS5u5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69eFH6spOTwBGKABYsbbrmb+Lpi5NbL+IMsR8wV2fQU=;
        b=O2z5FKInrGPtSMonztfWkuKitv6kvKaORiCcqxdYcQtuL9GtAC7PYdTU56RYXbLAK5
         WW/NkuMEqzuunoAPbnvjLU59HzPgBOS59Q6XLT4q+jvjDD3vUT+f5yZZrY81RDXpnGKK
         AU8HMhGsGXA/KLRl6jNllVJLymo9g3ooq892ZhcbRqOn6kSEW1HRGQBmm1Pgq/idzQ5d
         UbXSSpW2lwSyPmEjXilufT+1hdoyTzu8agtWqvps2yXo5ge9XEN6NW+8GM/IzMZ87yvz
         HvtTae9grMIU3MoKg9NeGi0c+erltY2keW4yrIR0KLaE8O2ZfUTtHxtZkQ9+oUqEzkq5
         CynA==
X-Gm-Message-State: AOAM530VbCUSgEfC8op7g0I2ZDLRJW8OpwryM2CENR8H8D0YiJj9lm5G
        E3U8zs3rp84MUHGVVF9U23jQ1Q7UlZzvt75fUKBoxA==
X-Google-Smtp-Source: ABdhPJz68mpmxTWnXQ4sCxmsI+dEugOJ1Iyt555rWWgvyVmRIezO951j51SxTwtOaI+GoDLQNC4lG1WyXxLqX6GGVsE=
X-Received: by 2002:a81:35d8:0:b0:2d6:b5aa:217 with SMTP id
 c207-20020a8135d8000000b002d6b5aa0217mr20755538ywa.286.1645525480023; Tue, 22
 Feb 2022 02:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com> <20220218091633.9368-21-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220218091633.9368-21-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 22 Feb 2022 18:24:29 +0800
Message-ID: <CAGXv+5H8WY6=qvcz1CARfjf5UREH7i7v2Uz99frby5S=eqV6gQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/23] arm64: dts: mt8192: Add display nodes
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "--to=Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 18, 2022 at 5:16 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add display nodes for mt8192 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 115 +++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index e3314cdc7c1a..026f2d8141b0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -32,6 +32,11 @@
>                 i2c7 = &i2c7;
>                 i2c8 = &i2c8;
>                 i2c9 = &i2c9;
> +               ovl0 = &ovl0;
> +               ovl-2l0 = &ovl_2l0;
> +               ovl-2l2 = &ovl_2l2;
> +               rdma0 = &rdma0;
> +               rdma4 = &rdma4;
>         };
>
>         clk26m: oscillator0 {
> @@ -1224,6 +1229,13 @@
>                         #clock-cells = <1>;
>                 };
>
> +               mutex: mutex@14001000 {
> +                       compatible = "mediatek,mt8192-disp-mutex";
> +                       reg = <0 0x14001000 0 0x1000>;
> +                       interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +               };
> +
>                 smi_common: smi@14002000 {
>                         compatible = "mediatek,mt8192-smi-common";
>                         reg = <0 0x14002000 0 0x1000>;
> @@ -1255,6 +1267,109 @@
>                         power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>                 };
>
> +               ovl0: ovl@14005000 {
> +                       compatible = "mediatek,mt8192-disp-ovl";
> +                       reg = <0 0x14005000 0 0x1000>;
> +                       interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +                       iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
> +                                <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
> +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +               };
> +
> +               ovl_2l0: ovl@14006000 {
> +                       compatible = "mediatek,mt8192-disp-ovl-2l";
> +                       reg = <0 0x14006000 0 0x1000>;
> +                       interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +                       iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
> +                                <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +               };
> +
> +               rdma0: rdma@14007000 {
> +                       compatible = "mediatek,mt8192-disp-rdma";
> +                       reg = <0 0x14007000 0 0x1000>;
> +                       interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +                       iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +                       mediatek,larb = <&larb0>;
> +                       mediatek,rdma-fifo-size = <5120>;
> +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +               };
> +
> +               color0: color@14009000 {
> +                       compatible = "mediatek,mt8192-disp-color",
> +                                    "mediatek,mt8173-disp-color";
> +                       reg = <0 0x14009000 0 0x1000>;
> +                       interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +               };
> +
> +               ccorr0: ccorr@1400a000 {
> +                       compatible = "mediatek,mt8192-disp-ccorr";
> +                       reg = <0 0x1400a000 0 0x1000>;
> +                       interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +                       clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +               };
> +
> +               aal0: aal@1400b000 {
> +                       compatible = "mediatek,mt8192-disp-aal";

git.kernel.org/chunkuang.hu/c/4ed545e7d10049b5492afc184e61a67e478a2cfd

suggests that there should be a fallback compatible? Otherwise this
doesn't probe.

ChenYu

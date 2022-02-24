Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCC4C2B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiBXMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBXMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:10:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E315F347;
        Thu, 24 Feb 2022 04:09:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so2681929wrb.6;
        Thu, 24 Feb 2022 04:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryt2IYjdNSmFLI6a3vnNM5EwFNVjdetPyVDqd/aUZeg=;
        b=D6vR6F2TXmpD1+UFCX8/J45nksM0voDBDyKbu5n1LNr1+wppAD0zyDcENlMVfqmii7
         BuTLLq0BL0y5mO5yu9m4ktr8rV4ovbhXhVp9IlmNKKjbEktMaMmojnWIqgVIgdYSyPdu
         aJ8YL5FVF6VLA1AZszcXBwQIB8jhWo0kJh2UiztMeSKsS8bdMOAS3vUGJJfNy7uK7X6l
         yUrloHTy+IHNLYCZ16bL2MLz+Y54F5+gMtXtLSZ7mj2pcuPOAgFvo35/VTDvSxAlRGFH
         1zhHW4cmhroVIuI3Vx+m6gXAo6COHCrdvEvzkI5X3fCzJ7YSh2IpNEOPPO8gbtQX9cHZ
         TJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryt2IYjdNSmFLI6a3vnNM5EwFNVjdetPyVDqd/aUZeg=;
        b=K9T288SeQ0pZ5HiYchXnb8i5z2Y79lAzqdN/rSAbQQusRdkezX+YlZlX9tDM8vkT2S
         Rfol/0rYUJLhZby7tMRchfYiafm+pp2qXKsFsEkTI09TVVoFmtOPZ+5VOLig5GeQz+zs
         5zwTDylU/F0Ezi+D5Pccjng8s4+eQmtaaBM06peOJI66wDCKK8o1zgv8e6LSEgodSvZB
         H3Wky3dk3bE/h7fJsxvUHTaWRtqkIGAPhDZhTSgtDxCCiDfncR6W7Ib6+afGZlnrZdwx
         tQ66JnPYkiEh7VJkE5ld7FjzHZR6QPV+ABJEQcpZvjLeFG5OdrmKA0ofp11kZxrMQB0d
         iOxA==
X-Gm-Message-State: AOAM531ekKwJKIBbyYbGBg/1sRys/BGqUmPx/Rq7ysMnwtKYV6DkA7/W
        Tgq9GY1NxwtK/YMDAlCAWALBQ+b28hD50kmU7uI=
X-Google-Smtp-Source: ABdhPJzKeTdhqWFtGflp/xcTtkiyTROqljqNG8nFw2113ZyvHBY7rTQF77YYb10eBX5RZULi20EbGlwm7JdHzAWN3+Y=
X-Received: by 2002:adf:f691:0:b0:1ed:f546:bd81 with SMTP id
 v17-20020adff691000000b001edf546bd81mr1726324wrp.542.1645704582892; Thu, 24
 Feb 2022 04:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20220224103030.2040048-1-michael@walle.cc> <20220224103030.2040048-2-michael@walle.cc>
In-Reply-To: <20220224103030.2040048-2-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 24 Feb 2022 13:09:31 +0100
Message-ID: <CAEyMn7ZU8EQCUWYDTyC5m0j7x-6NEyuG95czjL4P98MMpCDL9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-evk: fix the min/max voltages
 of the PMIC
To:     Michael Walle <michael@walle.cc>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Do., 24. Feb. 2022 um 11:30 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Use the proper voltages as supported by the board instead of the ones
> supported by the PMIC. The voltages were taken from both the schematic
> of the 8MNANOLPD4-EVK eval board and the datasheet of the IMX8MN SoC.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
> Please help review and test this. This was never tested on the actual
> 8MNANOLPD4-EVK because I don't have that board! Instead it is a
> "byproduct" of the development of an devicetree for the 8MNANOD3L-EVK
> which is quite similar except for the DDR voltage and the buck2
> converter.
>
> Changes since v1:
>  - swap buck1 and buck2
>
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 34 ++++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index 2b685c0c7eeb..4eb467df5ba7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -42,8 +42,8 @@ pmic: pmic@25 {
>                 regulators {
>                         buck1: BUCK1{
>                                 regulator-name = "VDD_SOC";
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <2187500>;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <950000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                                 regulator-ramp-delay = <3125>;
> @@ -51,8 +51,8 @@ buck1: BUCK1{
>
>                         buck2: BUCK2 {
>                                 regulator-name = "VDD_ARM_0V9";
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <2187500>;
> +                               regulator-min-microvolt = <850000>;
> +                               regulator-max-microvolt = <1000000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                                 regulator-ramp-delay = <3125>;
> @@ -62,32 +62,32 @@ buck2: BUCK2 {
>
>                         buck4: BUCK4{
>                                 regulator-name = "VDD_3V3";
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <3400000>;
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
>
>                         buck5: BUCK5{
>                                 regulator-name = "VDD_1V8";
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <3400000>;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
>
>                         buck6: BUCK6 {
>                                 regulator-name = "NVCC_DRAM_1V1";
> -                               regulator-min-microvolt = <600000>;
> -                               regulator-max-microvolt = <3400000>;
> +                               regulator-min-microvolt = <1100000>;
> +                               regulator-max-microvolt = <1100000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
>
>                         ldo1: LDO1 {
>                                 regulator-name = "NVCC_SNVS_1V8";
> -                               regulator-min-microvolt = <1600000>;
> -                               regulator-max-microvolt = <3300000>;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
> @@ -95,23 +95,23 @@ ldo1: LDO1 {
>                         ldo2: LDO2 {
>                                 regulator-name = "VDD_SNVS_0V8";
>                                 regulator-min-microvolt = <800000>;
> -                               regulator-max-microvolt = <1150000>;
> +                               regulator-max-microvolt = <800000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
>
>                         ldo3: LDO3 {
>                                 regulator-name = "VDDA_1V8";
> -                               regulator-min-microvolt = <800000>;
> -                               regulator-max-microvolt = <3300000>;
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
>
>                         ldo4: LDO4 {
>                                 regulator-name = "VDD_PHY_1V2";
> -                               regulator-min-microvolt = <800000>;
> -                               regulator-max-microvolt = <3300000>;
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
>                                 regulator-boot-on;
>                                 regulator-always-on;
>                         };
> --
> 2.30.2
>

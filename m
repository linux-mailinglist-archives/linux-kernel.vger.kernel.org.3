Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F34C2479
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiBXHa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiBXHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:30:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6F23401C;
        Wed, 23 Feb 2022 23:29:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so1503210wra.12;
        Wed, 23 Feb 2022 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MekU7yzGTUh/AWLPWochJWuvHGOEzviZufg9Kqv2Vhs=;
        b=ph9L1+z8Bbj1hrLNYFede2pWI67Wdxd8xWH0dHrwqZJ8DtNkJmHbURvQdF+Acy+J5+
         X8BhGhbBa1tzk1X5Y0n9EohD9ypQT6BlJQAKx7bgxWltexn/3dtaWMGNnNED2kj5xo9r
         v4RW7hdMEZXFj/l8hHZNMASugJNGDT+2ZeEYoUvjBlqp0r4ctAVVnOzz7jg8ejTjl4OG
         IR4eocnK62xIG+hR4O/WjKQYP3JcFFZBamg77ak7/VPcrwrOhSPaE943dsY0RNdzI+YV
         iM6s4192O52xJL8OJijUUjKUm12+6Wzqa6A3DedagM9qkr18YY+Zw12dstN5/dDtY5aZ
         ypSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MekU7yzGTUh/AWLPWochJWuvHGOEzviZufg9Kqv2Vhs=;
        b=oxtrdfH/jL071d7YaM6j1p6rJpzDmPpXMAuaRTNM8zRg5Gq38nL6RWSj887YpDH2ls
         E7Y/dnER9rqMz8gPbhHE1IdvDR7acqJePlgelf2gfI/GLF5g8ec9y96S18DrDoMg/AFe
         MsxtzkefyuL5Kgvt02/VVq2lBxriEScfgSCBLlKZ1ASxJjk0G/+XG/GYHMMZROM9Yawz
         QI7QKdRWtdSQPqeOu7m02K11RdIWdPjN2weZbfJA54+6QBikSSIy1NqgPmjt/IGfhwgv
         Z289N9urFyzN3ys6QGaPZjB8syS4vJ37gkOuvPy8Qea3AS3J/vuX0d/7CJUpqPDg5rsx
         DBng==
X-Gm-Message-State: AOAM533bdRwN9JmQXXO6XX9Z4I5BP8gzep3VbzvhNzUUsvZ9HgQRtAc3
        EP7E4ftL5DUlWnCVZqrDbNr0EF5StJRK6F+1a8c=
X-Google-Smtp-Source: ABdhPJxzPvUTzp3crzd/QO83key0oCR7IH88f0VUgjN8A/MIOqSodDNnggP/Z0QY7acdOOF9pi6jEuz6iDdK10hZ5zc=
X-Received: by 2002:adf:e84c:0:b0:1ee:4a2b:fed with SMTP id
 d12-20020adfe84c000000b001ee4a2b0fedmr146257wrn.149.1645687794602; Wed, 23
 Feb 2022 23:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20220223210559.1999209-1-michael@walle.cc>
In-Reply-To: <20220223210559.1999209-1-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 24 Feb 2022 08:29:43 +0100
Message-ID: <CAEyMn7aVWK7NBH5+FpcK-gr9LPqb8MwsiOOTVJqo+PZJ+_naSw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC outputs
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

Am Mi., 23. Feb. 2022 um 22:06 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Use the power signal names as given in the schematics of the reference
> board.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index b4225cfcb6d9..eaa06f49aef5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -41,7 +41,7 @@ pmic: pmic@25 {
>
>                 regulators {
>                         buck1: BUCK1{
> -                               regulator-name = "BUCK1";
> +                               regulator-name = "VDD_ARM_0V9";

I think BUCK1 and BUCK2 are twisted here. This should be "VDD_SOC".

>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <2187500>;
>                                 regulator-boot-on;
> @@ -50,7 +50,7 @@ buck1: BUCK1{
>                         };
>
>                         buck2: BUCK2 {
> -                               regulator-name = "BUCK2";
> +                               regulator-name = "VDD_SOC";

And this should be "VDD_ARM_0V9".

>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <2187500>;
>                                 regulator-boot-on;
> @@ -61,7 +61,7 @@ buck2: BUCK2 {
>                         };
>
>                         buck4: BUCK4{
> -                               regulator-name = "BUCK4";
> +                               regulator-name = "VDD_3V3";
>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <3400000>;
>                                 regulator-boot-on;
> @@ -69,7 +69,7 @@ buck4: BUCK4{
>                         };
>
>                         buck5: BUCK5{
> -                               regulator-name = "BUCK5";
> +                               regulator-name = "VDD_1V8";
>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <3400000>;
>                                 regulator-boot-on;
> @@ -77,7 +77,7 @@ buck5: BUCK5{
>                         };
>
>                         buck6: BUCK6 {
> -                               regulator-name = "BUCK6";
> +                               regulator-name = "NVCC_DRAM_1V1";
>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <3400000>;
>                                 regulator-boot-on;
> @@ -85,7 +85,7 @@ buck6: BUCK6 {
>                         };
>
>                         ldo1: LDO1 {
> -                               regulator-name = "LDO1";
> +                               regulator-name = "NVCC_SNVS_1V8";
>                                 regulator-min-microvolt = <1600000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
> @@ -93,7 +93,7 @@ ldo1: LDO1 {
>                         };
>
>                         ldo2: LDO2 {
> -                               regulator-name = "LDO2";
> +                               regulator-name = "VDD_SNVS_0V8";
>                                 regulator-min-microvolt = <800000>;
>                                 regulator-max-microvolt = <1150000>;
>                                 regulator-boot-on;
> @@ -101,7 +101,7 @@ ldo2: LDO2 {
>                         };
>
>                         ldo3: LDO3 {
> -                               regulator-name = "LDO3";
> +                               regulator-name = "VDDA_1V8";
>                                 regulator-min-microvolt = <800000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
> @@ -109,7 +109,7 @@ ldo3: LDO3 {
>                         };
>
>                         ldo4: LDO4 {
> -                               regulator-name = "LDO4";
> +                               regulator-name = "VDD_PHY_1V2";
>                                 regulator-min-microvolt = <800000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
> @@ -117,7 +117,7 @@ ldo4: LDO4 {
>                         };
>
>                         ldo5: LDO5 {
> -                               regulator-name = "LDO5";
> +                               regulator-name = "NVCC_SD2";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
> --
> 2.30.2
>

-- 
Heiko

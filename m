Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF617572FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiGMHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiGMHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:52:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC3E7ACD;
        Wed, 13 Jul 2022 00:52:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 70so9572469pfx.1;
        Wed, 13 Jul 2022 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iTG0Znyy8dcxoJ240RfYELWXGLIYvTXqlX00eUFqRU=;
        b=XFnuUh7pWfs6hqZpVLZW0mzy9uT4SQCOuwVQwFv2esdhnASBvDo6XHmJXrOBLXMNWF
         kiQloL02tBWBUz2F0nKyABsg+QAgHTOUnRFJsn1NwoczD70ewWsNIY/YC/l6NbGHmnQX
         EHUjN9dw9m6dazSxZrWnegtpEwunhqaeR4F4jIS4LUXvR0Hqb+2CBXj5fpCzsfEesYMy
         K3nmcj8okqwqSQQFunuAemtyEpwIhWRf+b1YTx9DA2h/oXTHTW/I3OlGbRiX0V9egw74
         15j1eeLtmhx+DaE+YkD/gHP3ZPBMb9CvmYAxvXF2i5LG8hDwfaQ+aBWQTKdIC0bIDYlA
         /PXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iTG0Znyy8dcxoJ240RfYELWXGLIYvTXqlX00eUFqRU=;
        b=E023YXm2yt6+Qh3T2sLnHlarInv2ldMVFk+URYS+q3U3elFc584nbfIfz8iMrRslzt
         Yy3YxuCFNgMJbkDl/nVsE9tLxWG8CkjjMxMAKV9FsCLD5d5URXhnS96i03y2rg6/Z5P7
         pAD1K7t2MicUD63uKeNONX3xDpmW7hS9rZqmzJOEb1WoEk0KimqhtZSp4X0QS7cz/1Po
         vn7yCeqqf2Y8bpdLZ4NXUfcypvxEZ5AKoOpsI+091b3QqHcQ9RnMQurUE4mRzhy2wTN6
         WFGvZCx2AaznCpo0mKX69gh9sJ2wAMFJTiG4trd+WLutb+vIbp88MuTNEWs7albvjHC1
         sM7A==
X-Gm-Message-State: AJIora+X+/2O7MbKqzHNtQwWAbaBV/q70Ql+ct7TGHBCxSrN0bjt3J+K
        HiW0/+DB44hpb4ziUkSjYjMjqh+xRXdo0SMEyhWtrGoZqtc=
X-Google-Smtp-Source: AGRyM1t0G8qSuYZKwi/pJD6mvfU21cYcWr1VNiJ8de1QrHTdhFi7PcogfX5Do+I37VeRgjkS5vw59uKlHK9LXg92HLs=
X-Received: by 2002:a63:1943:0:b0:411:5e12:4e4f with SMTP id
 3-20020a631943000000b004115e124e4fmr1901430pgz.400.1657698774474; Wed, 13 Jul
 2022 00:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220713074118.14733-1-frieder@fris.de> <20220713074118.14733-5-frieder@fris.de>
In-Reply-To: <20220713074118.14733-5-frieder@fris.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Wed, 13 Jul 2022 09:52:42 +0200
Message-ID: <CAEyMn7a7S6UZOTsubM3pY95diY0oR0WNvhQpTUSmedjG59Qn9g@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: imx8mm-kontron: Use upper case PMIC
 regulator names
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Frieder,

Am Mi., 13. Juli 2022 um 09:41 Uhr schrieb Frieder Schrempf <frieder@fris.de>:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Use upper case PMIC regulator names to comply with the bindings.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index 2d0661cce89b..2e3d51bbf92e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -85,7 +85,7 @@ pca9450: pmic@25 {
>
>                 regulators {
>                         reg_vdd_soc: BUCK1 {
> -                               regulator-name = "buck1";
> +                               regulator-name = "BUCK1";

Wouldn't it be better to use the real signal or voltage rail names
used in the schematics?

Like it is done here as example:
https://elixir.bootlin.com/linux/v5.19-rc6/source/arch/arm64/boot/dts/freescale/imx8mn-evk.dts#L44

Or use a name that includes both information (signal + PMIC out):
https://elixir.bootlin.com/linux/v5.19-rc6/source/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi#L445

>                                 regulator-min-microvolt = <800000>;
>                                 regulator-max-microvolt = <850000>;
>                                 regulator-boot-on;
> @@ -96,7 +96,7 @@ reg_vdd_soc: BUCK1 {
>                         };
>
>                         reg_vdd_arm: BUCK2 {
> -                               regulator-name = "buck2";
> +                               regulator-name = "BUCK2";
>                                 regulator-min-microvolt = <850000>;
>                                 regulator-max-microvolt = <950000>;
>                                 regulator-boot-on;
> @@ -107,7 +107,7 @@ reg_vdd_arm: BUCK2 {
>                         };
>
>                         reg_vdd_dram: BUCK3 {
> -                               regulator-name = "buck3";
> +                               regulator-name = "BUCK3";
>                                 regulator-min-microvolt = <850000>;
>                                 regulator-max-microvolt = <950000>;
>                                 regulator-boot-on;
> @@ -115,7 +115,7 @@ reg_vdd_dram: BUCK3 {
>                         };
>
>                         reg_vdd_3v3: BUCK4 {
> -                               regulator-name = "buck4";
> +                               regulator-name = "BUCK4";
>                                 regulator-min-microvolt = <3300000>;
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-boot-on;
> @@ -123,7 +123,7 @@ reg_vdd_3v3: BUCK4 {
>                         };
>
>                         reg_vdd_1v8: BUCK5 {
> -                               regulator-name = "buck5";
> +                               regulator-name = "BUCK5";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
> @@ -131,7 +131,7 @@ reg_vdd_1v8: BUCK5 {
>                         };
>
>                         reg_nvcc_dram: BUCK6 {
> -                               regulator-name = "buck6";
> +                               regulator-name = "BUCK6";
>                                 regulator-min-microvolt = <1100000>;
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-boot-on;
> @@ -139,7 +139,7 @@ reg_nvcc_dram: BUCK6 {
>                         };
>
>                         reg_nvcc_snvs: LDO1 {
> -                               regulator-name = "ldo1";
> +                               regulator-name = "LDO1";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
> @@ -147,7 +147,7 @@ reg_nvcc_snvs: LDO1 {
>                         };
>
>                         reg_vdd_snvs: LDO2 {
> -                               regulator-name = "ldo2";
> +                               regulator-name = "LDO2";
>                                 regulator-min-microvolt = <800000>;
>                                 regulator-max-microvolt = <900000>;
>                                 regulator-boot-on;
> @@ -155,7 +155,7 @@ reg_vdd_snvs: LDO2 {
>                         };
>
>                         reg_vdda: LDO3 {
> -                               regulator-name = "ldo3";
> +                               regulator-name = "LDO3";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-boot-on;
> @@ -163,7 +163,7 @@ reg_vdda: LDO3 {
>                         };
>
>                         reg_vdd_phy: LDO4 {
> -                               regulator-name = "ldo4";
> +                               regulator-name = "LDO4";
>                                 regulator-min-microvolt = <900000>;
>                                 regulator-max-microvolt = <900000>;
>                                 regulator-boot-on;
> @@ -171,7 +171,7 @@ reg_vdd_phy: LDO4 {
>                         };
>
>                         reg_nvcc_sd: LDO5 {
> -                               regulator-name = "ldo5";
> +                               regulator-name = "LDO5";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <3300000>;
>                         };
> --
> 2.37.0
>

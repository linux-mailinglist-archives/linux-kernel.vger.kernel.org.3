Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EC4C2B74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiBXMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiBXMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:11:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9015F35E;
        Thu, 24 Feb 2022 04:11:05 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so2651857wrg.11;
        Thu, 24 Feb 2022 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udUzQTx8uQbEn65wZkZ2LtdPlXauImFTreIuyYxFBvY=;
        b=d/ATDiRWsZIy62QldnaN2uraeOFMFI01rHXphEG2OOVtRSlMNE0Da0GtjJvc+0rInG
         LdzApld8xzsUg7ViCxXA2I6p02eYiyPfo6N/dMaUB3KhCG/Hd2cLV2+PcGFUy7qEGUaS
         1qbNT3r+v0ssqlIPgfjvaE8Ul/uiONV0Ij+aIQaKRaaajTOmzzDEG+mNNX3QXUIY6XNl
         ohYky5I2Jz+fNuKUwbL3fxrCZejUVoVe2qG4p/oQq75CnAkRzQwCtAwFgF+wJDIbQHzg
         OMNNptjMbK21Z5yc6BFT1cr6gwauDg6Xndcip0GYOBCt2WgKgSsBSiCpApiKDX9lnNTs
         Ps9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udUzQTx8uQbEn65wZkZ2LtdPlXauImFTreIuyYxFBvY=;
        b=OalehnXnv7R/tXz4+pZtg50D9r40AXewMagn5+n1rnD7/CJEQZKTxbteyN1a/gDOXM
         VBZJaR0gRwtWgN/ksPRDWbZ3dO+Ieb3oUzs7DvEBg1ZQivgu4IBvOfiOkWeA7zewza0o
         1p0j3/6iASNyGdxY7KtnmABZOj3Cy7x9G9PX4fPrmZkqq8kVVv3UgB6PwVi4uOPveHF/
         a5mHe1b7Ga1w29EH5Km/MrKA5QSgRtLzirp8NS9SI0ihI6WC6MR8+0/+mZVwTtRTbtn3
         7IQa0vjORsiwEEOksh28OFlHFNQnCWoR5aazemqPo1aDOz4l6iqpp3msnT2WEULcetcV
         3rYA==
X-Gm-Message-State: AOAM531yv6TKvCYzgwwPjaz4+CY+X34sHDR5YnqkH/v0bWV+aub0N+tu
        ODHLR0+W/LRZePdkxdh8Sxpdcq9Qc5FEXuVl3RY=
X-Google-Smtp-Source: ABdhPJyGHVy5G41dXsjJAzXd+4XE/D+KPzCpc4wJ3QNJT7bfYHzoSkj4YsLW5b6DinkojUs2K41l86hnicpruaupk9w=
X-Received: by 2002:a5d:64ac:0:b0:1e7:1415:2548 with SMTP id
 m12-20020a5d64ac000000b001e714152548mr2041092wrp.267.1645704664217; Thu, 24
 Feb 2022 04:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20220224103030.2040048-1-michael@walle.cc>
In-Reply-To: <20220224103030.2040048-1-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 24 Feb 2022 13:10:52 +0100
Message-ID: <CAEyMn7ZqypVn14dEa8eWWuUthRqwHqXg35X6hhFE9v7vRkCTxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC outputs
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

HI,

Am Do., 24. Feb. 2022 um 11:30 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Use the power signal names as given in the schematics of the reference
> board.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
> Changes since v1:
>  - swap buck1 and buck2
>
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index b4225cfcb6d9..2b685c0c7eeb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -41,7 +41,7 @@ pmic: pmic@25 {
>
>                 regulators {
>                         buck1: BUCK1{
> -                               regulator-name = "BUCK1";
> +                               regulator-name = "VDD_SOC";
>                                 regulator-min-microvolt = <600000>;
>                                 regulator-max-microvolt = <2187500>;
>                                 regulator-boot-on;
> @@ -50,7 +50,7 @@ buck1: BUCK1{
>                         };
>
>                         buck2: BUCK2 {
> -                               regulator-name = "BUCK2";
> +                               regulator-name = "VDD_ARM_0V9";
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

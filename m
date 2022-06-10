Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74218546ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbiFJUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiFJUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:54:28 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D9403CC;
        Fri, 10 Jun 2022 13:54:27 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AE467CD398;
        Fri, 10 Jun 2022 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654894435; bh=mtnnRXfEvyS5PCWjmATdGdb1H0kGP9ygAVEp9Lld9AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e1YgONubjsg9FKxawsYB/EUQBLF6hTjYLC83dblsiKhSrT5kfsUnTuGM6TlhLHzgx
         xVrT5giK0zK/TV7PjQROqlmG8QCFAXSv7XX0YLUvYX1LCwkjH6zH9Jmqfx31GjIq46
         aemaIcjeXjI5/FR32sBTPlFVNYHUN8AQLXH9wAIE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 03/14] ARM: dts: qcom: use generic sram as name for imem and ocmem nodes
Date:   Fri, 10 Jun 2022 22:53:55 +0200
Message-ID: <2632793.mvXUDI8C0e@g550jk>
In-Reply-To: <20220607171848.535128-3-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org> <20220607171848.535128-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Dienstag, 7. Juni 2022 19:18:37 CEST Krzysztof Kozlowski wrote:
> According to Devicetree specification, the device nodes should be
> generic, reflecting the function of the device.  The typical name for
> memory regions is "sram".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

> ---
>  arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts | 2 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi                | 4 ++--
>  arch/arm/boot/dts/qcom-sdx55.dtsi                  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts index
> ca9f73528196..de01e34409f2 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
> @@ -341,7 +341,7 @@ mmc@12400000 {
>  			};
>  		};
> 
> -		imem@2a03f000 {
> +		sram@2a03f000 {
>  			compatible = "syscon", "simple-mfd";
>  			reg = <0x2a03f000 0x1000>;
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 814ad0b46232..09b181bb5365
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1603,7 +1603,7 @@ opp-27000000 {
>  			};
>  		};
> 
> -		ocmem@fdd00000 {
> +		sram@fdd00000 {
>  			compatible = "qcom,msm8974-ocmem";
>  			reg = <0xfdd00000 0x2000>,
>  			      <0xfec00000 0x180000>;
> @@ -1650,7 +1650,7 @@ smd-edge {
>  			};
>  		};
> 
> -		imem: imem@fe805000 {
> +		imem: sram@fe805000 {
>  			compatible = "syscon", "simple-mfd";
>  			reg = <0xfe805000 0x1000>;
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi
> b/arch/arm/boot/dts/qcom-sdx55.dtsi index 1c2b208a5670..710c7f772d42 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -561,7 +561,7 @@ tlmm: pinctrl@f100000 {
>  			#interrupt-cells = <2>;
>  		};
> 
> -		imem@1468f000 {
> +		sram@1468f000 {
>  			compatible = "simple-mfd";
>  			reg = <0x1468f000 0x1000>;





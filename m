Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0451B991
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbiEEIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiEEIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:05:20 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA713DEC;
        Thu,  5 May 2022 01:01:39 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-a2a8-cdff-fe22-cbb7.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80:a2a8:cdff:fe22:cbb7])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2315ACEB6A;
        Thu,  5 May 2022 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1651737698; bh=IeUnsl/ixvyKvO7e0dLvzAvRdi8rGkqnV1VZTnCfw3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WgZjuED8hDVTn1wD7M5Pe+DThGDFjqMIu9n8J/6bHOybfVLuL9WFzzRHu/QnRU0tI
         CILVuo7mJGH7ccM9vX/mZ3/6U11LE+9cbJ1cKFTf7hNzQj13PA5WEMr5L191hgWkBJ
         dIc1fsZ0iJeBhI4sU8NBTDejayL62WRgWgc/LM68=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add LPG node to pm8941
Date:   Thu, 05 May 2022 10:01:37 +0200
Message-ID: <12122358.O9o76ZdvQC@g550jk>
In-Reply-To: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mittwoch, 4. Mai 2022 22:54:10 CEST Bjorn Andersson wrote:
> The PM8941 contains 8 LPG channels, as well as TRILED and LUT blocks.
> Add a node for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi
> b/arch/arm/boot/dts/qcom-pm8941.dtsi index cdd2bdb77b32..7881a071b372
> 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -144,6 +144,15 @@ pm8941_1: pm8941@1 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> 
> +		pm8941_lpg: lpg {
> +			compatible = "qcom,pm8941-lpg";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Just curious, why doesn't pm8941 have #pwm-cells = <2>; like the other lpg 
nodes in [0]?
Other than that, the node works fine on pm8941. Will send a patch for enabling 
notification LED on msm8974-FP2 soon.

Regards
Luca

[0] https://lore.kernel.org/linux-arm-msm/20220505022706.1692554-2-bjorn.andersson@linaro.org/


> +
> +			status = "disabled";
> +		};
> +
>  		pm8941_wled: wled@d800 {
>  			compatible = "qcom,pm8941-wled";
>  			reg = <0xd800>;





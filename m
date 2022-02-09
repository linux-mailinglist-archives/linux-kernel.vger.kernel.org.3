Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B614AF6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiBIQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiBIQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:32:06 -0500
Received: from fwd1.porkbun.com (fwd1.porkbun.com [52.10.174.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19209C0613C9;
        Wed,  9 Feb 2022 08:32:10 -0800 (PST)
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id 274F2419C6; Wed,  9 Feb 2022 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644424329;
        bh=BB63Yk6PU0uzJW9hg1lkMTJtA+olmom/DTUrgtp9UJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=HhgmD688bBdGMNu0q7R44cHzsgbmgQ+LZ4wx+FVsq0T7bHHcymMdd08zt/4+ZJKQW
         Ajbmsrv+GXrWwAzJ9DtuutGLg7fG4m32KMql4B7XOQ0ca4ndVr7oFv1quqY3XvoYzX
         KEVWmEFAcsBtyxLRlv8gJz89KrEVsbwT6NSoT9v0=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
Received: from webmail.porkbun.com (unknown [35.86.129.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id 9C9D342CD1;
        Wed,  9 Feb 2022 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644424310;
        bh=BB63Yk6PU0uzJW9hg1lkMTJtA+olmom/DTUrgtp9UJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=OJP8/Up+Q3+FI2y122Fa4EYtLZ4Ym0VZJ6NEZ0Sr+rCVwxZdaHlP4csqqp30lVkBk
         //nDTRyu1jyIkWKDT93RmcOEY3RAkPTshrZuEju9vhQYmDr8JAet2yZtpnt+YW+F3b
         88Hj+K6ncGfOq8T+6m0xlZYLb8fnSd86ZTM/r6kQ=
MIME-Version: 1.0
Date:   Wed, 09 Feb 2022 16:31:49 +0000
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: pm8226: Add VADC node
In-Reply-To: <20220207174933.20909-1-rayyan@ansari.sh>
References: <20220207174933.20909-1-rayyan@ansari.sh>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <506ae7e105b6f4f88e13e226aee060ea@ansari.sh>
X-Sender: rayyan@ansari.sh
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-07 17:49, Rayyan Ansari wrote:
> Add a node for the voltage ADC (VADC) found in PM8226.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi
> b/arch/arm/boot/dts/qcom-pm8226.dtsi
> index b3d0f7b5874d..a651b4c941b8 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -40,6 +40,39 @@ smbb: charger@1000 {
>  			chg_otg: otg-vbus { };
>  		};
> 
> +		pm8226_vadc: adc@3100 {
> +			compatible = "qcom,spmi-vadc";
> +			reg = <0x3100>;
> +			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			adc-chan@7 {
> +				reg = <VADC_VSYS>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
> +			};
> +			adc-chan@8 {
> +				reg = <VADC_DIE_TEMP>;
> +				label = "die_temp";
> +			};
> +			adc-chan@9 {
> +				reg = <VADC_REF_625MV>;
> +				label = "ref_625mv";
> +			};
> +			adc-chan@a {
> +				reg = <VADC_REF_1250MV>;
> +				label = "ref_1250mv";
> +			};
> +			adc-chan@e {
> +				reg = <VADC_GND_REF>;
> +			};
> +			adc-chan@f {
> +				reg = <VADC_VDD_VADC>;
> +			};
> +		};
> +
>  		pm8226_mpps: mpps@a000 {
>  			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
>  			reg = <0xa000>;

Ignore this patch, I forgot to include a header.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958D4ACAED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiBGVIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBGVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:08:35 -0500
Received: from fwd1.porkbun.com (fwd1.porkbun.com [52.10.174.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F9C0401DC;
        Mon,  7 Feb 2022 13:08:32 -0800 (PST)
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id 2B02241D0D; Mon,  7 Feb 2022 21:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644268112;
        bh=AEtROBqGP+jR5/7k+vesyxPbPrG5TrVHsHV0dRCttac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=rByPbPnPa+x8igDKssb1ZXs3Nq8PdEeFMpTk2fePlNXhOqBzm8j2dILWc5UryruxT
         4HtekvThgUKzYRxUQctWKopmhknG8Ngrovei5fGBdWXzBXgKhIe1Q0H5BvnoDShn1/
         A4OJgFFZcntes+z+JpPQCz1xtcXqUMd+79KbVywo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from webmail.porkbun.com (unknown [35.86.129.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id 40DFA41BD1;
        Mon,  7 Feb 2022 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644268099;
        bh=AEtROBqGP+jR5/7k+vesyxPbPrG5TrVHsHV0dRCttac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ZowXWhFxvTLt67TGpC0v5YQ1O65hMBhkNW0QviykJ92mkzCyS+M0GKxfAOTbGruLT
         Ac0fhz2G2d3xa521urTiC229ZUDPenFchxg3aaHH3tlQqWZy6sHUAJs+tAmonWHGLP
         dwzFA1tkxh76+DUKFpDSCspRn4W0gfJSvoEnbFLQ=
MIME-Version: 1.0
Date:   Mon, 07 Feb 2022 21:08:19 +0000
From:   rayyan@ansari.sh
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] arm64: dts: qcom: Add PM8953 PMIC
In-Reply-To: <20220112194118.178026-12-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-12-luca@z3ntu.xyz>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5e2c2d486c1d1f4794328f7b6c9035d1@ansari.sh>
X-Sender: rayyan@ansari.sh
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-12 19:41, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add a base DT for PM8953 PMIC, commonly used with MSM8953.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8953.dtsi | 90 ++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8953.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi
> b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> new file mode 100644
> index 000000000000..102555b3f313
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmic@0 {
> +		compatible = "qcom,pm8953", "qcom,spmi-pmic";
> +		reg = <0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rtc@6000 {
> +			compatible = "qcom,pm8941-rtc";
> +			reg = <0x6000>, <0x6100>;
> +			reg-names = "rtc", "alarm";
> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
> +		pm8953_pon: pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x800>;
> +			mode-bootloader = <0x2>;
> +			mode-recovery = <0x1>;
> +
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x00 0x08 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +
> +			pm8953_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x00 0x08 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
> +		};
> +
> +		temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +			io-channels = <&pm8953_vadc 0x08>;
> +			io-channel-names = "thermal";
> +			#thermal-sensor-cells = <0x00>;
> +		};
> +
> +		pm8953_vadc: vadc@3100 {
> +			compatible = "qcom,spmi-vadc";
> +			reg = <0x3100>;
> +			interrupts = <0x00 0x31 0x00 0x01>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +
> +			die_temp@8 {
> +				reg = <VADC_DIE_TEMP>;
> +			};
> +			ref_625mv@9 {
> +				reg = <VADC_REF_625MV>;
> +			};
> +			ref_1250v@a {
> +				reg = <VADC_REF_1250MV>;
> +			};
> +			ref_buf_625mv@c {
> +				reg = <VADC_SPARE1>;
> +			};
> +			ref_gnd@e {
> +				reg = <VADC_GND_REF>;
> +			};
> +			ref_vdd@f {
> +				reg = <VADC_VDD_VADC>;
> +			};

Could you use the generic names for each VADC channel as recommended in 
qcom,spmi-vadc.yaml?

> +		};
> +	};
> +
> +	pmic@1 {
> +		compatible = "qcom,pm8953", "qcom,spmi-pmic";
> +		reg = <1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};

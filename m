Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E54B73CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiBOQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:40:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbiBOQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:40:34 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8AF212D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:40:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m10so21360526oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1kj9pE4xw6JAJzinakuQqOKg6JJ0KzkGT4gYU3pHWA=;
        b=UCeI7kpxKycxeDv1CKWVXZiSqQZl7pCD/Zi0Nn3FNq3/b6tW5KckWNvCu73yVCLynj
         tCJq1ODydHRD39fH5qHnxqOJqJLVz3jkbcavRpeXAJnRcNuHIOo+HTRZHB0Mc4d3Bi3p
         Od1LuZhoT50Uce+glyEI0gfVmvUrW/OVI2bql8B1YEiCpeiZvZWdeRjn5da4UlWV79pH
         CRT5vtEZAD9Sx8lZHCTtt85jWIigmAFLchrwoWa1JwKM3vC/n55xqG6/8vrLMauyGD6f
         wvs17n2TNHLYXbPIdfFxRxabOftLSvL7hWs9hIQS7BzWVIKRCFImVfyqpNH2RFUZf2I5
         MXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1kj9pE4xw6JAJzinakuQqOKg6JJ0KzkGT4gYU3pHWA=;
        b=6FY7pPf2PTV+sudXlf2N1tory5XMLu+WtnjFBFPfvUdYVtqFgl1jGkMGSflkDxM+u9
         pGh/imEZfau5NFm9GT8x16CuoWtvTQCouKzzLHB39HRrDE53ecuNbw6Lx4/iw+1e1drv
         4bmMO+o9mKFHpyhEyJXi/6S8fQrc+r08vvsO7yKuxXHL7SkVLDseJXKZjvbzCox10t8O
         JOd2ZCxArhydOAeDMtsl6f6qa+gaP4crGWwqfFQazpLHSQYV0GlXwG8Xpgkypv9KMAro
         x7LxcNxlIykhdVn5y+G1KjKNPrDsyb7JKOqYT56u34AH6lvwAIlxn30gHwH5F4mH6zxK
         D6tQ==
X-Gm-Message-State: AOAM533herqk0YddC6tdJQdvOe2Lu+jHbm+972aRCvvjy0vGLh/B/z3/
        cc34wHq2UJJbjlToMlnPkckfig==
X-Google-Smtp-Source: ABdhPJwywAFvvPp04iK1gyctbPPD1igrq3/W2+Vd3W1gPOO1Z7BW13OeaSkecxF5Lrcky9rnyejdRw==
X-Received: by 2002:aca:3886:0:b0:2cf:6189:ee47 with SMTP id f128-20020aca3886000000b002cf6189ee47mr1954823oia.58.1644943223401;
        Tue, 15 Feb 2022 08:40:23 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id x3sm1703671oiv.29.2022.02.15.08.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:40:22 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:40:20 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] arm64: dts: qcom: Add MSM8953 device tree
Message-ID: <YgvXdFZfWEzHF2Oy@yoga>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-11-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-11-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Jan 13:40 CST 2022, Luca Weiss wrote:

> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add a base DT for MSM8953 SoC.
> 
> Co-developed-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 1337 +++++++++++++++++++++++++
>  1 file changed, 1337 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> new file mode 100644
> index 000000000000..59918b527750
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -0,0 +1,1337 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8953.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;

Why do you have address/size-cells of 2, and then limit them to 1 in
/soc?

> +
> +	aliases {
> +		i2c1 = &i2c_1;
> +		i2c2 = &i2c_2;
> +		i2c3 = &i2c_3;
> +		i2c4 = &i2c_4;
> +		i2c5 = &i2c_5;
> +		i2c6 = &i2c_6;
> +		i2c7 = &i2c_7;
> +		i2c8 = &i2c_8;

It was expressed a while back that you should specify alias only for the
things that you have enabled in your .dts.

> +	};
[..]
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x1905000 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tcsr: syscon@1937000 {
> +			compatible = "qcom,tcsr-msm8953", "syscon";
> +			reg = <0x1937000 0x30000>;
> +		};
> +
> +		tcsr_phy_clk_scheme_sel: syscon@193f044 {

I don't fancy exposing a single word from the middle of &tcsr using a
syscon. The tcsr node should express the TCSR region and if we need to
reference bits of information within that we should do that in some
structured way.

Wouldn't nvmem be a good candidate for this?

> +			compatible = "syscon";
> +			reg = <0x193f044 0x4>;
> +		};
> +

Regards,
Bjorn

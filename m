Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9380514FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbiD2PlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiD2PlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:41:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381FD64EF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:37:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m23so10958158ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=stMkcO1S0hj0oX1Ei7gZipJbH9uphrCYExzSuAxWDnE=;
        b=NKCCeEJE9f8DUHpV/aph0PNc62HIWap5nE7ORU3YbR6Sho4UxPWg6jrvTve8/euDHk
         dHAoRd7oE/Af+it9j8yPKMn1GYZ+maYB4q7dWrwURUFg+UE5x6K/yaQMLmajxJBJgK0/
         EJHIQ/TgHbR6+Q8ei5Az05eVALoN3hsUNH4E6W3RRJHkSGS73tJ5JHNTYkXfz28P7zH1
         f5+v28UkmbcGqJUnMraOL6fsf86hxDNBXZyLj7gsHw2E2xfA5QVzcJ2aVd2c+bD8SVAZ
         5zQkBBA+vr9rLUTl0LzSY9xkJMGKHK5TbFBKcc512vC7xThlX+V1dZ+T21KwgL4i2Z4O
         ERwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=stMkcO1S0hj0oX1Ei7gZipJbH9uphrCYExzSuAxWDnE=;
        b=7JAuYZSsVoJI2nH2j9BA7xiwleSbC+ucO7nLoKgURxE0GT0AghUXFPyjJPsiuDGqVJ
         UjH2ZqQbi/he+84pZPuiKNj1lLdv3yHaMEz3GRH7Xr1SfG0OiSm0LAmgNTubDJCNw7bv
         AWcXZdGjcWd6yYDT64IGpqj/SmC4+fy7lP++jxAI43+yd7InnyIIX6zJqnnMtW07P0U1
         v0cf1GP0zysObwgD3ynpfkAfri2PmfL1/GnXYo3mX9+o3K6HnnSGxz/YOSwnCJ7Vdh4C
         cEmDZ4pE5WUL2gAo8CAHWmvXhwVYc7aAL7jmlpo52+ADp9K9dDqZq52+o2yF4PHh0/Bl
         H/tw==
X-Gm-Message-State: AOAM533B8DRkmRdlQbePtnH65dkQiz5A7lmoY2LDCJYiMlGgh+bJx6nu
        aPBRJAp4XbCrw3ZbBe+sgjmpfA==
X-Google-Smtp-Source: ABdhPJxetaWuG1XOD9dG5eRmAlrCUuWE+0U+tFUzXJ5T7c2By9DA0oDU9maPvnEw9MvQl/UQenQ0pw==
X-Received: by 2002:a2e:855a:0:b0:24f:4e0:e426 with SMTP id u26-20020a2e855a000000b0024f04e0e426mr20580382ljj.330.1651246677526;
        Fri, 29 Apr 2022 08:37:57 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 5-20020ac24d45000000b0047210300c96sm263523lfp.137.2022.04.29.08.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:37:57 -0700 (PDT)
Message-ID: <82726e9e-8089-e43e-3493-8d906d3ae830@linaro.org>
Date:   Fri, 29 Apr 2022 18:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 9/9] arm64: dts: qcom: sm8350: Add DISPCC node
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-9-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-9-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 18:12, Robert Foss wrote:
> Add the dispcc clock-controller DT node for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

With mmcx-supply removed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index c49735d1b458..252fdef927cb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -3,7 +3,9 @@
>    * Copyright (c) 2020, Linaro Limited
>    */
>   
> +#include <dt-bindings/interconnect/qcom,sm8350.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,dispcc-sm8350.h>
>   #include <dt-bindings/clock/qcom,gcc-sm8350.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/dma/qcom-gpi.h>
> @@ -2533,6 +2535,29 @@ usb_2_dwc3: usb@a800000 {
>   			};
>   		};
>   
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,sm8350-dispcc";
> +			reg = <0 0x0af00000 0 0x10000>;
> +			mmcx-supply = <&mmcx_reg>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "bi_tcxo",
> +				      "dsi0_phy_pll_out_byteclk",
> +				      "dsi0_phy_pll_out_dsiclk",
> +				      "dsi1_phy_pll_out_byteclk",
> +				      "dsi1_phy_pll_out_dsiclk",
> +				      "dp_phy_pll_link_clk",
> +				      "dp_phy_pll_vco_div_clk";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>   		adsp: remoteproc@17300000 {
>   			compatible = "qcom,sm8350-adsp-pas";
>   			reg = <0 0x17300000 0 0x100>;


-- 
With best wishes
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94DE54F8AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382492AbiFQNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382386AbiFQNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:55:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84DF2F65B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:55:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p18so7103249lfr.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mSVdlrZwQBdRNTbOurp3xHACayt6ICnyCyJkN4WwF/E=;
        b=CJAPPp0Q592579nygMx7NnFAtrXHmBjj0VbS6q3wYNKvTiY2X49o0KjPgH1d743lct
         QNj1RZsfZQm9lr7Iks9hVM8wDiqJ87Jhl7QZ3bdg5q3GORT3uCTMxDRwQC3d18peE6aj
         ttNbek2WPier8b3XlwURBvxivnT/pc/6iKjG2odBxpAwEFTKmp9SsXLYTGs3451r73nI
         cDXJJZc2Ze99vWm4+z/u7Rtwe0RMHTjcGtFL8HhK23Y/kFjWh2t8nxZrPRG2V8OXE4Xq
         FJX4MEvi61GzO2Q5Wnm5aa2BPgGx6phnkcFrCuZVGafRLkPrz9a7S24oaOrVJJRoB3YP
         N7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mSVdlrZwQBdRNTbOurp3xHACayt6ICnyCyJkN4WwF/E=;
        b=URk74yEl7++PDQcIAf4bAgFPrhUZ0c+baatgmWiLrVQ/JHSjHlh8q3IvTWgP0lPKIt
         2H3w71tlc4D6FiDmzo8oNbRuaIPtjVmXrW8xZwfebNQFnPEi4A6nHEKSZEqJ84kRu2AO
         Zq7B8hPf5qIcah3vNa/HxuohYYeS+ZnjnAajB61dvR952Pq6Decehj51SqdqdVA+b26s
         SIpjLD/YovcQJbhvSYyHGl+kGrtzE+PP5R1OwirAC+gOAetK33Q+nJDlFmZqtTuRVeL9
         c1fAQ+USpMshryu004y+pc1G14TlhKw7lyCI5EiAB1uy/2vVMLbI/alzDrapzH939313
         8e7g==
X-Gm-Message-State: AJIora+aeFsP5GFHYPvmF/+8605jrMI0CxvN3gk5b/cKxqm8ovwd0tUA
        l6z3n5dj1G0wOREHDMDv0MebMw==
X-Google-Smtp-Source: AGRyM1u7saiT0IStvE2BqMAh3YsaZYv9yS135+UBfFFzhy/jP+fGGNQXVlplJ4ktB9J754nE3oDH2Q==
X-Received: by 2002:a05:6512:3ba3:b0:478:f078:d44c with SMTP id g35-20020a0565123ba300b00478f078d44cmr5843553lfv.351.1655474126131;
        Fri, 17 Jun 2022 06:55:26 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h21-20020ac24d35000000b004795a3181absm646808lfk.69.2022.06.17.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:55:25 -0700 (PDT)
Message-ID: <11aeba3d-5d45-e436-18b3-4d4f680d184a@linaro.org>
Date:   Fri, 17 Jun 2022 16:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: msm8953: add MDSS
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220612092218.424809-1-luca@z3ntu.xyz>
 <20220612092218.424809-5-luca@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220612092218.424809-5-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2022 12:22, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v1:
> - disable nodes by default, thanks Dmitry!
> - enable iommu for mdp
> 
>   arch/arm64/boot/dts/qcom/msm8953.dtsi | 208 ++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 961db3e23ee4..c7373c845f41 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -726,6 +726,214 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
>   			reg = <0x193f044 0x4>;
>   		};
>   
> +		mdss: mdss@1a00000 {
> +			compatible = "qcom,mdss";
> +
> +			reg = <0x1a00000 0x1000>,
> +			      <0x1ab0000 0x1040>;
> +			reg-names = "mdss_phys",
> +				    "vbif_phys";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
> +			clock-names = "iface",
> +				      "bus",
> +				      "vsync";

I've sent the patches using "core" clock for the mdss ([1]). Please 
consider utilizing it here.

[1]: https://patchwork.freedesktop.org/series/105162/

> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			status = "disabled";
> +
[skipped the rest]

-- 
With best wishes
Dmitry

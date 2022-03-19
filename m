Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACC4DE8C5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbiCSOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbiCSOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:44:33 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFD56404;
        Sat, 19 Mar 2022 07:43:06 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id j15so7935753eje.9;
        Sat, 19 Mar 2022 07:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2K9xNCSfVRll95LKjtA+ZFFUY//W/i74AdYYFDO0Wk0=;
        b=AiIrSOcsrfAHBCkCkOSD7wAhliFozhtU663cz02TIItyq0InpaQPiQOGrrl2XfE23V
         6n+CkBOz0Vk3rav1mAB4kHJ8Mc/YuXLuNJnChrH9LNSQsRvZWXwbSv78biwX7+ddxGP0
         ws4dQONs5UMCdF3ycByGSPkPLpxCNmQm2FqRlGWgRCknMwT+Ipu1HKrB/rEVUMi1i5qU
         +mNs1zKqnRvr6bejpONCf33lBePNa0e3jd0/6Xk6nvi6y+ZwFLkWn5iBk71wTNAOoJMW
         HKRV4Ta4gjnMXaXwL03mk2QdMeIcmlPubV+SNwYawmex2aYIZm8L4hFTsqb9e9MHxcsj
         a1qg==
X-Gm-Message-State: AOAM533tZxnJyyJH3AQZwISKTtczhRtlDtoGwGzqTsEoZ/jFi/hd4/mS
        8X5ngO34d+xQTJLITBdWf9g=
X-Google-Smtp-Source: ABdhPJwf2WsjjkOa2ZXEEMQnBghWTfKPAvRrU3+MpBTnX3RYXyomUtJRvdRhLl0FpNQmH3AjtSaa7Q==
X-Received: by 2002:a17:907:7254:b0:6db:ad8f:27b4 with SMTP id ds20-20020a170907725400b006dbad8f27b4mr13488747ejc.599.1647700984696;
        Sat, 19 Mar 2022 07:43:04 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id m12-20020a17090677cc00b006df85d9a924sm4329478ejn.217.2022.03.19.07.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:43:04 -0700 (PDT)
Message-ID: <c88ed4b5-2e44-c3fd-ff2b-b4bee1354765@kernel.org>
Date:   Sat, 19 Mar 2022 15:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm6350: Add UFS nodes
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
 <20220318183004.858707-6-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318183004.858707-6-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 19:30, Luca Weiss wrote:
> Add the necessary nodes for UFS and its PHY.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 79 ++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index d7c9edff19f7..c5c93b6bcd2a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -541,6 +541,85 @@ uart2: serial@98c000 {
>  			};
>  		};
>  
> +		ufs_mem_hc: ufshc@1d84000 {

Generic node name, so ufs.

> +			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0 0x01d84000 0 0x3000>,
> +			      <0 0x01d90000 0 0x8000>;
> +			reg-names = "std", "ice";
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			iommus = <&apps_smmu 0x80 0x0>;
> +
> +			clock-names =

Drop unneeded blank line, start just after '=' and align next elements
with it.

> +				"core_clk",
> +				"bus_aggr_clk",
> +				"iface_clk",
> +				"core_clk_unipro",
> +				"core_clk_ice",
> +				"ref_clk",
> +				"tx_lane0_sync_clk",
> +				"rx_lane0_sync_clk",
> +				"rx_lane1_sync_clk";
> +			clocks =

The same.


Best regards,
Krzysztof

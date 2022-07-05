Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB2566FAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGENoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiGENn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:43:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4972CCA4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:08:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu42so604930lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1ALZ4/PqL8MWshKy7QXRBD1PzrOacYbyo6I8jS34n90=;
        b=EVtUUR0AHgY14YanyVUhvle7uBzof+Adsv/0J0NucfyhCyS5eICnnMraWU+ql6U+UK
         DKxalum8br916UMLFqqaB+5Qh+EvjQQlo6+6BMNjFRWoAzTK3HLhM+K7VCeQueFbV2hm
         C/Tc+Ne/mRsY11VK/HeBQ9CAn49gRMwCM1BG4r72DFhwUyIZ2a6l/o4tPKhIbM4FZOGR
         cFCxyK7wnC3a5vcpY3qUDo7PNieobZRR1oLRxTrZ+88coUUiQqJkO7jmN5dEUlo2eECc
         AJdzHZI7HF5A2c749BvTBQcXp++FnmzNVHQVAphWd2Fp9tBWxahmo+grC7/QyqirJzLU
         RSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1ALZ4/PqL8MWshKy7QXRBD1PzrOacYbyo6I8jS34n90=;
        b=jmJTkCbuxMqZxLArrD1BQ1l9ylm+mFyREzfwEm6Qh/51ApKPqhzWZ0S30w4nWW3ScD
         vQACZAKV6cihWlOyfZkgJAiCQnSlsugeTN3mmRYVDsSpVorP8xwZ/YUVI2vUcbujNSJ4
         ulncxo8XxrYFfC1epksfATLHT86tPS96JFDrwVBSjoQ6XnMLAdLXFKTC6weJZ1khYqRj
         07nnywTlrCXT2HhHux3Xjq5ipdQAEn20zhzTX3aiui7vpqPDPUxROpvqHklDIA2sPmx4
         AECCHFaDonJo/4FthF/op4TG3eWhUAV+t/YX1foMVE5111eViKnRY0PZuIJaSXTZcCDJ
         upaQ==
X-Gm-Message-State: AJIora9d6gM9oC6xyfaHHCFyyhhLHvDV70YIRreJdyvTxQ/J1q1r3Sfg
        U/KJbxtgXVZ+61Si7rtnrw74sA==
X-Google-Smtp-Source: AGRyM1skhDvMDz6fWBLBnkSwusjLrg0TYBCJGScxZZHrVbyU8OhICtUWbwPS5bDSGltSAVSbEB6m5w==
X-Received: by 2002:ac2:4f02:0:b0:481:43a8:e368 with SMTP id k2-20020ac24f02000000b0048143a8e368mr20983909lfr.65.1657026480496;
        Tue, 05 Jul 2022 06:08:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a8-20020ac25208000000b0047f74ee6a1fsm5688589lfl.63.2022.07.05.06.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 06:08:00 -0700 (PDT)
Message-ID: <8a423377-a181-2f41-6c11-a0e2b0d46c92@linaro.org>
Date:   Tue, 5 Jul 2022 16:07:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 13/14] arm64: dts: qcom: msm8996: use non-empty ranges for
 PCIe PHYs
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:40, Johan Hovold wrote:
> Clean up the PCIe PHY nodes by using a non-empty ranges property.

A matter of taste, but nevertheless:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index b670d0412760..16869bb7d625 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -590,7 +590,7 @@ pcie_phy: phy@34000 {
>   			reg = <0x00034000 0x488>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x00034000 0x4000>;
>   
>   			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
>   				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
> @@ -603,10 +603,10 @@ pcie_phy: phy@34000 {
>   			reset-names = "phy", "common", "cfg";
>   			status = "disabled";
>   
> -			pciephy_0: phy@35000 {
> -				reg = <0x00035000 0x130>,
> -				      <0x00035200 0x200>,
> -				      <0x00035400 0x1dc>;
> +			pciephy_0: phy@1000 {
> +				reg = <0x1000 0x130>,
> +				      <0x1200 0x200>,
> +				      <0x1400 0x1dc>;
>   				#phy-cells = <0>;
>   
>   				#clock-cells = <0>;
> @@ -617,10 +617,10 @@ pciephy_0: phy@35000 {
>   				reset-names = "lane0";
>   			};
>   
> -			pciephy_1: phy@36000 {
> -				reg = <0x00036000 0x130>,
> -				      <0x00036200 0x200>,
> -				      <0x00036400 0x1dc>;
> +			pciephy_1: phy@2000 {
> +				reg = <0x2000 0x130>,
> +				      <0x2200 0x200>,
> +				      <0x2400 0x1dc>;
>   				#phy-cells = <0>;
>   
>   				#clock-cells = <0>;
> @@ -631,10 +631,10 @@ pciephy_1: phy@36000 {
>   				reset-names = "lane1";
>   			};
>   
> -			pciephy_2: phy@37000 {
> -				reg = <0x00037000 0x130>,
> -				      <0x00037200 0x200>,
> -				      <0x00037400 0x1dc>;
> +			pciephy_2: phy@3000 {
> +				reg = <0x3000 0x130>,
> +				      <0x3200 0x200>,
> +				      <0x3400 0x1dc>;
>   				#phy-cells = <0>;
>   
>   				#clock-cells = <0>;


-- 
With best wishes
Dmitry

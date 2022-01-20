Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58382494C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiATKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:54:12 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20783 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbiATKyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642676046; x=1674212046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OQxEySdr4f1nr1SBYHxpL92c8SRLaP68TBUursFakxg=;
  b=k0uhan7wA1J/TqCRb06WRcaYOEL38yKZA/Fnh1fEVfBubfqrDBgHwkLl
   JR5rEREwWaY+v0sqrwyKDvOKVPhvqlPw60AetnN9AnkE4dXgnpR0G0SAW
   4AZUq9cpAod+JhyeyUkE5gqwx/y3UuxgzZ4zfxWk/7gRGJvygiYar3G+f
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jan 2022 02:54:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:54:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:54:05 -0800
Received: from [10.216.6.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 20 Jan
 2022 02:53:59 -0800
Message-ID: <816df5c9-aa89-e019-4036-6c9a79e534bd@quicinc.com>
Date:   Thu, 20 Jan 2022 16:23:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8150: Add pdc interrupt
 controller node
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <bhupesh.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
 <20220119203133.467264-4-bhupesh.sharma@linaro.org>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <20220119203133.467264-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/2022 2:01 AM, Bhupesh Sharma wrote:
> Add pdc interrupt controller for sm8150.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 6012322a5984..cc4dc11b2585 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1626,6 +1626,16 @@ system-cache-controller@9200000 {
>   			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sm8150-pdc", "qcom,pdc";
> +			reg = <0 0x0b220000 0 0x400>, <0 0x17c000f0 0 0x60>;

<0x17c000f0 0x64>;

Remove the second reg, its not used in the driver and also not 
documented yet.

Thanks,
Maulik
> +			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
> +					  <125 63 1>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
>   		ufs_mem_hc: ufshc@1d84000 {
>   			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";

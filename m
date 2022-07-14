Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B95745C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiGNHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiGNHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:17:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421913E38;
        Thu, 14 Jul 2022 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657783046; x=1689319046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lVDa0Ra8BPX8SfKu3uDgPJAJ7DsotlSCQsd1gi3W+Ro=;
  b=ESfK9u3aqQH6HJzrgGuyeg9MQkOPlCxfqNunMNvYBZTUv9USM6AnzQMB
   GlKo6oiX/WjVTHSywIABfgiNOBdtxjkTN8doU+pDL5FR+x473+pv7CWUo
   WEfnXQU/ABwKokPC95EYRGnf4AmcMLaGw9All/3AwV0XzVJdn4oNAwoWg
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 00:17:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 00:17:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 00:17:24 -0700
Received: from [10.50.55.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 00:17:21 -0700
Message-ID: <27007c45-1dbb-2c35-b1a8-eb2b2a6c9512@quicinc.com>
Date:   Thu, 14 Jul 2022 12:47:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: fix apps_smmu irq
Content-Language: en-US
To:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasanna Kumar <quic_kprasan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20220712140009.20765-1-quic_ppareek@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220712140009.20765-1-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parikshit,

On 7/12/2022 7:30 PM, Parikshit Pareek wrote:
> Wrong values have been introduced for interrupts property. Fix those
> ones, and correct the mapping of context banks to irq number.
>
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 7945cbb57bb4..1276a833251e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1580,7 +1580,6 @@
>   				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1591,6 +1590,7 @@
>   				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,

Cross checking with the IP doc, 696 is not the only one missing, couple of other interrupts are also missing, below is the list.

Interrupt 689 and 706 are not present in the IP doc, remove it.
Interrupts 696, 697, 716, 913 are missing, I see this patch adds 696, add 697 as well.
Interrupt 890 is not a context interrupt, remove it.


Thanks,
Sai

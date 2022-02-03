Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2765F4A82E7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbiBCLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:07:21 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:43148 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbiBCLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643886438; x=1675422438;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2C+3IsYfm09Uf6TZuQK9DHohoF0hBiKau/8SF3sQH0I=;
  b=t36cXuzJqksOE/9dWfaka3/EtRfp9ZCEf1Cj/vA8LDtdJ15XnHLZFnSq
   pYbyNsyHhgyKMMrRh27bMZA4loFZR49jocX35T1YMYf0pM3ZYVRebElhD
   viUE8YNxs9Aq4SjOawfaVzk8UGpuhLCba4ux9vpFlHeLlJpxZLdphr1rd
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2022 03:07:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:07:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:07:16 -0800
Received: from [10.216.62.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 03:07:12 -0800
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
 <1641208380-15510-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51QAJFBALV7eEKLDunQaCNqPyTmdHRRUt7Khvkt8st=_g@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <fdd74ba3-935d-b5fa-e642-6fedaf33116c@quicinc.com>
Date:   Thu, 3 Feb 2022 16:37:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51QAJFBALV7eEKLDunQaCNqPyTmdHRRUt7Khvkt8st=_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2022 2:37 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-01-03 03:12:59)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index c0d9de3..68c7755 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -17,6 +17,7 @@
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,lpass.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>
>>   / {
>> @@ -1840,6 +1841,62 @@
>>                          #size-cells = <0>;
>>                  };
>>
>> +               lpass_cpu: qcom,lpass@3260000 {
> audio-subsystem@3260000?
Okay. will change accordingly.
>
>> +                       compatible = "qcom,sc7280-lpass-cpu";
>> +                       reg = <0 0x3260000 0 0xC000>,
>> +                               <0 0x3280000 0 0x29000>,
>> +                               <0 0x3340000 0 0x29000>,
>> +                               <0 0x336C000 0 0x3000>,
>> +                               <0 0x3987000 0 0x68000>,
>> +                               <0 0x3B00000 0 0x29000>;
>> +                       reg-names = "lpass-rxtx-cdc-dma-lpm",
>> +                                       "lpass-rxtx-lpaif",
>> +                                       "lpass-va-lpaif",
>> +                                       "lpass-va-cdc-dma-lpm",
>> +                                       "lpass-hdmiif",
>> +                                       "lpass-lpaif";
>> +
>> +                       iommus = <&apps_smmu 0x1820 0>,
>> +                               <&apps_smmu 0x1821 0>,
>> +                               <&apps_smmu 0x1832 0>;
>> +                       status = "disabled";
>> +
>> +                       power-domains = <&rpmhpd SC7280_LCX>;
>> +                       power-domain-names = "lcx";
>> +                       required-opps = <&rpmhpd_opp_nom>;
>> +
>> +                       clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
>> +                                       <&lpasscc LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
>> +                                       <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
>> +                                       <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
>> +                                       <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
>> +                                       <&lpasscc LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
>> +                                       <&lpasscc LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
>> +                                       <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
>> +                       clock-names = "aon_cc_audio_hm_h",
>> +                                       "core_cc_sysnoc_mport_core",
>> +                                       "audio_cc_codec_mem0",
>> +                                       "audio_cc_codec_mem1",
>> +                                       "audio_cc_codec_mem2",
>> +                                       "core_cc_ext_if0_ibit",
>> +                                       "core_cc_ext_if1_ibit",
>> +                                       "aon_cc_va_mem0";
> Please align these things on " and <.
Okay.
>
>> +
>> +                       #sound-dai-cells = <1>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>> +                                               <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
>> +                                               <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
>> +                                               <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +                       interrupt-names = "lpass-irq-lpaif",
>> +                                       "lpass-irq-vaif",
>> +                                       "lpass-irq-rxtxif",
>> +                                       "lpass-irq-hdmi";
> Same.
Okay.
>
>> +               };
>> +
>>                  vamacro: codec@3370000 {
>>                          compatible = "qcom,sc7280-lpass-va-macro";
>>                          pinctrl-0 = <&dmic01_active>;
>> --
>> 2.7.4
>>

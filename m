Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1C4A82F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350063AbiBCLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:10:44 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59479 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiBCLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643886643; x=1675422643;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tUkvSCXv5sVqRR0CMxg/pwmt2Q5ctAdeRzvoDev75VM=;
  b=qTYLue21/KWuYxXdnX/RmNpO2SS0IWtZSMvORTfz1l9lPaB5Kg266rAv
   61yKumJotLtxu07oyA1x5WQnmBcxJrruz0JlhiGpH69wp6QW4eWDi133M
   oVorla0NpXY8XUDRRQ2ZE7p9I+XFdQdfU9va/uyoXOFLY6qnE6CUrQYFZ
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 03:10:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 03:10:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 03:10:42 -0800
Received: from [10.216.62.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 03:10:37 -0800
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: add sound card support
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
 <1641208380-15510-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n5069ehb97ybJV7Z0FXnODvRBuy-w6r1KJSfZnHece7k1A@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <4ea4cac4-4372-9235-269f-d987cf816cf2@quicinc.com>
Date:   Thu, 3 Feb 2022 16:40:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n5069ehb97ybJV7Z0FXnODvRBuy-w6r1KJSfZnHece7k1A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2022 2:40 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-01-03 03:13:00)
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 3449d56..63b1184 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -637,6 +637,99 @@
>>          };
>>   };
>>
>> +&sound {
>> +       compatible = "google,sc7280-herobrine";
>> +       model = "sc7280-wcd938x-max98360a-1mic";
>> +       status = "okay";
>> +       audio-routing =
>> +               "IN1_HPHL", "HPHL_OUT",
>> +               "IN2_HPHR", "HPHR_OUT",
>> +               "AMIC1", "MIC BIAS1",
>> +               "AMIC2", "MIC BIAS2",
>> +               "VA DMIC0", "MIC BIAS3",
>> +               "VA DMIC1", "MIC BIAS3",
>> +               "VA DMIC2", "MIC BIAS1",
>> +               "VA DMIC3", "MIC BIAS1",
>> +               "TX SWR_ADC0", "ADC1_OUTPUT",
>> +               "TX SWR_ADC1", "ADC2_OUTPUT",
>> +               "TX SWR_ADC2", "ADC3_OUTPUT",
>> +               "TX SWR_DMIC0", "DMIC1_OUTPUT",
>> +               "TX SWR_DMIC1", "DMIC2_OUTPUT",
>> +               "TX SWR_DMIC2", "DMIC3_OUTPUT",
>> +               "TX SWR_DMIC3", "DMIC4_OUTPUT",
>> +               "TX SWR_DMIC4", "DMIC5_OUTPUT",
>> +               "TX SWR_DMIC5", "DMIC6_OUTPUT",
>> +               "TX SWR_DMIC6", "DMIC7_OUTPUT",
>> +               "TX SWR_DMIC7", "DMIC8_OUTPUT";
>> +
>> +               qcom,msm-mbhc-hphl-swh = <1>;
>> +               qcom,msm-mbhc-gnd-swh = <1>;
> Why are these last extra tabbed?
Okay. Will remove it.
>
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       #sound-dai-cells = <0>;
>> +
>> +       dai-link@6 {
>> +               link-name = "WCD Playback";
>> +               reg = <LPASS_CDC_DMA_RX0>;
>> +               cpu {
>> +                       sound-dai = <&lpass_cpu LPASS_CDC_DMA_RX0>;
>> +               };
>> +
>> +               codec {
>> +                       sound-dai = <&wcd938x 0>, <&swr0 0>, <&rxmacro 0>;
>> +               };
>> +       };
>> +
>> +       dai-link@19 {
>> +               link-name = "WCD Capture";
>> +               reg = <LPASS_CDC_DMA_TX3>;
>> +               cpu {
>> +                       sound-dai = <&lpass_cpu LPASS_CDC_DMA_TX3>;
>> +               };
>> +
>> +               codec {
>> +                       sound-dai = <&wcd938x 1>, <&swr1 0>, <&txmacro 0>;
>> +               };
>> +       };
>> +
>> +       dai-link@1 {
>> +               link-name = "Secondary MI2S Playback";
>> +               reg = <MI2S_SECONDARY>;
>> +               cpu {
>> +                       sound-dai = <&lpass_cpu MI2S_SECONDARY>;
>> +               };
>> +
>> +               codec {
>> +                       sound-dai = <&max98360a>;
>> +               };
>> +       };
>> +
>> +       dai-link@5 {
>> +               link-name = "DP Playback";
>> +               reg = <LPASS_DP_RX>;
>> +               cpu {
>> +                       sound-dai = <&lpass_cpu LPASS_DP_RX>;
>> +               };
>> +
>> +               codec {
>> +                               sound-dai = <&msm_dp>;
> Why double tabbed?
Okay. will remove it.
>
>> +               };
>> +       };
>> +
>> +       dai-link@25 {
>> +               link-name = "DMIC Capture";
>> +               reg = <LPASS_CDC_DMA_VA_TX0>;
>> +               cpu {
>> +                       sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
>> +               };
>> +
>> +               codec {
>> +                       sound-dai = <&vamacro 0>;
>> +               };
>> +       };
> The order of the nodes seems arbitrary. Is there any sort order that can
> be used to avoid conflicts in the future? Maybe the reg property because
> that's how we sort the SoC node.
Okay. Will change accordingly.
>
>> +};
>> +
>>   &swr0 {
>>          wcd_rx: wcd938x-rx{
>>                  compatible = "sdw20217010d00";
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 68c7755..57bc5ef 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2786,6 +2786,9 @@
>>
>>                  };
>>
>> +               sound: sound {
> Is this really necessary? Certainly it shouldn't be in the SoC node as
> it doesn't have a reg property.
Okay. will remove it here and add in board specific files.
>
>> +               };
>> +
>>                  usb_1_hsphy: phy@88e3000 {
>>                          compatible = "qcom,sc7280-usb-hs-phy",
>>                                       "qcom,usb-snps-hs-7nm-phy";
>> --
>> 2.7.4
>>

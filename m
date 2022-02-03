Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9394A828E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiBCKnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:43:23 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39433 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiBCKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643885000; x=1675421000;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iLYjfVRgu/NMwL/2Yx8B9HPwPGlUwYPeqGsyIpO3CrM=;
  b=xTUAnPknjwj3zoD2k4zh0uELkBW1J4I8Jvjp07hSBlrOPOchSGtIZWu4
   eMuE3vuZ2F/7Wi5FO3JXmQCCwcsCTUQMzL745B1c+EEPnRuyecrYus5c3
   MA3U+TbEZ/Ql9G7bMPH13gWGXoLZqGiuV6moc7ccWNenTHAi/SK9Z+RM6
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 02:43:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:43:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:43:19 -0800
Received: from [10.216.62.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 02:43:14 -0800
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Vincent Knecht <vincent.knecht@mailoo.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
 <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
 <f15a477aa01e2e972f54d1c36fa24df9cce48506.camel@mailoo.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <fa6cabdb-4eb5-2bbf-ceea-9883c9ae1eff@quicinc.com>
Date:   Thu, 3 Feb 2022 16:13:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f15a477aa01e2e972f54d1c36fa24df9cce48506.camel@mailoo.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2022 3:53 AM, Vincent Knecht wrote:
Thanks for Your team Vincent!!!
> Le lundi 03 janvier 2022 à 16:42 +0530, Srinivasa Rao Mandadapu a écrit :
>> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
>> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
>> Add these nodes for sc7280 based platforms audio use case.
>> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 ++
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  52 ++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 113 +++++++++++++++++++++++++++++++
>>   3 files changed, 169 insertions(+)
> [...]
>
>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index ddeb508..94614c9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -636,3 +636,55 @@
>>                  bias-pull-up;
>>          };
>>   };
>> +
>> +&swr0 {
>> +       wcd_rx: wcd938x-rx{
> Space before brace...
Okay.
>
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 4>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,rx-port-mapping = <1 2 3 4 5>;
>> +       };
>> +};
>> +
>> +&swr1 {
>> +       wcd_tx: wcd938x-tx{
> Ditto...
Okay.
>
>> +               compatible = "sdw20217010d00";
>> +               reg = <0 3>;
>> +               #sound-dai-cells = <1>;
>> +               qcom,tx-port-mapping = <1 2 3 4>;
>> +       };
>> +};
>> +
>> +&soc {
>> +       max98360a: audio-codec-0 {
>> +               compatible = "maxim,max98360a";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&amp_en>;
>> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
>> +               #sound-dai-cells = <0>;
>> +       };
>> +
>> +       wcd938x: codec {
>> +               compatible = "qcom,wcd9380-codec";
>> +               #sound-dai-cells = <1>;
>> +
>> +               reset-gpios = <&tlmm 83 0>;
> GPIO_ACTIVE_HIGH ?
Okay. Will change accordingly.
>

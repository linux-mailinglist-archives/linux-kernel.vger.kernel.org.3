Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4561F4A825E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349719AbiBCKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:34:51 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32322 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234355AbiBCKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643884490; x=1675420490;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9gWwvc8qN1nZHzXucwAWYiq6S0breJjv7fSYzpSenLo=;
  b=BNGe0ckdDsv2QPGe/y3/udo4wP34a26B2jOMCNCeJq+E9frieV7jZr6q
   ZRvtYcSp4HoTJBc/AJVUAAkKM0j4fyOBTXn5cbSHaNeBCO5FWmER27Ar8
   ZQ4S7yZxO2tiJkzakfKBCldqq14aEOIQW0lJnYTGd3OA41iGaR2Mz5YgT
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2022 02:34:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:34:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:34:49 -0800
Received: from [10.216.62.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 3 Feb 2022
 02:34:45 -0800
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
 <fd7f6a115ece824c75f5b8fd02f1fc84cefca176.camel@mailoo.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <5779db22-b4a7-b376-293d-9a5b7eb9acf8@quicinc.com>
Date:   Thu, 3 Feb 2022 16:04:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fd7f6a115ece824c75f5b8fd02f1fc84cefca176.camel@mailoo.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2022 3:34 AM, Vincent Knecht wrote:
Thanks for Your time Vincent!!!
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
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> index cd2755c..035cca9 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
>> @@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
>>          pins = "gpio51";
>>   };
>>   
>> +&wcd938x {
>> +       qcom,us-euro-gpios = <&tlmm 81 0>;
>> +};
>> +
> Maybe using a defined value is possible, rather than an obscure zero ?
> GPIO_ACTIVE_HIGH ?
Okay. Will change accordingly!!!
>
>
>

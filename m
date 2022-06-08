Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3058542FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiFHMH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiFHMHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:07:53 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9801E1D01D0;
        Wed,  8 Jun 2022 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654690070; x=1686226070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eixAlGC3/66qXleJOQL13o9s1uPtPCDR9p1TUd1YkLw=;
  b=NwjbTwHgEpkJeV1IG1+4JR87Kb+qUa6TMp7TwSMFmjcmtpJruaSp///v
   V+Jp/W4n1+cCzrxBmwXRIjzzCsdHD8gYpFYFj1BpDmpziQNSe5OnzQxPo
   hWPOBwPIBlqPjiAutQBCzl1xHklQjG73zQ5WOi2hhMhSYTnd8OucyaqeM
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jun 2022 05:07:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 05:07:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 05:07:49 -0700
Received: from [10.216.33.38] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 05:07:43 -0700
Message-ID: <e4c67862-d173-906f-e9c7-d26408135e3a@quicinc.com>
Date:   Wed, 8 Jun 2022 17:37:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-2-git-send-email-quic_kriskura@quicinc.com>
 <00cf0a30-46d5-f566-af35-9f7c33ec4182@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <00cf0a30-46d5-f566-af35-9f7c33ec4182@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/2022 3:06 PM, Krzysztof Kozlowski wrote:
> On 01/06/2022 08:56, Krishna Kurapati wrote:
>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>
>> Add device tree bindings for SNPS phy tuning parameters.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> index 1ce251d..daeeb04 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> @@ -53,6 +53,102 @@ properties:
>>     vdda33-supply:
>>       description: phandle to the regulator 3.3V supply node.
>>   
>> +  qcom,hs-disconnect-bp:
>> +    description:
>> +      This adjusts the voltage level for the threshold used to
>> +      detect a disconnect event at the host. Possible values are.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: -272
>> +    maximum: 2156
>> +
>> +  qcom,squelch-detector-bp:
>> +    description:
>> +      This adjusts the voltage level for the threshold used to
>> +      detect valid high-speed data.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: -2090
>> +    maximum: 1590
>> +
>> +  qcom,hs-amplitude-bp:
>> +    description:
>> +      This adjusts the high-speed DC level voltage.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: -660
>> +    maximum: 2670
>> +
>> +  qcom,pre-emphasis-duration-bp:
>> +    description:
>> +      This signal controls the duration for which the
>> +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
>> +      The HS Transmitter pre-emphasis duration is defined in terms of
>> +      unit amounts. One unit of pre-emphasis duration is approximately
>> +      650 ps and is defined as 1X pre-emphasis duration.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: 10000
>> +    maximum: 20000
>> +
>> +  qcom,pre-emphasis-amplitude-bp:
>> +    description:
>> +      This signal controls the amount of current sourced to
>> +      DP<#> and DM<#> after a J-to-K or K-to-J transition.
>> +      The HS Transmitter pre-emphasis current is defined in terms of unit
>> +      amounts. One unit amount is approximately 2 mA and is defined as
>> +      1X pre-emphasis current.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: 10000
>> +    maximum: 40000
>> +
>> +  qcom,hs-rise-fall-time-bp:
>> +    description:
>> +      This adjusts the rise/fall times of the high-speed waveform.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +    minimum: -4100
>> +    maximum: 5430
>> +
>> +  qcom,hs-crossover-voltage-microvolt:
>> +    description:
>> +      This adjusts the voltage at which the DP<#> and DM<#>
>> +      signals cross while transmitting in HS mode.
>> +      The values defined are in milli volts.
> It's not accurate anymore - it's microvolt. I propose to skip this one
> sentence, because unit is obvious from the type.

Hi Krzysztof,

Sure, will omit this line in the next series.

>> +    maximum: 28000
>> +
>> +  qcom,hs-output-impedance-micro-ohms:
>> +    description:
>> +      In some applications, there can be significant series resistance
>> +      on the D+ and D- paths between the transceiver and cable. This adjusts
>> +      the driver source impedance to compensate for added series
>> +      resistance on the USB. The values defined are in milli ohms.
> The same. Other places might need similar change.
>
> Best regards,
> Krzysztof

Sure, Will make sure to remove the basis points sentence from other 
params as well as bp has been added to dtschema and is self-explanatory.


Thanks,

Krishna,


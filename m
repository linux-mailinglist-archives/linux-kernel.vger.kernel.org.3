Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2B5525C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377815AbiEMHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377799AbiEMHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:34:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6A26CC67;
        Fri, 13 May 2022 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652427244; x=1683963244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yo78rzdHQ7MtB+XjdOalcRXdM1gAh94x2EuY0h91QFY=;
  b=tET2GvrLEngFH0MJS/gXb08pzmKuDRiZwK3DglQkscn/rmYuAXyL+onx
   624FzpyIqsqd4Z/z/M0VuwdceQfTOtf460rRfOK1gg05PETrnfLzUKH3r
   SzR4ivgg7V9B+ffOfdTjDiuhitYSkJt+yBZSqFC2AAecfZliQ8jMndbrR
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 May 2022 00:34:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 00:34:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 00:34:02 -0700
Received: from [10.206.28.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 00:33:56 -0700
Message-ID: <3abbb26f-9396-d024-67f6-f24f7db3408d@quicinc.com>
Date:   Fri, 13 May 2022 13:03:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v4 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
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
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Vinod Koul" <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
References: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
 <1652282793-5580-2-git-send-email-quic_kriskura@quicinc.com>
 <d296720d-ccbe-27f0-8ba1-9653af25dd52@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <d296720d-ccbe-27f0-8ba1-9653af25dd52@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/2022 11:49 PM, Krzysztof Kozlowski wrote:
> On 11/05/2022 17:26, Krishna Kurapati wrote:
>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>
>> Add device tree bindings for SNPS phy tuning parameters.
>>
>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 87 ++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> index 1ce251d..70efffe 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>> @@ -53,6 +53,93 @@ properties:
>>     vdda33-supply:
>>       description: phandle to the regulator 3.3V supply node.
>>   
>> +  qcom,hs-disconnect-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This adjusts the voltage level for the threshold used to
>> +      detect a disconnect event at the host. Possible values are.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
> This means there is some minimum and maximum (100%)?
>
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,squelch-detector-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This adjusts the voltage level for the threshold used to
>> +      detect valid high-speed data.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,hs-amplitude-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This adjusts the high-speed DC level voltage.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,pre-emphasis-duration-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This signal controls the duration for which the
>> +      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
>> +      The HS Transmitter pre-emphasis duration is defined in terms of
>> +      unit amounts. One unit of pre-emphasis duration is approximately
>> +      650 ps and is defined as 1X pre-emphasis duration.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,pre-emphasis-amplitude-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This signal controls the amount of current sourced to
>> +      DP<#> and DM<#> after a J-to-K or K-to-J transition.
>> +      The HS Transmitter pre-emphasis current is defined in terms of unit
>> +      amounts. One unit amount is approximately 2 mA and is defined as
>> +      1X pre-emphasis current.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,hs-rise-fall-time-bps:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This adjusts the rise/fall times of the high-speed waveform.
>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>> +      The hardware accepts only discrete values. The value closest to the
>> +      provided input will be chosen as the override value for this param.
>> +
>> +  qcom,hs-crossover-voltage-mv:
>> +    $ref: /schemas/types.yaml#/definitions/int32
>> +    description:
>> +      This adjusts the voltage at which the DP<#> and DM<#>
>> +      signals cross while transmitting in HS mode.
>> +      The values defined are in milli volts. The hardware accepts only
>> +      discrete values. The value closest to the provided input will be
>> +      chosen as the override value for this param.
>> +
>> +  qcom,hs-output-impedance-mohm:
>> +    $ref: /schemas/types.yaml#/definitions/int32
> Here and in other places, please use standard units. See
> dtschema/schemas/property-units.yaml in dtschema repo.
>
>
> Best regards,
> Krzysztof

Hi Krzystof, thanks for the input.

I see there are microvolt and microohm units present in 
schemas/property-units.yaml

Would it be possible to add bps (basis point) to the list of standard 
units if it makes sense to use it ?

Regards,

Krishna,


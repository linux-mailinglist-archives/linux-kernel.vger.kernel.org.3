Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19254EBF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbiC3K5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiC3K46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:56:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E45264F6B;
        Wed, 30 Mar 2022 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648637714; x=1680173714;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hF95iTc4t1M/e3D7i6dYPtn0iM9iJEhQx/uN5MIoDMQ=;
  b=wY8XYSJix5RR1MpKLM1SSqEGBUCCeqN3knzH3UZkDQs6e1VrhfPBzMFT
   Gw6rhaLqxxMAlBOOJeKWpqIA8OpBERR7g4jYvY5y3NiEem1ALbdFWqyjp
   KrAgDdmnKZYE9mYpxJ7TWV4G579TZu/+U9w7jnSldShrGETOIDx3BQoNB
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Mar 2022 03:55:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:55:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 03:55:12 -0700
Received: from [10.216.27.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 03:55:07 -0700
Subject: Re: [PATCH V8 1/7] dt-bindings: mfd: pm8008: Modify the compatible as
 per driver
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
 <1648209491-30165-2-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n523f-aAUkj1SUscNgw_Gh=mP8JfXV4u_hNeFhqtfr_Fgg@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <26e7298c-9337-c4d4-ce32-2a67d727ccfc@quicinc.com>
Date:   Wed, 30 Mar 2022 16:25:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n523f-aAUkj1SUscNgw_Gh=mP8JfXV4u_hNeFhqtfr_Fgg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 3/25/2022 11:32 PM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-03-25 04:58:05)
>> Modify the compatible string as per the pm8008 mfd driver.
>> Add reset-gpios property and make interrupts and interrupt-cells
>> as optional properties, they are not strictly required and may
>> cause yaml compilation errors when not added in the DT files.
> Does it have an interrupt controller inside? If so, the properties
> should be present even if the driver isn't using them.


Yes it has an interrupt controller but we are not configuring/using any 
interrupts currently in the DT node. So, if we add the properties under 
"required" list it throws a make dtbs error. Do you think we can somehow 
bypass this error?


>> Also, change the node name in example to match with the
>> pm8008_infra DT node.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V5:
>>   - Remove compatible for regulators node.
>>   - Move supply nodes of the regulators to chip level.
>>
>> Changes in V6:
>>   - No changes.
>>
>> Changes in V7:
>>   - Removed the intermediate regulators node and added ldos
>>     directly under mfd node.
>>
>> Changes in V8:
>>   - Change the compatible as per driver, remove interrupts from required
>>     properties, add reset-gpios and move regulators to separate binding.
>>
>>   Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> index ec3138c..12431ea 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> @@ -16,7 +16,7 @@ description: |
>>
>>   properties:
>>     compatible:
>> -    const: qcom,pm8008
>> +    const: qcom,pm8008-infra
> Why is the compatible being replaced with -infra postfix?


I've changed the compatible after splitting the probe into two parts 
pm8008-infra-probe and pm8008-regulators-probe. Only reason for change 
is to make it more readable/understandable.


>>     reg:
>>       description:
>> @@ -44,6 +44,10 @@ properties:
>>     "#size-cells":
>>       const: 0
>>
>> +  reset-gpios:
>> +    description: |
>> +      Specifies the GPIO to be toggled to bring pm8008 chip out of reset.
> Remove description. Add maxItems: 1


Okay.


>> +
>>   patternProperties:
>>     "^gpio@[0-9a-f]+$":
>>       type: object
>> @@ -88,10 +92,8 @@ patternProperties:
>>   required:
>>     - compatible
>>     - reg
>> -  - interrupts
>>     - "#address-cells"
>>     - "#size-cells"
>> -  - "#interrupt-cells"
> Should reset-gpios be required? I'd expect this patch to be adding
> reset-gpios and making it required and that's about it. Given that
> there isn't a DT using this compatible upstream so far it looks like we
> don't need to do anything like worry about backwards compatibility.


Okay.


>>   additionalProperties: false
>>
>> @@ -99,11 +101,12 @@ examples:
>>     - |
>>       #include <dt-bindings/mfd/qcom-pm8008.h>
>>       #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>>       qupv3_se13_i2c {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>> -      pm8008i@8 {
>> -        compatible = "qcom,pm8008";
>> +      pm8008_infra: pmic@8 {
> Remove unused phandle.


Okay.


>> +        compatible = "qcom,pm8008-infra";
>>           reg = <0x8>;
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> @@ -113,6 +116,8 @@ examples:
>>           interrupt-parent = <&tlmm>;
>>           interrupts = <32 IRQ_TYPE_EDGE_RISING>;
>>
>> +        reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>;
>> +
>>           pm8008_gpios: gpio@c000 {
>>             compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
>>             reg = <0xc000>;
>> --
>> 2.7.4
>>

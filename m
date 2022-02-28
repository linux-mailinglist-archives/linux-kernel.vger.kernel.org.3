Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830494C6F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiB1OPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiB1OPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:15:46 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A9D50E0C;
        Mon, 28 Feb 2022 06:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646057708; x=1677593708;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=214IHmeaSYgEtmwJm7lHCh4wPF2r2kl5QIdZUcIBo74=;
  b=au3ZI8+7JXNrfQ7/hyn/4VomKNHQuMrDQe87nzaD+eaJk7MAV8oKt0U4
   DRts+qyrhM5d2Go+13jW9pxN73qm5RjNY6UnnGC18Vc3OTBk5X8uT1+PL
   JRI+R4hLsWiz4F7zAN9FTzVPbDTcqvJrsfYus1LwCL6/sUs8L11WOhG0p
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2022 06:15:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 06:15:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 06:15:06 -0800
Received: from [10.216.7.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 06:15:01 -0800
Subject: Re: [PATCH V7 1/5] dt-bindings: mfd: pm8008: Add pm8008 regulators
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
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645182064-15843-2-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n51X=LJMjDb9KS0rqQDqLR5srzxCOJCRS4oJgPSXbvaSiQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <05780d0a-bc9c-3a81-2676-ea92453d7303@quicinc.com>
Date:   Mon, 28 Feb 2022 19:44:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51X=LJMjDb9KS0rqQDqLR5srzxCOJCRS4oJgPSXbvaSiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/19/2022 7:09 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-02-18 03:00:59)
>> Add regulators and their supply nodes. Add separate compatible
>> "qcom,pm8008-regulators" to differentiate between pm8008 infra
>> and pm8008 regulators mfd devices.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
> Is the register layout compatible with SPMI regulators? The gpio node
> seems to be fully compatible and the same driver probes there for SPMI
> and i2c, so I wonder why we can't extend the existing SPMI gpio and
> regulator bindings to have the new compatible strings for pm8008. Is
> anything really different, or do we have the same device talking i2c
> instead of SPMI now? Possibly it's exposing the different hardware
> blocks inside the PMIC at different i2c addresses. It looks like the i2c
> address is 0x8 and then there's 16-bits of address space inside the i2c
> device to do things. 0x9 is the i2c address for the regulators and then
> each ldo is at some offset in there?


The register layout is not compatible with spmi regulators, I see some 
differences w.r.t VOLTAGE_CTL, EN_CTL, MODE_CTL registers. Also, there 
is no headroom related stuff in the spmi driver.


>> Changes in V2:
>>   - As per Rob's comments changed "pm8008[a-z]?-regulator" to
>>     "^pm8008[a-z]?-regulators".
>>
>> Changes in V3:
>>   - Fixed bot errors.
>>   - As per stephen's comments, changed "^pm8008[a-z]?-regulators$" to
>>     "regulators".
>>
>> Changes in V4:
>>   - Changed compatible string to "qcom,pm8008-regulators"
>>
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
>>   .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 +++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> index ec3138c..6b3b53e 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> @@ -16,7 +16,9 @@ description: |
>>
>>   properties:
>>     compatible:
>> -    const: qcom,pm8008
>> +    enum:
>> +      - qcom,pm8008
>> +      - qcom,pm8008-regulators
>>
>>     reg:
>>       description:
>> @@ -44,6 +46,21 @@ properties:
>>     "#size-cells":
>>       const: 0
>>
>> +  vdd_l1_l2-supply:
>> +    description: Input supply phandle of ldo1 and ldo2 regulators.
>> +
>> +  vdd_l3_l4-supply:
>> +    description: Input supply phandle of ldo3 and ldo4 regulators.
>> +
>> +  vdd_l5-supply:
>> +    description: Input supply phandle of ldo5 regulator.
>> +
>> +  vdd_l6-supply:
>> +    description: Input supply phandle of ldo6 regulator.
>> +
>> +  vdd_l7-supply:
>> +    description: Input supply phandle of ldo7 regulator.
>> +
>>   patternProperties:
>>     "^gpio@[0-9a-f]+$":
>>       type: object
>> @@ -85,13 +102,16 @@ patternProperties:
>>
>>       additionalProperties: false
>>
>> +  "^ldo[1-7]$":
>> +    type: object
>> +    $ref: "../regulator/regulator.yaml#"
>> +    description: PM8008 regulator peripherals of PM8008 regulator device
>> +
>>   required:
>>     - compatible
>>     - reg
>> -  - interrupts
>>     - "#address-cells"
>>     - "#size-cells"
>> -  - "#interrupt-cells"
>>
>>   additionalProperties: false
>>
>> @@ -102,13 +122,11 @@ examples:
>>       qupv3_se13_i2c {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>> -      pm8008i@8 {
>> +      pm8008_infra: pm8008@8 {
>>           compatible = "qcom,pm8008";
>>           reg = <0x8>;
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> -        interrupt-controller;
>> -        #interrupt-cells = <2>;
>>
>>           interrupt-parent = <&tlmm>;
>>           interrupts = <32 IRQ_TYPE_EDGE_RISING>;
> I still fail to see what this part of the diff has to do with
> regulators. Can it be split off to a different patch with a clear
> description of why interrupt-controller and #interrupt-cells is no
> longer required for qcom,pm8008?


This diff has nothing to do with regulators, I removed it to avoid yaml 
errors during dtbs check.

I'll move this to a separate patch.


> It really looks like we're combining the binding for qcom,pm8008 and
> qcom,pm8008-regulators at the same level, which looks wrong. We don't
> want to describe the least common denominator between the two bindings.
> Why not make two different bindings and files? One for the interrupty
> gpio/interrupt controller device (at 0x8) and one for the regulator one
> (at 0x9)?


Okay, I'll add a different binding for regulators 
(mfd/qcom,pm8008-regulators.yaml), leave this binding as it is.. and 
also add separate DT files for pm8008-infra and pm8008-regulators.


>> @@ -123,6 +141,24 @@ examples:
>>             #interrupt-cells = <2>;
>>           };
>>         };
>> -    };
>>
>> +      pm8008_regulators: pm8008@9 {
> pmic@9, or regulators@9? The node name should be generic.
>
>> +        compatible = "qcom,pm8008-regulators";
>> +        reg = <0x9>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
>> +        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
>> +        vdd_l5-supply = <&vreg_bob>;
>> +        vdd_l6-supply = <&vreg_bob>;
>> +        vdd_l7-supply = <&vreg_bob>;
>> +
>> +        pm8008_l1: ldo1 {
>> +          regulator-name = "pm8008_l1";
>> +          regulator-min-microvolt = <950000>;
>> +          regulator-max-microvolt = <1300000>;
>> +        };
>> +      };
> For some i2c devices that appear on multiple i2c addresses we make an
> i2c client for each address in the driver that attaches to the node we
> put in DT. I suppose that won't work easily here. Either way, it would
> make it much clearer if this existing binding was left alone. Is there
> other functionality inside the i2c address 0x9 register space that isn't
> regulators?


As mentioned above, I'll make a separate binding for regulators. There 
is no other functionality apart from regulators in the i2c 0x9 register 
space.



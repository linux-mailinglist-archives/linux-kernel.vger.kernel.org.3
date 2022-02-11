Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F4A4B2307
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiBKKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:24:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiBKKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:24:00 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C41220;
        Fri, 11 Feb 2022 02:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644575039; x=1676111039;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UkTuOxm219Uf9vWVBlVQGbmmZ+csO/awHC70HwYJGsA=;
  b=msNiC289Tb1TnnMiLChcYNYDV7a4ueneFyRZu5+erH1MdHQ4+3Huj8jf
   aJvTYXWpPA2yt1OB6Wa3hwycROQ6NUglVTUktBgosnROhbD9E5uSyezrz
   gJH5dpbOp70rHEDwd/uKc3agv5y6cGHOINBhmLWFpkNBdFFdwZk/Dq5ah
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:23:59 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:23:57 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:23:52 -0800
Subject: Re: [PATCH V5 1/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Das Srinagesh" <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-2-git-send-email-quic_c_skakit@quicinc.com>
 <YgWxRDeo7vuTBeAo@builder.lan>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <cb7858fe-4891-ead5-f1cf-fb64e8368927@quicinc.com>
Date:   Fri, 11 Feb 2022 15:53:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgWxRDeo7vuTBeAo@builder.lan>
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


On 2/11/2022 6:13 AM, Bjorn Andersson wrote:
> On Tue 08 Feb 08:52 CST 2022, Satya Priya wrote:
>
>> Add bindings for pm8008 pmic regulators.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V2:
>>   - Moved this patch before "mfd: pm8008: Add pm8008 regulator node" to
>>     resolve dtschema errors. Removed regulator-min-microvolt and
>>     regulator-max-microvolt properties.
>>
>> Changes in V3:
>>   - As per Rob's comments added standard unit suffix for mindropout property,
>>     added blank lines where required and added description for reg property.
>>
>> Changes in V4:
>>   - Changed compatible string to "com,pm8008-regulators"
>>   - Moved "regulator-min-dropout-voltage-microvolt" to regulator.yaml as
>>     separate patch.
>>
>> Changes in V5:
>>   - Removed the separate compatible for pm8008 regulator driver.
>>   - Moved the supply nodes to chip level.
>>   - Removed min-dropout property.
>>
>>   .../bindings/regulator/qcom,pm8008-regulator.yaml  | 31 ++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
>> new file mode 100644
>> index 0000000..0098845
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
>> @@ -0,0 +1,31 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/qcom,pm8008-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
>> +
>> +maintainers:
>> +  - Satya Priya <skakit@codeaurora.org>
>> +
>> +description:
>> +  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
>> +  containing 7 LDO regulators.
>> +
>> +patternProperties:
>> +  "^LDO[1-7]$":
> Please make this lower case, to match all other regulator bindings.


Okay.


>> +    type: object
>> +    $ref: "regulator.yaml#"
>> +    description: PM8008 regulator peripherals of PM8008 regulator device
>> +
>> +    properties:
>> +      regulator-name: true
>> +
>> +    required:
>> +      - regulator-name
> Why is regulator-name a (and the only) required property?


It is not a required property, I'll correct this.


> Regards,
> Bjorn
>
>> +
>> +    unevaluatedProperties: false
>> +
>> +additionalProperties: false
>> +...
>> -- 
>> 2.7.4
>>

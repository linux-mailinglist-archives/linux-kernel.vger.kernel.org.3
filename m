Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42514EBF53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiC3K6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiC3K56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:57:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E526A971;
        Wed, 30 Mar 2022 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648637772; x=1680173772;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8glvKZKQ2PVgt+3kZ9jKaFtQpoEPSwyGlb9hNBy2TAU=;
  b=lYEFQg4uRMMXkb/0QRLFPtOBmfLOHnLPKsm7f0uQXLx1KhzEEUxOltZR
   xEWHookY9MWCyJVo9Jj4jFh/1EDYpefUYqJ6rrLlZgfDpUCyo+d9gDjZa
   BhtCspD3TiftQzBmWIHlGpWyTv4X2greq9AlOjrgX69wNBu/fzIvu0HQB
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Mar 2022 03:56:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:56:12 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 03:56:11 -0700
Received: from [10.216.27.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 03:56:06 -0700
Subject: Re: [PATCH V8 2/7] dt-bindings: mfd: pm8008: Add pm8008 regulator
 bindings
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
 <1648209491-30165-3-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53Zk1rXu5U6vEppZ=B8cJ0chmt+-aY03=W4mQedQq5Omg@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <77c4b843-d269-155f-ad54-39ee458dd069@quicinc.com>
Date:   Wed, 30 Mar 2022 16:26:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53Zk1rXu5U6vEppZ=B8cJ0chmt+-aY03=W4mQedQq5Omg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2022 11:38 PM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-03-25 04:58:06)
>> Add bindings for pm8008 regulators device.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes in V8:
>>   - This is split from pm8008.yaml binding.
>>
>>   .../bindings/mfd/qcom,pm8008-regulators.yaml       | 87 ++++++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
>> new file mode 100644
>> index 0000000..139fbf9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/qcom,pm8008-regulators.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
>> +
>> +maintainers:
>> +  - Satya Priya <quic_c_skakit@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
>> +  containing 7 LDO regulators. This binding specifies the PM8008
>> +  regulator peripherals of PM8008 device.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,pm8008-regulators
>> +
>> +  reg:
>> +    description:
>> +      I2C slave address.
> Drop description? We know what it is.


okay


>> +
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 0
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
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
>> +patternProperties:
>> +  "^ldo[1-7]$":
>> +    type: object
>> +    $ref: "../regulator/regulator.yaml#"
>> +    description: PM8008 regulator peripherals of PM8008 regulator device
>> +
>> +required:
>> +  - compatible
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/mfd/qcom-pm8008.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    qupv3_se13_i2c {
> i2c
>
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      pm8008_regulators: pmic@9 {
> Drop phandle please.


Okay.


>> +        compatible = "qcom,pm8008-regulators";
>> +        reg = <0x9>;
>> +        #address-cells = <0>;
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
>> +    };
>> +...
>> --
>> 2.7.4
>>

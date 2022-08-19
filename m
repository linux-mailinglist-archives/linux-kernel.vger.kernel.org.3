Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F359A712
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350956AbiHSU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349984AbiHSU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:26:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B82A10C819;
        Fri, 19 Aug 2022 13:26:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JK0Fjv013604;
        Fri, 19 Aug 2022 20:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wAZ5O0r5U9Cc0FNrBgoWr3B5hJwbXoqEjRowJFMxkFo=;
 b=h4B7P7G+sM1XklXjbususOSO54EPGq53y6bW7qcXs9GNAV6uqUfBIYuFGuAGqVruTgJT
 /IcesUjQle9DRAaZL9uoYbOhbZP1hJ9ZqdYq14vLKRujigF0tAtBLaYw8N5HqxlMcCpQ
 1weKZSLIFSekHDrN3U8UnloVaSA6l3D6js/4ovswas101Qnr9gWbkOzh+s7YUtY0BA1Q
 3k880AyKD2LdsF9GO+56r4pDO4YPl/jHjioFZOxF3izGDMqE6V0N7LauXBMYN4XOHOIY
 otySwJceQLHJAhVri0e1CJNVDVJq3EF+74LKEhWA7jqcMQcYCaxYujFxDhOvugn9RKo/ pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j253kj9sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 20:26:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27JKQRr6019827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 20:26:27 GMT
Received: from [10.110.45.134] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 19 Aug
 2022 13:26:26 -0700
Message-ID: <0e6bf142-ca56-2414-86c4-1a18b74b3ba6@quicinc.com>
Date:   Fri, 19 Aug 2022 13:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20220725191314.19456-1-quic_amelende@quicinc.com>
 <20220725191314.19456-2-quic_amelende@quicinc.com>
 <a47a33a5-aec7-2a52-f1e8-52c45307862e@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <a47a33a5-aec7-2a52-f1e8-52c45307862e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4OQopEB2hWhWf1F7fpuD-4lCrdARhR05
X-Proofpoint-ORIG-GUID: 4OQopEB2hWhWf1F7fpuD-4lCrdARhR05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krzysztof,
First I would like to apologize for my lack of response to this patch series
over these past few weeks. I have been out of office.

On 7/26/2022 3:25 AM, Krzysztof Kozlowski wrote:
> On 25/07/2022 21:13, Anjelique Melendez wrote:
>> From: David Collins <quic_collinsd@quicinc.com>
>>
>> Update the description of "reg" property to add the PON_PBS base
>> address along with PON_HLOS base address.  Also add "reg-names"
>> property constraints.
>>
>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
>>  1 file changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> index 353f155d..d7b6b875 100644
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> @@ -15,18 +15,27 @@ description: |
>>  
>>    This DT node has pwrkey and resin as sub nodes.
>>  
>> -allOf:
>> -  - $ref: reboot-mode.yaml#
>> -
>>  properties:
>>    compatible:
>>      enum:
>>        - qcom,pm8916-pon
>>        - qcom,pms405-pon
>>        - qcom,pm8998-pon
>> +      - qcom,pmk8350-pon
>>  
>>    reg:
>> -    maxItems: 1
>> +    description: |
>> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
>> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
>> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
>> +      peripherals.  In that case, the PON_PBS address needs to be specified to
>> +      facilitate software debouncing on some PMIC.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    pwrkey:
>>      type: object
>> @@ -42,6 +51,39 @@ required:
>>  
>>  unevaluatedProperties: false
>>  
>> +allOf:
>> +  - $ref: reboot-mode.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pm8916-pon
>> +              - qcom,pms405-pon
>> +              - qcom,pm8998-pon
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 1
>> +        reg-names:
>> +          items:
>> +            - const: pon
> 
> All your previous patches were actually missing (in commit msg, in the
> code) that piece of information which you add here. You now add
> reg-names with "pon" for older devices. I assumed previous that it is
> somehow needed, so I gave you the hints how it should be coded. But I
> don't understand - why are you doing it
> 
> This should be explained in commit msg. To me it is not needed at all...
> unless you want to mark that first address space is entirely different
> for other devices?
Adding reg-names "pon" for older devices is simply to provide clarification
about what the register relates to. Similar to reg-names "hlos" and "pbs"
for gen3 children devices, reg-names is completely optional and is not
consumed by any driver.

Before adding the "qcom,pmk8350-pon" compatible string, the best way to
differentiate between a "qcom,pm8998-pon" parent with a gen1/gen2 child vs a
"qcom,pm8998-pon" parent with a gen3 child with only an hlos register was to
include reg-names. i.e.

pon_hlos@1300 {
        reg = <0x1300>;
        compatible = "qcom,pm8998-pon";
	reg-names = "pon";
};

vs 

pon_hlos@1300 {
        reg = <0x1300>;
        compatible = "qcom,pm8998-pon";
	reg-names = "hlos";
};

Adding the new "qcom,pmk8350-pon" compatible string would now be used to
differentiate between gen1/gen2 vs gen3 children, so we could get rid of the
addition of reg-names for older devices.


Similarly we could get rid of reg-names and the "qcom,pmk8350-pon" compatible
string as a whole like mentioned in
https://lore.kernel.org/all/99a5d9ac-9c20-b441-44af-26772a0e989d@linaro.org/,
if reg-names and the new compatible string is causing too much confusion.


Thanks,
Anjelique 
> 

>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,pmk8350-pon
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 1
>> +          maxItems: 2
>> +        reg-names:
>> +          minItems: 1
>> +          items:
>> +            - const: hlos
>> +            - const: pbs
>> +
>>  examples:
>>    - |
>>     #include <dt-bindings/interrupt-controller/irq.h>
> 
> 
> Best regards,
> Krzysztof

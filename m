Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F933578B60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiGRT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiGRT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:57:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FD2E9F0;
        Mon, 18 Jul 2022 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658174232; x=1689710232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JnA8EvXdeEwN8pRQP0MpQ7Bwix3rW1cV6V4o1jd2WMY=;
  b=BfHZJ0PLsOssmCOiB6NoK44Hn/Ww8NGdc3ifMyWjgI7nr6VvSFWXr+bO
   2W5DOWHvi/4nq6KcZUEWnD9d8S7J5bofPqdQWOkyrurNiQVtOafLjgai+
   FSaL9JmSjfoWLqTWe5D7XghTLgkJb16JykCZrLAFhQARsk7iej4odl0c8
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jul 2022 12:57:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:57:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 12:57:10 -0700
Received: from [10.110.0.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 12:57:10 -0700
Message-ID: <ffb31b6f-8ed3-e890-976d-64a48478d404@quicinc.com>
Date:   Mon, 18 Jul 2022 12:57:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: update "reg"
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
References: <20220713193350.29796-1-quic_amelende@quicinc.com>
 <20220713193350.29796-2-quic_amelende@quicinc.com>
 <c129c748-4306-da64-fc18-2d224b2fc97c@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <c129c748-4306-da64-fc18-2d224b2fc97c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2022 4:48 AM, Krzysztof Kozlowski wrote:
> On 13/07/2022 21:33, Anjelique Melendez wrote:
>> From: David Collins <quic_collinsd@quicinc.com>
>>
>> Update the description of "reg" property to add the PON_PBS base
>> address along with PON_HLOS base address.  Also add "reg-names"
>> property description.
>>
>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 73 ++++++++++++++++++++++++++++--
>>  1 file changed, 69 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> index 353f155d..562fe308 100644
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> @@ -15,18 +15,26 @@ description: |
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
> 
> You miss here min and maxItems
ACK
> 
>> +
>> +  reg-names:
>> +    description: |
>> +      For PON GEN1 and GEN2, it should be "pon". For PON GEN3 it should include
>> +      "hlos" and optionally "pbs".
> 
> Skip description. You miss here min and maxItems.
> 
> See
> https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57
> for examples.
ACK
> 
> 
>>  
>>    pwrkey:
>>      type: object
>> @@ -42,6 +50,63 @@ required:
>>  
>>  unevaluatedProperties: false
>>  
>> +allOf:
>> +  - $ref: reboot-mode.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,pm8916-pon
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 1
>> +        reg-names:
>> +          items:
>> +            - const: pon
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,pms405-pon
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 1
>> +        reg-names:
>> +          items:
>> +            - const: pon
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,pm8998-pon
>> +    then:
>> +      properties:
>> +        reg:
>> +          maxItems: 1
>> +        reg-names:
>> +          items:
>> +            - const: pon
> 
> No clue why you made three if statements. This is one if for all three
> variants.
> 
Sorry about that was not sure how to combine the if statements originally.
Found that you could do:

- if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,pm8916-pon
              - qcom,pms405-pon
              - qcom,pm8998-pon
    then:
     ...

I was wondering if for the "qcom,pmk8350-pon" compatible would you rather
have the if statement the way it is or have it follow the same pattern as
above i.e.

contains:
  const: qcom,pmk8350-pon

vs

contains:
  enum:
    - qcom,pmk8350-pon
>> +
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

Thanks,
Anjelique

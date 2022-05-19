Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F652DFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbiESWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiESWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:31:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954A9FD2;
        Thu, 19 May 2022 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652999472; x=1684535472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDLidO+uz/WxZLgd7T0KPUs7o3mI46xraJxkCn7ZFMc=;
  b=L3bmzxmvKv0afo4OS0Cl3vprFCz4ygPt8+5thrqcpI0TsSTFMv/tB3GB
   Ra84KiwHRxeIvkx8knnfaOROkXK/WC3FfEgcB9A+jbGxHB6Ac96R/UtPC
   qRp3vOnmALkUpMyLH/tnDSBNduAwtNtIAHkcEZkybHN/ECzglUQo4Wj6L
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 May 2022 15:31:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:31:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 15:30:38 -0700
Received: from [10.110.88.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 15:30:37 -0700
Message-ID: <27515993-18f3-8891-4835-9b6a8d7f86b0@quicinc.com>
Date:   Thu, 19 May 2022 15:30:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <swboyd@chromium.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
 <20220422191239.6271-2-quic_amelende@quicinc.com>
 <YmcWZLp2X8UYOVas@robh.at.kernel.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <YmcWZLp2X8UYOVas@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2022 2:45 PM, Rob Herring wrote:
> On Fri, Apr 22, 2022 at 12:12:38PM -0700, Anjelique Melendez wrote:
>> From: David Collins <collinsd@quicinc.com>
>>
>> Update the description of "reg" property to add the PON_PBS base
>> address along with PON_HLOS base address.  Also add "reg-names"
>> property description.
>>
>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/power/reset/qcom,pon.yaml | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> index 353f155d..65ec8197 100644
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> @@ -26,7 +26,24 @@ properties:
>>        - qcom,pm8998-pon
>>  
>>    reg:
>> -    maxItems: 1
>> +    description: |
>> +      Specifies the SPMI base address for the PON (power-on) peripheral.  For
>> +      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
>> +      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
>> +      peripherals.  In that case, the PON_PBS address needs to be specified to
>> +      facilitate software debouncing on some PMICs.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    description: |
>> +      For PON GEN1 and GEN2, it should be "pon".  For PON GEN3 it should include
>> +      "pon_hlos" and optionally "pon_pbs".
>> +    minItems: 1
>> +    items:
>> +      - const: pon_hlos
>> +      - const: pon_pbs
>> +      - const: pon
> 
> Did you test that 'reg-names = "pon";' works? It doesn't. The schema 
> says 'pon' is the 3rd entry in reg-names.
> 
> As 'reg-names' is new I thin this should be:
> 
> items:
>   - const: hlos
>   - const: pbs
> 
> And if there's 1 entry, then 'reg-names' should not be there.
> 
> Rob

currently reg-names is not consumed by the pm8941 driver but rather for users to understand
what each reg address is associated with. 
With this being the case would the following be acceptable?
	minItems: 1
	maxItems: 2
	items:
    	    anyOf:
     	      - const: pon_hlos
     	      - const: pon_pbs
     	      - const: pon

If not we would be ok with getting rid of the reg-name property.

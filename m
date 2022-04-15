Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0F502EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346926AbiDOSr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346845AbiDOSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:47:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA027FCA;
        Fri, 15 Apr 2022 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650048294; x=1681584294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y+DhyXYe7xzr+Dy/hh989lOaL8GjUsKaTM+O+hQ/8vY=;
  b=Hqarrxtyhj5uhgwrZSrk6K8I+lcuwNQF9niAXNlOO/2t90oTF0/YO2Ao
   Nych7fFfKkxXLlrJv+hNrl4kezg+EqasAVOK5aCoyZMLbnTLk1aPfc8JA
   PAjDKiSctqvpOKwP2calDRzk8SfuRpv/5qpD+Aj8sne+ZKVPVhf8ZHg4e
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Apr 2022 11:44:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 11:44:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 11:44:12 -0700
Received: from [10.110.117.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Apr
 2022 11:44:11 -0700
Message-ID: <89483178-2b8b-e583-7f4f-572076c95141@quicinc.com>
Date:   Fri, 15 Apr 2022 11:44:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/5] dt-bindings: power: reset: qcom-pon: update "reg"
 property details
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <skakit@codeaurora.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20220411200506.22891-1-quic_amelende@quicinc.com>
 <20220411200506.22891-2-quic_amelende@quicinc.com>
 <Ylg+7MVRS4sKbOFb@robh.at.kernel.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <Ylg+7MVRS4sKbOFb@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 8:34 AM, Rob Herring wrote:
> On Mon, Apr 11, 2022 at 01:05:03PM -0700, Anjelique Melendez wrote:
>> From: David Collins <quic_collinsd@quicinc.com>
>>
>> Update the description of "reg" property to add the PON_PBS base
>> address along with PON_HLOS base address.  Also add "reg-names"
>> property description.
>>
>> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/power/reset/qcom,pon.yaml | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> index 353f155d..542200b2 100644
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> +++ b/Documentation/bindings/power/reset/qcom,pon.yaml
>> @@ -26,7 +26,25 @@ properties:
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
>> +    maxItems: 2
>> +    items:
>> +      - const: pon_hlos
>> +      - const: pon_pbs
>> +      - const: pon
> 
> This says there are 3 entries, but you limited to 2. The schema also 
> doesn't match what the description says. Entries should be extended by 
> adding new entries to the end and keeping optional entries last. So like 
> this:
> 
> minItems: 1
> items:
>   - const: pon
>   - const: pon_hlos
>   - const: pon_pbs
> 
> RobWill update in next patch. Thanks

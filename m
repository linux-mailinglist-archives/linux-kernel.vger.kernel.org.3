Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911F4FF6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiDMM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiDMM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:27:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE55B3D7;
        Wed, 13 Apr 2022 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649852706; x=1681388706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EKwk77NQWQ3blrhwRLxsWtVHafSCwKFNqxFUCO9mJVA=;
  b=bR0SuJ/ykDJTW2RfLFSU93LnvJnAGvORCHKlMlXmZ9aNX6D6RIFFScxC
   HEK+/hNDoJb9m9/DFZysS8cZ/2/VNWAfUaldH8e1F7p6Nr0VluY1CSFs0
   88rMOJwhn0OtjFo3OZqyRHWC9SirVisVn+Woh02hsB9D3kb6ghmoqQ0s7
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Apr 2022 05:25:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 05:25:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 05:25:04 -0700
Received: from [10.216.28.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 05:25:01 -0700
Message-ID: <954fae08-b11a-7a1b-b1b5-49fc2af660a6@quicinc.com>
Date:   Wed, 13 Apr 2022 17:54:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SDX65 DT
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <djakov@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1649740053-14507-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649740053-14507-2-git-send-email-quic_rohiagar@quicinc.com>
 <7e1e6c10-c02a-c8da-44c0-ba3abef1950e@linaro.org>
 <99e49c61-4a6a-69c6-810c-581ee0ce5008@quicinc.com>
 <89ad9e08-e0b2-d163-b089-c96ce70509b3@linaro.org>
 <9704adae-54f0-f8f4-1584-aefc2b1de402@quicinc.com>
 <a96f56b6-0959-b672-0521-e44e5d9f6fbc@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <a96f56b6-0959-b672-0521-e44e5d9f6fbc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2022 5:51 PM, Krzysztof Kozlowski wrote:
> On 13/04/2022 14:14, Rohit Agarwal wrote:
>> On 4/13/2022 12:03 PM, Krzysztof Kozlowski wrote:
>>> On 13/04/2022 08:29, Rohit Agarwal wrote:
>>>> On 4/12/2022 2:52 PM, Krzysztof Kozlowski wrote:
>>>>> On 12/04/2022 07:07, Rohit Agarwal wrote:
>>>>>> Add interconnect IDs for Qualcomm SDX65 platform.
>>>>>>
>>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>> (...)
>>>>>
>>>>>> diff --git a/include/dt-bindings/interconnect/qcom,sdx65.h b/include/dt-bindings/interconnect/qcom,sdx65.h
>>>>>> new file mode 100644
>>>>>> index 0000000..8d02c79
>>>>>> --- /dev/null
>>>>>> +++ b/include/dt-bindings/interconnect/qcom,sdx65.h
>>>>>> @@ -0,0 +1,67 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> Is it possible to license it the same as bindings (GPL-2.0 OR BSD-2-Clause)?
>>>> The qcom related code are marked as GPL 2.0 license
>>> This I see here, unless you meant some other qcom related code?
>> Yes, I meant the other codes as well because most of them I see (for eg.
>> sdx55) have added only GPL 2.0.
> Happens, maybe no one pointed out this. The bindings, including headers
> because these are part of bindings, are expected to have (GPL-2.0 OR
> BSD-2-Clause) license. Just because some bindings or some binding
> headers have GPL-2.0, is not a justification that wrong license should
> be used.

Okay, understood. Thanks for the clarification. Will update this 
immediately.

Thanks,
Rohit.

>
> Best regards,
> Krzysztof

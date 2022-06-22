Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAE55469F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357563AbiFVL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357169AbiFVL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:59:10 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF493CA78;
        Wed, 22 Jun 2022 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655899141; x=1687435141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lr/u0iIly9juJsCDQg+gxnesL/0/rlagsE/GYqfpsMc=;
  b=T+mQC6HE23MT/O0WIJxVN4BLWaQJrsdcQ2VO32CvKIPJlpbgTefpLdB4
   MuB36VEv2fy5WUqDDBVnmKzFqlgav/BWEz8p6dnqd33Z3dZ/0mW3cvrO0
   JLR7Xzft2vkRpyCL3jP+FYWYZsUH2A/TBsaxCsrcjgi001/9mUWlLVE64
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 04:59:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 04:59:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 04:59:00 -0700
Received: from [10.216.32.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 04:58:54 -0700
Message-ID: <dbfe1e7c-19dc-2d20-700a-c26f0bf721e5@quicinc.com>
Date:   Wed, 22 Jun 2022 17:28:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Rob Herring" <robh@kernel.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
 <Yp5tjUICIEUptKSx@ripper> <3e4e504c-5a38-43cd-ea8d-afbbb72eacad@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <3e4e504c-5a38-43cd-ea8d-afbbb72eacad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/7/2022 12:20 PM, Krzysztof Kozlowski wrote:
> On 06/06/2022 23:11, Bjorn Andersson wrote:
>> On Wed 01 Jun 03:11 PDT 2022, Krzysztof Kozlowski wrote:
>>
>>> Add bindings for the Qualcomm Bandwidth Monitor device providing
>>> performance data on interconnects.  The bindings describe only BWMON
>>> version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
>>> Controller.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Georgi Djakov <djakov@kernel.org>
>>> ---
>>>   .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
>>>   1 file changed, 97 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>> new file mode 100644
>>> index 000000000000..8c82e06ee432
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Interconnect Bandwidth Monitor
>>> +
>>> +maintainers:
>>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> +
>>> +description:
>>> +  Bandwidth Monitor measures current throughput on buses between various NoC
>>> +  fabrics and provides information when it crosses configured thresholds.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,sdm845-cpu-bwmon       # BWMON v4
>>
>> It seems the thing that's called bwmon v4 is compatible with a number of
>> different platforms, should we add a generic compatible to the binding
>> as well, to avoid having to update the implementation for each SoC?
>>
>> (I.e. "qcom,sdm845-cpu-bwmon", "qcom,bwmon-v4")

it seems pretty useful to have the "qcom,bwmon-v4" and "qcom,bwmon-v5"
compatibles, I tried these patches on a sc7280 device which has a bwmon4
between the cpu and caches (and also has a bwmon5 between the caches and DDR)
and the driver works with zero changes.

> 
> I am hesitant. I could not find BWMON IP block versioning in the
> Qualcomm docs. Only the downstream sources had it. Therefore I think it
> is more applicable to use this one as fallback for other boards, e.g.:
> 
> "qcom,sdm660-cpu-bwmon", "qcom,sdm845-cpu-bwmon"
> (even if the number is a bit odd - newer comes as last compatible).
> 
> What's your preference?
> 
> Best regards,
> Krzysztof

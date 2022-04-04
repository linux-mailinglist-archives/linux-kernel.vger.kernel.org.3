Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151354F153E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiDDMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiDDMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:55:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEAAE3E;
        Mon,  4 Apr 2022 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649076824; x=1680612824;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Lpl3iK+S56CvjhysE8teBw2n6Rh/6wCcnYxXXoX3m3E=;
  b=QXoL3rJwn1tCp3PM+J0RzKWtMLoT5S36PA5VVnh20DVaxTGTTUTACfz7
   hkR56k1OtXSZRmxlvWzHBCGKP+tdD9/5NTkuPrMuccZPQmzBifo31qAGq
   wU8ocY+wo8D8l5ta35OnvOzcWXTlq7UEDzzeoK8SkHsmKc5s16VRATlWd
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Apr 2022 05:53:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 05:53:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 05:53:27 -0700
Received: from [10.216.20.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Apr 2022
 05:53:22 -0700
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
 <26e7298c-9337-c4d4-ce32-2a67d727ccfc@quicinc.com>
 <CAE-0n53NSiQz+MV+faAWaevY2FY_Jt+gLGrD1xzX+T6Dn9uQjQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <af5bfc92-804a-1f2d-0908-c78f4aa9ebaa@quicinc.com>
Date:   Mon, 4 Apr 2022 18:23:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53NSiQz+MV+faAWaevY2FY_Jt+gLGrD1xzX+T6Dn9uQjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2022 2:45 AM, Stephen Boyd wrote:
> Quoting Satya Priya Kakitapalli (Temp) (2022-03-30 03:55:03)
>> On 3/25/2022 11:32 PM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-03-25 04:58:05)
>>>> Modify the compatible string as per the pm8008 mfd driver.
>>>> Add reset-gpios property and make interrupts and interrupt-cells
>>>> as optional properties, they are not strictly required and may
>>>> cause yaml compilation errors when not added in the DT files.
>>> Does it have an interrupt controller inside? If so, the properties
>>> should be present even if the driver isn't using them.
>>
>> Yes it has an interrupt controller but we are not configuring/using any
>> interrupts currently in the DT node. So, if we add the properties under
>> "required" list it throws a make dtbs error. Do you think we can somehow
>> bypass this error?
>>
> Can you fix the existing node to have those properties?


Okay.


>>>> Also, change the node name in example to match with the
>>>> pm8008_infra DT node.
>>>>
>>>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>>>> ---
>>>> Changes in V5:
>>>>    - Remove compatible for regulators node.
>>>>    - Move supply nodes of the regulators to chip level.
>>>>
>>>> Changes in V6:
>>>>    - No changes.
>>>>
>>>> Changes in V7:
>>>>    - Removed the intermediate regulators node and added ldos
>>>>      directly under mfd node.
>>>>
>>>> Changes in V8:
>>>>    - Change the compatible as per driver, remove interrupts from required
>>>>      properties, add reset-gpios and move regulators to separate binding.
>>>>
>>>>    Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>>>> index ec3138c..12431ea 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>>>> @@ -16,7 +16,7 @@ description: |
>>>>
>>>>    properties:
>>>>      compatible:
>>>> -    const: qcom,pm8008
>>>> +    const: qcom,pm8008-infra
>>> Why is the compatible being replaced with -infra postfix?
>>
>> I've changed the compatible after splitting the probe into two parts
>> pm8008-infra-probe and pm8008-regulators-probe. Only reason for change
>> is to make it more readable/understandable.
>>
>>
> Please leave the pm8008 compatible alone.


Okay.


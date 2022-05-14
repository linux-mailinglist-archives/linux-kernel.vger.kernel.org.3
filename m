Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BEB526F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiENGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiENGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 02:24:37 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C95F7C;
        Fri, 13 May 2022 23:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652509475; x=1684045475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CTPKV5/3XbPVVsmMfjikShM7ViVrOedVu3KK+AOri88=;
  b=WOhoiUbJORohS/GZKozszJzqGqKc13KzcLtHzoK+6AmBJnabt48skTNe
   wkSRFvC2H9GzfYS9sw2JCrmEjM63fOXc4kOcN4z4vzNQGUpKOwEWftJ/7
   HMR3JYOTPhVvUh2vUsxq5CgNhyFbgOJhpKOp54CTtHB5kBDfMLWTfRFZP
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 May 2022 23:24:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 23:24:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 23:24:34 -0700
Received: from [10.216.22.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 23:24:27 -0700
Message-ID: <972ac516-efac-54d6-febc-1b180ec36d4b@quicinc.com>
Date:   Sat, 14 May 2022 11:54:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [v4 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Vinod Koul" <vkoul@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>
References: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
 <1652282793-5580-2-git-send-email-quic_kriskura@quicinc.com>
 <d296720d-ccbe-27f0-8ba1-9653af25dd52@linaro.org>
 <9644d608-4ab9-ed0d-50fb-0016e4331361@quicinc.com>
 <5b32cecf-873a-6367-df87-1b8d45e63cec@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <5b32cecf-873a-6367-df87-1b8d45e63cec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/12/2022 4:00 PM, Krzysztof Kozlowski wrote:
> On 12/05/2022 07:57, Krishna Kurapati PSSNV wrote:
>> On 5/11/2022 11:49 PM, Krzysztof Kozlowski wrote:
>>> On 11/05/2022 17:26, Krishna Kurapati wrote:
>>>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>
>>>> Add device tree bindings for SNPS phy tuning parameters.
>>>>
>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 87 ++++++++++++++++++++++
>>>>    1 file changed, 87 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>> index 1ce251d..70efffe 100644
>>>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>> @@ -53,6 +53,93 @@ properties:
>>>>      vdda33-supply:
>>>>        description: phandle to the regulator 3.3V supply node.
>>>>    
>>>> +  qcom,hs-disconnect-bps:
>>>> +    $ref: /schemas/types.yaml#/definitions/int32
>>>> +    description:
>>>> +      This adjusts the voltage level for the threshold used to
>>>> +      detect a disconnect event at the host. Possible values are.
>>>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>>> This means there is some minimum and maximum (100%)?
>> Hi Krzystof,
>>
>> Yes there are max and min for each parameter (not necessarily 0%/100%)
>>
>> As an example if we take squelch detector threshold, the register value
>> vs actual percentage changer as per data book is as follows :
>>
>> % change in voltage    |     corresponding reg value
>>
>>    -20.90%                        |    7
>>    -15.60%                        |    6
>> -10.30%                         |    5
>> -5.30%                           |    4
>> 0%                                  |    3
>> 5.30%                            |    2
>> 10.60%                          |    1
>> 15.90%                          |    0
>>
>> Here the min and max are 15.9% to -20.9%
>>
>> The min and max differ for each parameter and might not be necessarily
>> 0% and 100%
> Then it seems possible to define minimum and maximum values - please add
> them ("minimum: xxxx").
>
>
> Best regards,
> Krzysztof

Hi Krzysztof,

  Sorry for the late reply, missed this mail.

Currently, these values have a fixed maximum and minimum. But if these 
limits change in the

future (say on a per target basis) , would it be appropriate to add them 
here in bindings file ?

Also in the driver file for sc7280 target, we have added parameter 
mapping : (map b/w register value

and bps passed from device tree). For squelch detector, it is as follows:

+static struct override_param squelch_det_threshold_sc7280[] = {
+	OVERRIDE_PARAM(-2090, 7),
+	OVERRIDE_PARAM(-1560, 6),
+	OVERRIDE_PARAM(-1030, 5),
+	OVERRIDE_PARAM(-530, 4),
+	OVERRIDE_PARAM(0, 3),
+	OVERRIDE_PARAM(530, 2),
+	OVERRIDE_PARAM(1060, 1),
+	OVERRIDE_PARAM(1590, 0),
+};

And the code is written such that if we give a bps value in dt greater than max value in
table, we would automatically choose max value. And if we provide bps value lesser than
minimum value, we would choose the min value.

So, would it be appropriate to add the min and max in dt-bindings when there is a
slight chance of them changing in the future ?

Would like to know your thoughts on this,

Thanks,
Krishna,


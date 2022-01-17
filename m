Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B849010E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiAQFMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:12:34 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23919 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAQFMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642396352; x=1673932352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+i3OFZvbJvxEhERitXVmUI0MC3HAKYJToPu9J4JaZw=;
  b=a8iHXuiAmkMLZ2+N+Y+EZJ9uHjm2d6WO3kEx2i1x+mRQpCrJ7xKTRqDr
   R8IGMZ8LP3jnoAY9qdnie6HFoWj8wtGxsFs8umwlZ8OnIv6Ies/ZdBiwE
   tUJo7R/57cyTZEitFP3x+AJozgxtA0KKLpG5Tc6+CRTEqvAoX1YH0fRPJ
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 21:12:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:12:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:12:31 -0800
Received: from [10.50.10.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 21:12:25 -0800
Message-ID: <ffda32f9-85ff-b6d2-0736-6c36d6c709ec@quicinc.com>
Date:   Mon, 17 Jan 2022 10:42:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 1/7] dt-bindings: Add the yaml bindings for EUD
Content-Language: en-CA
To:     Rob Herring <robh@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>,
        <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <5d9491693870b5dde757959f4491296503d22f70.1641288286.git.quic_schowdhu@quicinc.com>
 <Yd4qD7ziPNgAQNHG@robh.at.kernel.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <Yd4qD7ziPNgAQNHG@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/2022 6:38 AM, Rob Herring wrote:
> On Tue, Jan 04, 2022 at 05:28:14PM +0530, Souradeep Chowdhury wrote:
>> Documentation for Embedded USB Debugger(EUD) device tree
>> bindings in yaml format.
> I agree with Bjorn's comments.
Ack
>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,eud.yaml     | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>> new file mode 100644
>> index 0000000..3523932
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Qualcomm Embedded USB Debugger
>> +
>> +maintainers:
>> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> +
>> +description:
>> +  This binding is used to describe the Qualcomm Embedded USB Debugger, which is
>> +  mini USB-hub implemented on chip to support USB-based debug capabilities.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,sc7280-eud
>> +      - const: qcom,eud
>> +
>> +  reg:
>> +    items:
>> +      - description: EUD Base Register Region
>> +      - description: EUD Mode Manager Register
>> +
>> +  interrupts:
>> +    description:
>> +      EUD interrupt
> Just 'maxItems: 1' is sufficient here.
Ack
>
>> +
>> +  port:
> Based on Bjorn's comment, you will need 2 port nodes.
Ack
>
>> +    description:
>> +      This port is to be attached to the endpoint of the connector child of
>> +      DWC3 controller node. The controller has the "usb-role-switch" property.
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    eud@88e0000 {
>> +           compatible = "qcom,sc7280-eud","qcom,eud";
>> +           reg = <0x88e0000 0x2000>,
>> +                 <0x88e2000 0x1000>;
> Are the ports really optional?
Ack. Will make them mandatory.
>
>> +    };
>> -- 
>> 2.7.4
>>
>>

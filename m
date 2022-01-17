Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49B4900FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiAQFIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:08:19 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2148 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAQFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642396098; x=1673932098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KnDADVX4Q8x2TGCM9zLo6rDNv3lCahkszHUYzuCxN5Y=;
  b=X6XdDoOHJLR+AGusAoxaljQfirOPBy4EcrknrRDPkfs9klLTW6ikSa/7
   AxI+ARW0pU/j6wLg1T76kwTJ9tkm8rjUlR1ZwaBQEfNR5aE8uHAMmIMja
   Efy5L7YAj80oMSVJxpeB13GQ7Khelu5vYqXFEzOlQIHjjJ8718qWsXWif
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 21:08:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:08:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:08:17 -0800
Received: from [10.50.10.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 21:08:10 -0800
Message-ID: <452edfc2-7fb1-fa3d-9217-830f17e85f35@quicinc.com>
Date:   Mon, 17 Jan 2022 10:38:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 2/7] dt-bindings: connector: Add property for EUD
 type-C connector
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
        <tsoni@codeaurora.org>, <psodagud@codeaurora.org>,
        <satyap@codeaurora.org>, <pheragu@codeaurora.org>,
        <rnayak@codeaurora.org>, <sibis@codeaurora.org>,
        <saiprakash.ranjan@codeaurora.org>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <8194777786be70073a5364fe45ba7ec684019a71.1641288286.git.quic_schowdhu@quicinc.com>
 <YdePWXEwfk50S+P2@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YdePWXEwfk50S+P2@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2022 6:24 AM, Bjorn Andersson wrote:
> On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:
>
>> Added the property for EUD(Embedded USB Debugger) connector. EUD
>> is a mini usb hub with debug and trace capabilities and it has a
>> type C connector attached to it for role-switching. This connector
>> is attached to EUD via port.
>>
> Per my feedback on the dts patch, I don't think this binding is needed.
Ack
>
> Regards,
> Bjorn
>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 7eb8659..417d39a 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -30,6 +30,10 @@ properties:
>>             - const: samsung,usb-connector-11pin
>>             - const: usb-b-connector
>>   
>> +      - items:
>> +          - const: qcom,usb-connector-eud
>> +          - const: usb-c-connector
>> +
>>     label:
>>       description: Symbolic name for the connector.
>>   
>> @@ -179,7 +183,8 @@ properties:
>>       properties:
>>         port@0:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -        description: High Speed (HS), present in all connectors.
>> +        description: High Speed (HS), present in all connectors. Also used as a
>> +                     port to connect QCOM Embedded USB Debugger(EUD).
>>   
>>         port@1:
>>           $ref: /schemas/graph.yaml#/properties/port
>> -- 
>> 2.7.4
>>

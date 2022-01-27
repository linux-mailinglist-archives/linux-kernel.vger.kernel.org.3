Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773FD49DFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbiA0K71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:59:27 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16141 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239823AbiA0K7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643281165; x=1674817165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KTP4TUzkh25tpu4udD5kFIQwJQKQlGXQ/NMKhlNAbr4=;
  b=SSDzWAhdGgXxJHtV0J4rHIiFxQPMtQ6c+SCshYcx5f7n9Zl54F9OZ2AC
   6deTTlw3eUFPq7OaLdh4fYxlXrQtWowx/xuqqhCgcs8VmmDHhFjvm9Kym
   IwFyWPb7ZXzxyBAd1S8KvvsqfoTgAlBEO5vivLBYAfodC9k66hNKDl9nq
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 02:59:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 02:59:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 02:59:23 -0800
Received: from [10.50.37.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 27 Jan
 2022 02:59:17 -0800
Message-ID: <7ecf4224-4a8c-6508-a3de-df1c3119bb28@quicinc.com>
Date:   Thu, 27 Jan 2022 16:28:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 2/6] bindings: usb: dwc3: Update dwc3 properties for
 EUD connector
Content-Language: en-CA
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <greg@kroah.com>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ddaf7dc192c5f03f70d27297551e758a39a4ab5.1642768837.git.quic_schowdhu@quicinc.com>
 <YfDMQIFiCfzQy91y@builder.lan>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YfDMQIFiCfzQy91y@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/2022 9:51 AM, Bjorn Andersson wrote:
> On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:
>
>> Add the ports property for dwc3 node. This port can be used
>> by the Embedded USB Debugger for role switching the controller
>> from device to host mode and vice versa.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index d29ffcd..ccb1236 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -332,6 +332,16 @@ properties:
>>       items:
>>         enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>   
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description:
>> +      This port is to be attached to the endpoint of the Embedded USB Debugger.
> More generally this is used together with the already documented
> usb-role-switch property to connect the dwc3 to the Type-C connector.
>
> Which makes me feel that we don't actually need ports/port, but could do
> with just port? Perhaps I'm missing some usecase?
>
>
> I'm somewhat confused to why this isn't already documented...

Ack. Will document this as a port.

>
> Regards,
> Bjorn
>
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Connector endpoint of Embedded USB debugger.
>> +
>>   unevaluatedProperties: false
>>   
>>   required:
>> -- 
>> 2.7.4
>>

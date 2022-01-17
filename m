Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F17490104
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiAQFJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:09:23 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:11585 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbiAQFJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642396160; x=1673932160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d3QZiek8j6PZ5/tH31mSHN1tc8UXX5DOPvX2WzKszeY=;
  b=IY61UTPQWQ55myhkSPF8Gb17r/1xdFOiD/TKaHELYHiwELWhAvR+2n6l
   UwBIz1IVxhLhonHfNqHHvx6m/+4f990sSUIVYWdOoiX80vkrH/pEK92Yo
   aljda/9T3JuqvCGmNMII8m5JJ/8Y2ZInEZfEVfQ192IT1dRS8HQDCWHql
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jan 2022 21:09:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 21:09:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 21:09:18 -0800
Received: from [10.50.10.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 16 Jan
 2022 21:09:12 -0800
Message-ID: <4544bd87-f456-bc6a-8e7f-40bd4eb33ef1@quicinc.com>
Date:   Mon, 17 Jan 2022 10:39:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 3/7] bindings: usb: dwc3: Update dwc3 properties for
 EUD connector
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
 <163f4d977fb6a0d80d8fd8d358991aeeb58d31a6.1641288286.git.quic_schowdhu@quicinc.com>
 <YdePqpJjIiPAuHlJ@ripper>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <YdePqpJjIiPAuHlJ@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/2022 6:26 AM, Bjorn Andersson wrote:
> On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:
>
>> Add the connector property for dwc3 node. This connector can
>> be used to role-switch the controller from device to host and
>> vice versa.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index 078fb78..9382168 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -318,6 +318,12 @@ properties:
>>       items:
>>         enum: [1, 4, 8, 16, 32, 64, 128, 256]
>>   
>> +  connector:
> The dwc3 isn't the connector, so I think you should put a ports {} in
> the dwc3 and link that to the connector that is described elsewhere.
Ack
> Regards,
> Bjorn
>
>> +    type: object
>> +    $ref: /connector/usb-connector.yaml#
>> +    description:
>> +      Connector for dual role switch, especially for "eud-usb-c-connector"
>> +
>>   unevaluatedProperties: false
>>   
>>   required:
>> -- 
>> 2.7.4
>>

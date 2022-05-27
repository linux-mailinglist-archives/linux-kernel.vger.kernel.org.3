Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35C535EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbiE0LK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351230AbiE0LKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:10:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C812E334;
        Fri, 27 May 2022 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653649803; x=1685185803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dMqJBDYB8+RuHUmp3QwgkB4N3NKdQo8UUZF3w5eGsYg=;
  b=d3bkPtvS+o5NEyvoT6z396Dl4M6O9A909FHXUAVp213ZMPVaskOXa6ZP
   NImv+wo4jDoT0w1AtRrKcXalZNJ10j0hyd2s1bGvlzGi75pI5WzZLDXg3
   GeUrS5Vse+N1CBKd4yLGCgcJJQ3wf0EcSlf4/MAuEjW2IqmANIxX/K1oL
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 May 2022 04:10:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 04:10:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 04:10:02 -0700
Received: from [10.216.14.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 04:09:59 -0700
Message-ID: <00b7850b-ed6e-c67c-b3f1-fc89a992cca6@quicinc.com>
Date:   Fri, 27 May 2022 16:39:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
 <20220523122554.GA416176-robh@kernel.org>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <20220523122554.GA416176-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2022 5:55 PM, Rob Herring wrote:
> On Thu, May 19, 2022 at 06:04:54PM +0530, Harsh Agarwal wrote:
>> Added support for multiport, mport, num-ssphy and num-hsphy
>> properties. These properties are used to support devices having
>> a multiport controller.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> ---
>>   .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index f4471f8..39c61483 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -341,6 +341,35 @@ properties:
>>         This port is used with the 'usb-role-switch' property  to connect the
>>         dwc3 to type C connector.
>>   
>> +  multiport:
>> +    description:
>> +      If a single USB controller supports multiple ports, then it's referred to as
>> +      a multiport controller. Each port of the multiport controller can support
>> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
>> +      port is represented by "mport" node and all the "mport" nodes are grouped
>> +      together inside the "multiport" node where individual "mport" node defines the
>> +      PHYs supported by that port.
>> +    required:
>> +      - mport
>> +
>> +  num-hsphy:
>> +    description: Total number of HS-PHYs defined by the multiport controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  num-ssphy:
>> +    description: Total number of SS-PHYs defined by the multiport controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> These seem redundant. Can't you count ports/phys?

Counting ports will not suffice as there could be devices which has 
different numbers of HS
and SS PHYs. Consider a case like a Quadport multiport controller where 
we have the 1st & 2nd
port supporting SS and 3rd & 4th port supporting HS only. So we would 
need the proper number
of HS and SS PHYs.
Currently in the RFC v2 we are calculating the exact number of PHYS 
supported by each port
by counting the phandles we have defined.

>
>> +
>> +  mport:
>> +    description: Each mport node represents one port of the multiport controller.
>> +    patternProperties: "^mport@[0-9a-f]+$"
> Think about how the USB device binding fits into this. A hub vs.
> multiple root ports doesn't seem much different.
A hub will have multiple ports but only one HS and SS PHYs at the root 
port supporting it.
With Multiport Controller, each port will have its own PHY [whether HS 
only or both HS & SS]
>
> Rob

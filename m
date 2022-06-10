Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8436954661D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiFJLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346884AbiFJLzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:55:36 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF452BEB;
        Fri, 10 Jun 2022 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654862134; x=1686398134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=URTfI69BGXZ3xiy1fFmXlo0G+Q4p3G8vrUw8TcRjnH8=;
  b=xL833q6joQN8e6tAgZ9gv2udNx+Ar8ZqNLlyorbyKOqpdFRtoswgrc5T
   TOItZCNZygAXtnHviR22IKMufgSbvkC3SxQ5UzSYA3RgmSP7kB4grL9lS
   3QakJuCjcli4dvc2tcuVZuoQjkmKQ2OftmuD6hhIMpbamMe6aqZqL/ROr
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 10 Jun 2022 04:55:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:55:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 04:55:33 -0700
Received: from [10.216.58.87] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 10 Jun
 2022 04:55:28 -0700
Message-ID: <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
Date:   Fri, 10 Jun 2022 17:25:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <ahalaney@redhat.com>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
 <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
 <20220609153826.GA3828657-robh@kernel.org>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <20220609153826.GA3828657-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/2022 9:08 PM, Rob Herring wrote:
> On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
>> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
>> properties. These properties are used to support devices having
>> a multiport controller.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> ---
>>   .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index d41265b..9332fa2 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -343,6 +343,32 @@ properties:
>>         This port is used with the 'usb-role-switch' property  to connect the
>>         dwc3 to type C connector.
>>   
>> +  multiport:
> Again, I don't think this is going to play well if you need to describe
> USB devices in your DT. For example, a USB hub with additional DT
> properties.
Thanks for the review Rob.
Can you please explain why would one want to describe a USB hub in 
device tree ?
IF USB hub is attached to a root port , it would be enumerated by the 
SW. I am not clear how DT is coming
into picture. Even if there was a scenario to add DT properties for a 
hub, then this multiport node would be like a nop
as it just helps us to get the PHY phandles in a proper way.
Do you feel we still might have a problem with multiport node ?
>> +    description:
>> +      If a single USB controller supports multiple ports, then it's referred to as
>> +      a multiport controller. Each port of the multiport controller can support
>> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
>> +      port is represented by "mport" node and all the "mport" nodes are grouped
>> +      together inside the "multiport" node where individual "mport" node defines the
>> +      PHYs supported by that port.
>> +
>> +  num_usb2_phy:
>> +    description: Total number of HS-PHYs defined by the multiport controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  num_usb3_phy:
>> +    description: Total number of SS-PHYs defined by the multiport controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  mport:
>> +    description: Each mport node represents one port of the multiport controller.
>> +    oneOf:
>> +      - required:
>> +        - usb-phy
> This is deprecated. Why are you adding it?
Do you mean "usb-phy" is deprecated ?
Internally we use usb-phy with our downstream GLUE driver
>
>> +      - required:
>> +        - phys
>> +        - phy-names
> Other multi port USB hosts just have a list of phys. Why can't you just
> use phy-names to identify each phy:
>
> phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
>    "port3-hs";
With the above method we would have to do some kind of string parsing on 
the phy-names to get the HS and SS PHYs as we need to cater to different 
combinations of Ports ( some support HS+SS , other supports SS only).
So one challenge here is with the "usb-phy". There we directly define 
the phy phandles and that might/might-not have proper sub-strings. eg 
USB_QMP_PHY . So extracting PHYS could be tricky if the phy-handle does 
not have proper substring like "SS" "HS" etc.
We cannot break existing implementation and so we thought of going with 
the "multiport" node approach, listing below some flexibility :

1. Better representation of the PHYs and it's relation with a port.
2. Here for each port we pick the first PHY as HS and 2nd PHY as SS as 
we have been doing traditionally.
So for "usb-phy" we need not care how the PHY handles are named.

3. It's future proof incase we need to add additional properties 
specific to a port. We can just add those properties inside MP_1 or MP_2 
etc.
Though nothing like this has yet been implemented.

Also agree that there are multiple ways to approach this problem and 
that's why we had RFC tag earlier to get feedback on the same.
> Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4D55D0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiF0NHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiF0NHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:07:41 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6E65A8;
        Mon, 27 Jun 2022 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656335224; x=1687871224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6rq7G08GhO71nswW2YFTrLYTHyw3WQN6jd5/+z4OnT4=;
  b=UZ0ugkjPjvaODOXbLjcwL/5kCnVG6BQlyCN3Ml0uj6jpX39azroNjI51
   z2ON+XFm4sQiaoDaO31YUjuTcp6macj5JL6oKzATuJtrWaMBSMaugrZvX
   32KReGRAIRDQ6Mw7/n8bV5wz4ZZvuRiu+DP2CyLK0jC1eWQp9kdMg+00z
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 06:07:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:07:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 06:07:03 -0700
Received: from [10.216.8.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 06:06:58 -0700
Message-ID: <5d2a3a55-ae24-1bbb-2448-e7a23b9debde@quicinc.com>
Date:   Mon, 27 Jun 2022 18:36:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
 <20220610172210.GE1787330-robh@kernel.org>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <20220610172210.GE1787330-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 6/10/2022 10:52 PM, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 05:25:25PM +0530, Harsh Agarwal wrote:
>> On 6/9/2022 9:08 PM, Rob Herring wrote:
>>> On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
>>>> Added support for multiport, mport, num_usb2_phy and num_usb3_phy
>>>> properties. These properties are used to support devices having
>>>> a multiport controller.
>>>>
>>>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>>>> ---
>>>>    .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index d41265b..9332fa2 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -343,6 +343,32 @@ properties:
>>>>          This port is used with the 'usb-role-switch' property  to connect the
>>>>          dwc3 to type C connector.
>>>> +  multiport:
>>> Again, I don't think this is going to play well if you need to describe
>>> USB devices in your DT. For example, a USB hub with additional DT
>>> properties.
>> Thanks for the review Rob.
>> Can you please explain why would one want to describe a USB hub in device
>> tree ?
> Because someone soldered a hub on the board and then connected extra
> things like resets, GPIOs, supplies which are all outside of standard
> USB. It's quite common...
>
> There's some flavors of Beagle boards that have a USB ethernet on board.
> Guess what, they skipped out on a eeprom and so the device and a MAC
> address has to be described in DT (if you want a stable MAC addr).
>
>> IF USB hub is attached to a root port , it would be enumerated by the SW. I
>> am not clear how DT is coming
>> into picture. Even if there was a scenario to add DT properties for a hub,
>> then this multiport node would be like a nop
>> as it just helps us to get the PHY phandles in a proper way.
> It won't be enumerated by the SW if it has to be powered on first using
> non-standard resources.
>
>> Do you feel we still might have a problem with multiport node ?
> A board design could have a hub or device on any or all your ports.
>
>>>> +    description:
>>>> +      If a single USB controller supports multiple ports, then it's referred to as
>>>> +      a multiport controller. Each port of the multiport controller can support
>>>> +      either High Speed or Super Speed or both and have their own PHY phandles. Each
>>>> +      port is represented by "mport" node and all the "mport" nodes are grouped
>>>> +      together inside the "multiport" node where individual "mport" node defines the
>>>> +      PHYs supported by that port.
>>>> +
>>>> +  num_usb2_phy:
>>>> +    description: Total number of HS-PHYs defined by the multiport controller.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  num_usb3_phy:
>>>> +    description: Total number of SS-PHYs defined by the multiport controller.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +
>>>> +  mport:
>>>> +    description: Each mport node represents one port of the multiport controller.
>>>> +    oneOf:
>>>> +      - required:
>>>> +        - usb-phy
>>> This is deprecated. Why are you adding it?
>> Do you mean "usb-phy" is deprecated ?
> It is replaced by 'phys'. Any new user should use 'phys'.
>
>> Internally we use usb-phy with our downstream GLUE driver
> Upstream does not care about that.
>
>>>> +      - required:
>>>> +        - phys
>>>> +        - phy-names
>>> Other multi port USB hosts just have a list of phys. Why can't you just
>>> use phy-names to identify each phy:
>>>
>>> phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
>>>     "port3-hs";
>> With the above method we would have to do some kind of string parsing on the
>> phy-names to get the HS and SS PHYs as we need to cater to different
>> combinations of Ports ( some support HS+SS , other supports SS only).
> You are doing string parsing anyways to get the child nodes and
> properties.
>
>> So one challenge here is with the "usb-phy". There we directly define the
>> phy phandles and that might/might-not have proper sub-strings. eg
>> USB_QMP_PHY . So extracting PHYS could be tricky if the phy-handle does not
>> have proper substring like "SS" "HS" etc.
> The schema can and should enforce that you have the proper strings.
Hi Rob,
Apologies for replying late.

I get your concern. Yes we can remove the "multiport" node and instead 
define the
USB phy phandles all in one place. Still I would need to add support for 
both generic-phy and
usb-phy framework as downstream many vendors are using "usb-phy" and 
it's supported by ACK as well.
This would not regress anything with Generic PHY.

@Greg can you please comment as ACK has support for usb-phy framework.

Now coming to implementation, let's consider a 4 port USB multiport 
controller having
4 HS PHYs and 2 SS PHYs.  We can have two approaches here

#1 -> If we could mandate using "HS" or "SS" as substring in
phy-names or usb-phy, then we can calculate number of HS and SS phy and 
also get
corresponding PHY nodes. Only concern here is that downstream vendors 
might need
to change their existing usb-phy names and add proper substring if they 
are not doing so ;

phy = <&usb-hs-phy>,<&usb-ss-phy>,
       <&usb-hs-phy1>, <&usb-ss-phy1>,
       <&usb-hs-phy2>, <&usb-hs-phy3>;

phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
    "port3-hs";


OR


#2-> We could mandate defining the USB phy in HS - SS pairs.
For ports that has only HS PHY, we would need to define usb_nop_phy in 
SS place.
Then we can calculate the number of HS & SS phys and get corresponding
PHY nodes by using simple fact that HS phy would be defined at odd places &
SS phy defined at even. Here substrings are not mandated.

phy = <&usb-hs-phy>,<&usb-qmp-phy>,
       <&usb-hs-phy1>, <&usb-qmp-phy1>,
       <&usb-hs-phy2>, <&usb_nop_phy>
       <&usb-hs-phy3>, <&usb_nop_phy>;

phy-names = "port0-hs", "port0-ss",
	    "port1-hs", "port1-ss",
	    "port2-hs", "usb-nop",
	    "port3-hs", "usb-nop";


Please let me know if you prefer any approach here or have any suggestions.

>   
>
>> We cannot break existing implementation and so we thought of going with the
>> "multiport" node approach, listing below some flexibility :
> How would this break?
>
>> 1. Better representation of the PHYs and it's relation with a port.
>> 2. Here for each port we pick the first PHY as HS and 2nd PHY as SS as we
>> have been doing traditionally.
>> So for "usb-phy" we need not care how the PHY handles are named.
>>
>> 3. It's future proof incase we need to add additional properties specific to
>> a port. We can just add those properties inside MP_1 or MP_2 etc.
>> Though nothing like this has yet been implemented.
> Then you have to consider how the standard USB device binding fits into
> this, and it needs to work for anyone with multiple ports. The
> usb-hcd.yaml schema already defines that child nodes represent a USB
> device attached to a port on the host. 'reg' is the port number.
>
> Rob

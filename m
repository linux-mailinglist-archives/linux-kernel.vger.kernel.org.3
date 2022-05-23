Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D778530FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiEWLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiEWLyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:54:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3684515B1;
        Mon, 23 May 2022 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653306888; x=1684842888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZN1kRrWx/r2+ijq8bOfsSzbQOMIw0nqMbgQfjggyOo=;
  b=cwX4NxvfoTKGAPuRtc/ibsDBZU68mBfP/rau18dbRu0x5kGZhqE4HjLa
   ArjSI399t/6TqctBthY+z7e39dVc+qXkpzfw1xQaBMxOQ6JpFjJb6PGwx
   mn4v3BpjKbNA7iCAelv8tKaWbXWlQhcqf136uOX+HCbERqOoOg/g8D1Fu
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 May 2022 04:54:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 04:54:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 04:54:47 -0700
Received: from [10.216.62.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 04:54:43 -0700
Message-ID: <df0fb8cb-79bb-6941-5ce7-baaef2393797@quicinc.com>
Date:   Mon, 23 May 2022 17:24:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC 1/2] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-2-git-send-email-quic_harshq@quicinc.com>
 <YohW/W3Mk0J0AKVt@ripper>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <YohW/W3Mk0J0AKVt@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/2022 8:35 AM, Bjorn Andersson wrote:
> On Thu 19 May 05:34 PDT 2022, Harsh Agarwal wrote:
>
>> Added support for multiport, mport, num-ssphy and num-hsphy
>> properties. These properties are used to support devices having
>> a multiport controller.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> Please do run dt_binding_check on your bindings, even though they are
> RFCs.
There was some dt_binding package issue so I could not run it.
Thought to check this later since this is RFC.
Sure, I will check this.
>
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
> Why are you inventing an of_graph lookalike here?

Not really an of_graph lookalike, here we just wanted to add "multiport" 
node which would have "mport" nodes for every port that it supports.
We can treat this "multiport" like an object encapsulating other "mport" 
objects.

>
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
> I'm expecting that you wont' have any superspeed-only ports. As such
> this number would imply be the number of ports listed under the node.

Yes we can say that num_hsphy is equal to the number of "mport" nodes as 
every node will
have a HSPHY.

>
>> +
>> +  num-ssphy:
>> +    description: Total number of SS-PHYs defined by the multiport controller.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> Can you please explain why it's necessary to specify usb_nop_phy?
> Wouldn't it be possible to omit the phy in the case of a HS-only port?
> In which case this could just be calculated as well.
Yes we can ignore usb_nop_phy. It's not really necessary at places where 
we don't have a proper PHY in place.
>
> Regards,
> Bjorn
>
>> +
>> +  mport:
>> +    description: Each mport node represents one port of the multiport controller.
>> +    patternProperties: "^mport@[0-9a-f]+$"
>> +    oneOf:
>> +       - required:
>> +         - usb-phy
>> +       - required:
>> +          - phys
>> +          - phy-names
>> +
>>   unevaluatedProperties: false
>>   
>>   required:
>> @@ -369,4 +398,30 @@ examples:
>>         snps,dis_u2_susphy_quirk;
>>         snps,dis_enblslpm_quirk;
>>       };
>> +  - |
>> +    usb@4a000000 {
>> +      compatible = "snps,dwc3";
>> +      reg = <0x4a000000 0xcfff>;
>> +      interrupts = <0 92 4>;
>> +
>> +      multiport {
>> +
>> +	MP_1: mport@1 {
>> +          usb-phy = <&usb2_phy0>, <&usb3_phy0>;
>> +	};
>> +
>> +	MP_2: mport@2 {
>> +          usb-phy = <&usb2_phy1>, <&usb3_phy1>;
>> +	};
>> +
>> +	MP_3: mport@3 {
>> +          usb-phy = <&usb2_phy2>, <&usb_nop_phy>;
>> +	};
>> +
>> +	MP_4: mport@4 {
>> +          usb-phy = <&usb2_phy3>, <&usb_nop_phy>;
>> +	};
>> +
>> +      };
>> +    };
>>   ...
>> -- 
>> 2.7.4
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC853CA14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiFCMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFCMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B693A712;
        Fri,  3 Jun 2022 05:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A74B82338;
        Fri,  3 Jun 2022 12:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C26C385B8;
        Fri,  3 Jun 2022 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654259796;
        bh=X5+Q4bdVh1TVXN5s2RYm5wbG5xeVTt7YcpesFs/f8wg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XZAHQ3GUKS4+wsCT5hKKLDDpTa8PN2NY2cOPfP8XQozb1Zl5CLtB2n6o4ci5PZTut
         huFY7zAUo8DD8QshWmjfvvn0i93KLJ4IaVTMnmzVYoX6G4nWaIU4HzaHgPEli5ceTV
         coUB544Bt/I6R1DtZ+LuNYpF3YwBOCK5TND1B5f9RJ/aZfNgVXg+Ryz9u89NztlRwI
         e+9KdFycjaiFxuUxqgaQQFEm2XKWERFv/fLWbNwdld8hR/1MlVX09DaMr/SYBF0opU
         jEV/bEWyg6WEh2C0XaKHlQUHkpKdJzb9aJXpWiACPT2bhqU5YtobPG4hWKLoVz31kT
         mBYDHi1S3Qk+A==
Message-ID: <e8bc3470-11fe-16d0-a967-92bd4352d411@kernel.org>
Date:   Fri, 3 Jun 2022 15:36:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        dan.carpenter@oracle.com, kishon@ti.com, grygorii.strashko@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220531111221.22963-1-s-vadapalli@ti.com>
 <20220531111221.22963-2-s-vadapalli@ti.com>
 <26603540-8887-ef8d-8f4d-26f2f33d2a6f@kernel.org>
 <b5353c06-c8b4-c065-3843-28b2a34e1867@ti.com>
 <a7754c31-bfc6-6451-8340-5d3aa671e3c4@kernel.org>
 <985ab302-17aa-c0de-ccac-63525589918a@ti.com>
 <12afd8fc-ad03-a0f1-fad4-a9902e8a690c@kernel.org>
 <1baaa67e-43e9-49c6-f99b-5f24da4c2f1b@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1baaa67e-43e9-49c6-f99b-5f24da4c2f1b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth,

On 03/06/2022 13:49, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 03/06/22 14:18, Roger Quadros wrote:
>> Hi Siddharth,
>>
>> On 01/06/2022 14:27, Siddharth Vadapalli wrote:
>>> Hello Roger,
>>>
>>> On 01/06/22 15:08, Roger Quadros wrote:
>>>> Siddharth,
>>>>
>>>> On 01/06/2022 09:01, Siddharth Vadapalli wrote:
>>>>> Hello Roger,
>>>>>
>>>>> On 31/05/22 17:15, Roger Quadros wrote:
>>>>>> Hi Siddharth,
>>>>>>
>>>>>> On 31/05/2022 14:12, Siddharth Vadapalli wrote:
>>>>>>> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
>>>>>>> that are not supported on earlier SoCs. Add a compatible for it.
>>>>>>>
>>>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>>>> ---
>>>>>>>  .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
>>>>>>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++++++++-
>>>>>>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>>>> index fa86691ebf16..e381ba62a513 100644
>>>>>>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>>>> @@ -48,6 +48,11 @@ patternProperties:
>>>>>>>      description:
>>>>>>>        This is the SERDES lane control mux.
>>>>>>>  
>>>>>>> +  "phy@[0-9a-f]+$":
>>>>>>> +    type: object
>>>>>>> +    description:
>>>>>>> +      This is the register to set phy mode through phy-gmii-sel driver.
>>>>>>> +
>>>>>>
>>>>>> Is this really required? The system controller has 100s of different such registers and it is not practical to mention about all.
>>>>>
>>>>> The property has to be mentioned in order to pass: make dtbs_check.
>>>>>
>>>>>>
>>>>>>>  required:
>>>>>>>    - compatible
>>>>>>>    - reg
>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>>>> index ff8a6d9eb153..7427758451e7 100644
>>>>>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>>>> @@ -53,12 +53,21 @@ properties:
>>>>>>>        - ti,am43xx-phy-gmii-sel
>>>>>>>        - ti,dm814-phy-gmii-sel
>>>>>>>        - ti,am654-phy-gmii-sel
>>>>>>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>>>>>
>>>>>> Why not just "ti,j7200-phy-gmii-sel" so it is consistent naming.
>>>>>
>>>>> In TI's J7200 device, there are two CPSW MACs, namely CPSW2G and CPSW5G. While
>>>>> CPSW5G supports QSGMII mode, CPSW2G does not. Hence, the compatible being added
>>>>> with the extra mode (QSGMII) enabled is applicable only for CPSW5G and not for
>>>>> CPSW2G. Thus, to highlight this, the word "CPSW5G" has been included in the name
>>>>> of the compatible.
>>>>
>>>> Here we are talking about the PHY driver (phy-gmii-sel) and not the MAC (CPSW2G / CPSW5G)
>>>> Does this PHY on J7200 always support QSGMII mode? if yes then embedding "cpsw5g" in compatible is wrong.
>>>
>>> The PHY on J7200 is part of the Add-On Ethernet card. It is possible to connect
>>> RGMII, QSGMII and SGMII PHY. The CPSW5G MAC supports all these modes. With the
>>> current patch, I am adding just QSGMII mode as an extra mode, but in a future
>>> patch, I will be adding SGMII also as an extra mode. For this reason, CPSW5G is
>>> being mentioned in the compatible name, to differentiate supported modes for
>>> CPSW2G and CPSW5G. Also, the phy-gmii-sel driver actually configures CPSW MAC
>>> registers and not the PHY.
>>
>> phy-gmii-sel configures CTRL MMR register right? How does it configure CPSW MAC register?
>>
>> Anyways, I just looked at the TRM and there are in fact separate phy-gmii-sel (ENET_CTRL)
>> registers for CPSW2g and CPSW5g. So they warrant for separate compatibles as they are
>> not identical.
> 
> By CPSW MAC registers being configured, I meant that the configuration being
> done is for the MAC and not for the PHY. As per the TRM, for CPSW2G, the
> CTRLMMR_MCU_ENET_CTRL register is configured and for CPSW5G, the
> CTRLMMR_ENETx_CTRL registers are configured, with x ranging from 1 to 4
> (corresponding to the 4 ports of CPSW5G). These registers configure the CPSW MAC
> (CPSW2G/CPSW5G) and not the PHY. For this reason, I think that it would be
> appropriate to use cpsw5g in the compatible name, to indicate which CTRLMMR
> registers are being configured.

Yes, I already agreed that separate compatible is fine :).

> 
>>>
>>>>
>>>> You need to use a different compatible in CPSW driver and make sure CPSW2G doesn't initiate QSGMII mode.
>>>
>>> Yes, I will add a check there too by using a different compatible in the CPSW
>>> driver, but shouldn't the phy-gmii-sel driver also have a check to ensure that
>>> it doesn't try configuring QSGMII mode for CPSW2G?
>>
>> Yes, additional check in phy-gmii-sel driver is fine.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>  
>>>>>>>    reg:
>>>>>>>      maxItems: 1
>>>>>>>  
>>>>>>>    '#phy-cells': true
>>>>>>>  
>>>>>>> +  ti,enet-ctrl-qsgmii:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description: |
>>>>>>> +      Required only for QSGMII mode. Bitmask to select the port for
>>>>>>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>>>>>> +      ports automatically. Any of the 4 CPSW5G ports can act as the
>>>>>>> +      main port with the rest of them being the QSGMII_SUB ports.
>>>>>>> +
>>>>>>
>>>>>> This is weird way of doing things.
>>>>>>
>>>>>> The Ethernet controller driver already knows which mode the port is
>>>>>> supposed to operate.
>>>>>
>>>>> From the ethernet driver perspective, there is no difference between the QSGMII
>>>>> or QSGMII-SUB modes and both are treated the same. However, the phy-gmii-sel
>>>>> driver configures CPSW MAC registers differently depending on the mode being
>>
>> You mean the ENET_CTRL register in CTRL_MMR space?
> 
> Yes I am referring to the CTRLMMR_ENETx_CTRL registers as per the J7200 TRM,
> corresponding to the CPSW5G MAC.
> 
>>
>>>>> QSGMII or QSGMII-SUB. Hence, the ti,enet-ctrl-qsgmii property is used to
>>>>> identify the QSGMII main port and the rest are configured in CPSW MAC as
>>>>> QSGMII-SUB ports.
>>>>>
>>>>>>
>>>>>> e.g.
>>>>>> +&cpsw0_port1 {
>>>>>> +	phy-handle = <&cpsw5g_phy0>;
>>>>>> +	phy-mode = "qsgmii";
>>>>>> +	mac-address = [00 00 00 00 00 00];
>>>>>> +	phys = <&cpsw0_phy_gmii_sel 1>;
>>>>>> +};
>>>>>> +
>>>>>> +&cpsw0_port2 {
>>>>>> +	phy-handle = <&cpsw5g_phy1>;
>>>>>> +	phy-mode = "qsgmii-sub";
>>>>>> +	mac-address = [00 00 00 00 00 00];
>>>>>> +	phys = <&cpsw0_phy_gmii_sel 2>;
>>>>>>
>>>>>> And it can convey the mode to the PHY driver via phy_ops->set_mode.
>>>>>> So you should be depending on that instead of adding this new property.
>>>>>
>>>>> QSGMII-SUB is not a standard mode in the Linux kernel. In order to proceed with
>>>>> the suggested implementation, a new phy mode named PHY_INTERFACE_MODE_QSGMII_SUB
>>>>> has to be introduced to the kernel. Additionally, all existing phy drivers will
>>>>> have to be updated to recognize the new phy mode.
>>>>>
>>>>> Since the QSGMII-SUB mode is TI specific, it was decided that it would be better
>>>>> to add a new property in TI specific files for identifying the QSGMII main port
>>>>> and treating the rest as QSGMII-SUB ports.
>>>>
>>>> Who decides which port should be MAIN and which should be SUB? Can all ports be MAIN?
>>>> Can all ports be SUB or there has to be at least one MAIN?
>>>
>>> All 4 ports in CPSW5G have the capability to be the MAIN port, with the only
>>> restriction being that only one of them should be the MAIN port at a time. The
>>> role of the CPSW5G ports is decided based on what PHY port each of the CPSW5G
>>> ports connects to.
>>
>> OK, then instead of using bitmask and property being named "ti,enet-ctrl-qsgmii", why not
>> just say "ti,qsgmii-main-port" = <main_port_number>;
> 
> I plan to send patches for J721e device which has CPSW9G (8 external ports) MAC.
> CPSW9G can work with two sets of QSGMII interfaces (4 ports + 4 ports). Thus,
> using a bitmask for the QSGMII main port will help identify the QSGMII main port
> across both sets of QSGMII interfaces. The bitmask in case of J721e CPSW9G will
> consider the first 4 bits for the first interface's 4 ports and the next 4 bits
> for the second interface's 4 ports. In this manner, it will be possible to
> extend it for 8 port CPSW9G MAC as well, without having to add a new property
> for the second QSGMII interface.
> 
>>
>> Also do some sanity check when getting that property.
> 
> To ensure that multiple QSGMII ports are not declared as the main port, the
> "ti,enet-ctrl-qsgmii" property has been declared as an enum: [1,2,4,8]. If a

All I'm saying is that instead of bitmask please use port number to specify main port.
You can use minimum/maximum to limit the values.

Take care of limit checking per compatible and converting into bitmask in the driver.

> different value other than the value in enum were to be used, then "make
> dtbs_check" would raise an error. This will prevent configuring multiple QSGMII
> ports as the main port at once. Also, in the phy-gmii-sel driver, a default
> value of 1 is being assigned to the variable that will store the value
> corresponding to the ti,enet-ctrl-qsgmii property from the device tree, thereby
> treating the first CPSW5G port as the QSGMII main port by default.
> 
> Thanks,
> Siddharth.

cheers,
-roger

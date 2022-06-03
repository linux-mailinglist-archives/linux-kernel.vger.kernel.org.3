Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367453C724
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiFCIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiFCIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 04:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6956344D5;
        Fri,  3 Jun 2022 01:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3612F6196B;
        Fri,  3 Jun 2022 08:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F576C385A9;
        Fri,  3 Jun 2022 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654246090;
        bh=SlYIuYb3vUt+TIhGDtDoaBNEpUVdqQ8PBrShdCpp/dg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t+NSi1L5uA7yMCdxUlXCi5+Ouqw9y562EvUAKQbfX5OmrhG8Thvj2Nz99chst90Pq
         0YXQGNHbh4wXbn/qr0vnFlPQntf1YJMsGR8V7wI0MuJtHD2x0YR2nEGxRsGZIvOEHg
         mNP0YbRXzN+gn8gEwU8GStRy9qYsoweFn6WkUzoJEac40Fscrp1Ae4KxC8loQQakoV
         bCwzK0v8EXgYtD9Cb3wpwdpw56+AltzuZwVN922jbRA+wOMgTvccjOQe64IkohE/+S
         NkxFSQyOt/wBVj8RxJCQxlDNGDIDp1phFAh5jK8bY6gjcktx0PRRd1MoReddnSJTNs
         UUoPdj0DWlXIg==
Message-ID: <12afd8fc-ad03-a0f1-fad4-a9902e8a690c@kernel.org>
Date:   Fri, 3 Jun 2022 11:48:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220531111221.22963-1-s-vadapalli@ti.com>
 <20220531111221.22963-2-s-vadapalli@ti.com>
 <26603540-8887-ef8d-8f4d-26f2f33d2a6f@kernel.org>
 <b5353c06-c8b4-c065-3843-28b2a34e1867@ti.com>
 <a7754c31-bfc6-6451-8340-5d3aa671e3c4@kernel.org>
 <985ab302-17aa-c0de-ccac-63525589918a@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <985ab302-17aa-c0de-ccac-63525589918a@ti.com>
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

Hi Siddharth,

On 01/06/2022 14:27, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 01/06/22 15:08, Roger Quadros wrote:
>> Siddharth,
>>
>> On 01/06/2022 09:01, Siddharth Vadapalli wrote:
>>> Hello Roger,
>>>
>>> On 31/05/22 17:15, Roger Quadros wrote:
>>>> Hi Siddharth,
>>>>
>>>> On 31/05/2022 14:12, Siddharth Vadapalli wrote:
>>>>> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
>>>>> that are not supported on earlier SoCs. Add a compatible for it.
>>>>>
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> ---
>>>>>  .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
>>>>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++++++++-
>>>>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>> index fa86691ebf16..e381ba62a513 100644
>>>>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>>>> @@ -48,6 +48,11 @@ patternProperties:
>>>>>      description:
>>>>>        This is the SERDES lane control mux.
>>>>>  
>>>>> +  "phy@[0-9a-f]+$":
>>>>> +    type: object
>>>>> +    description:
>>>>> +      This is the register to set phy mode through phy-gmii-sel driver.
>>>>> +
>>>>
>>>> Is this really required? The system controller has 100s of different such registers and it is not practical to mention about all.
>>>
>>> The property has to be mentioned in order to pass: make dtbs_check.
>>>
>>>>
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg
>>>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>> index ff8a6d9eb153..7427758451e7 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>>>> @@ -53,12 +53,21 @@ properties:
>>>>>        - ti,am43xx-phy-gmii-sel
>>>>>        - ti,dm814-phy-gmii-sel
>>>>>        - ti,am654-phy-gmii-sel
>>>>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>>>
>>>> Why not just "ti,j7200-phy-gmii-sel" so it is consistent naming.
>>>
>>> In TI's J7200 device, there are two CPSW MACs, namely CPSW2G and CPSW5G. While
>>> CPSW5G supports QSGMII mode, CPSW2G does not. Hence, the compatible being added
>>> with the extra mode (QSGMII) enabled is applicable only for CPSW5G and not for
>>> CPSW2G. Thus, to highlight this, the word "CPSW5G" has been included in the name
>>> of the compatible.
>>
>> Here we are talking about the PHY driver (phy-gmii-sel) and not the MAC (CPSW2G / CPSW5G)
>> Does this PHY on J7200 always support QSGMII mode? if yes then embedding "cpsw5g" in compatible is wrong.
> 
> The PHY on J7200 is part of the Add-On Ethernet card. It is possible to connect
> RGMII, QSGMII and SGMII PHY. The CPSW5G MAC supports all these modes. With the
> current patch, I am adding just QSGMII mode as an extra mode, but in a future
> patch, I will be adding SGMII also as an extra mode. For this reason, CPSW5G is
> being mentioned in the compatible name, to differentiate supported modes for
> CPSW2G and CPSW5G. Also, the phy-gmii-sel driver actually configures CPSW MAC
> registers and not the PHY.

phy-gmii-sel configures CTRL MMR register right? How does it configure CPSW MAC register?

Anyways, I just looked at the TRM and there are in fact separate phy-gmii-sel (ENET_CTRL)
registers for CPSW2g and CPSW5g. So they warrant for separate compatibles as they are
not identical.
> 
>>
>> You need to use a different compatible in CPSW driver and make sure CPSW2G doesn't initiate QSGMII mode.
> 
> Yes, I will add a check there too by using a different compatible in the CPSW
> driver, but shouldn't the phy-gmii-sel driver also have a check to ensure that
> it doesn't try configuring QSGMII mode for CPSW2G?

Yes, additional check in phy-gmii-sel driver is fine.

> 
>>
>>>
>>>>
>>>>>  
>>>>>    reg:
>>>>>      maxItems: 1
>>>>>  
>>>>>    '#phy-cells': true
>>>>>  
>>>>> +  ti,enet-ctrl-qsgmii:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description: |
>>>>> +      Required only for QSGMII mode. Bitmask to select the port for
>>>>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>>>> +      ports automatically. Any of the 4 CPSW5G ports can act as the
>>>>> +      main port with the rest of them being the QSGMII_SUB ports.
>>>>> +
>>>>
>>>> This is weird way of doing things.
>>>>
>>>> The Ethernet controller driver already knows which mode the port is
>>>> supposed to operate.
>>>
>>> From the ethernet driver perspective, there is no difference between the QSGMII
>>> or QSGMII-SUB modes and both are treated the same. However, the phy-gmii-sel
>>> driver configures CPSW MAC registers differently depending on the mode being

You mean the ENET_CTRL register in CTRL_MMR space?

>>> QSGMII or QSGMII-SUB. Hence, the ti,enet-ctrl-qsgmii property is used to
>>> identify the QSGMII main port and the rest are configured in CPSW MAC as
>>> QSGMII-SUB ports.
>>>
>>>>
>>>> e.g.
>>>> +&cpsw0_port1 {
>>>> +	phy-handle = <&cpsw5g_phy0>;
>>>> +	phy-mode = "qsgmii";
>>>> +	mac-address = [00 00 00 00 00 00];
>>>> +	phys = <&cpsw0_phy_gmii_sel 1>;
>>>> +};
>>>> +
>>>> +&cpsw0_port2 {
>>>> +	phy-handle = <&cpsw5g_phy1>;
>>>> +	phy-mode = "qsgmii-sub";
>>>> +	mac-address = [00 00 00 00 00 00];
>>>> +	phys = <&cpsw0_phy_gmii_sel 2>;
>>>>
>>>> And it can convey the mode to the PHY driver via phy_ops->set_mode.
>>>> So you should be depending on that instead of adding this new property.
>>>
>>> QSGMII-SUB is not a standard mode in the Linux kernel. In order to proceed with
>>> the suggested implementation, a new phy mode named PHY_INTERFACE_MODE_QSGMII_SUB
>>> has to be introduced to the kernel. Additionally, all existing phy drivers will
>>> have to be updated to recognize the new phy mode.
>>>
>>> Since the QSGMII-SUB mode is TI specific, it was decided that it would be better
>>> to add a new property in TI specific files for identifying the QSGMII main port
>>> and treating the rest as QSGMII-SUB ports.
>>
>> Who decides which port should be MAIN and which should be SUB? Can all ports be MAIN?
>> Can all ports be SUB or there has to be at least one MAIN?
> 
> All 4 ports in CPSW5G have the capability to be the MAIN port, with the only
> restriction being that only one of them should be the MAIN port at a time. The
> role of the CPSW5G ports is decided based on what PHY port each of the CPSW5G
> ports connects to.

OK, then instead of using bitmask and property being named "ti,enet-ctrl-qsgmii", why not
just say "ti,qsgmii-main-port" = <main_port_number>;

Also do some sanity check when getting that property.

> 
> MAIN port of CPSW5G MAC is responsible for auto-negotiation with the PHY port on
> the PHY which supports auto-negotiation. Thus, there can and should be only one
> MAIN port.
> 
> Thanks,
> Siddharth.

cheers,
-roger

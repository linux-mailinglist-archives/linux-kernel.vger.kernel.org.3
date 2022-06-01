Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3576153A0C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiFAJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbiFAJiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D539FCE;
        Wed,  1 Jun 2022 02:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3136261382;
        Wed,  1 Jun 2022 09:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D515AC385A5;
        Wed,  1 Jun 2022 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654076295;
        bh=/cAh/hUl6aZYm5faACeVWIPzmTUmPWXKFSswlO2JgXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PaHm9E75tqTQSl/rTAiT1R5bXb3H58U2VfRPw8mLbFrhkx+6gTmhEbfMEeY7gvMcC
         9aBpfte9cXblh9Bu1aHmP2yK9TytdiLCmvN9PWagKvMimV3BnmPaLH4HLbhZXaG7IT
         EI7FNqKHfJQt2bi4IVRzE7blXOmw6LRlaHETwh+2eYNCti7sG4un2JbDbU5+83giIG
         WDl6U9veBtcnprHBMkJ2tVmBYSFgLVnbPxfyxOHf13RA0+1XZLuFeB37TMK+MLKGNw
         vpNwz4CZUs9xZgGuqUvXPKFB32ZRm+J3X8GEdVqw+WafeUgJCVI4h/Z5rUaz7OpCs5
         NUcQCvrYNREsg==
Message-ID: <a7754c31-bfc6-6451-8340-5d3aa671e3c4@kernel.org>
Date:   Wed, 1 Jun 2022 12:38:10 +0300
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
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <b5353c06-c8b4-c065-3843-28b2a34e1867@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Siddharth,

On 01/06/2022 09:01, Siddharth Vadapalli wrote:
> Hello Roger,
> 
> On 31/05/22 17:15, Roger Quadros wrote:
>> Hi Siddharth,
>>
>> On 31/05/2022 14:12, Siddharth Vadapalli wrote:
>>> TI's J7200 SoC supports additional PHY modes like QSGMII and SGMII
>>> that are not supported on earlier SoCs. Add a compatible for it.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>  .../mfd/ti,j721e-system-controller.yaml       |  5 ++++
>>>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 24 ++++++++++++++++++-
>>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> index fa86691ebf16..e381ba62a513 100644
>>> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>>> @@ -48,6 +48,11 @@ patternProperties:
>>>      description:
>>>        This is the SERDES lane control mux.
>>>  
>>> +  "phy@[0-9a-f]+$":
>>> +    type: object
>>> +    description:
>>> +      This is the register to set phy mode through phy-gmii-sel driver.
>>> +
>>
>> Is this really required? The system controller has 100s of different such registers and it is not practical to mention about all.
> 
> The property has to be mentioned in order to pass: make dtbs_check.
> 
>>
>>>  required:
>>>    - compatible
>>>    - reg
>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> index ff8a6d9eb153..7427758451e7 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
>>> @@ -53,12 +53,21 @@ properties:
>>>        - ti,am43xx-phy-gmii-sel
>>>        - ti,dm814-phy-gmii-sel
>>>        - ti,am654-phy-gmii-sel
>>> +      - ti,j7200-cpsw5g-phy-gmii-sel
>>
>> Why not just "ti,j7200-phy-gmii-sel" so it is consistent naming.
> 
> In TI's J7200 device, there are two CPSW MACs, namely CPSW2G and CPSW5G. While
> CPSW5G supports QSGMII mode, CPSW2G does not. Hence, the compatible being added
> with the extra mode (QSGMII) enabled is applicable only for CPSW5G and not for
> CPSW2G. Thus, to highlight this, the word "CPSW5G" has been included in the name
> of the compatible.

Here we are talking about the PHY driver (phy-gmii-sel) and not the MAC (CPSW2G / CPSW5G)
Does this PHY on J7200 always support QSGMII mode? if yes then embedding "cpsw5g" in compatible is wrong.

You need to use a different compatible in CPSW driver and make sure CPSW2G doesn't initiate QSGMII mode.

> 
>>
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>>    '#phy-cells': true
>>>  
>>> +  ti,enet-ctrl-qsgmii:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Required only for QSGMII mode. Bitmask to select the port for
>>> +      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
>>> +      ports automatically. Any of the 4 CPSW5G ports can act as the
>>> +      main port with the rest of them being the QSGMII_SUB ports.
>>> +
>>
>> This is weird way of doing things.
>>
>> The Ethernet controller driver already knows which mode the port is
>> supposed to operate.
> 
> From the ethernet driver perspective, there is no difference between the QSGMII
> or QSGMII-SUB modes and both are treated the same. However, the phy-gmii-sel
> driver configures CPSW MAC registers differently depending on the mode being
> QSGMII or QSGMII-SUB. Hence, the ti,enet-ctrl-qsgmii property is used to
> identify the QSGMII main port and the rest are configured in CPSW MAC as
> QSGMII-SUB ports.
> 
>>
>> e.g.
>> +&cpsw0_port1 {
>> +	phy-handle = <&cpsw5g_phy0>;
>> +	phy-mode = "qsgmii";
>> +	mac-address = [00 00 00 00 00 00];
>> +	phys = <&cpsw0_phy_gmii_sel 1>;
>> +};
>> +
>> +&cpsw0_port2 {
>> +	phy-handle = <&cpsw5g_phy1>;
>> +	phy-mode = "qsgmii-sub";
>> +	mac-address = [00 00 00 00 00 00];
>> +	phys = <&cpsw0_phy_gmii_sel 2>;
>>
>> And it can convey the mode to the PHY driver via phy_ops->set_mode.
>> So you should be depending on that instead of adding this new property.
> 
> QSGMII-SUB is not a standard mode in the Linux kernel. In order to proceed with
> the suggested implementation, a new phy mode named PHY_INTERFACE_MODE_QSGMII_SUB
> has to be introduced to the kernel. Additionally, all existing phy drivers will
> have to be updated to recognize the new phy mode.
> 
> Since the QSGMII-SUB mode is TI specific, it was decided that it would be better
> to add a new property in TI specific files for identifying the QSGMII main port
> and treating the rest as QSGMII-SUB ports.

Who decides which port should be MAIN and which should be SUB? Can all ports be MAIN?
Can all ports be SUB or there has to be at least one MAIN?

Just trying to understand if there can be a solution without introducing a new
custom property.

cheers,
-roger

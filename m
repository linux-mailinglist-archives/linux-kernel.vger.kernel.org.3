Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E84E72CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358016AbiCYMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351392AbiCYMOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:14:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89181344D4;
        Fri, 25 Mar 2022 05:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CFF618F4;
        Fri, 25 Mar 2022 12:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24922C340E9;
        Fri, 25 Mar 2022 12:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648210391;
        bh=Y/4il5PTv0k7vOpnOaFfNmWG5EFpXpTVGlg4uy6R8oM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=umEavdpR9nMKXOqjv3UBfB2vpGE9EKXBmhSPOxFTRwnXBOE0faELQkmG2eYQA8pw6
         9b0UC2kikZnkN7IWjzUcjrFw5cGwWGl3uVzoIKwIlCE1pHKoTpCP+InrS/Pt0EMiKj
         OD/6SujYAQJyeQIgrFCfrxrxUDmQ2BPjyTZ/3QkStNC6+fYNM9jHuBNE7yxsG63S99
         m/u21mCwN8VDIkZvG/yAGjR22CD7WCk9dLJGDLj1LpEEJPuYoMTgWwVKCMj3dTGGSl
         Uom3yIklhUtNaKMNAvlTkkSLTVu9bgvURvqfdgWPH1m+4T2Q2qllHWoXDzegUObvtj
         g8SZrcHBGhoow==
Message-ID: <85022bd4-52fb-d15c-cc47-8d891ae3a968@kernel.org>
Date:   Fri, 25 Mar 2022 14:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-3-rogerq@kernel.org>
 <a222efb1-4f95-d65d-919b-ed55c5448c9a@kernel.org>
 <abcbe390-45a8-6183-56a8-f9f751e84f49@kernel.org>
 <597e4bfb-383d-0f3b-dce8-ffc12f543b46@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <597e4bfb-383d-0f3b-dce8-ffc12f543b46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/2022 14:08, Krzysztof Kozlowski wrote:
> On 25/03/2022 13:05, Roger Quadros wrote:
>>
>>
>> On 24/03/2022 20:26, Krzysztof Kozlowski wrote:
>>> On 23/03/2022 12:18, Roger Quadros wrote:
>>>> TI's AM64 SoC has the Error Locator Module. Add compatible and
>>>> related properties to support ELM on AM64 SoC.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  .../devicetree/bindings/mtd/ti,elm.yaml       | 27 ++++++++++++++++++-
>>>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>> index 24ed0fb84204..bc01d35ce605 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
>>>> @@ -17,7 +17,9 @@ description:
>>>>  properties:
>>>>    compatible:
>>>>      items:
>>>> -      - const: ti,am3352-elm
>>>> +      - enum:
>>>> +          - ti,am3352-elm
>>>> +          - ti,am64-elm
>>>>  
>>>>    reg:
>>>>      maxItems: 1
>>>> @@ -25,6 +27,17 @@ properties:
>>>>    interrupts:
>>>>      maxItems: 1
>>>>  
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +    description: Functional clock.
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: fck
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>>    ti,hwmods:
>>>>      description:
>>>>        Name of the HWMOD associated with ELM. This is for legacy
>>>> @@ -37,6 +50,18 @@ required:
>>>>    - reg
>>>>    - interrupts
>>>>  
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: ti,am64-elm
>>>> +    then:
>>>> +      required:
>>>> +        - clocks
>>>> +        - clock-names
>>>> +        - power-domains
>>>
>>> Are these new properties also valid for am3352?
>>
>> No they are not required for am3352-elm. Only required for K3 based platforms like AM64.
>>
> 
> I understand they are not required, but I asked if they are valid. IOW,
> whether ELM in am3352 also is part of power domain and has clock input?

Yes it does have power and clock domains but they are handled a bit differently
on AM335x platform. i.e. in the parent node

e.g.

               target-module@80000 {                   /* 0x48080000, ap 38 18.0 */
                        compatible = "ti,sysc-omap2", "ti,sysc";
                        reg = <0x80000 0x4>,
                              <0x80010 0x4>,
                              <0x80014 0x4>;
                        reg-names = "rev", "sysc", "syss";
                        ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
                                         SYSC_OMAP2_SOFTRESET |
                                         SYSC_OMAP2_AUTOIDLE)>;
                        ti,sysc-sidle = <SYSC_IDLE_FORCE>,
                                        <SYSC_IDLE_NO>,
                                        <SYSC_IDLE_SMART>;
                        ti,syss-mask = <1>;
                        /* Domains (P, C): per_pwrdm, l4ls_clkdm */
                        clocks = <&l4ls_clkctrl AM3_L4LS_ELM_CLKCTRL 0>;
                        clock-names = "fck";
                        #address-cells = <1>;
                        #size-cells = <1>;
                        ranges = <0x0 0x80000 0x10000>;

                        elm: elm@0 {
                                compatible = "ti,am3352-elm";
                                reg = <0x0 0x2000>;
                                interrupts = <4>;
                                status = "disabled";
                        };
                };

cheers,
-roger

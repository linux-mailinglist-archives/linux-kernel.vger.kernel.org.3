Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566B1566DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiGEMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiGEMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A21D32E;
        Tue,  5 Jul 2022 05:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED7961A3E;
        Tue,  5 Jul 2022 12:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FCAC341C8;
        Tue,  5 Jul 2022 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657023345;
        bh=J+M/V+SykFxnbsUfIgMLQ6alq6tMHZTNp0OHJ6KPsS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZV8RpJDUns4kVvCHvGMaR47uUZcdPx9djbDXnxBCMEyoF22KGS04ewRV41Y6NHZwN
         N9CcRYG9UT222yQmigSgCRLmHi5/bntycnMlYzXzZaKvH0kp8EW3c6JExmKMzBZtoi
         xTZVucVi1ZgoX2VybWxpp0RouJTB1DiQ4utjiXLDxsm5cKOL/QYFHqV/2ooH7mUt60
         PB/9Z1P4Mg+dlTAeR0IafJloIRp9DWxSXU17Bsam0q6vcJLh8b6f1uu41MO1KE3Nkn
         q8uSvGeNN5Ph5Ob3iaDTYzvt/0lpIySxaoZLqisQfxRG/bEo+0kukcsT3L92MR7vtP
         hzRIOPkHoivEg==
Received: by pali.im (Postfix)
        id BCD44CBF; Tue,  5 Jul 2022 14:15:41 +0200 (CEST)
Date:   Tue, 5 Jul 2022 14:15:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Message-ID: <20220705121541.t7jjcjp4hkqprsdo@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
 <20220705114238.xwgexavgozqskwbw@pali>
 <90fd55cb-13f4-eac2-2b1a-85ae628ecc89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90fd55cb-13f4-eac2-2b1a-85ae628ecc89@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2022 13:51:12 Krzysztof Kozlowski wrote:
> On 05/07/2022 13:42, Pali Rohár wrote:
> > On Tuesday 05 July 2022 13:36:54 Krzysztof Kozlowski wrote:
> >> On 05/07/2022 02:04, Pali Rohár wrote:
> >>> Add device-tree bindings documentation for Turris 1.x RGB LEDs.
> >>>
> >>> Signed-off-by: Pali Rohár <pali@kernel.org>
> >>> ---
> >>>  .../bindings/leds/cznic,turris1x-leds.yaml    | 116 ++++++++++++++++++
> >>>  1 file changed, 116 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> >>> new file mode 100644
> >>> index 000000000000..fd09613c8d2d
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> >>> @@ -0,0 +1,116 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: CZ.NIC's Turris 1.x LEDs driver
> >>> +
> >>> +maintainers:
> >>> +  - Pali Rohár <pali@kernel.org>
> >>> +
> >>> +description:
> >>> +  This module adds support for the RGB LEDs found on the front panel of the
> >>> +  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
> >>> +  firmware running on Lattice FPGA. Firmware is open source and available at
> >>> +  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: cznic,turris1x-leds
> >>> +
> >>> +  reg:
> >>> +    maxItems: 2
> >>
> >> You need to describe the items, if it is really two items. However your
> >> example has only one item, so this was not tested and won't work.
> > 
> > Ehm? Example has two items in the reg.
> 
> No, you have exactly one item.
> <0x13 0x1d>
> 
> Two items are for example:
> <0x13 0x1d>, <0x23 0x1d>

Ok. So I should change maxItems to 1 in this case?

And how you want to describe those items?

> > 
> >> You'll get warning from Rob's robot soon... but you should test the
> >> bindings instead.
> > 
> > I have tested bindings on the real hardware and it is working fine
> > together with the driver from patch 2/2.
> 
> Bindings cannot be tested on real hardware. Bindings are tested with
> dt_binding_check, as explained in writing-schema.rst

Ou... this is something which I was not able to run, it just does not
work, throws lot of python dependency hell errors and it spend more than
hour with it. So sorry, I really cannot run it. Maybe it would be a wise
to provide web service for these checks for those who cannot run them
locally?

> > 
> >>> +
> >>> +  "#address-cells":
> >>> +    const: 1
> >>> +
> >>> +  "#size-cells":
> >>> +    const: 0
> >>> +
> >>> +patternProperties:
> >>> +  "^multi-led@[0-7]$":
> >>> +    type: object
> >>> +    $ref: leds-class-multicolor.yaml#
> >>
> >> This looks incorrect, unless you rebased on my patchset?
> > 
> > So what is the correct? (I used inspiration from
> > cznic,turris-omnia-leds.yaml file)
> 
> Which according to current multicolor bindings is not correct. Correct
> is pwm-multicolor. However if you rebase on [1], it looks fine, except
> missing unevaluatedProperties.

Ok. So does it mean that I should just add
"unevaluatedProperties: false"?

> [1]
> https://lore.kernel.org/all/20220624112106.111351-1-krzysztof.kozlowski@linaro.org/
> 
> > 
> >>> +
> >>> +    properties:
> >>> +      reg:
> >>> +        minimum: 0
> >>> +        maximum: 7
> >>> +
> >>> +    required:
> >>> +      - reg
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +
> >>
> >> No blank line.
> > 
> > Ok.
> > 
> >>> +    #include <dt-bindings/leds/common.h>
> >>> +
> >>> +    cpld@3,0 {
> >>
> >> Generic node name.
> > 
> > Is not cpld name generic enough?
> 
> No, it means nothing to me. Just like "a", "ashjd" or "wrls".

If you never heard about it, I would suggest to read something about
Programmable logic devices. It is interesting category of hardware with
which you can play. CPLD and FPGA are very often used in lot of products
and FPGA is very easy for playing and programming custom logic.

For example on wikipedia is list of different technologies of
programmable logic devices:
https://en.wikipedia.org/wiki/Programmable_logic_device

So if you want more generic name, just name it "pld"? But as it is CPLD
device I would suggest to name it really as "cpld". It does not matter
from which manufactor you have CPLD, just like it does not matter from
which manufactor you have NAND.

From bus point of view, cpld is like nand or nor nodes in DTS. All of
them refers to specific memory map of chip selects on the local bus.

> "The name of a node should be somewhat generic, reflecting the function
> of the device and not its precise programming
>  model. If appropriate, the name should be one of the following choices:"

Hm... You forgot to send what are those "choices:"?

> Best regards,
> Krzysztof

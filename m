Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36803566A04
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiGELmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGELmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A801704E;
        Tue,  5 Jul 2022 04:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72BFE6163C;
        Tue,  5 Jul 2022 11:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E139C341C7;
        Tue,  5 Jul 2022 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021361;
        bh=UdQ7JRNNmKOouwZRfkPg0ishKhazBun/wUcYJwP4HfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPHJDjRFaAfomSYoAqFLAi9AnrB7jQK4vbF9qUAr7ClDKQ6ODCH5gl/JkxUDa2nsw
         JqGuhFlXLDg8DmareUba+FTM4XLIyB1svfMcqY8yvYx48hXTDCfx3+EmaEJG8Qyntc
         5uGb2Bks0wuurxKstzIYPFP0FkncuOSi2LCS5B6w4K9cD7+fM4Asj4vjyowneYrylY
         Gle5n2CKsjOm0EcMXm4xlNEn7FCO/QMgPy3RMZfEQ0wVSFj/BWh6Ym47rdEE3ujnYR
         n705NsUsLNzdZiCB/y7/eDhIrVu57lbvqlBpPJV3vq7K4CAz6mlf3NkJyukyQvYvkq
         XvwG8ZNXtG7BQ==
Received: by pali.im (Postfix)
        id A3287CBF; Tue,  5 Jul 2022 13:42:38 +0200 (CEST)
Date:   Tue, 5 Jul 2022 13:42:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Add cznic,turris1x-leds.yaml
 binding
Message-ID: <20220705114238.xwgexavgozqskwbw@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d837dd-fbd1-6294-2fa0-8a07ae0f8d44@linaro.org>
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

On Tuesday 05 July 2022 13:36:54 Krzysztof Kozlowski wrote:
> On 05/07/2022 02:04, Pali Rohár wrote:
> > Add device-tree bindings documentation for Turris 1.x RGB LEDs.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../bindings/leds/cznic,turris1x-leds.yaml    | 116 ++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> > new file mode 100644
> > index 000000000000..fd09613c8d2d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: CZ.NIC's Turris 1.x LEDs driver
> > +
> > +maintainers:
> > +  - Pali Rohár <pali@kernel.org>
> > +
> > +description:
> > +  This module adds support for the RGB LEDs found on the front panel of the
> > +  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
> > +  firmware running on Lattice FPGA. Firmware is open source and available at
> > +  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
> > +
> > +properties:
> > +  compatible:
> > +    const: cznic,turris1x-leds
> > +
> > +  reg:
> > +    maxItems: 2
> 
> You need to describe the items, if it is really two items. However your
> example has only one item, so this was not tested and won't work.

Ehm? Example has two items in the reg.

> You'll get warning from Rob's robot soon... but you should test the
> bindings instead.

I have tested bindings on the real hardware and it is working fine
together with the driver from patch 2/2.

> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^multi-led@[0-7]$":
> > +    type: object
> > +    $ref: leds-class-multicolor.yaml#
> 
> This looks incorrect, unless you rebased on my patchset?

So what is the correct? (I used inspiration from
cznic,turris-omnia-leds.yaml file)

> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 7
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> 
> No blank line.

Ok.

> > +    #include <dt-bindings/leds/common.h>
> > +
> > +    cpld@3,0 {
> 
> Generic node name.

Is not cpld name generic enough?

> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        led-controller@13 {
> > +            compatible = "cznic,turris1x-leds";
> > +            reg = <0x13 0x1d>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> 
> 
> Best regards,
> Krzysztof

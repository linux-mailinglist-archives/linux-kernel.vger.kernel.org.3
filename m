Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F704C1663
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbiBWPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiBWPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:19:07 -0500
X-Greylist: delayed 66724 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 07:18:38 PST
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4559039B9C;
        Wed, 23 Feb 2022 07:18:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E89AAC000A;
        Wed, 23 Feb 2022 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645629516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8WJ1C1Tx3aKKa3O4w4oElLz8XE2ctzr9MgK1/YUoCU=;
        b=oc+Jes6pQdZo1kzhSYkAkXsvE4s+RVTUPbPWDmF1a35hrX82st5TluCAV2C15w0eMkA6I5
        nP4Q+Q12KrmS/7Sss8FFkJroL31r78SoKt2sw/bLzZGFDhtudEOtKMfhmDS+/0qjJ+B7yL
        J2/IS+Z4W/TYryGG1X8Dz/Y49ypWY9CsE22lqqkz4jV2WVnpyPb9JDrEiHzzf2yyFa3jOd
        R0ubzG96gMcXnRbrpvcpOyppNxeAFUVC0LPXkmZwmq0wqfUPITlJbx8HtOmcK+ntjSCVm5
        lVxdfAzaWpUBonEOa73WxiVLJABsIPWjte8zqb/7KK1JEox5Lbi/c0jsv1EyAw==
Date:   Wed, 23 Feb 2022 16:18:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Conor.Dooley@microchip.com
Cc:     a.zummo@towertech.it, Lewis.Hanly@microchip.com,
        Daire.McNamara@microchip.com, Ivan.Griffin@microchip.com,
        atishp@rivosinc.com, palmer@rivosinc.com, robh@kernel.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        krzysztof.kozlowski@canonical.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 03/11] dt-bindings: rtc: add bindings for microchip
 mpfs rtc
Message-ID: <YhZQRqHib2+GR7Ma@piout.net>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-4-conor.dooley@microchip.com>
 <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 07:41:27+0000, Conor.Dooley@microchip.com wrote:
> Hi Alessandro, Alexandre,
> If one of you could take a look at this, that'd be great.

I actually expected someone else to apply this, what is your plan?

> Thanks,
> Conor.
> 
> On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Add device tree bindings for the real time clock on
> > the Microchip PolarFire SoC.
> > 
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/rtc/microchip,mfps-rtc.yaml      | 58 +++++++++++++++++++
> >   1 file changed, 58 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> > new file mode 100644
> > index 000000000000..a2e984ea3553
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/microchip,mfps-rtc.yaml#
> > +
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip PolarFire Soc (MPFS) RTC Device Tree Bindings
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
> > +
> > +maintainers:
> > +  - Daire McNamara <daire.mcnamara@microchip.com>
> > +  - Lewis Hanly <lewis.hanly@microchip.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,mpfs-rtc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: |
> > +          RTC_WAKEUP interrupt
> > +      - description: |
> > +          RTC_MATCH, asserted when the content of the Alarm register is equal
> > +          to that of the RTC's count register.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: rtc
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    rtc@20124000 {
> > +        compatible = "microchip,mpfs-rtc";
> > +        reg = <0x20124000 0x1000>;
> > +        clocks = <&clkcfg 21>;
> > +        clock-names = "rtc";
> > +        interrupts = <80>, <81>;
> > +    };
> > +...
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

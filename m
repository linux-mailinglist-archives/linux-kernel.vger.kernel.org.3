Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417934C1D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiBWUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBWUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:21:32 -0500
X-Greylist: delayed 18142 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 12:21:00 PST
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6094D24F;
        Wed, 23 Feb 2022 12:21:00 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 25761FF806;
        Wed, 23 Feb 2022 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645647659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kppx7Y3HjhzvN/0jitv+VoeGh8Sofe2wA4Rh6vVi4nc=;
        b=i/1fOodDKjajA7oMrrhNGuIu5sn0knGb8CS5vjJRRF7pgR6lo5Ax8zNhM85PKuJUiuuMMJ
        F0ge0zIXNiPi+gichbf04LURreif0+ASM4CWWywE/KCI6lilVoJDvfZMYiuii5a4mRbP4Y
        AUv8ltZiNhwC1Ql3jZABl97QRZdG2LeBIC7pGp17YhCDjdnwi+MxSbUwKYL84UFDGbQIgx
        cscriGuvt8D1yBksk8WwgtAfGxiTH/2OeFLQtKidR0tQoG6rQw94NpHYVw/pgoiQ8+W72f
        qmrsyQSEpelVR7uovNn5/lleH0xAvDpEEZO2utZV2oJeePAOqWCmWRRSuV7qVg==
Date:   Wed, 23 Feb 2022 21:20:54 +0100
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
Message-ID: <YhaXJofTTTgaoEsn@piout.net>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-4-conor.dooley@microchip.com>
 <5b0681a0-ff46-7eb4-3644-0d1173c1f0d4@microchip.com>
 <YhZQRqHib2+GR7Ma@piout.net>
 <3483b6c4-67a7-5ed5-2953-728ea8ba5874@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3483b6c4-67a7-5ed5-2953-728ea8ba5874@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 15:25:00+0000, Conor.Dooley@microchip.com wrote:
> On 23/02/2022 15:18, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 23/02/2022 07:41:27+0000, Conor.Dooley@microchip.com wrote:
> >> Hi Alessandro, Alexandre,
> >> If one of you could take a look at this, that'd be great.
> > 
> > I actually expected someone else to apply this, what is your plan?
> 
> I was going to ask Palmer to take the series via riscv. Since I have
> Rob's R-b, I was just looking for a subsystem maintainer ack/R-b before
> actually asking him.
> 

Rob's review is enough for a DT binding, no need to wait for me. but
FWIW:

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> Thanks,
> Conor.
> 
> > 
> >> Thanks,
> >> Conor.
> >>
> >> On 14/02/2022 13:58, conor.dooley@microchip.com wrote:
> >>> From: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Add device tree bindings for the real time clock on
> >>> the Microchip PolarFire SoC.
> >>>
> >>> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> >>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>>    .../bindings/rtc/microchip,mfps-rtc.yaml      | 58 +++++++++++++++++++
> >>>    1 file changed, 58 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> >>> new file mode 100644
> >>> index 000000000000..a2e984ea3553
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
> >>> @@ -0,0 +1,58 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/rtc/microchip,mfps-rtc.yaml#
> >>> +
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Microchip PolarFire Soc (MPFS) RTC Device Tree Bindings
> >>> +
> >>> +allOf:
> >>> +  - $ref: rtc.yaml#
> >>> +
> >>> +maintainers:
> >>> +  - Daire McNamara <daire.mcnamara@microchip.com>
> >>> +  - Lewis Hanly <lewis.hanly@microchip.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - microchip,mpfs-rtc
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    items:
> >>> +      - description: |
> >>> +          RTC_WAKEUP interrupt
> >>> +      - description: |
> >>> +          RTC_MATCH, asserted when the content of the Alarm register is equal
> >>> +          to that of the RTC's count register.
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: rtc
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - interrupts
> >>> +  - clocks
> >>> +  - clock-names
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    rtc@20124000 {
> >>> +        compatible = "microchip,mpfs-rtc";
> >>> +        reg = <0x20124000 0x1000>;
> >>> +        clocks = <&clkcfg 21>;
> >>> +        clock-names = "rtc";
> >>> +        interrupts = <80>, <81>;
> >>> +    };
> >>> +...
> >>
> > 
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

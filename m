Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239104AF07D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiBIMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiBIL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:41 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADA0E0407B8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:58:10 -0800 (PST)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6E34B29F375;
        Wed,  9 Feb 2022 11:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644404288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOLtgfJTjpy0/bSG7vguavNiQOyb4CA7NGaPWqjr8EM=;
        b=pgZXiLP2dYfgMUiQhIceGbLCPtrqqNKvWNjHUJUoaRBzrbRCIiYYIjAr0REx8oscknW3YE
        XcNNWYaMST6DJqh0ysOz5BKO7j/Lxs2sT7GlFhUhCNknmI7BBDA+bl4EXhlICulgYF01eJ
        OOhhpuo4RjNDBXkSO6DBwebdme+s0yoG2lYjRrdFxGNS1BES5dqkdlRZHDf28RK1SnDleo
        A/ZQG0r0aUY8LlU/a9ML0ugAKwZTQGk3VCCuoXPwjjnCpgM4Apxud9YTJUaAX4UGXo9FlK
        ZM80Cb/+9H0kDecwz1lm2keH5f6yTRLsspNd3+F/hrXfZHLMXyO2oY/fEaqvbQ==
Message-ID: <71783087474514dc71db9acdc06f460dfdaa1333.camel@svanheule.net>
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add realtek,otto-tc binding
From:   Sander Vanheule <sander@svanheule.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 09 Feb 2022 11:58:06 +0100
In-Reply-To: <YgMrwEXraoiJxSXe@robh.at.kernel.org>
References: <cover.1642369117.git.sander@svanheule.net>
         <7c53821386b8f4c1c0ac440f1cd186e09f4a0456.1642369117.git.sander@svanheule.net>
         <YgMrwEXraoiJxSXe@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 2022-02-08 at 20:49 -0600, Rob Herring wrote:
> On Sun, Jan 16, 2022 at 10:39:24PM +0100, Sander Vanheule wrote:
> > New binding for the timer/counter blocks found on the Realtek Otto MIPS
> > platform.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> >  .../bindings/timer/realtek,otto-tc.yaml       | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-
> > tc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> > b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> > new file mode 100644
> > index 000000000000..12971b9ecdf5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/realtek,otto-tc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Realtek Otto platform timer/counter bindings
> > +
> > +description:
> 
> '|' at the end if you want to keep formatting.
> 
> > +  "Up-counting 28-bit timer that can operate in oneshot or repeating mode,
> 
> And drop the quotes.
> 
> > +  providing an interrupt at roll-over.
> > +
> > +  The timer is driven by a divided clock, derived from the bus clock. The
> > clock
> > +  divisor is configurable from 2 to 65535. Divisor values of 0 and 1
> > disable
> > +  the timer clock. The timer can also be enabled or disabled independently
> > from
> > +  the clock (divisor) selection.
> > +
> > +  The number of timers supported by the different SoC families is:
> > +  - RTL8380: 5 timers
> > +  - RTL8390: 5 timers
> > +  - RTL9300: 6 timers
> > +  - RTL9310: 7 timers"
> > +
> > +maintainers:
> > +  - Sander Vanheule <sander@svanheule.net>
> > +
> > +properties:
> > +  compatible:
> > +    const: realtek,otto-tc
> 
> 4 SoCs with differences in the block, you need 4 SoC specific 
> compatibles. With a fallback if appropriate.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Parent clock from peripheral bus
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +examples:
> > +  - |
> > +    timer0: timer@3100 {
> 
> Drop unused labels.

I forgot to remove this, as originally I had...

> 
> > +      compatible = "realtek,otto-tc";
> > +      reg = <0x3100 0x10>;
> > +
> > +      interrupts = <29 4>;
> > +
> > +      clocks = <&lx_clk>;
> > +      clock-names = "bus";

clocks = <&lx_clk>, <&timer0>;
clock-names = "bus", "timer";

to have a self-reference for the (private) derived clock. Not sure if it makes
sense to do it like this though, or if only the bus clock would be sufficient.

I'll also fix your other remarks in v2.

Best,
Sander


> > +    };
> > -- 
> > 2.34.1
> > 
> > 

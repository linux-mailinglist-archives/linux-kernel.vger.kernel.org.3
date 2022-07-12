Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EC5719E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiGLMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiGLMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:18 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3FCA5E4B;
        Tue, 12 Jul 2022 05:24:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4375CDF286;
        Tue, 12 Jul 2022 05:24:17 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eSbaFB-KPugV; Tue, 12 Jul 2022 05:24:16 -0700 (PDT)
Message-ID: <c6066da644dfd55a2c4a008ab5e70c9efd85dfed.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657628656; bh=zCJYAyelIRYW6p1Xe689vdRxKt59/Iy6VTbPWL4bSqI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SI3SRLlPjJ26yGcRIHF57cq4bMyItFVgxu0DCpYrIBOS682Jrp1nkeREuVZbSyjiM
         RRtbOXHWcQWOZNO2JfxHJizFqd780/aCxYM769pQOpdTgtvG8yTfofs9tejUEGJyx6
         C96yqf4hFC/KwiaukQ4FU5dUKSbYmj4K3gsFApjn+0fulU+mumUYegrJPU3gBjUcZ1
         01K3BZzizxGgpv9ej9ju2uVZ7UFafy/mZSu2x++QS+xXDe0G7T72Yp9EvjPB5HpI0v
         k5809V7M1GZNuG/nC29XnvgmhKKLTyL4pfMlIdzyVghrps7TuxODNbLo6Omk6URxFN
         wpJPb9f6Vlfkg==
Subject: Re: [PATCH v1 2/3] dt-binding: power: power-domain: add
 power-supply-needs-irq
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 12 Jul 2022 14:24:08 +0200
In-Reply-To: <69e8195e-8d2b-3df0-0783-269f9aef1a83@linaro.org>
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
         <20220711094549.3445566-2-martin.kepplinger@puri.sm>
         <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
         <f2142a9816095eca504c464a6221a96a0cbd6b54.camel@puri.sm>
         <69e8195e-8d2b-3df0-0783-269f9aef1a83@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 12.07.2022 um 09:01 +0200 schrieb Krzysztof Kozlowski:
> On 11/07/2022 15:17, Martin Kepplinger wrote:
> > Am Montag, dem 11.07.2022 um 12:38 +0200 schrieb Krzysztof
> > Kozlowski:
> > > On 11/07/2022 11:45, Martin Kepplinger wrote:
> > > > Add the power-supply-needs-irq board description property for
> > > > power
> > > > domains.
> > > 
> > > Where is a board description here? I think you just meant
> > > "power-supply-needs-irq property"?
> > > > 
> > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > > ---
> > > >  .../devicetree/bindings/power/power-domain.yaml        | 10
> > > > ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/power/power-
> > > > domain.yaml b/Documentation/devicetree/bindings/power/power-
> > > > domain.yaml
> > > > index 889091b9814f..e82c2f7ccb97 100644
> > > > --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> > > > +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> > > > @@ -70,6 +70,16 @@ properties:
> > > >        by the given provider should be subdomains of the domain
> > > > specified
> > > >        by this binding.
> > > >  
> > > > +  power-supply: true
> > > 
> > > This is a new property not described in the commit msg.
> > 
> > true, I think it's missing and could be added as a separate patch.
> > 
> > > 
> > > > +
> > > > +  power-supply-needs-irq:
> > > > +    type: boolean
> > > > +    description:
> > > > +      A power-supply can link for example to a regulator
> > > > controlled via
> > > > +      i2c or otherwise needing interrupts enabled to be able
> > > > to
> > > > enable and
> > > > +      disable. 
> > > 
> > > Not really a property of power domain. How the regulator supply
> > > works
> > > is
> > > entirely up to regulator. Otherwise such property should appear
> > > for
> > > every device.
> > 
> > you're right. The power-domain driver could read the power-supply
> > regulator node directly. Still, I think then a new regulator
> > property
> > is needed instead, or is it?
> 
> In case of regulator, I am not so sure it needs a dedicated property
> of
> DT. If it is I2C regulator - the parent node is I2C bus and regulator
> device is some child of I2C controller (could be via a MFD device),
> so
> no need for dedicated property.
> 
> If it uses interrupts, then:
> 1. The presence of interrupts is already known - "interrupts"
> property.
> 2. The actual use of interrupts is DT independent and only driver
> knows it.

thanks for this great suggestion! for the imx8mq devices this (1.)
indeed is the case for exactly the 3 regulators I manually describe
here. v2 of this patch looks very elegant (and I guess I could have
removed the DT people from the email, I forgot). here it is:

https://lore.kernel.org/linux-arm-kernel/20220712121832.3659769-1-martin.kepplinger@puri.sm/T/#u

> 
> Best regards,
> Krzysztof



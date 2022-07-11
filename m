Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFD57040D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiGKNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGKNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:17:43 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556EC3E77F;
        Mon, 11 Jul 2022 06:17:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B686FDF80B;
        Mon, 11 Jul 2022 06:17:41 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x4jnSWMSPkx2; Mon, 11 Jul 2022 06:17:41 -0700 (PDT)
Message-ID: <f2142a9816095eca504c464a6221a96a0cbd6b54.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1657545461; bh=loLzIztXpcWDKjqrW/8JqeDWdPr8OtVlFcuH9XDPBk0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fJ0TxsveR+F9NhDnytauCSPpatACOvucztQhqLVUtHlGQPbjTdDaTHiRwGtyHj7ic
         t19gojZKSOBt7HZORmXcGnNJOsO/WbO6a6Tj1OOcKvo/Jf7Q/1CZBIhH+HOtb1wCmt
         PtmtR8jdjlke4eJoz1bzKotfEPBpfjQptGBxF9Atr4A1ESEfOaB8ATwyDDeA3Slibh
         NXApcSt3ZKUREZSkSIIh6tmMN4nriCrdioxxMDxxALyI8lQA61OaA8Cer5EvuCi9J3
         XYkbTTHNIYj4kXF9HzR0c1g9o8VkkxnD/dKFKfu7dIJxOnyNQss7sd2Vnkd87VjvKm
         M9f0mDZrD1rDg==
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
Date:   Mon, 11 Jul 2022 15:17:33 +0200
In-Reply-To: <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
         <20220711094549.3445566-2-martin.kepplinger@puri.sm>
         <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
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

Am Montag, dem 11.07.2022 um 12:38 +0200 schrieb Krzysztof Kozlowski:
> On 11/07/2022 11:45, Martin Kepplinger wrote:
> > Add the power-supply-needs-irq board description property for power
> > domains.
> 
> Where is a board description here? I think you just meant
> "power-supply-needs-irq property"?
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  .../devicetree/bindings/power/power-domain.yaml        | 10
> > ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/power-
> > domain.yaml b/Documentation/devicetree/bindings/power/power-
> > domain.yaml
> > index 889091b9814f..e82c2f7ccb97 100644
> > --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> > +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> > @@ -70,6 +70,16 @@ properties:
> >        by the given provider should be subdomains of the domain
> > specified
> >        by this binding.
> >  
> > +  power-supply: true
> 
> This is a new property not described in the commit msg.

true, I think it's missing and could be added as a separate patch.

> 
> > +
> > +  power-supply-needs-irq:
> > +    type: boolean
> > +    description:
> > +      A power-supply can link for example to a regulator
> > controlled via
> > +      i2c or otherwise needing interrupts enabled to be able to
> > enable and
> > +      disable. 
> 
> Not really a property of power domain. How the regulator supply works
> is
> entirely up to regulator. Otherwise such property should appear for
> every device.

you're right. The power-domain driver could read the power-supply
regulator node directly. Still, I think then a new regulator property
is needed instead, or is it?

> 
> > This property makes various callbacks usually run in the
> > +      noirq phase, being run when interrupts are available.
> 
> Last sentence does not fit - you embed Linux implementation into DT
> bindings. noirq phase is Linux specific.

oh I keep making this mistake. thanks for the fast review!

> 
> > +
> >  required:
> >    - "#power-domain-cells"
> >  
> 
> 
> Best regards,
> Krzysztof



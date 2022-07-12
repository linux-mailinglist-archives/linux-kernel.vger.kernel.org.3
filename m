Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0F571D73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiGLO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiGLO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:57:51 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387D4F1AE;
        Tue, 12 Jul 2022 07:57:49 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id u13so4963304iln.6;
        Tue, 12 Jul 2022 07:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9CzwXKTA7gScMXDGBi3YiyfwBmHDS9K2YoQ8GfmJds=;
        b=Xvc78D3dp/VDHudSaq7kcdgrwSpeCUQRp0gbjYQmw/VSi27O5iLEVO7eUJiCM63bdf
         JKPaJTGKz5F5IdvH8nzD/SRLUEyChEcllb7EBkDxatAVO7IIFQFa2ZCyQJJTgGRGyvjx
         uRnOWpD+KD5byDkOUlMg+DZ0dQn8H+EpqUpbpAZDunt7qfncraJPV7NLNcwpi+9+Gm9k
         U3tw3vfS55kI66hcvfDa+4D9lP5MLklyHM6PboG71tio2UWxv1E2D3x/d/irBnLKmUD2
         KUkvKBdepXoQCjmnrhnGFi4E/R5dHK8C9qD9Ru1zYyvSFrPAPYhfvBo6jIsRiWzKIOSa
         teCQ==
X-Gm-Message-State: AJIora+zBAq4vhJ5VAGTu8dmDwyebMdEZxDchuP08m0i9JIPLRFz++m8
        NZVqI+MjaSievJ4g53Be5Q==
X-Google-Smtp-Source: AGRyM1vh+aOogTSLhe8igwtKsd1CvRwky5ggWI6vrAvQdlfZY/BrJEMIos/2AOR9m0rpgyLP5fxlgw==
X-Received: by 2002:a05:6e02:1445:b0:2da:ad32:8300 with SMTP id p5-20020a056e02144500b002daad328300mr12299828ilo.280.1657637868823;
        Tue, 12 Jul 2022 07:57:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r25-20020a02b119000000b0032e271a558csm4168235jah.168.2022.07.12.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:57:48 -0700 (PDT)
Received: (nullmailer pid 1848087 invoked by uid 1000);
        Tue, 12 Jul 2022 14:57:47 -0000
Date:   Tue, 12 Jul 2022 08:57:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: leds: Add binding for a multicolor
 group of LEDs
Message-ID: <20220712145747.GA1823936-robh@kernel.org>
References: <20220615154918.521687-1-jjhiblot@traphandler.com>
 <20220615154918.521687-4-jjhiblot@traphandler.com>
 <20220627221257.GA3046298-robh@kernel.org>
 <c84d0513-b89b-0eea-eeaf-68dc634bd7b0@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84d0513-b89b-0eea-eeaf-68dc634bd7b0@traphandler.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:33:22AM +0200, Jean-Jacques Hiblot wrote:
> 
> On 28/06/2022 00:12, Rob Herring wrote:
> > On Wed, Jun 15, 2022 at 05:49:17PM +0200, Jean-Jacques Hiblot wrote:
> > > This allows to group multiple monochromatic LEDs into a multicolor
> > > LED, e.g. RGB LEDs.
> > > 
> > > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > > ---
> > >   .../bindings/leds/leds-group-multicolor.yaml  | 94 +++++++++++++++++++
> > >   1 file changed, 94 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> > > new file mode 100644
> > > index 000000000000..30a67985ae33
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
> > > @@ -0,0 +1,94 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/leds-group-multicolor.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Multi-color LED built with monochromatic LEDs
> > > +
> > > +maintainers:
> > > +  - Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > > +
> > > +description: |
> > > +  This driver combines several monochromatic LEDs into one multi-color
> > > +  LED using the multicolor LED class.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: leds-group-multicolor
> > > +
> > > +  multi-led:
> > > +    type: object
> > > +
> > > +    patternProperties:
> > > +      "^led-[0-9a-z]+$":
> > > +        type: object
> > > +        $ref: common.yaml#
> > > +
> > > +        additionalProperties: false
> > > +
> > > +        properties:
> > > +          leds:
> > Not a standard property. What is the type?
> That would be a reference to the node of a LED
> > Really, just do a GPIO multi-color LED binding similar to the PWM one
> > rather than adding this layer. I suppose you could combine LEDs from all
> > different controllers, but that seems somewhat unlikely to me.
> 
> I'm not using gpio leds, rather leds driven by two TLC5925.
> 
> I agree that combining from different model of controller is unlikely.
> However from 2 separate chips of the same model is not (ex: driving 5 RGB
> LEDs with two 8-output chips)
> 
> In the case of the TLC5925, that is not really a problem because as long as
> the chips are on the same CS, they are considered as a single entity by the
> driver. But for I2C chips at least that would be a problem.

Okay.

I think the binding can be simplified a bit to just this:

multi-led {
    compatible = "leds-group-multicolor";
    color = <LED_COLOR_ID_RGB>;
    function = LED_FUNCTION_INDICATOR;
    
    leds = <&red_led>, <&green_led>, <&blue_led>;
};

The individual color should be defined in the parent LED node (e.g. 
red_led). You can either look up the color or the index in 'leds' 
defines the color.

Also, I don't think 'max-brightness' here makes sense. That's a property 
of the parent LED.

Rob

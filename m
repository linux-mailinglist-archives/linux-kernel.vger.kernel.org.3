Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A7501905
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiDNQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiDNQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:50:00 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27012F6EB;
        Thu, 14 Apr 2022 09:17:31 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so3731820otr.2;
        Thu, 14 Apr 2022 09:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+dYyu7y5UVTMexCQcf0EtUHGOdwuv57lNmgQ07q4u5Y=;
        b=3Jcz9zwGBF4OJpsQLzmGDyXF7Plri6Hb/uE02e38s+nci0gQas3LJZ66a6rL+3uqro
         fsojxbVNXSxyEPlu8WhGjzyqL24loPCEa/M4RaBycbetBBczgxiqhh/bZZvHbv5wVx7k
         ho7rnU7i7rAdaaSfgp2IlXgfE3OYqBy3tvSWJy9EBcW4V4ia53sVitmsRAYxwKSCa9Kn
         ymg4KVO8fs7mnCXNycCgRUIn8WV7XDdjDwWqEptI6lapGbEGQcIQ/AIuH4PjbQbXPeGt
         yJrQJSKrLQhDb/LQoze0D3wdjIcTZiP2NBqbJUQ8MYYmxeNJIfDrh7TEpzbK90LgjEsK
         11fA==
X-Gm-Message-State: AOAM53095RAJHAsRlemlRg7ljjly4qO+VjGicLe27QxFIR+rDmbr3moL
        c14qUbh3olDEmEXTdBs5Ig==
X-Google-Smtp-Source: ABdhPJzm1hyipOam0Bbm1/ZIUN7HVSh8anI4Sp0p0Vi30YCcZ20K4EDM6Ws/WU/LJosQ8gdb9KAMKQ==
X-Received: by 2002:a9d:75cc:0:b0:5cd:9f3a:6ee6 with SMTP id c12-20020a9d75cc000000b005cd9f3a6ee6mr1186806otl.10.1649953050470;
        Thu, 14 Apr 2022 09:17:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870f20600b000e2a451bcaesm874137oao.17.2022.04.14.09.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:17:30 -0700 (PDT)
Received: (nullmailer pid 2164706 invoked by uid 1000);
        Thu, 14 Apr 2022 16:17:29 -0000
Date:   Thu, 14 Apr 2022 11:17:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: rt2880: fix binding name,
 pin groups and functions
Message-ID: <YlhJGerakzbsXwnv@robh.at.kernel.org>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
 <20220413060729.27639-11-arinc.unal@arinc9.com>
 <ba7cd13f-d216-0ac6-97e1-6c13f1e15f38@linaro.org>
 <550b20f2-098e-0f25-ad9f-3ff523879cb7@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <550b20f2-098e-0f25-ad9f-3ff523879cb7@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:34:31AM +0300, Arınç ÜNAL wrote:
> On 13/04/2022 18:25, Krzysztof Kozlowski wrote:
> > On 13/04/2022 08:07, Arınç ÜNAL wrote:
> > > Change binding name from ralink,rt2880-pinmux to ralink,rt2880-pinctrl.
> > > This is the binding for the Ralink RT2880 pinctrl subdriver.
> > 
> > What I don't see here is why you are doing this. pinmux/pinctrl have the
> > same meaning, I guess?
> 
> What I understand is pinmux is rather a specific term for the muxing of pins
> or pin groups. Pinctrl is what we prefer here since the term is more
> inclusive of what the subdriver does: controlling pins. Any mediatek
> driver/subdriver is called pinctrl so I'm not doing something uncommon.

The correct name is really whatever the h/w block is called, not 
whatever we've come up with for some class of devices.

> 
> > 
> > > 
> > > Current pin group and function bindings are for MT7621. Put bindings for
> > > RT2880 instead.
> > > 
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > ---
> > >   ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 24 +++++++++----------
> > >   1 file changed, 12 insertions(+), 12 deletions(-)
> > >   rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (56%)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
> > > similarity index 56%
> > > rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
> > > rename to Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
> > > index 9de8b0c075e2..c657bbf9fdda 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
> > > @@ -1,21 +1,23 @@
> > >   # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > >   %YAML 1.2
> > >   ---
> > > -$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinmux.yaml#
> > > +$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
> > >   $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > -title: Ralink rt2880 pinmux controller
> > > +title: Ralink RT2880 Pin Controller
> > >   maintainers:
> > > +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> > 
> > Mention this in commit msg.
> 
> Will do.
> 
> > 
> > >     - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > >   description:
> > > -  The rt2880 pinmux can only set the muxing of pin groups. Muxing indiviual pins
> > > +  Ralink RT2880 pin controller for RT2880 SoC.
> > > +  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
> > >     is not supported. There is no pinconf support.
> > >   properties:
> > >     compatible:
> > > -    const: ralink,rt2880-pinmux
> > > +    const: ralink,rt2880-pinctrl
> > 
> > you need to deprecate old property and add a new one.
> 
> Do we really have to? That property name was inaccurate from the start. I
> don't see a reason to keep it being referred to on the binding.

It's an ABI. There are exceptions, but you've got to spell out the 
reasoning in the commit message.

Really, who cares. It's just a unique identifier. Unless you also had a 
h/w block called 'pinmux' in addition to a 'pinctrl' block it doesn't 
matter. We could use just GUIDs instead.

Rob

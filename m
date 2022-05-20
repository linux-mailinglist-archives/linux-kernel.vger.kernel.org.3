Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E252EAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiETLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiETLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:34:34 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93470903;
        Fri, 20 May 2022 04:34:30 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3974B1C0009;
        Fri, 20 May 2022 11:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653046468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1RpCyOt9vJRwKKZzMrNpG1QDdfyBUk2YTX9dVi8KKY=;
        b=Wcv2GBx4h6bBjBzJJdSS+4fp72OcI+2Tee3mT8kqifTa+CgH64T0l9F1N+HCSwYgXMt/XU
        1mQlR4x6eCs8CGmkef2yNz1vxLNhgclH9+fi8MhIqSPG52me/Del76AttyXF4bP5dhf82U
        ulvNLRDEKpq4REfbrBk2opMcYhS5/FQh6XmjT/D+bBpfNrYMupvHDoS5xXULqRGyHnsCn7
        FVybCaG+3VjOJmI7w0VGs6BJaAiEYXwn0qhIGp856pbl9ri6eLgTFsivh6RcM5yTgv2qA7
        WP1p0YkRiSYNi9BhReSFhQazp9AuMkfrzD8ZSsC701ZJ0He/bNeXZMORIDhcag==
Date:   Fri, 20 May 2022 13:34:26 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN966x
 compatible string
Message-ID: <20220520133426.3b4728ae@bootlin.com>
In-Reply-To: <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
        <20220513105850.310375-3-herve.codina@bootlin.com>
        <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 14:57:55 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/05/2022 12:58, Herve Codina wrote:
> > The USB device controller available in the Microchip LAN966x SOC
> > is the same IP as the one present in the SAMA5D3 SOC.
> >=20
> > Add the LAN966x compatible string and set the SAMA5D3 compatible
> > string as a fallback for the LAN966x.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/usb/atmel-usb.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Docu=
mentation/devicetree/bindings/usb/atmel-usb.txt
> > index f512f0290728..a6fab7d63f37 100644
> > --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > @@ -87,6 +87,9 @@ Required properties:
> >  	       "atmel,at91sam9g45-udc"
> >  	       "atmel,sama5d3-udc"
> >  	       "microchip,sam9x60-udc"
> > +	       "microchip,lan996x-udc" =20
>=20
> No wildcards please, especially that it closely fits previous wildcard
> (lan996x includes lan9960 which looks a lot like sam9x60...)
>=20

Well, first, I made a mistake. It should be lan966x instead of lan996x.

This family is composed of the LAN9662 and the LAN9668 SOCs.

Related to the wilcard, lan966x is used in several bindings for common
parts used by both SOCs:
- microchip,lan966x-gck
- microchip,lan966x-cpu-syscon
- microchip,lan966x-switch
- microchip,lan966x-miim
- microchip,lan966x-serdes
- microchip,lan966x-pinctrl

I think it makes sense to keep 'microchip,lan966x-udc' for the USB
device controller (same controller on LAN9662 and LAN9668) and so
keeping the same rules as for other common parts.

Regards,
Herv=C3=A9

>=20
> Best regards,
> Krzysztof



--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

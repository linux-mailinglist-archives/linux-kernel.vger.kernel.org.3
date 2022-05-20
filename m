Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9352ECD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbiETNCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiETNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:02:52 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD91053C9;
        Fri, 20 May 2022 06:02:49 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 59257100012;
        Fri, 20 May 2022 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653051768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM+OQWMMenMdJO9VR7JqvfPNJ36dVqv2du9IbwKv91Y=;
        b=GYqkhhX9Ravj9OLkpyMQwENtAgyIVKU1s2TSxcGELOwbbLIgP1KvDYQgmETc6+ntlED7F2
        Gwk6Lmfpx7++EE+pMxjdgZY6PIOUe4cEgCiWEM18wnF8dJnZbzb+eGlwTmk/ofyZwHEgzD
        twsN10wNEhd9HJFh3UBM2m1JE89kf61LlRBYXGDvzqcKDczAlcpSBSH7rKok5MzRo3dgpD
        7WedWx1CTlj+H3qkGhWC4sXiCcZdRxi0eukArpQDvrd04mT8e6pOI1RNKFVEacoUX/RisY
        oZvZ42roNURnuYz/BAJ4L2KS9NokcxmLAYRRpZWuYmNN2INs39YX6JUJXQYalQ==
Date:   Fri, 20 May 2022 15:02:43 +0200
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
Message-ID: <20220520150243.625723fa@bootlin.com>
In-Reply-To: <01b31a02-523e-10bf-3b46-5b830e456522@linaro.org>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
        <20220513105850.310375-3-herve.codina@bootlin.com>
        <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
        <20220520133426.3b4728ae@bootlin.com>
        <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
        <20220520142109.57b84da2@bootlin.com>
        <01b31a02-523e-10bf-3b46-5b830e456522@linaro.org>
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

On Fri, 20 May 2022 14:50:24 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/05/2022 14:21, Herve Codina wrote:
> >>> I think it makes sense to keep 'microchip,lan966x-udc' for the USB
> >>> device controller (same controller on LAN9662 and LAN9668) and so
> >>> keeping the same rules as for other common parts.   =20
> >>
> >> Having wildcard was rather a mistake and we already started correcting
> >> it, so keeping the "mistake" neither gives you consistency, nor
> >> correctness...
> >> =20
> >=20
> > I think that the "family" compatible should be present.
> > This one allows to define the common parts in the common
> > .dtsi file (lan966x.dtsi in our case).
> >=20
> > What do you think about:
> > - microchip,lan9662-udc
> > - microchip,lan9668-udc
> > - microchip,lan966-udc  <-- Family
> >=20
> > lan966 is defined as the family compatible string since (1) in
> > bindings/arm/atmel-at91.yaml and in Documentation/arm/microchip.rst
> >  =20
>=20
> You can add some family compatible, if it makes sense. I don't get why
> do you mention it - we did not discuss family names, but using
> wildcards... Just please do not add wildcards.

Well, I mentioned it as I will only use the family compatible string
and not the SOC (lan9662 or lan9668) compatible string in lan966x.dtsi.
In this case, the family compatible string can be seen as a kind of
"wildcard".

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

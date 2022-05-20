Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8F52EBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbiETMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349291AbiETMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:21:49 -0400
X-Greylist: delayed 2803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 05:21:16 PDT
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2724C406;
        Fri, 20 May 2022 05:21:13 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 89441FF810;
        Fri, 20 May 2022 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653049272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9/j3N/5Wrep8nEVTKpfSVpG01w0RrIsJwIuJSpfUqk=;
        b=RfW0rjzcmmERfR5djFuVWqGNNOXEXZH64WSz4zF6bNV8PZOupWqEnejx3YHzGPR+ANVyqf
        u1X+8G40M4FtwDyht1zoabB49i3jwiatJroTJKQsi8taz+RmQUh7KOjlv3g7H4mwsBkOEX
        E/2xcdCNRM5z9JO4Qlm5sMWl3Px7hdyoPqweUk79/uJg6x8eq86WoxsWxi9VL98gUDG6wv
        wt0+qMRqFXeArB91COg4rAgJAMcC6yoywoHCtjeNU8H2BTfoF1zFcuBdcf1kk46rzz6dOu
        K1/VdbzH87ALHDx9nJLW3gvFjxdEVBf1JMUA+bWEM3Kl7OnBLa1FtUBEnu2L1A==
Date:   Fri, 20 May 2022 14:21:09 +0200
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
Message-ID: <20220520142109.57b84da2@bootlin.com>
In-Reply-To: <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
        <20220513105850.310375-3-herve.codina@bootlin.com>
        <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
        <20220520133426.3b4728ae@bootlin.com>
        <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
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

Hi Krzysztof,

On Fri, 20 May 2022 13:40:13 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/05/2022 13:34, Herve Codina wrote:
> > On Fri, 13 May 2022 14:57:55 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 13/05/2022 12:58, Herve Codina wrote: =20
> >>> The USB device controller available in the Microchip LAN966x SOC
> >>> is the same IP as the one present in the SAMA5D3 SOC.
> >>>
> >>> Add the LAN966x compatible string and set the SAMA5D3 compatible
> >>> string as a fallback for the LAN966x.
> >>>
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Do=
cumentation/devicetree/bindings/usb/atmel-usb.txt
> >>> index f512f0290728..a6fab7d63f37 100644
> >>> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> >>> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> >>> @@ -87,6 +87,9 @@ Required properties:
> >>>  	       "atmel,at91sam9g45-udc"
> >>>  	       "atmel,sama5d3-udc"
> >>>  	       "microchip,sam9x60-udc"
> >>> +	       "microchip,lan996x-udc"   =20
> >>
> >> No wildcards please, especially that it closely fits previous wildcard
> >> (lan996x includes lan9960 which looks a lot like sam9x60...)
> >> =20
> >=20
> > Well, first, I made a mistake. It should be lan966x instead of lan996x.
> >=20
> > This family is composed of the LAN9662 and the LAN9668 SOCs.
> >=20
> > Related to the wilcard, lan966x is used in several bindings for common
> > parts used by both SOCs:
> > - microchip,lan966x-gck
> > - microchip,lan966x-cpu-syscon
> > - microchip,lan966x-switch
> > - microchip,lan966x-miim
> > - microchip,lan966x-serdes
> > - microchip,lan966x-pinctrl =20
>=20
> And for new bindings I pointed that it is not preferred, so already few
> other started using specific compatible.
>=20
> >=20
> > I think it makes sense to keep 'microchip,lan966x-udc' for the USB
> > device controller (same controller on LAN9662 and LAN9668) and so
> > keeping the same rules as for other common parts. =20
>=20
> Having wildcard was rather a mistake and we already started correcting
> it, so keeping the "mistake" neither gives you consistency, nor
> correctness...
>=20

I think that the "family" compatible should be present.
This one allows to define the common parts in the common
.dtsi file (lan966x.dtsi in our case).

What do you think about:
- microchip,lan9662-udc
- microchip,lan9668-udc
- microchip,lan966-udc  <-- Family

lan966 is defined as the family compatible string since (1) in
bindings/arm/atmel-at91.yaml and in Documentation/arm/microchip.rst

(1) https://lore.kernel.org/all/20211004105926.5696-1-kavyasree.kotagiri@mi=
crochip.com/

Regards,
Herve

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

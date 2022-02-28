Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A524C6C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiB1MU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiB1MUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:20:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A53970861;
        Mon, 28 Feb 2022 04:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646050780;
        bh=eDnjD3CV02Uc/By04jlSmoifwR/p3yucck7qbvDxUlY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B9BCTw46CSs6HdScf5XBawxD261BdUGbcVtvaZsdJDHi2aw34dyIzFwrX9OopqveD
         I2FtTc+nyZ9E4u5CgcH5n9+D6ghZCxaA62EeLjBh5jeEx35r22YPOwqDwutzAbWIrT
         /KLD3QdJm0+k9AFS8CXSWx8hQUCYiEv4XnfOeZNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.12] ([80.245.79.12]) by web-mail.gmx.net
 (3c-app-gmx-bs53.server.lan [172.19.170.137]) (via HTTP); Mon, 28 Feb 2022
 13:19:40 +0100
MIME-Version: 1.0
Message-ID: <trinity-ac45bde6-392d-4810-8aad-9a06d2bcd85a-1646050780475@3c-app-gmx-bs53>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Aw: Re: [PATCH v3 1/3] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Feb 2022 13:19:40 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
References: <20220227182800.275572-1-linux@fw-web.de>
 <20220227182800.275572-2-linux@fw-web.de>
 <4c3303f5-7af5-9974-7bea-b7f0d6c7ef53@canonical.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:WaOTMMs0zzPP9tR16fWXqpWJRLEnDSFpogU6J4ahuEh214gtupGtD2mYIKJcs+tuuRER3
 hf7ggCrwJWr2C9y1xR0SZQqrW4Abh7eZAk31qY8QgryhDv05RhLHGLKXRCl8ukDxfL5xSNIiBx9A
 0LzDqJ4WiJXU6TVd+DB9w31d9fYxLHtsOSbnjZv1jqb38pJAyrLQgmcDFcAb+yF5gHspLU/8tLou
 31vNidvi2cMhKejH94AM30KcnwlIBpmI8yAu8mUOvX1sLvLYKG20d4efANu9L4kpunmzmx+lpM7W
 1A=
X-UI-Out-Filterresults: notjunk:1;V03:K0:76GDCbpdFcA=:wpvhXNgTMyp6Ol+GqGncQQ
 6fq/Zf0ws8kdPkPT2yLCA9KNFu5GcRg+DNyon0A0F0UzG1d8SHcs2P15344yAAgPuXpZee3vD
 /REh6YniW6B3jCUbf1po7hCbwiZtOUADjaLU/Wyjt+DmI14IfTO8XZfiuQ7TRi6vdAFaoaSrv
 cJ69NbpJSENtDCRa9k2naZBoUrKu1OzzRGBCdZ2X+yK/DwD1g9PqyuZJwadLwQWKaspcGgop8
 ckCLM5Q6E0dorKHzhyGlyYSdVrTCMoOvGJY/fqatDvlL0ETi3VDp/EgFiCMIva3yV+S/PQop9
 Gn1XQgg7/dzktSDRE6pnpsfkembpCIIj78hYuo4itrncQ4IEa3CiuXu7fzLqXpAyhyV5yKa6g
 VEnyk4ujidYUrNwN6XoD2hhq+D384cr9gzJLwITNfpFRePOLF6MlFzMNpSljLpPZVfHSzmLBl
 wWIFCqFuyR41sZeMRFfkjSIhp4rnCKoFYOqZ29+STVq+EIYgPsyA/F7EWuz/ECgWA1+JkOWZH
 ogg9h7Ap2bmbXBmkXh0zE4QqMioDH2T8A0UTjRn3ZJXYt77LBk9Okjh5ltXLKJC7dZJKKh7/t
 g7LTPpnSbtBz9OXpNTOSL4DVvTum6FTROLBL4Yu4JERHpkvLi+EpjQQVY3XdTi7MY8A856A04
 JgNKxhGYlvMsaPrfJodkgrTG6m7o2Uw3f1Fqmxl2mPXc4E3bz9xmhbHUdHTT5uPfG+mmwZ/mU
 13t6/8h2B/t/Vx1SJvaL7S4D0CEldIVN98gLMxOnm00wtqxcigkoJ5eF8ts9keS2203Pm6I0c
 T2Hl80h
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

thanks for first review.

> Gesendet: Montag, 28. Februar 2022 um 11:08 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>

> On 27/02/2022 19:27, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>

> You missed devicetree mailing list (corrupted address).

sorry, devicetree ML was To, but forget the Cc-Header (prepared addresses =
in coverletter)

> > imho all errors should be fixed in the dts not in the yaml...

> > -- reg               : <registers mapping>
> > -
> > -Please note that when using "generic-ahci" you must also specify a So=
C specific
> > -compatible:
> > -	compatible =3D "manufacturer,soc-model-ahci", "generic-ahci";
...
> > +properties:
> > +  compatible:
> > +    contains:
> > +      enum:
> > +        - brcm,iproc-ahci
> > +        - cavium,octeon-7130-ahci
> > +        - generic-ahci
> > +        - hisilicon,hisi-ahci
> > +        - ibm,476gtr-ahci
> > +        - marvell,armada-380-ahci
> > +        - marvell,armada-3700-ahci
>
> Order entries alphabetically.

ok

> > +        - snps,dwc-ahci
> > +        - snps,spear-ahci
>
> You converted the TXT bindings explicitly, but you missed the comment
> just below the 'reg' about generic-ahci. The generic-ahci never comes al=
one.

How should this comment be added? description above/below the compatible-p=
roperty?
Sorry for dumb questions...this is my first yaml ;)

e.g.

properties:
  compatible:
    description:
      Please note that when using "generic-ahci" you must also specify a S=
oC specific
      compatible:
         compatible =3D "manufacturer,soc-model-ahci", "generic-ahci";
    contains:
      enum:

> The snps,dwc-ahci could come, although history shows that Synapsys
> blocks are commonly re-used and they should have specific compatible.
> Current users still have single snps,dwc-ahci, so it could be fixed a
> bit later.
>
> On the other hand, I expect to fix all the DTS in the same series where
> the bindings are corrected.

i don't know the marvell/broadcom-hw so i cannot fix them.
Just converted the txt to check my rockchip sata nodes and to be more
future-proof (no more exceptions like the marvell/broadcom)

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
>
> Items should be described. Next or this patch could add also clock-names=
.

i was told to drop clock-names (same for interrupt-names and reset-names) =
from dts
and in txt it was not there so have not added it

https://patchwork.kernel.org/comment/24755956/

> > +
> > +  interrupts:
> > +    minItems: 1
>
> You mean maxItems?

no, minItems, as interrupts suggests 1+ (same for phys)

> > +
> > +  ahci-supply:
> > +    description:
> > +      regulator for AHCI controller
> > +
> > +  dma-coherent:
> > +    description:
> > +      Present if dma operations are coherent
>
> Skip description, it's obvious. Just 'true'.

ok, took this from the txt

> > +
> > +  phy-supply:
> > +    description:
> > +      regulator for PHY power
> > +
> > +  phys:
> > +    minItems: 1
>
> maxItems?
> > +
> > +  phy-names:
> > +    minItems: 1
>
> Describe the items.
>
> > +
> > +  ports-implemented:
> > +    description:
> > +      Mask that indicates which ports that the HBA supports
> > +      are available for software to use. Useful if PORTS_IMPL
> > +      is not programmed by the BIOS, which is true with
> > +      some embedded SoCs.
> > +    minItems: 1
>
> You need a type and maxItems.

what will be the type of a mask?

> > +
> > +  resets:
> > +    minItems: 1
>
> maxItems?

if there is a known maximum....

> > +
> > +  target-supply:
> > +    description:
> > +      regulator for SATA target power
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9]+$":
>
> You limit number of ports to 10. On purpose? What about 0xa? 0xb?

oh, right, there can be hexadecimal...
thought this is only true for the main-node (address) and have only seen @=
0, @1 and @2

> > +    type: object
> > +    description:
> > +      Subnode with configuration of the Ports.
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      phys:
> > +        minItems: 1
>
> maxItems? Why do you put everywhere minItems? Are several phys really
> expected?

name suggests that it can be more than 1. i know from usb subsystem (dwc3 =
usb3) that a device can have more than one phy, and because in the txt the=
re are no ranges i set everywhere MinItems to 1 with open end as i do not =
know all possibilities. Anything else will be trial and error...for all pr=
operties

> > +
> > +      target-supply:
> > +        description:
> > +          regulator for SATA target power
> > +
> > +    required:
> > +      - reg
> > +
> > +    anyOf:
> > +      - required: [ phys ]
> > +      - required: [ target-supply ]
> > +
> > +allOf:
> > +- $ref: "sata-common.yaml#"
>
> This goes before properties.
>
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +        sata@ffe08000 {
>
> Wrong indentation. It starts just below |

will fix it

> > +               compatible =3D "snps,spear-ahci";
> > +               reg =3D <0xffe08000 0x1000>;
> > +               interrupts =3D <115>;
> > +        };
> > +  - |
> > +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +        #include <dt-bindings/clock/berlin2q.h>
> > +        sata@f7e90000 {
> > +                compatible =3D "marvell,berlin2q-achi", "generic-ahci=
";
>
> This clearly won't pass your checks. I don't think you run
> dt_binding_check. You must test your bindings first.

i had them tested ...needed to add the includes...after that the dt_bindin=
gs_check was without errors/warnings

these are the commands i used:

ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_check DT_S=
CHEMA_FILES=3DDocumentation/devicetree/bindings/ata/ahci-platform.yaml
ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dtbs_check DT_SCHEMA_=
FILES=3DDocumentation/devicetree/bindings/ata/ahci-platform.yaml

> Best regards,
> Krzysztof

regards Frank

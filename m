Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468574CA235
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiCBKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiCBKc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:32:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A7A652F;
        Wed,  2 Mar 2022 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646217098;
        bh=4bdmMEQw8spR517oJ7qXxXX+uJRFnQKrfHpGnboGiZ0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bZEva4y7ths00ttdO/UooBif6ALksHiAnjBWdqeGUJVbz8jQrDvYJuEHvXrvqxfyR
         YcIgyCblkbuQvqmiJUTfBHI1qLBy21rvqMddhh7LqvFgPlO7NjYE0/N76lRWgmIBr2
         ixMZNaAS5ZwQxLj3wPmNzQdRrqEjyD385c3tQ2Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.190] ([80.245.77.190]) by web-mail.gmx.net
 (3c-app-gmx-bap21.server.lan [172.19.172.91]) (via HTTP); Wed, 2 Mar 2022
 11:31:38 +0100
MIME-Version: 1.0
Message-ID: <trinity-80a229fb-42dd-4705-9c55-fe6f3a381a40-1646217098213@3c-app-gmx-bap21>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Aw: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 2 Mar 2022 11:31:38 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
 <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:4Gpe9DnEZg6/2Us5ng4Vs+x+BJ+VcCuxFPt0OY8/cpI1KL2/NW731L08yXZA2/TTVVk6+
 uDr9F1YWWrAbLuR8Q9PYkpsqbOQSINIMeUd4Jjrgsb/AskZtRQRC8/7tE8fCWyFPpxGKkEQr+IDK
 TQdDJN+At+27aKoUuUxKjxTBfyuyYCuR6Afn4+j+9KUCBuYuu+ALvG33VVtjzO+3ltdwL+EZcJKt
 WhQB2bCv0KWTdWvXFZFD0Na2LQoB07OyyTaxmTl+iAFgEPgCi6m5w/NA5dpzbHsuItcmeX+SnezL
 Fw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:vk4EW4SvWFo=:EpZrOPPl+6CuL2emR4Il5R
 BGbiJ6qZyF4TofkTyyy82OQSw6sHIkaRLVog7OvuuarvArgeogT42vK3ewTSki4nA0o3Y6e7u
 c2rQyEtFpbDmmynGWA79SB6rULKKTfW1rREKEtRRbkl45RPIk5cdUTt3yPEZg1PgBlZ6cC1Zi
 a9Z8zyCSZccjMF8qEq5bGhhe6FXLORRPnphPybhvdR+4uBfsDf43PMptW+7cA7aHU9RcUZxf2
 L9czc6SXo5GxXruLZ0sPiYV0oVXE7lgXHREjYZl2H7VRFGjGA7T/7rE44MWBxCCyz3EKMxcQJ
 iYU0mIsfbDI6aro468K3IE0yIy8zgCbgEaj89mPq11vTGQIv2TQRMXCqUh6JO+HkURxpza6DR
 EaWBo228M78BGsV/8/GMVQpaNGLUGJMuVQXy4O4kn1I5oPI/UleDpcrl4vGFFTzflUdlV7OnH
 5PqmDWpFVOc9SjrDEdWUiK6NpMqGcQymVjhk9IU3NKF4heVWRVg7M0EFpllim3TxIIjpCZhF/
 mQ2SJQH0lnkcHerWGlofe0xJnnGEP43rjFZwmMwi4k36V7mpb8/gbZevht+ndg5fAHM9NRTbW
 5dHdOX/R2abeVpDw+16McJfSQ7qoEKIeU+Tb4g0sPjFvnhCsUaXJNLXKXdehoa8WXRJngIbLo
 xO9m4Xzf7ToIscjeIgvux6YUX5JqzTWMxKvWBMsREufhXpKWwI8eGKJ+OHotuhFkyJHJJV9iA
 CjStIoCuT7D1w6FSVK/GB85hqTTUJAyVHF85xGb89/rjb86Gm7kp++JuNPKagdzL1di3D2rjq
 xcz2wmi
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Mittwoch, 02=2E M=C3=A4rz 2022 um 10:46 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@canonical=2Ecom>

> On 01/03/2022 16:24, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files=2Ede>

> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - brcm,iproc-ahci
> > +          - marvell,armada-8k-ahci
> > +          - marvell,berlin2q-ahci
> > +        - const: generic-ahci
> > +      - enum:
> > +        - brcm,iproc-ahci
>=20
> This one is already earlier in generic-ahci, so you can skip him here=2E

OK, i drop it

> > +        - cavium,octeon-7130-ahci
> > +        - hisilicon,hisi-ahci
> > +        - ibm,476gtr-ahci
> > +        - marvell,armada-3700-ahci
> > +        - marvell,armada-380-ahci
> > +        - snps,dwc-ahci
> > +        - snps,spear-ahci
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Clock IDs array as required by the controller=2E
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupts:
> > +    description:
> > +      specifies the interrupt number for the controller=2E
>=20
> Skip description, it's obvious=2E

OK

> > +    maxItems: 1
> > +
> > +  ahci-supply:
> > +    description:
> > +      regulator for AHCI controller
> > +
> > +  clock-names:
> > +    description:
> > +      Names of clocks corresponding to IDs in the clock property=2E
> > +    minItems: 1
> > +    maxItems: 3
>=20
> Put the clock-names next to clocks=2E

had moved them down as they are optional, but ok, i move up

> > +
> > +  dma-coherent:
> > +    true
>=20
> New line not needed=2E "dma-coherent: true"

OK

> > +  ports-implemented:
> > +    $ref: '/schemas/types=2Eyaml#/definitions/uint32'
> > +    description:
> > +      Mask that indicates which ports that the HBA supports
> > +      are available for software to use=2E Useful if PORTS_IMPL
> > +      is not programmed by the BIOS, which is true with
> > +      some embedded SoCs=2E
> > +    maxItems: 1
>=20
> maxItems are incorrect here, this is not an array=2E

right, i'll change it

> > +patternProperties:
> > +  "^sata-port@[0-9a-f]+$":
> > +    type: object
> > +    description:
> > +      Subnode with configuration of the Ports=2E
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      phys:
> > +        minItems: 1
>=20
> maxItems: 1

oh, missed that

> > +    #include <dt-bindings/interrupt-controller/arm-gic=2Eh>
> > +    #include <dt-bindings/clock/berlin2q=2Eh>
> > +    sata@f7e90000 {
> > +            compatible =3D "marvell,berlin2q-ahci", "generic-ahci";
> > +            reg =3D <0xe90000 0x1000>;
>=20
> You still have wrong address=2E

only took the example from the txt, but i guess reg should be <0xf7e90000 =
0x1000>; ?

will also fix all subjects to

"dt-bindings: ata: ahci-platform: =2E=2E=2E"

Thanks

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93234A8341
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbiBCLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiBCLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:36:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F9C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:36:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u24so5232141eds.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vFy48ZZiU8QAY9/PLWSNOvL9jOGgbaoU12BTjZhog7Y=;
        b=mMcdGxMtuo6M+460mzP5SzpBNrbzI6tUkqeMYttEMODU6LTLjXAO0U46aRsT20IH7d
         KycfwJjPq/+FCEb9HUoDiO1x3TnIWz8YufiJt6CVqurYl86lnKge8OuJLqdzt8FAjBhf
         6Wkq/dbSe7q/5Nt8m5GBr0IBzb3PXDnaz4598QUXh62dFnbBJUZtnWWWA37tN56P8ewj
         0WLg8Y6aCJ5/210fJzQfyqnKylDYRX5XQo30ilFNaMsahH7zBpgXvQkYw8OJZKhsE64H
         8GRJ6ksyflJ37pSgHG0Uuwj5W+6fnlqnhsdkbHM8tV2r3LhowHsVYPmea2/0uLN+L529
         /9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vFy48ZZiU8QAY9/PLWSNOvL9jOGgbaoU12BTjZhog7Y=;
        b=snvjX6bCwXp3+kJi+mngZ5W0QqZCF1QBHZaBngdjgld6i8oXd+IlaP6bpHl/+oYxSm
         V+O+Q9jPOZQoyTyVbGhOkTq/+RbEpHNpF6BDSSAuC8qEmlcsJZwgz1CGlhoUgq3wwWaC
         GjDI6cJkFNSgECR73+3areWBHfiJRVxrw5+YvXKlJFizNbXNc4dF4qfF0ia0Pk6ylaZw
         YfssGRx/r/Qxc08tLail4U2KZBL3iNybXmWAIW6QZ3nvhxbs0dP6yhHxtWCQUZ3EsnAO
         seR6MTybrOx8+boaQ5BxDWlewbiwMHESFHsHxCOYdUq8TAuaCdbK5UU6YSg1l4aYRsGz
         KSsw==
X-Gm-Message-State: AOAM531RTgaqX+ddihZ7BHLXdQXMY1KzUmPxSGcZxkWdUMuGz7QfFCP9
        SBVQvrXl7w+ZlR4A22OdzEE5ATQdOOMHmPGeQVOVag==
X-Google-Smtp-Source: ABdhPJyzZe0U19wP90fnne4tM9FZZhDvI3v/CBdvI+Vq6vmEDqqklUOSzy/nRsN3cZvIKJEl9FWda7h6IYpW2TXcwNE=
X-Received: by 2002:a05:6402:5191:: with SMTP id q17mr35177389edd.395.1643888205646;
 Thu, 03 Feb 2022 03:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
 <20220202175639.149681-4-jeanmichel.hautbois@ideasonboard.com>
 <cfa2f751-2988-c372-4bcb-30080efed587@i2se.com> <9bce4322-881e-06a7-d6a4-431b1417ced5@ideasonboard.com>
 <YfsHTXxx/VDHR9Jn@pendragon.ideasonboard.com>
In-Reply-To: <YfsHTXxx/VDHR9Jn@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 3 Feb 2022 11:36:29 +0000
Message-ID: <CAPY8ntA+kLof=NEcXPSrKWZKfKduOYWBNgSJVwMnYCF1U1aGKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 03/11] media: dt-bindings: media: Add bindings for bcm2835-unicam
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devicetree@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Naushir Patuck <naush@raspberrypi.com>, robh@kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel and Laurent

n Wed, 2 Feb 2022 at 22:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jean-Michel,
>
> On Wed, Feb 02, 2022 at 11:09:20PM +0100, Jean-Michel Hautbois wrote:
> > On 02/02/2022 19:33, Stefan Wahren wrote:
> > > Hi Jean-Michel,
> > >
> > > please drop the first "media:" before dt-bindings.
> > >
> > > Am 02.02.22 um 18:56 schrieb Jean-Michel Hautbois:
> > >> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> > >> camera interface. Also add a MAINTAINERS entry for it.
> > >>
> > >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > >> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboar=
d.com>
> > >> ---
> > >> Dave: I assumed you were the maintainer for this file, as I based it=
 on the
> > >> bcm2835-unicam.txt file. Are  you happy to be added directly as the
> > >> maintainer, or should this be specified as "Raspberry Pi Kernel
> > >> Maintenance <kernel-list@raspberrypi.com>"

Probably easiest to switch to "Raspberry Pi Kernel Maintenance
<kernel-list@raspberrypi.com>".
That list didn't exist when I originally wrote the doc, and it just
makes life easier should I decide to move on (not planning it). Naush
is on that list too.

> > >> ---
> > >>   .../bindings/media/brcm,bcm2835-unicam.yaml   | 107 ++++++++++++++=
++++
> > >>   MAINTAINERS                                   |   7 ++
> > >>   2 files changed, 114 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/media/brcm,bc=
m2835-unicam.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-un=
icam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yam=
l
> > >> new file mode 100644
> > >> index 000000000000..5bf41a8834fa
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.ya=
ml
> > >> @@ -0,0 +1,107 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Broadcom BCM283x Camera Interface (Unicam)
> > >> +
> > >> +maintainers:
> > >> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> > >> +
> > >> +description: |-
> > >> +  The Unicam block on BCM283x SoCs is the receiver for either
> > >> +  CSI-2 or CCP2 data from image sensors or similar devices.
> > >> +
> > >> +  The main platform using this SoC is the Raspberry Pi family of bo=
ards.
> > >> +  On the Pi the VideoCore firmware can also control this hardware b=
lock,
> > >> +  and driving it from two different processors will cause issues.
> > >> +  To avoid this, the firmware checks the device tree configuration
> > >> +  during boot. If it finds device tree nodes starting by csi then
> > >> +  it will stop the firmware accessing the block, and it can then
> > >> +  safely be used via the device tree binding.
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: brcm,bcm2835-unicam
> > >> +
> > >> +  reg:
> > >> +    maxItems: 2
> > >
> > > I would be nice to have reg-names here similar to the clocks.
> >
> > Sure, I just don't know what the names are ;-).
>
> Please discuss this with the Rasperry Pi developers to figure out then.

It's the "Unicam" and "Clock Manager Image" (CMI) blocks respectively.

CMI is only 4 registers. It provides high speed clock source selection
for the two Unicam blocks, a camera test block that has never been
used, and one of the USB controllers. Each peripheral is controlled by
a separate register.
It was discussed previously and viewed as not worthwhile creating a
full clock driver for it.

> > >> +
> > >> +  interrupts:
> > >> +    maxItems: 1
> > >> +
> > >> +  clocks:
> > >> +    items:
> > >> +      - description: Clock for the camera.
>
> This also seems weird, as far as I know the SoC doesn't output a clock
> for the camera sensor (and it should be specified in the camera sensor
> DT node if it did anyway).

It's the clocks to Unicam, not to the camera / sensor.

The LP clock drives the LP state machine of Unicam for the relevant
DPHY state transitions.
The VPU or core clock is needed to ensure that the other bus systems
are running fast enough for the data generated.

  Dave

> > >> +      - description: Clock for the vpu.
> > >> +
> > >> +  clock-names:
> > >> +    items:
> > >> +      - const: lp
> > >> +      - const: vpu
> > >> +
> > >> +  power-domains:
> > >> +    items:
> > >> +      - description: Unicam power domain
> > >> +
> > >> +  num-data-lanes:
>
> This is a vendor-specific property and thus requires a vendor prefix.
>
> > >> +    items:
> > >> +      - enum: [ 2, 4 ]
> > >> +
> > >> +  port:
> > >> +    additionalProperties: false
> > >> +    $ref: /schemas/graph.yaml#/$defs/port-base
> > >> +
> > >> +    properties:
> > >> +      endpoint:
> > >> +        $ref: /schemas/media/video-interfaces.yaml#
> > >> +        unevaluatedProperties: false
> > >> +
> > >> +        properties:
> > >> +          data-lanes: true
> > >> +          link-frequencies: true
> > >> +
> > >> +        required:
> > >> +          - data-lanes
> > >> +          - link-frequencies
> > >> +
> > >> +    required:
> > >> +      - endpoint
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +  - interrupts
> > >> +  - clocks
> > >> +  - clock-names
> > >> +  - power-domains
> > >> +  - num-data-lanes
> > >> +  - port
> > >> +
> > >> +additionalProperties: False
> > >> +
> > >> +examples:
> > >> +  - |
> > >> +    #include <dt-bindings/clock/bcm2835.h>
> > >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >> +    #include <dt-bindings/power/raspberrypi-power.h>
> > >> +    csi1: csi@7e801000 {
> > >> +        compatible =3D "brcm,bcm2835-unicam";
> > >> +        reg =3D <0x7e801000 0x800>,
> > >> +              <0x7e802004 0x4>;
> > >> +        interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > >> +        clocks =3D <&clocks BCM2835_CLOCK_CAM1>,
> > >> +                 <&firmware_clocks 4>;
> > >> +        clock-names =3D "lp", "vpu";
> > >> +        power-domains =3D <&power RPI_POWER_DOMAIN_UNICAM1>;
> > >> +        num-data-lanes =3D <2>;
> > >> +        port {
> > >> +                csi1_ep: endpoint {
> > >> +                        remote-endpoint =3D <&imx219_0>;
> > >> +                        data-lanes =3D <1 2>;
> > >> +                        link-frequencies =3D /bits/ 64 <456000000>;
> > >> +                };
> > >> +        };
> > >> +    };
> > >> +...
> > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > >> index a0770a861ca4..29344ea86847 100644
> > >> --- a/MAINTAINERS
> > >> +++ b/MAINTAINERS
> > >> @@ -3670,6 +3670,13 @@ N:  bcm113*
> > >>   N:       bcm216*
> > >>   N:       kona
> > >>
> > >> +BROADCOM BCM2835 CAMERA DRIVER
> > >> +M:        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.=
com>
> > >> +L:        linux-media@vger.kernel.org
> > >> +S:        Maintained
> > >> +F:        Documentation/devicetree/bindings/media/brcm,bcm2835-unic=
am.yaml
> > >> +F:        arch/arm/boot/dts/bcm283x*
> > >> +
> > >
> > > I suggest to make the MAINTAINERS changes a single separate patch
> > > instead of small incremental changes.
> >
> > I can make it a separate patch, indeed.
> >
> > >>   BROADCOM BCM47XX MIPS ARCHITECTURE
> > >>   M:       Hauke Mehrtens <hauke@hauke-m.de>
> > >>   M:       Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
>
> --
> Regards,
>
> Laurent Pinchart

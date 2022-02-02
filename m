Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62694A706B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbiBBL7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:59:22 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:36795 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiBBL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643803145;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=pZc3k2e6gytwmznM0Uuw5dl3AVAzNWITlIrFh3iYiJs=;
    b=EGdniJJxXbqCy9Pn3hBHZErt73L65URr7vHPaRv2hPxj07lhRJs4o6iHlOmNNrFCh2
    cvEnXNYPyoEyt+Dnq12lUztkpALMJu4HGN6smhw6RZktaXuz5Qw8iyxNr8lnXwBebPDB
    Kvf1Cmim4OWdVYiMGYr/UMFtfGxAfP+4gQUw8Jg7HTMEIdaTFE0k1s+mhwHkFqahbwIF
    +Lwl3/TyEWaTa1VfNtGmXl0afyeHJJBSB6Y0Ba3rGTfvXPb7X+jDgDYcqQAq3+WAe93m
    xanNTLrsORBIH/fbecOu2KA1LU+qX8vvmFrsIkr6D258lxZxLRTfjl8srD3pf9J0duOB
    eUBQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDCocQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y12Bx49lf
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 2 Feb 2022 12:59:04 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v12 3/9] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <D29O6R.3788L9G5J66L@crapouillou.net>
Date:   Wed, 2 Feb 2022 12:59:03 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89CF4AD2-F147-4A06-B630-5422DB6AAFE9@goldelico.com>
References: <cover.1643632014.git.hns@goldelico.com>
 <2386420a975e0a6c17393828af776991f3d17c01.1643632014.git.hns@goldelico.com>
 <D29O6R.3788L9G5J66L@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 02.02.2022 um 10:59 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le lun., janv. 31 2022 at 13:26:49 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
>> Based on .txt binding from Zubair Lutfullah Kakakhel
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>> .../display/bridge/ingenic,jz4780-hdmi.yaml   | 83 =
+++++++++++++++++++
>> 1 file changed, 83 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>> diff --git =
a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yam=
l =
b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yam=
l
>> new file mode 100644
>> index 0000000000000..5a2767308c0ab
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yam=
l
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: =
http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for Ingenic JZ4780 HDMI Transmitter
>> +
>> +maintainers:
>> +  - H. Nikolaus Schaller <hns@goldelico.com>
>> +
>> +description: |
>> +  The HDMI Transmitter in the Ingenic JZ4780 is a Synopsys =
DesignWare HDMI 1.4
>> +  TX controller IP with accompanying PHY IP.
>> +
>> +allOf:
>> +  - $ref: synopsys,dw-hdmi.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ingenic,jz4780-dw-hdmi
>> +
>> +  reg-io-width:
>> +    const: 4
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Input from LCD controller output.
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: Link to the HDMI connector.
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - ports
>> +  - reg-io-width
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
>> +
>> +    hdmi: hdmi@10180000 {
>> +        compatible =3D "ingenic,jz4780-dw-hdmi";
>> +        reg =3D <0x10180000 0x8000>;
>> +        reg-io-width =3D <4>;
>> +        ddc-i2c-bus =3D <&i2c4>;
>> +        interrupt-parent =3D <&intc>;
>> +        interrupts =3D <3>;
>> +        clocks =3D <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
>> +        clock-names =3D "iahb", "isfr";
>> +        hdmi-5v-supply =3D <&hdmi_power>;
>=20
> Where is this property defined?

It was (not) is defined in v11... So forgot to remove it from the =
example.
HDMI power is now defined at the connector.

Thanks,
Nikolaus

>=20
> Cheers,
> -Paul
>=20
>> +
>> +        ports {
>> +            #address-cells =3D <1>;
>> +            #size-cells =3D <0>;
>> +            hdmi_in: port@0 {
>> +                reg =3D <0>;
>> +                dw_hdmi_in: endpoint {
>> +                    remote-endpoint =3D <&jz4780_lcd_out>;
>> +                };
>> +            };
>> +            hdmi_out: port@1 {
>> +                reg =3D <1>;
>> +                dw_hdmi_out: endpoint {
>> +                    remote-endpoint =3D <&hdmi_con>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>> --
>> 2.33.0
>=20
>=20


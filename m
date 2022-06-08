Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E954371C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244012AbiFHPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbiFHPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:14:58 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E679C3ED09
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654699986; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=g3XBbcUgcr7RPvjyGEXjx+/RTzPFGWR/DvVUHYZc7LFndYP06sHFzbu3ykLfe2hpTAP5OtOyg72XFa4IHnttmb+oU8sxXUoKaJUh+raTW8OrVLG6P42/l5YRPPR/GwepprEG/F4zrYK/Tp8n6Y81OMca+SZXp+JJJNjMrFDEDHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654699986; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=F9JBMBia5rEoXy4yptoHZJknCMfwVffC8pmBgrhBArY=; 
        b=d3liPRSDOtPjiQPUfbeA2/YJEaxOUWWi/QomjSx9Qp+pZ3K3wZDxyBVOwGjrsL5bpEhbVuzQWV8Jn2eJaistqlk8zYk1ANMaYL2IDpsNo6D8OjgHSegyXrKvPEoQbYSozFAGg1lUr1k9I1BQo21C22EyF18VNCxaQbLwywtEtPI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654699986;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=F9JBMBia5rEoXy4yptoHZJknCMfwVffC8pmBgrhBArY=;
        b=W/Gxnvle0kTMRWewMbHueLB3F8j90Ih/+8aa4eajDkYeFvCilKZdp1rQW8Zz9Z+k
        jFaHiSCCfIWR2obhpGMJbdcLSVByQTH8/O7o0M2PKeWJpe038DUvkegeM5NzXx5zxiS
        oDEiJuzRYUELr4IOUpRZMX1WhPXyK5F0e1de2EGQ=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654699984521556.1461877734166; Wed, 8 Jun 2022 07:53:04 -0700 (PDT)
Message-ID: <3628fbc2eb9a8c21dc0742b929ee14da76f9adf5.camel@icenowy.me>
Subject: Re: [PATCH 2/7] dt-bindings: phy: add binding document for
 Allwinner F1C100s USB PHY
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-usb@vger.kernel.org
Date:   Wed, 08 Jun 2022 22:52:52 +0800
In-Reply-To: <20220608144939.GA1366879-robh@kernel.org>
References: <20220608070452.338006-1-uwu@icenowy.me>
         <20220608070452.338006-3-uwu@icenowy.me>
         <20220608144939.GA1366879-robh@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-06-08=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 08:49 -0600=EF=BC=
=8CRob Herring=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Jun 08, 2022 at 03:04:47PM +0800, Icenowy Zheng wrote:
> > Allwinner F1C100s has the most simple USB PHY among all Allwinner
> > SoCs,
> > because it has only one OTG USB controller, no host-only OHCI/EHCI
> > controllers.
> >=20
> > Add a binding document for it.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0.../phy/allwinner,suniv-f1c100s-usb-phy.yaml=C2=A0 | 83
> > +++++++++++++++++++
> > =C2=A01 file changed, 83 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-
> > phy.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/allwinner,suniv-
> > f1c100s-usb-phy.yaml
> > b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-
> > usb-phy.yaml
> > new file mode 100644
> > index 000000000000..180fa8840bf7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/allwinner,suniv-
> > f1c100s-usb-phy.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> Dual license please.

I am based on another Allwinner USB PHY binding file in the same
directory, and that file is single licensed. I created a new file
because each variant of the PHY has a single file now.

>=20
> > +%YAML 1.2
> > +---
> > +$id:
> > http://devicetree.org/schemas/phy/allwinner,suniv-f1c100s-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner F1C100s USB PHY Device Tree Bindings
> > +
> > +maintainers:
> > +=C2=A0 - Chen-Yu Tsai <wens@csie.org>
> > +=C2=A0 - Maxime Ripard <mripard@kernel.org>
> > +
> > +properties:
> > +=C2=A0 "#phy-cells":
> > +=C2=A0=C2=A0=C2=A0 const: 1
> > +
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 const: allwinner,suniv-f1c100s-usb-phy
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: PHY Control registers
> > +
> > +=C2=A0 reg-names:
> > +=C2=A0=C2=A0=C2=A0 const: phy_ctrl
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: USB OTG PHY bus clock
> > +
> > +=C2=A0 clock-names:
> > +=C2=A0=C2=A0=C2=A0 const: usb0_phy
>=20
> *-names is not needed with only one entry. Plus, just using the
> module=20
> name is not a great choice.

However the driver expects it...

Should I patch the driver to use no name on F1C100s?

>=20
> > +
> > +=C2=A0 resets:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: USB OTG reset
> > +
> > +=C2=A0 reset-names:
> > +=C2=A0=C2=A0=C2=A0 const: usb0_reset
>=20
> Same here.
>=20
> > +=C2=A0 usb0_id_det-gpios:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: GPIO to the USB OTG ID pin
> > +
> > +=C2=A0 usb0_vbus_det-gpios:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: GPIO to the USB OTG VBUS detect pin
> > +
> > +=C2=A0 usb0_vbus_power-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Power supply to detect the USB OTG VBU=
S
> > +
> > +=C2=A0 usb0_vbus-supply:
> > +=C2=A0=C2=A0=C2=A0 description: Regulator controlling USB OTG VBUS
>=20
> Why the 'usb0_' prefix?
>=20
> Are these GPIOs and Vbus supply connected to the phy? If not, these
> all=20
> belong in a connector node (as that is where they are connected to in
> h/w).

Well these are historical things of phy-sun4i-usb driver too.

>=20
> > +
> > +required:
> > +=C2=A0 - "#phy-cells"
> > +=C2=A0 - compatible
> > +=C2=A0 - clocks
> > +=C2=A0 - clock-names
> > +=C2=A0 - reg
> > +=C2=A0 - reg-names
> > +=C2=A0 - resets
> > +=C2=A0 - reset-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/gpio/gpio.h>
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/suniv-f1c100s-ccu.h>
> > +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/suniv-f1c100s-ccu.h>
> > +
> > +=C2=A0=C2=A0=C2=A0 phy@1c13400 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "allwinner,s=
univ-f1c100s-usb-phy";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x01c13400 0x10>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-names =3D "phy_ctrl";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ccu CLK_USB_PH=
Y0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "usb0_phy";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&ccu RST_USB_PH=
Y0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names =3D "usb0_reset=
";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #phy-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb0_id_det-gpios =3D <&pio=
 4 2 GPIO_ACTIVE_HIGH>;
> > +=C2=A0=C2=A0=C2=A0 };
> > --=20
> > 2.36.0
> >=20
> >=20



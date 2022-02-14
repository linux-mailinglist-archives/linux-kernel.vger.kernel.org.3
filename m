Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC364B52DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354968AbiBNOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:11:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345527AbiBNOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:11:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92856140FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:11:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJc4H-0000Vq-VR; Mon, 14 Feb 2022 15:11:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJc4H-00GZ4x-4p; Mon, 14 Feb 2022 15:11:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJc4F-0038n2-Ee; Mon, 14 Feb 2022 15:11:03 +0100
Date:   Mon, 14 Feb 2022 15:11:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     xinlei.lee@mediatek.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [1/1] dt-bindings: pwm:Convert pwm-mtk-disp.txt format file to
 pwm-mtk-disp.yaml format file
Message-ID: <20220214141103.74fdqqfixq3jnoyc@pengutronix.de>
References: <1644847276-27622-1-git-send-email-xinlei.lee@mediatek.com>
 <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="at4uj2znseres3nl"
Content-Disposition: inline
In-Reply-To: <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--at4uj2znseres3nl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 14, 2022 at 10:01:16PM +0800, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
>=20
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.yaml      | 60 ++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Do=
cumentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> new file mode 100644
> index 0000000..2f1183e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek PWM Controller Device Tree Bindings
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Rob Herring <robh+dt@kernel.org>

I would have expected some mediatek people here instead of the PWM and
dt maintainers.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-disp-pwm
> +      - mediatek,mt6595-disp-pwm
> +      - mediatek,mt8173-disp-pwm
> +      - mediatek,mt8183-disp-pwm
> +      - mediatek,mt8186-disp-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Clock
> +      - description: Mm Clock
> +
> +  clock-names:
> +    items:
> +      - const: main
> +      - const: mm
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8186-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    disp_pwm: disp_pwm0@1100e000 {
> +        compatible =3D "mediatek,mt8183-disp-pwm";
> +        reg =3D <0x1100e000 0x1000>;
> +        interrupts =3D <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&topckgen CLK_TOP_DISP_PWM>,
> +                 <&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
> +        clock-names =3D "main", "mm";
> +        status =3D "okay";
> +    };
> \ No newline at end of file

Please add this newline at EOF.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--at4uj2znseres3nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIKYvQACgkQwfwUeK3K
7AmL6wf/arB/fkjjL+4DNJ9y4wa0AkBwDsowLOO78FRZ0tP4Hx4tq0Gat6GCVTrG
3JPyJxbc+sNvxH41ZkzQGTpaWjMl+TGqXZbyLlX97oqXQoEbT+VkkJntsQBRnZWj
v42uTTI9CyM49zJDtfw/oUVaczEIs6bHQm+jqq5c4mxLMXjbZRZdZsdY9jH+GVfR
lZJ8nPEUowlLTcev0WvcE0oU5g2YlzyXAgOWui7VbTqo+cr1BmPu8WZ847adr6pV
TtD6iS+9d0nqGyxvEZAKeRKRyNfejsbQb6onm08rgucbzl8Cwq2HZEbaHrei9Inb
y+FHrtgw0wHzEZ3dP6qrP7tlOJ3y5Q==
=DN6s
-----END PGP SIGNATURE-----

--at4uj2znseres3nl--

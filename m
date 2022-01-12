Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F748C319
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbiALL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:29:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60808 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiALL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:29:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 076061F44D4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641986948;
        bh=rf9+cWrdS7JD3Gpgve/3SFu8AlosMnzAoPUmyjtiX0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsBWJsJh7Wrzd43FvdNEfV89QxymsJMEBZsbSfswWhLTrGtlVSJeNWr5I6qwnSq7I
         k2GQwMqoiArHnkhMG0vM4Bwprw2lp+udd2OENyBS8FxugRZhJ4tZoTI/d3RKKs3daa
         CSG3vlcEmLBYTQPXHky07U91jYlT9FrOKunQ+9v5yhucgj7QRwD5cr8EtL27RppzBo
         zENFULOAK78taU6Ud5kHeStCh2PnAuSCmkZ2a29LCdzuhQk9tajKHONxOhibF13KDl
         kKVPqlJDNbk9dGNNF4NGMvIH4H1lH8ExGkzGoIYrIVut7X1DJo6ELEEGe8lU3PYMlk
         FAKLn+ceCtdlg==
Received: by earth.universe (Postfix, from userid 1000)
        id 597503C0CB7; Wed, 12 Jan 2022 12:29:05 +0100 (CET)
Date:   Wed, 12 Jan 2022 12:29:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max14577:
 convert to dtschema
Message-ID: <20220112112905.n6zb36kwop2kfm2n@earth.universe>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxq3ixy3tyzmqoc5"
Content-Disposition: inline
In-Reply-To: <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yxq3ixy3tyzmqoc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 11, 2022 at 06:43:35PM +0100, Krzysztof Kozlowski wrote:
> Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

I expect this to be merged through MFD:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../bindings/power/supply/maxim,max14577.yaml | 84 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,=
max14577.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1457=
7.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
> new file mode 100644
> index 000000000000..3978b48299de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max14577.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX14577/MAX77836 MicroUSB and Companion Power Management I=
C Charger
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX14577/MAX77836 Mic=
roUSB
> +  Integrated Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max14577.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max14577-charger
> +      - maxim,max77836-charger
> +
> +  maxim,constant-uvolt:
> +    description:
> +      Battery Constant Voltage in uV
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 4000000
> +    maximum: 4350000
> +
> +  maxim,eoc-uamp:
> +    description: |
> +      Current in uA for End-Of-Charge mode.
> +      MAX14577: 50000-20000
> +      MAX77836: 5000-100000
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  maxim,fast-charge-uamp:
> +    description: |
> +      Current in uA for Fast Charge
> +      MAX14577: 90000-950000
> +      MAX77836: 45000-475000
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  maxim,ovp-uvolt:
> +    description:
> +      OverVoltage Protection Threshold in uV; In an overvoltage conditio=
n, INT
> +      asserts and charging stops.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [6000000, 6500000, 7000000, 7500000]
> +
> +required:
> +  - compatible
> +  - maxim,constant-uvolt
> +  - maxim,eoc-uamp
> +  - maxim,fast-charge-uamp
> +  - maxim,ovp-uvolt
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: maxim,max14577-charger
> +    then:
> +      properties:
> +        maxim,eoc-uamp:
> +          minimum: 50000
> +          maximum: 200000
> +        maxim,fast-charge-uamp:
> +          minimum: 90000
> +          maximum: 950000
> +    else:
> +      # max77836
> +      properties:
> +        maxim,eoc-uamp:
> +          minimum: 5000
> +          maximum: 100000
> +        maxim,fast-charge-uamp:
> +          minimum: 45000
> +          maximum: 475000
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1f8f312f322..13e21c229c5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11681,6 +11681,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canon=
ical.com>
>  M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
>  F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
>  F:	drivers/power/supply/max14577_charger.c
>  F:	drivers/power/supply/max77693_charger.c
> --=20
> 2.32.0
>=20

--yxq3ixy3tyzmqoc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHeu3QACgkQ2O7X88g7
+polkBAAiCtY5s8LmSHJ4Lsi/ZvlsYjjvE/LAPdmalhgw0yZxeDZ0Dl2DerTtnMe
xHjAVa0GEzkI/Qv1v5LGdGZ9ExaYRz+u7fIDo2SaTMUQjL/sFExcdW1v7KIQX94m
Qnl81HKs+niXLOs1yaZwEJxbNJwu/Sg8siz9CCV2kffCVM/fa6ysq91jdqSaYN1O
m/DXz9uDZjQkMmyuDJXskoYBGrQcIkhgrRCmNwWfLr+Q5hiF4/jWXR73zgsiiDXv
Z1IaYa6Ri2SBEU8IDLuI6mGgnuKI1gYazzp6u+57vBBtm9T79TYpS8W5z7l0VPZ8
4LyAoLJ7aFwM6ynd9l296RkpDt9eAD44LMLhAfYQkrvoEB5LF2mlQ9hMZkF7UuPs
vbNMilk4RTWuCO9z6xDwgDwuLBrqGxY1iCVBOqJtzVVyWfOzi9jLSii5WOv2/lGC
Jhr0h9YpbEdMtH39h4XTnnepCVcBoh3EESr8tzLVL5GzShpVSWquM0cALb/g1M1c
2HPnhy7Al8a12IHtZnIA39QCPA1XPYNWoB2+BfGyp60W2hj3cZDDJYYaRpz+5pAK
XfjbyK75Hov/FgFubRaoz4MFojXlgSN1ianDCFTi0SpuF5w0RLDuSE1D96e5d0Lu
ag6QPQzTgw7KrufOVVl0PeYXUzRx15aQ/i8r0bFUW4z/CWXAQ4M=
=YZJc
-----END PGP SIGNATURE-----

--yxq3ixy3tyzmqoc5--

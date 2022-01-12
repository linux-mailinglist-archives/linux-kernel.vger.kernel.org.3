Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58D348C325
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbiALLbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:31:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60852 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiALLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:31:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 252881F44D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641987070;
        bh=QaddnVuAGh34b/vvUEEUmniaA8iMOx8VQkk27YV+934=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7ZTGjA9QyexnjmGklm/I0+xXFMSsqB0gNhmsf4F8KiYm80JhYxXMoDdp5q1BvLX0
         gwnWWDv71XIEUopzpJb8ZwXppEqqLqLXs+tYTX0ESav3pFufhhxLetPdyLY1Etnmbn
         Yb9OzrN/103W2PQr4iWsWGQSOjS7IWaQpfmfuxaE28nGd/G4f7O8dFI35cL+f8esNZ
         iDeD+Mvjh2aUJP++J7yrI9WSJG3TGWnSMVAFOrzhPIzgDzgu6z/OQCCirEvvAMcWY6
         h3gqfUWhiT9as0x4aJ21f1J9VRyg1pRhNXBc8zDNjjQjpnA/RY+kvtFEbZt8otSMXs
         LOaKY+6m6y8Og==
Received: by earth.universe (Postfix, from userid 1000)
        id 8693C3C0CB7; Wed, 12 Jan 2022 12:31:07 +0100 (CET)
Date:   Wed, 12 Jan 2022 12:31:07 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max77693:
 convert to dtschema
Message-ID: <20220112113107.qahlfoizapcc2k23@earth.universe>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6iv24ch4yx5vat5"
Content-Disposition: inline
In-Reply-To: <20220111175017.223966-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6iv24ch4yx5vat5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 11, 2022 at 06:50:15PM +0100, Krzysztof Kozlowski wrote:
> Convert the Charger bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

I expect this to go through Rob's or Lee's tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../bindings/power/supply/maxim,max77693.yaml | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,=
max77693.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max7769=
3.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
> new file mode 100644
> index 000000000000..a21dc1a8890f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max77693.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77693 MicroUSB and Companion Power Management IC Charger
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77693 MicroUSB Int=
egrated
> +  Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77693-charger
> +
> +  maxim,constant-microvolt:
> +    description: |
> +      Battery constant voltage in uV. The charger will operate in fast
> +      charge constant current mode till battery voltage reaches this lev=
el.
> +      Then the charger will switch to fast charge constant voltage mode.
> +      Also vsys (system voltage) will be set to this value when DC power=
 is
> +      supplied but charger is not enabled.
> +      Valid values: 3650000 - 4400000, step by 25000 (rounded down)
> +    minimum: 3650000
> +    maximum: 4400000
> +    default: 4200000
> +
> +  maxim,min-system-microvolt:
> +    description: |
> +      Minimal system voltage in uV.
> +    enum: [3000000, 3100000, 3200000, 3300000, 3400000, 3500000,
> +           3600000, 3700000]
> +    default: 3600000
> +
> +  maxim,thermal-regulation-celsius:
> +    description: |
> +      Temperature in Celsius for entering high temperature charging mode.
> +      If die temperature exceeds this value the charging current will be
> +      reduced by 105 mA/Celsius.
> +    enum: [70, 85, 100, 115]
> +    default: 100
> +
> +  maxim,battery-overcurrent-microamp:
> +    description: |
> +      Overcurrent protection threshold in uA (current from battery to
> +      system).
> +      Valid values: 2000000 - 3500000, step by 250000 (rounded down)
> +    minimum: 2000000
> +    maximum: 3500000
> +    default: 3500000
> +
> +  maxim,charge-input-threshold-microvolt:
> +    description: |
> +      Threshold voltage in uV for triggering input voltage regulation lo=
op.
> +      If input voltage decreases below this value, the input current will
> +      be reduced to reach the threshold voltage.
> +    enum: [4300000, 4700000, 4800000, 4900000]
> +    default: 4300000
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5e4f14f6768..ead08768fb78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11681,6 +11681,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@canon=
ical.com>
>  M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
>  F:	drivers/power/supply/max14577_charger.c
>  F:	drivers/power/supply/max77693_charger.c
> =20
> --=20
> 2.32.0
>=20

--f6iv24ch4yx5vat5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHeu/sACgkQ2O7X88g7
+polphAAm/l8/UHhSpnw9k7he1pdP+mfWcJ+lfiwMPHLRa96gVpIhBWZUE5ezs3+
mwbeMitlkYHHTQZfxyPoGNDRw4FPaJxF9h6Yb2MUrw6tQP294BDAegleq8tPVcFg
IGQanfR3QhgMmFuSZLSgBZuLesIAV9rpxZteoNBmvJnSNO4RMf+k9kJH9xQwODxM
D6NoS7OfMbGPRQ8EJVHgKOB0Q7GzTobBlANReIVtREXOGMJF5JpGX8THlT9CibNP
4jBGMTHqlWjuJKOHOro59qraYF7T1MWmXfe0HnmyDC6SUIWs+h2pX2TJvQXFnTjE
U3Powkm1uuK1b7lUEdjShVGRX+2GWNPcBl+GSJ1ICnUmZJRhcRrccyfG9MRwePo0
cx5Ph1bqiQmbyva2U0r3H2Ft31qkikdGoumOJjIrIgbfvW6G05k2ZDReyAVHrEiX
NqnZwO9T/pY6qP0frQTCZ3cIuyHp2inhMglM9P9YIHp2akD+XXA3bHme/uj0VYBP
r6S8Neilx/Ypkiwi/vlC+g3/Iv0uCpQ+GxAkMlSS9dq1zDrQl1JFCh6hjuy08BJr
wDswwUCUB5uB3F0lTzh3037Rot3gEZq94oJYFwHPAbMkBJpoHTtSLjneQj2f5FiF
CyEhc6pxSwlESplkadcpxKH6Xw+tRxGIEUGl4DaPuTYh5O29Au0=
=Z1vI
-----END PGP SIGNATURE-----

--f6iv24ch4yx5vat5--

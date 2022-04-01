Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE14EFCF5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353305AbiDAXFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiDAXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:05:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2417337E;
        Fri,  1 Apr 2022 16:04:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D6D21F47E32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648854239;
        bh=Zf4/W8ZkSiud0d32XUvUEMHUjsk++IGQrm8gV1GEolk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZKLEOOlx4hJsK/bJUWnbWB9ipw5XTL7NS4BldrvaDTaiwrOzuNz6CXXqYGbs0dUZ
         mAn0tiWUqA/nPPuimbR+qB7Zcdwiu62oVpH1y0ewXQME4TPr3bBwbErdhgV9/EWMfH
         W8+YhbCuG/x78UaVUgCWHt8+628CW5Ar8xThDFTnRiHqofpGwk2pPwtX9snvvvm7RK
         nJs1Bj8nLplirk81vcKRQuHbprwM4VIgensHvb4qLQoI2Rgu0sYu8y70k5s/h6SHDX
         NSs6mHnWfGSe62hCwfXFKwRNozb8SEuW5wLCNAl8R7U9326o/KGQFF73z8zGcgHy7Q
         b5bqClftr8oZg==
Received: by mercury (Postfix, from userid 1000)
        id AAF2C1060582; Sat,  2 Apr 2022 01:03:56 +0200 (CEST)
Date:   Sat, 2 Apr 2022 01:03:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Message-ID: <20220401230356.w7obr3nxl6673mig@mercury.elektranox.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ug4hpksr7eokrzoi"
Content-Disposition: inline
In-Reply-To: <20220401202643.877609-7-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ug4hpksr7eokrzoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> drivers.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/power/supply/qcom,smb2.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,s=
mb2.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb2.yam=
l b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> new file mode 100644
> index 000000000000..1bea1fef78b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/qcom,smb2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
> +
> +maintainers:
> +  - Caleb Connolly <caleb.connolly@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pmi8998-smb2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: usb plugin
> +
> +  interrupt-names:
> +    items:
> +      - const: usb-plugin
> +
> +  io-channels:
> +    items:
> +      - description: USB in current in uA
> +      - description: USB in voltage in uV
> +
> +  io-channel-names:
> +    items:
> +      - const: usbin_i
> +      - const: usbin_v

Is there a good reason to use usbin_ instead of usb_in_?

-- Sebastian

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    pmic {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      #interrupt-cells =3D <4>;
> +
> +      smb2@1000 {
> +        compatible =3D "qcom,pmi8998-smb2";
> +        reg =3D <0x1000>;
> +
> +        interrupts =3D <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
> +        interrupt-names =3D "usb-plugin";
> +
> +        io-channels =3D <&pmi8998_rradc 3>,
> +                      <&pmi8998_rradc 4>;
> +        io-channel-names =3D "usbin_i",
> +                           "usbin_v";
> +      };
> +    };
> --=20
> 2.35.1
>=20

--ug4hpksr7eokrzoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJHhNUACgkQ2O7X88g7
+prg8w/9GK7RzA2mPafvhUeYbyRQBj+1grwrYt5QBCUw9MSYJFAxoeViL4xgF5KX
aVG7hbymkgL2XiPo9J2AvY6DMkXfJTgvHeLS8uTZCRLd1NeXUL/M6LGoDz3w4f1U
rv9oI9pz7QMnK5DThAKqxlaV7BALW/2KUnNgK3Cfi7Qm0updbfN3Pq2fh4yiCM2t
7Nveg5d2Uf6IhTxVRANyKcNKJuwbdTFzFASIj88H8JPxbH9Wb7eL77D031pu1szp
oj72j8mW9lU18Ovm3Cft0zOzRe9Uk2X4BmTEGhsJZrnN6SbsBHpmH9dVg0yXcHWp
Q81iVNrFWG7ROsM6YcU5F0w/Unx1UkJtpqRCeKd+ZzoZcxABuRBT2tAV9CmBCMY6
bw/0s+UWN6bck4ji3gYbu/7MTOyjwxw+FoTCLe/MMRX4WY0N3hVyMZnDNdaWrXUo
jlsi9r6q7iMemBaelThQdHUX9FHBndj2IMo4kCdn4RRoCkWTYMfAnTzrqmJ3kJo6
+iTLK1wQLf13IUaLT8DTou4swFgAKaBdyyT4YsTQ4zVpQXCDLvor7NjBsV/bgjeK
LQZyRWm+xVKWa7HfY9D/nSGBnM62gvIiFAOzGgS42VXCW3x8GyqnVH3oLFCkDUs5
sydsVOkIc8ENWYgrH/kMC9LlltzdRd5fgtlVc2Hth7ylUofr15o=
=66Jf
-----END PGP SIGNATURE-----

--ug4hpksr7eokrzoi--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004E4DC582
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiCQMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiCQMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:08:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06ED1D4C13;
        Thu, 17 Mar 2022 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647518763;
        bh=FvAOnwGgm6mSzo4GWwbSbtaPsT3+hToFjrf6jLKI3b8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Mrd5vzWfzAzg7upBL2NOum5ESRYqII4I7LB5+xCbu7zbeJY72xXm/4wnCf2Vdv7yp
         8RnGN798Lzhv2zIEvf8XnzN1IQAaTbHHnYWyH/BP90OEBQqNNN4lFVowp+PC5VaZVN
         qVmFcKpo7juvb+9R9dWAkzyIQoH7TPf/QiFA1uUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1o19yD3EMd-00gssK; Thu, 17
 Mar 2022 13:06:02 +0100
Date:   Thu, 17 Mar 2022 13:05:54 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Subject: Re: [PATCH 14/18] dt-bindings: irqchip: nuvoton,wpcm450-aic: include
 generic schema
Message-ID: <YjMkIkaMD4aXW4p3@latitude>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
 <20220317115705.450427-13-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6We2K2LccY5TYmIH"
Content-Disposition: inline
In-Reply-To: <20220317115705.450427-13-krzysztof.kozlowski@canonical.com>
X-Provags-ID: V03:K1:HgL/c7y20/2o06wU7DUbHTGm2dtdKvONyD2DCEUDcT19aKB9dp/
 4YFswLqVeUacbJfuaUDINBhpX8w3EAd6v+d4BzRlu0XisSUP17PNuWg/7WN/pvmXHwcLhw9
 f4fq2mw5u+m5ub1UFpJm0YNLy237jEHwhPjQxCZUJ3KWdkHY3PtDNxdr4n9t/F25/ik6h9M
 JcWSfb1x/nlLhWFmAaahQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q+LaKt2UmKs=:OOCnDGzegq7M4POFDUWR4b
 M7csAE3emHW6sJoi+gtTJIMwzgN+Ow+9Nt4CL/4QdsUnbrvl6FfU09hizYzSvEbtmPklO99ap
 SjjPAHFGB6621T7B55di6QPcgLDFQUXK3tw+a2zeB00U9ijpUWWAlrd+KvzKhu9QnpACnatEn
 e0InZ2dITD8ae/tJ3bxreUEbEysNjf/WeUnmbz3Q7olzEIaiKh8qN0uJxjfBUXDjXqiCWTspP
 KxK8nEUG9hXMbI3oQ7wNwalMarGKFDlCwAFodPp0eAGNlNAU8J/Ee4d9wYAVFxTjwNKOgSpsn
 3FUpyE7Uh2bRsibCBetlUjV20Ps/9Fq25jBodwt+QiEgDCq68M0T/HBprD/j08dCu7tgj5OOW
 +iBcP8m9X8CP2UYG7gXOKTCqVf5HFI99GAJ6DrvnVOlVaI5udZfWY485qmUZhZ5iBYipb1vAh
 2Vj+8UdkO8A+w3TzocjW9InzwT0NdkCQpVZDjjwDbmpU53zIpct7/TZAwWr7/2D9sIp/SraMM
 rqAUQbPBEQFKsFNxDwRDifg4x4V+S/e7d0vaqIJGHY0FmEN8kQSpSU62mXfjapbft3OfaK3B9
 k6wxO0MXZYzYKONEPWvVU/IBPPIKxDoWMEyaMvb4V2zWoQlQbzOUZqQBLCBdKLLEmxu2xhYuj
 lcedH/Z8K/h8ctpENTCkzJmPmRNFWgNHvLE9fjwYF/w3ANCm76XdAEjQPPYZaLceFg2exs/Kc
 VMU7W4zqdO9hbpQkyFVecUgjvQJfvQghIk32+Hi1xlwgrK+37ne91k1/tnHfrMLZGQkg1650Q
 SmoN4Y7j9Uz/mbTROEqvASzxjOayimJMBQDKCHhkaM0/rW/PJwsabtmYH5YOyeXnHCnHyn18t
 ARwSlMVdGg6djVHg8TnK85kyvqjGSQ7xSfLTkQJ5gdqRbUlASCJt9p49BAAF3bWgTj/4eHMZJ
 p4qnimyKYT1jcZmZtmc32m/MmClphx33oBtSPt1Ux/MI6PSyiLbK8oC061wAUbgfLXpqWbhI/
 1IHaDPvocdBDAUmVTrMgzWsGRJvhvaWU2GzwTcWKppO5gQb81i56C0EZKylcDKUuGCXQzVCkV
 qWMwg/tfQIUG8I=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6We2K2LccY5TYmIH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 12:57:01PM +0100, Krzysztof Kozlowski wrote:
> Include generic interrupt-controller.yaml schema, which enforces node
> naming and other generic properties.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

>  .../bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nuvot=
on,wpcm450-aic.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/nuvoton,wpcm450-aic.yaml
> index 9ce6804bdb99..285c20de0962 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm=
450-aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm=
450-aic.yaml
> @@ -9,6 +9,9 @@ title: Nuvoton WPCM450 Advanced Interrupt Controller bind=
ings
>  maintainers:
>    - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> =20
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
>  properties:
>    '#interrupt-cells':
>      const: 2
> @@ -21,14 +24,14 @@ properties:
>    reg:
>      maxItems: 1
> =20
> -additionalProperties: false
> -
>  required:
>    - '#interrupt-cells'
>    - compatible
>    - reg
>    - interrupt-controller
> =20
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      aic: interrupt-controller@b8002000 {
> --=20
> 2.32.0
>=20

--6We2K2LccY5TYmIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIzJAAACgkQCDBEmo7z
X9uWABAAyCJBDe/oJqNtFTHpiAaREvkhvc/p2FA+LYL7rx1AakR0loGpsK2LPJKZ
zyaXqwnn/eM43JdcpN8IiOu4hcrpBZ3IYwvdbBbCyvhTruAxgCYyeVCzYTiaDvl1
viiR1Nrne+v9WIV5+6wQzU3SCXIIZFHR8NTDoYjIwQm+Kk/0iIgp31Fir5/1Gxne
qkFkHNxsTyuV+lhXPPxR4Ckws+DBAhSAoD7Z93Fz3Wxe8dvwSqCm9bdrRwBI3FoN
PMsK68P8HY8UjfJaShm1YCmiHAVVXCuVtPhv8t5qYk9QRRnwR9PMmsWBZUWJ5/X3
PVc+U61swOpCcjekpEqCaANNOIj5gGegG7TyOfFKMvjQg007dOXkrVneZY6LWct7
bBz9YqPvobcqXgQ65kY3hZN31F7NbK1NqEN1Y6uuEPzWBh63rSQusXuOMXYqIg2W
gX43E6GEAfZODJErtwXdF2GQOnaK0VcnHHVzn2xO7n2ygXXtgh5Ty7t/wAAV34Li
cUeL3a5B0drHBT4SHGGGyDGtgar4gfoUQuMWipQo3in/puaUPwK0ZdpEHxRuy5lJ
B1OlCMRiBAm4TeGr3uAo5xEnCagPAYOQnX5YuGF4LXgWKtBNvrbMekA8MtNg2jTz
nsyloA9vu5b6xYWcBOych0jIGJqubGCUmTLG5/AYXoAZfWTm8Js=
=eXJh
-----END PGP SIGNATURE-----

--6We2K2LccY5TYmIH--

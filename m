Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961935454F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiFIT3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiFIT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:29:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75F231CDA;
        Thu,  9 Jun 2022 12:29:10 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C1F66601606;
        Thu,  9 Jun 2022 20:29:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802949;
        bh=w0P9wZ/kc6XE+JbDq871TspET2hrLn0GYYaPCh+KNY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Czl9yZkJJs44t6TgQE0mARAOXOXWKdGm+lvcXhzSY6cUhr9gsKQaKHsM5fXciuZBP
         Ca+CdoU4Ln4zp0qg3+diD0cRAXyJkEOPfVkMWnDaJzxWuhZt9SKdIr0wmWxd6b9WsC
         EVfmRGLmbJX5U0Tc9ij+FXjHJxL60uuBU3PYuIvWLY5rPisd3v+RnryvLjJ9KUj1sB
         +NCK4QEc0+uVVsgghNfUH/OSbI2M9C7Dgnpudzpm9LP+rAd38ZfDjY8w/nFPKsXlUP
         t0e8Q2LneYi9uoY4PF2ZgBgl3HKqsDMEEAV7q7eZ6i449k5jEd+YuVZEzU18t3fun2
         TFXNaqo0Slb4Q==
Received: by mercury (Postfix, from userid 1000)
        id 40C7810605B9; Thu,  9 Jun 2022 21:29:07 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:29:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: bq24190: use regulator
 schema for child node
Message-ID: <20220609192907.cya33m4dwuu3i6e6@mercury.elektranox.org>
References: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lytm5kd4x2zi537x"
Content-Disposition: inline
In-Reply-To: <20220601071911.6435-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lytm5kd4x2zi537x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 01, 2022 at 09:19:08AM +0200, Krzysztof Kozlowski wrote:
> The 'usb-otg-vbus' child node is a regulator so reference the regulator
> schema for proper evaluation.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks, I applied all 4 patches to power-supply's for-next branch.

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml =
b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> index 0d7cbbdf808b..402d9d2ed2b9 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> @@ -28,7 +28,7 @@ properties:
>      maxItems: 1
> =20
>    usb-otg-vbus:
> -    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
>      description: |
>        Regulator that is used to control the VBUS voltage direction for
>        either USB host mode or for charging on the OTG port
> --=20
> 2.34.1
>=20

--lytm5kd4x2zi537x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiSgIACgkQ2O7X88g7
+poiMA//WsqIrNMXApabQgDSUxebomwX5vE6bifiBUf7O3rVHSgp99zjesbcD26O
l2Fwf4fF6mzdXv59XTw8U/CY6eLj47ZadmcjW3QC4tjxdqm+X0mThyN1vqN2VFog
t4NK6LXQtkT/L8b6Pgbbh34X+812KHh5lrlkAjdFRiuCK+N79ETOM3B1fxkjT5bp
pJRb2ax4r6sQC07cAg5KkR069FyH2Ay9Ibj2n163paxVuPzo5w2eXxEzB3vByejm
0k2zdyLK0QANi01KfWs60YqYcNG4TgMuvjCOwbV68kRRyRZ6G2pzEzH41XKj/HTp
BkcZZsvBUXGSDWGKcCmYZG5jbqK/xugYHrHEtXMRE3+vfQIiL51p5lvjaToJnxUy
6zDMlvAo9Bu/Gbd6B1QjH3gd4nM+2b/2qLT6CbsyBOClz4ngi3XEs8+Y2H5bCSCE
EbRndpEsAn8Oqdn5Tw5NZn68achvw0/zJDswVM8knHyKKjzIwwsIvVPpK3ttNBbr
SWFFn0dmj3PghSoJOM4S8dIiAbF1KHNmG+Vuti6jji9EpcuFzqtwh0kJGnRkzmIZ
un532n5lQHs2HICjaCdCdhXoAZTugEtPGLvqsPvJmZi4ye8O/FjcHsAbtMiWVxhz
/Yybuo5rr8Ya2PKQm3tc9LXx7Hd9PGRc38xUTaS/Ncx+UmfvSyQ=
=Cd96
-----END PGP SIGNATURE-----

--lytm5kd4x2zi537x--

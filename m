Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F29157DC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiGVIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiGVIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:24:14 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B879E795
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=G7DpDeN+J+UKLSZ3ZAUmo1+Q13ja
        LhczmLdzIypc5iw=; b=dx9scorbcb3LAJsGOtXnijWvyPNZJos6oAAPbljl4hif
        LOvhy6QU5/+2cjU1PejQi6Zq2vNpHmS4CK5snERMumvh0yFRYdVP9ElUcyfLmIXP
        eTQh3GWBFQhaKWGQ+1/hXAnFXyJ8XFxMi6hogYJ/DAhR7OInIBrjuin8hBjuRfU=
Received: (qmail 1290898 invoked from network); 22 Jul 2022 10:24:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jul 2022 10:24:04 +0200
X-UD-Smtp-Session: l3s3148p1@t5ZNjmDk7DtZzJki
Date:   Fri, 22 Jul 2022 10:23:58 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out
Message-ID: <YtpedafKl9xJhi61@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <2e3863ae32e17d49f41111580f195dd34e2b769d.1658303544.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XJU1ImY/AXCixQxc"
Content-Disposition: inline
In-Reply-To: <2e3863ae32e17d49f41111580f195dd34e2b769d.1658303544.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XJU1ImY/AXCixQxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2022 at 09:53:34AM +0200, Geert Uytterhoeven wrote:
> Restore sort order (by family, followed by type).
> Update the conditional sections specifying the number of interrupts.
>=20
> Fixes: 525b296185b4b0ab ("dt-bindings: timer: renesas,cmt: Add r8a779f0 a=
nd generic Gen4 CMT support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you, Geert, looks good to me!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--XJU1ImY/AXCixQxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmLaXp0ACgkQFA3kzBSg
KbY7ng/9EftoPPaWNzC3yanwkmpjMRigJf4LJb9cBxoBnhDrerfG8zog8a+VrOgZ
210XXsohukbHFJdaqA5tQX4XU5OXTlnzD2H0sC4hIRql5NI4t6xNDH1vl9mf1ucq
OorY7d6T98TnzU6XMGIfpfvUgVu4iL9GxTCcYPOMJn6gSpce0ciEDsR/mmrPiPkH
HaPgBTKAWMCDAR3BDu3a82F8qw8lCEFKZxAbbAnemGDuKao7XRE+eTw20sMhKHR+
nRcui3z5EimpP22h/6Fz51waZftkAVtcAxAMHhVYm8qlkDvYqCmOYr957802mY5w
Uo1IBProk4xw8z8sdnbfHSF56daIXaKVS51UZkzMFpWoRN1mbHTU5H1gkNsfyg9o
w2i6qQgwkrUVM0naY6N5XZ5M/66QrMjE5jwjEExjn5gyrP5jYR7Zg/nPsDiOcbUv
APssbGzGgnO6fH5cqqS5Tb36B//iuCBiY8MJgjOKayZZuijIh6NMNqChSNnCaq9l
24UyIk4SityUHTdKjpv2EdIVykyJin1493tfMBpGyIXctw2BpaPffCnudyyHO5mg
kpH76wz6RYVoFMYEUo2agfWqZTZsaCe5+CENJcgjcXnyRC4aaqpbXKVAyYwIDXHU
/uJoPqqQmXFY6lcOziRyvpjehM7T5v04rN8Gsx38Lf1vaXhspJI=
=fh/7
-----END PGP SIGNATURE-----

--XJU1ImY/AXCixQxc--

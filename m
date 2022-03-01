Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5E4C8E62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiCAO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiCAO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:56:22 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08405A2526
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=NWFwramrqcFN43h+FBE0GPSWZHqM
        i8FJofMttgZwmB0=; b=J6slbFMQLnPPz2J5t9hb+AoYlMna/ORbwBNKz1CGhoUr
        Ym+qcrtL1mF9xTFEiC6jy7J1IDIj6fcNJvRd4zlljN092tZnUB6B9U4OUO5/2FjV
        BgswJtc1TZ70PcYe/ZnhaJQbQQKWO6S9roZue0GE90+rlbekCLWX19IG7qdhyQU=
Received: (qmail 3901312 invoked from network); 1 Mar 2022 15:55:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Mar 2022 15:55:38 +0100
X-UD-Smtp-Session: l3s3148p1@keipWynZ9NQgAQnoAGI9AP6D0HJXVmR3
Date:   Tue, 1 Mar 2022 15:55:38 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: renesas,wdt: Document RZ/V2L
 SoC
Message-ID: <Yh4z6kUetYEtP2BJ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org
References: <20220301122332.14796-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IB0UhyAI3pAW8tBk"
Content-Disposition: inline
In-Reply-To: <20220301122332.14796-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IB0UhyAI3pAW8tBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 12:23:32PM +0000, Lad Prabhakar wrote:
> Document RZ/V2L WDT bindings. RZ/V2L WDT is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-wdt" will be used as a fallback.
>=20
> While at it, drop the comment "# RZ/G2L" for "renesas,rzg2l-wdt"
> compatible string as this will avoid changing the line for every new
> SoC addition.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--IB0UhyAI3pAW8tBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmIeM+oACgkQFA3kzBSg
KbY1dQ/9HhVFB9t7bUHKAmblMsWFLb4M+BaQnTCbCaI8oQTi4U75I3XSVnNcqMyS
qTTX+m0FusfG3XjVXeKg4Bniv5O25Zppt0cp631e3ghBY16aRNYBuo/xCXRtRHSS
kynx6Uustw2K2PxZ35XFDE4NzUgYw33COlNU9QOOIfs0bt5Z+oe9h+mvbQMeV7PO
qXjWVjcTZnaBf1yBEwL+YQ9O80+3xRay4NMcgCJ9zvsy2QvDDN8wy3IgKOTYnSSr
pEuH3RkGuOwFwW2Mie+a78QfYjkFX/o0yxLHEzgBri7wlnt5JRDRy7lHjGo79IIG
6dG/ACRu1+f4bs25lSoGIPIkivitYMICFJH6BLgTxmQzEDbf95h+/LskfGf77vLZ
blIJncavupjf5nf8gHfyOlJzZN13vi3Cv7PjS5zLYpSmWBX+JNUyE2o6pyYHegib
TKuP9jFSG3NNH8DVZd+J0HpgVIQIq9J+MYGq3IkOFKZpWuBB6W7uFdV/mqXUZ9oq
Go1agEP5cTQ7vx6J+R0VWgH64XZTrg/ia+Nj8tCe+pw/rz2bPhfdF5LxVvMNtS54
hek4o2SLjgGzW/PpvObIjze4foEdmDOGs8MrrLMzug8MqXQghjVGLgFF7hzLdN1T
2tK7ouGke1MV5YgxyQrVIQZx6igHz9N+1qY4gv65ThBSPFv3j0A=
=Jowe
-----END PGP SIGNATURE-----

--IB0UhyAI3pAW8tBk--

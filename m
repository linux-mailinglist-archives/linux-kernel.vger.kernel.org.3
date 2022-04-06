Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389E4F6C84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiDFVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbiDFVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:21:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F122B1B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=I+79RCC5wLvFgPdEG/X+30z3ozXN
        htsMgw7+VDQgq/M=; b=1XQ+8XnJSym3Pz+8JhjqZWTD9FkGYE9NSl8GPVjmH5NU
        9B+IxJpH3Z+3EG/b/rK85hKY5d5okBDIlyjAERZ0RR/819KD5FVGwjfJ4YQqyuN/
        wRWrS5yGRe1dQSTZak4xFYXGgSNt9gQ6jwALI8JymzHG75zBZ+2VuKTeCaV+goE=
Received: (qmail 2883505 invoked from network); 6 Apr 2022 22:15:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Apr 2022 22:15:43 +0200
X-UD-Smtp-Session: l3s3148p1@x9isBgLc4scgAQnoAH8rAHnYTrcYCkZJ
Date:   Wed, 6 Apr 2022 22:15:43 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux-renesas-soc@vger.kernel.org list
 for Renesas TMIO/SDHI driver
Message-ID: <Yk307+KxWoh6sYtP@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220404174159.571-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BWAkag8zG++8jsre"
Content-Disposition: inline
In-Reply-To: <20220404174159.571-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BWAkag8zG++8jsre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2022 at 06:41:59PM +0100, Lad Prabhakar wrote:
> Add linux-renesas-soc@vger.kernel.org list entry for Renesas TMIO/SDHI
> driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Yes, can be argued.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--BWAkag8zG++8jsre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJN9O8ACgkQFA3kzBSg
KbbJ9g//azq48qKcFXX6BzAgo9gl0HwWlS8h9hEz4jq1oeiTbFrk7DB3ldVZXkTD
YAR03cs6qTN5JXr0xLifgerJsp05kG1ZFHJGIxqIr3u1wYP3xBZvYNrHr0y8tRrE
lxcIHKCQnA7JyuImDYKwp1TMtsK88zEb4ObAejWp1xyWIkUH4A2Q8oXUHGoA/5bO
IE7HKkYv7GGnon95hcQCqPsacqY5WUnQjU6aWFjVdX7MMaDvdXlz5XKlCMomJA1M
H3l8OaEWBLQ0H48DvpakURlsgPY7IEBLDh2URtadZri0XGoAYK4/HbG1eXKLOE/K
6TG5z6EnxNOh8rKHCN5bw1oImZudahBlvgANn1ybBkv4wd5JtjGD/Fhq+81f6xu4
VW8WC0WOKbFwX5kWF9oo+5pll6JWIo5NIFMpqh/DytuFt2UJpt14ilxKUjvKpQX9
bkEY8pHe+9zW840Ncdycp+pNF6wcGtMOuAge+6X0eTe0gQ0qTthiLJkYXyw9/3bJ
1cZdrVz4ywS4lavGmSfelHuKQnXHxrwKRt/oIXbDcvL/FfjXH2lb6+ZcISX1/vin
RKMPj6MFZNSwpjL46jW0Yz/mAhYjsDZ5JVv8A4jwYq3fhMt6IHaVui5eSioLIxSU
xU69GdBTM/LeaIyi2XzyGejtZS3Smnnf9pP6aQWWY4MstL1bsyw=
=aqhj
-----END PGP SIGNATURE-----

--BWAkag8zG++8jsre--

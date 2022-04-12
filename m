Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B904FDD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiDLK6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbiDLKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:52:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757A22BC7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Fj8VO6yUX/TG+ZwJZmOwkh7zNQnO
        gn90D0zMWyzIvnU=; b=lKHbOYSHXrHXzoAU0xuLD4BzV2ze1u63QPuRIEgJhIFL
        X9sTyU4Jv8qE7LzoB5wW7DmVxTNj/YMhzpZPyjjxhmEvSH8SsSa1hEFGO0hui6E4
        muRRWsVrk2hjNF6YzGn6AJdgDFATY/OvX2Y6/FXb1q4LJNtUyVS9zpT0lJBDmjU=
Received: (qmail 987440 invoked from network); 12 Apr 2022 11:49:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 11:49:07 +0200
X-UD-Smtp-Session: l3s3148p1@WEzI+HHcDucgAQnoAGZ4AFi7qjeMIP6q
Date:   Tue, 12 Apr 2022 11:49:06 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: renesas-rpc-if: Simplify single/double data
 register access
Message-ID: <YlVLEnRaARVmWZnZ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
 <YlVJc3z1xXT2emIc@ninjato>
 <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S735XdVRzV/i3nen"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGkba3hiRJPEw26oBdc6_MK_eBO==Z9QeinaoeZv8Qbw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S735XdVRzV/i3nen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > +                     regmap_write(rpc->regmap, RPCIF_SMWDR0, *p++);
> >
> > Last '++' can be omitted?
>=20
> I know. But I think it looks nicer this way ;-)

I have to admit it looks a little like "I copy&pasted without thinking"
to me :)


--S735XdVRzV/i3nen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJVSxIACgkQFA3kzBSg
KbYQCw//Tg4IDheuIWgzV7n9xNtp7Dk17Iz4LggQVlK/eKuuSJbsCwoapbtTVzGi
tM+BG5tigk87t1bjkhUzbjK9vxclhEcLmi80UquzPswl4frW4nM/1SBFCuIlXmV9
YqZnJlyM2e7RXjiftKfvmZO85x2eyvjv4nqEtj8b4tzog6HaPACQdQJYuxMxBz+Q
635MoH0kP20jKL/7u+2lyAq97IkuR0sSXngakNiAB92T2WGJUTUcmBJaVGV7qQNG
Zh0FH96JrX2RIq1Yl+s6Tfipsfgivw+l2gsgxQOKwuvcTyUZcuvWkZtL1A1tf0d4
crws5bMBIxXJV1oKU/gU/azoy3xoGDOoz2TFn9dulprQSogW+/5sx2mA/usdU2j/
IpbjZ4wiS6piDlXzplqXQDZjfVMSfnncfGjqmWRAmBVV0KV6BdSzEFBNsDqnx31D
PkcY8ezxBL34YzKRJ2N+CwdozzAAxisA6DtuvK5nLdNbjz0P6tQsYYZjJUSsE587
4g5cUbCpV72ZFYCuqNbcQFvuYA9/+fJQDdf/IrF4kvYP6LudwXRsIp0Nb79Xo4Z9
9QQ/TmDDv6wQ4cEhDobBY/DcVhbvB+SOZ5dbPMJhIKooi0YWhNw7MikbVMmmDzRD
jBXKkFQRfM8aShBo+dTG+Fs1MmZWiKoNLhYGpG3+9If+aZBcd/0=
=C8Jw
-----END PGP SIGNATURE-----

--S735XdVRzV/i3nen--

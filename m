Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A54E7CCC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiCYRac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239646AbiCYR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:50 -0400
Received: from 8.mo584.mail-out.ovh.net (8.mo584.mail-out.ovh.net [188.165.33.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02ABFD6CC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:27:12 -0700 (PDT)
Received: from player774.ha.ovh.net (unknown [10.111.172.147])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id B17CB24FC2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:26:28 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 4971828B1BB84;
        Fri, 25 Mar 2022 17:26:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G00356359f32-029d-4eac-a7f9-d434de905eee,
                    1702D5D0C6B5DF16716081994498F990499A02DA) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Fri, 25 Mar 2022 18:26:16 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm*: use simple i2c probe function
Message-ID: <20220325182616.6fb6e13e@heffalump.sk2.org>
In-Reply-To: <Yj34gLRxhmXD1Y5B@sirena.org.uk>
References: <20220325162439.1203870-1-steve@sk2.org>
        <Yj34gLRxhmXD1Y5B@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LGYoqigLMFV5fNGYgZ/d6BA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 18105596405216544390
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudehuddguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepveelvdeufedvieevffdtueegkeevteehffdtffetleehjeekjeejudffieduteeknecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LGYoqigLMFV5fNGYgZ/d6BA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Mar 2022 17:14:40 +0000, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Mar 25, 2022 at 05:24:39PM +0100, Stephen Kitt wrote:
> > The i2c probe functions here don't use the id information provided in
> > their second argument, so the single-parameter i2c probe function
> > ("probe_new") can be used instead. =20
>=20
> This is going to generate conflicts with other pending and more
> substantial patches for wm8731 - please resubmit after those have been
> applied, or split up into finer grained patches so the rest can go.

Ah right, I=E2=80=99ll re-submit without wm8731.

Which tree should I check for conflicts? I=E2=80=99ve got similar patches a=
cross all
the i2c-using sound/soc/codecs files, I wouldn=E2=80=99t want to waste anyo=
ne=E2=80=99s time
if I can check beforehand...

Regards,

Stephen

--Sig_/LGYoqigLMFV5fNGYgZ/d6BA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmI9+zgACgkQgNMC9Yht
g5wFGA/8CemT4b+V9V3cnh/mh1h/rRO+sWTc4MiLmIYyNKN93uWgIPna3Mg5QLgX
Oe/or0EWwQ7U0W74gHwd8KElvxYndmweePAegyu5tTtosmG1WMk3l9JzinNzoKjk
IX4Ql8dFYMeyIYEu9ozdePh+oiJDDz9nsMlLdVnjWN+v4ceFSIpYwjQcui8eTkCe
bnsquWR3l4vuIMsHbRmG0Pj6S7fI8ddIyvjvfhRyYLwHxGfIHjZQPOqIIdAvkYWx
pacw7lkfen4zwrNcVkxA5RXvmDq78WzX9tz0WuAniMzDuix/UdEQTwzW6XnIyla/
cFb2RCkE3lDK8ngRZm9aaG6Z26/glujZnY/2T5wiBkYjTiJmDiH9QMObO28RLouZ
PneOtlTVubin4jZK4IoCQcGZbB0FM5/1zb1zzjfDVgiD8A2qXoTzSqcGJ1wz3iHt
5w/7eo4CKi0ar2Q3DNdjTQN0kLrjS/y0tZJghM+1aYu2mlarkHx4j3uTC/QEXwst
EwxtRMcEbb/DKaMuyPrWg8TxxyFSugLHJrug+8hDvuYMl6YoKTAy93bHNccrpSu5
t0Y9lHIYJr+vlbM3D1BxrgNj7oAsS3PH8ivHW/vqcUbwMmMPmeJjgxjt0u1XFnGQ
T76ocvCh/ZoGnXKxduQBU31I7jMaBp/noc38PAYjOkAZ/tcvyZo=
=/huU
-----END PGP SIGNATURE-----

--Sig_/LGYoqigLMFV5fNGYgZ/d6BA--

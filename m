Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0E516692
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352035AbiEARVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiEARVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:21:42 -0400
Received: from 14.mo581.mail-out.ovh.net (14.mo581.mail-out.ovh.net [178.33.251.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C862A23
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:18:15 -0700 (PDT)
Received: from player696.ha.ovh.net (unknown [10.108.1.240])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 19BB9211BC
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:08:14 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player696.ha.ovh.net (Postfix) with ESMTPSA id 920801FD70409;
        Sun,  1 May 2022 17:08:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001f5844953-7db1-42db-9d2e-ace5f20121a5,
                    5040CBFF384BEDF7422707969F5457AB1E143173) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Sun, 1 May 2022 19:08:02 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ASoC: tpa6130: use i2c_match_id and simple i2c
 probe
Message-ID: <20220501190802.6ae4797a@heffalump.sk2.org>
In-Reply-To: <YmahmnPi4B2n29BE@sirena.org.uk>
References: <20220415160613.148882-1-steve@sk2.org>
        <20220415160613.148882-8-steve@sk2.org>
        <YmahmnPi4B2n29BE@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XgdtRu8Xt=SJpMeSq_X_jXU";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 13726127241353332358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepieehvedvueegjefffeetffevhfeigeejvefhkeejjedvlefgfeekhefhudffhfejnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XgdtRu8Xt=SJpMeSq_X_jXU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Apr 2022 14:26:50 +0100, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 15, 2022 at 06:06:13PM +0200, Stephen Kitt wrote:
> > As part of the ongoing i2c transition to the simple probe
> > ("probe_new"), this patch uses i2c_match_id to retrieve the
> > driver_data for the probed device. The id parameter is thus no longer
> > necessary and the simple probe can be used instead. =20
>=20
> This breaks the build for omap2plus defconfig on arm:
>=20
> /build/stage/linux/sound/soc/codecs/tpa6130a2.c:322:11: error:
> initialization of =E2=80=98int (*)(struct i2c_client *, const struct i2c_=
device_id
> *)=E2=80=99 from incompatible pointer type =E2=80=98int (*)(struct i2c_cl=
ient *)=E2=80=99
> [-Werror=3Dincompatible-pointer-types] 322 |  .probe =3D tpa6130a2_probe,=
 |
>       ^~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/codecs/tpa6130a2.c:322:11: note: (near
> initialization for =E2=80=98tpa6130a2_i2c_driver.probe=E2=80=99) cc1: som=
e warnings being
> treated as errors
>=20
> You forgot to move probe() to probe_new() in the driver struct.

Sorry about that, I obviously missed that file in my build.

v3 will be on its way soon (only for that commit)...

Regards,

Stephen

--Sig_/XgdtRu8Xt=SJpMeSq_X_jXU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmJuvnIACgkQgNMC9Yht
g5wIYxAAkmzbwdQBuLGKNjsHvhI3+W82S1wSxg7d8l6PBjjxNK8IWn+kjyIR2dRE
qj5CORvlanVZgejPH5JBLIGENU9Gm1iUXE3VTjM3DnjWtuWMrVQCbec5ojy4pXMe
JICtv1a2zZQzOq+kA5njrcpfBjEPRHyaykUIBC5AzpxqWJOle8sJw2M7kkSySB5B
YK2wkQUwnfjhhFdS+mvS70lprZZ63S/maDAfOlLFM5NHqCvQNqfKC/C3HgPrl98d
8G464ZVvCbZ714VcDx8FKuYKjnzTktwlHzPR+K0dQbYMki0muaM3XxEXN698E1LC
RH8CNzNq+R1t8a/UPqqG3+sTCyblyd83ipqZhGhCdMnDegiU8VnVxgfxi9fxaBdB
OiIlfXmwpJ7YTcqTStDZvY62ZoqON4IpZs1xiA0OCDIG81nzm94fli4Wh3/9+1Dr
RYH+/JaccW/imxxsetmzdYuna3PX6oXOiYSQ7Bf8tQXAzZjI2HQishvMPZOR1Os4
kUIBJ5vQJILgX01qud4vHJZSamfQhoOIjjOKRVSxME9n2jhDzLXn+P9NcARbLAAk
4achZZUrmf9FyboDmhtJOxz/F19md60Q+bz/5gFAAMsCozoRXUp5vR2lVnPtM0OM
BoCioJZJz7YuZCs4Y7737awIeR1nfM7zuK7bi1YShgP6y/7Vmno=
=icKx
-----END PGP SIGNATURE-----

--Sig_/XgdtRu8Xt=SJpMeSq_X_jXU--

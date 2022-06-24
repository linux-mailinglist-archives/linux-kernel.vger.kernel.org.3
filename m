Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3155A343
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiFXVFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFXVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:05:42 -0400
Received: from 20.mo582.mail-out.ovh.net (20.mo582.mail-out.ovh.net [178.32.124.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753F7A1BF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:05:40 -0700 (PDT)
Received: from player773.ha.ovh.net (unknown [10.108.4.132])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 73026233F0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:05:38 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id 6DE9C2C06DF10;
        Fri, 24 Jun 2022 21:05:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-106R006201a9714-390d-451a-9f28-57b8eaa2682f,
                    3A36F777C3506A3F96EA03190DC1808DFCB0D32C) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Fri, 24 Jun 2022 23:05:25 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Dianlong Li <long17.cool@163.com>,
        Wolfram Sang <wsa@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: use simple i2c probe
Message-ID: <20220624230525.0b78a0e9@heffalump.sk2.org>
In-Reply-To: <YrX3mWxDex7OuEpn@mail.local>
References: <20220610162346.4134094-1-steve@sk2.org>
        <YqSnwf7paZa1+uuh@mail.local>
        <2bd6ab78f649ba282c5369d0e969fea2@sk2.org>
        <YrX3mWxDex7OuEpn@mail.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zcUjq.t0PedMxF0zVF7vJxa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 2819816318092412550
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudefledgudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheevvdeugeejffefteffvefhieegjeevhfekjeejvdelgfefkeehhfdufffhjeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zcUjq.t0PedMxF0zVF7vJxa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jun 2022 19:42:49 +0200, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 12/06/2022 21:23:47+0200, Stephen Kitt wrote:
> > Do you have an example of a change requiring id to support RTCs on x86
> > systems? =20
>=20
> I checked and your patch is actually fine, the issue I referred to is:
>=20
> 1c1b3098ae1e ("rtc: pcf85063: add i2c_device_id name matching support")

Ah yes, I see! The changes I=E2=80=99m making are compatible with that (as =
you
figured out), I=E2=80=99m not removing the id tables, just avoiding calls to
i2c_match_id when they=E2=80=99re not needed. In fact the approach I use fo=
r drivers
which do need their id tables is the same as in the commit above, with an
explicit call to i2c_match_id instead of the old-style probe.

Regards,

Stephen

--Sig_/zcUjq.t0PedMxF0zVF7vJxa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmK2JxUACgkQgNMC9Yht
g5w0yg/6A6hxeeRgI0j1ocMrEZRUHdyTQA9xnNLb+/A6M6NwEtm6rCeBi7JwvTvl
yWn2KbqShV7wcc1GiNKgCDPMWosl3nVNaJQlM6rSr3ntk+9Zkj/JaN6AIVTOQpl5
zEl5GGfh6kjD3e4MlffHFek8Iap0xLUO7ocj+t4+73xzvwLZgK4gVN2qlR5E+dan
+uoD8KVY2zhemakk05ZXs96n+owJsPJfDWo+MLNqYq04kI/IbDCsojVo5P6oWQNH
Ivh2pkFPwawyQZyOwNF6Fa43rHopSHu8lxGNYWhN5A8odivmmOn91oRi80CjXDfo
DfX1MOhhG6QD4zv7UzrmJqrcym+PZZczA2qcE2x9IO8KXyQ2hEfO+711r+swF2/H
6CcAUc5sc+LOnjN/e4BFt+V0fCpYHZoBEdVpHfkuniuIrReMALHLqmlWTfG2Qi48
EpAvo5oooB9xqHwYJ5Wjd2ZkcoUGTNmPuO+Iv1+TF1RzqXY/7p0tcBl08rB46Dry
9mDbjQu7X0WeBkEEPO0MSCaJeV9kFhWMKna8JB3Kvb9aQlQA1y1vFIEKrQaVuLGy
aBXeZvHinsd3wNq9q/FOWyrmXybTpIGt8JbaMO1vVHD3u6ZBj6pC6QHMsRa6557g
cK30IBS4qLcntohfmDFrNQ/FU8u9APFCCzVPOPOE+zmC/amxXZI=
=y/QV
-----END PGP SIGNATURE-----

--Sig_/zcUjq.t0PedMxF0zVF7vJxa--

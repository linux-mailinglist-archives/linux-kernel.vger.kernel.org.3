Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297754248B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443986AbiFHCH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391009AbiFHAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:36:46 -0400
X-Greylist: delayed 5978 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 14:02:45 PDT
Received: from 20.mo582.mail-out.ovh.net (20.mo582.mail-out.ovh.net [178.32.124.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F6110AFD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:02:43 -0700 (PDT)
Received: from player739.ha.ovh.net (unknown [10.108.4.54])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 54E522414E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:02:42 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player739.ha.ovh.net (Postfix) with ESMTPSA id 95405274946B0;
        Tue,  7 Jun 2022 21:02:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S00141dc07c7-5d7b-4e1e-8dda-b9878c058f71,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Tue, 7 Jun 2022 23:02:31 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] auxdisplay: ht16k33: Use backlight helper
Message-ID: <20220607230231.07e36338@heffalump.sk2.org>
In-Reply-To: <CANiq72kRhmT37H1FAGYGny83ONYXeqJuO8ZPbym0ajQOWKY4Kw@mail.gmail.com>
References: <20220607180406.1116277-1-steve@sk2.org>
        <CANiq72kRhmT37H1FAGYGny83ONYXeqJuO8ZPbym0ajQOWKY4Kw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PUlUnIq0mXPgwAmIA0b49MF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 13614944625785603718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheevvdeugeejffefteffvefhieegjeevhfekjeejvdelgfefkeehhfdufffhjeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejfeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PUlUnIq0mXPgwAmIA0b49MF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, 7 Jun 2022 21:08:34 +0200, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, Jun 7, 2022 at 8:04 PM Stephen Kitt <steve@sk2.org> wrote:
> > backlight_properties.fb_blank is deprecated. The states it represents
> > are handled by other properties; but instead of accessing those
> > properties directly, drivers should use the helpers provided by
> > backlight.h.
> >
> > Instead of retrieving the backlight brightness in struct
> > backlight_properties manually, and then checking whether the backlight
> > should be on at all, use backlight_get_brightness() which does all
> > this and insulates this from future changes. =20
>=20
> Thanks for the patch! Looks good to me.
>=20
> There is a functional change in that `BL_CORE_SUSPENDED` is taken into
> account with this change, but I assume that is expected. In that case,
> it could be good to mention it in the commit message.

That=E2=80=99s a good point, and it is indeed expected; I=E2=80=99ll add it=
 to the commit
message.

Regards,

Stephen

--Sig_/PUlUnIq0mXPgwAmIA0b49MF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmKfvOcACgkQgNMC9Yht
g5zYOQ/9H3YNK2TyqQSG4j7HQk9Wj4DrSnbALPbkQ+Ej+PNa/OrE5SDk+bfhFJig
Ctiu1ja2SQHnCoda0Wxy9FuXJXNXp9YNO64Bo1GrQ6zSSNJO5MiDBr82HwF2GfvU
sbLnsDipylStz7F5+qHfVbUSFvWT3xOFZJwB62JiSrNL5Y7qQr3OR+50BW1s2gid
rU9MPTfyRBkIeR/JrkyN2ZO1TZweAhVFzn5QVfOxCBmdE1Qzj1Drw9+C3wxaXtfL
rsLhUaBcvUi0xl9BCavgB/Zk+dIq0k9jXJKOyddp/M0utEf9daCPJswN85I98RKe
mhKWACHvx8zTh1G7/86+hyV8VLhG995zuPW13TMRR5hSJ3RIGyadwo/MAw8+3Jaf
31F3g+0e/cbux4a8WRu2VOICrbv9ZfYf6LG9dN3qyj7uwujVMfAbR4j2tphxOIb0
Z0T85E+gr82uZHDVT7Hyr+cK/dSSxhYU6xjW+ywdlXjGLy86qVr2QwTBjUxRI35I
aPLrarw8prP3nch47JnfUsfjO65vXqcy9/EHY4FjwFuxRjbxisY7VDZw458suid6
yk7VdYU/EAYhj2I9E6+NZEtQVCV/XnMqZw7Ma82aHf/7HRWuOkat10PpPXH/mnN1
XOkR6MTcxLz89MqCZIu5+HyY/haBcWSpq5WCd4U3oPm7jnVG2+8=
=//gF
-----END PGP SIGNATURE-----

--Sig_/PUlUnIq0mXPgwAmIA0b49MF--

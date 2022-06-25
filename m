Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3F55AB9B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiFYQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiFYQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:38:12 -0400
X-Greylist: delayed 4198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Jun 2022 09:38:10 PDT
Received: from 16.mo584.mail-out.ovh.net (16.mo584.mail-out.ovh.net [188.165.55.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55031A444
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:38:08 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.111.172.45])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id C414B209A0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:22:56 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 114742BF81CAC;
        Sat, 25 Jun 2022 15:22:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003f7620af6-7b52-4906-bc6a-9af872b4aa46,
                    6AC0142EC25AD3FE2D0BC2776DBD8C4E282FD61D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Sat, 25 Jun 2022 17:22:45 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide/sysctl: escape % symbols
Message-ID: <20220625172245.15d0ae7b@heffalump.sk2.org>
In-Reply-To: <871qvd6fq2.fsf@meer.lwn.net>
References: <20220624110230.595740-1-steve@sk2.org>
        <871qvd6fq2.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pe0R7RzTtKL/6ALA3/RL0CV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 2904821760775325318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudeguddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeffgefhgfeuueeffeejieefieefgfefffethfdtudegvdejueelhffhfeegjeeinecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeeg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pe0R7RzTtKL/6ALA3/RL0CV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jun 2022 13:09:25 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> Stephen Kitt <steve@sk2.org> writes:
> > % symbols need to be escaped to render correctly here, do so.
> >
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > ---
> >  Documentation/admin-guide/sysctl/kernel.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> > b/Documentation/admin-guide/sysctl/kernel.rst index
> > ddccd1077462..079a51ed88a9 100644 ---
> > a/Documentation/admin-guide/sysctl/kernel.rst +++
> > b/Documentation/admin-guide/sysctl/kernel.rst @@ -38,8 +38,8 @@ acct
> > =20
> >  If BSD-style process accounting is enabled these values control
> >  its behaviour. If free space on filesystem where the log lives
> > -goes below ``lowwater``% accounting suspends. If free space gets
> > -above ``highwater``% accounting resumes. ``frequency`` determines
> > +goes below ``lowwater``\% accounting suspends. If free space gets
> > +above ``highwater``\% accounting resumes. ``frequency`` determines
> >  how often do we check the amount of free space (value is in
> >  seconds). Default: =20
>=20
> Interesting...I had to go digging into why this is, because "%" isn't
> really special for RST.  The real problem is that ``literal`` markup
> needs to have word separators around it, and the recommended solution is
> to use "\ " instead.
>=20
> So I'll apply this, but tweak the changelog and add the extra spaces.

Ah yes, thanks for looking into this!

Regards,

Stephen

--Sig_/Pe0R7RzTtKL/6ALA3/RL0CV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmK3KEUACgkQgNMC9Yht
g5z18Q/9ERonRuANlr+e7Zjg4opVcYZC+lOypAfauXJvP6DGiXqF4bOOgUezE7ns
EGtHKyKm2HWIwnrdu1WdkHl5RcLsGLrcBRrTWSEqABXauv0zHSM8cdqNosfBaz/g
WgZA41bc7VzBL/70gjwPXqV9OYS/03Vq+TLPznQ/mw0PEdFIQTaR+7Y9AL61r1Tw
NUNkNMb65jPmyeNDdAhLXtvRn3JHibEPAq9kpc4QNejCN/1Yu2Q0OPxeEppEUXZA
1JRGttDrRjAxMeWYiSJc9iaVc20qLMdcy79mugBbd5vGqVzPBT0Je4sEkHrTJvtn
8oP+sr77/nCiGp8ZrzqJEszdJUd/SclMz8MiDQvq/ls023feuGwUm5wdX6WY2k2r
aPIdH2JPG7h6b2Rh2SEtF7um4KB3pbQr+wqj2PlYOSV7x20lSwCpZ5rOWgpn6FhI
UMdbeYDZKN0ptpd0gOuwvgk5E3G5mFzovRTE0QbNRiI906Xw1ceiR1qlzfHKtgec
8pygx+p/nftHWg7Zsg/KckA3iS8F/64nsJ+e1Q1Y4dnjZI+jUxiij3IGO8Njqe+t
963mF+/GdecjtObLsgX2b46Wl1GCMCzXSlTULrzLrSL6wr3d/5pqohI/wJRzsPSd
qJpWgAYlEWMvRi/dbubIBHJ2hF8xjhEonVthUbrb4UiZYJvdtqs=
=ADlL
-----END PGP SIGNATURE-----

--Sig_/Pe0R7RzTtKL/6ALA3/RL0CV--

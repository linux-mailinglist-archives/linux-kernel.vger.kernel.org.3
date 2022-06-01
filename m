Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3941653AEBD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiFAU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiFAU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:57:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32B14E2C8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:57:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 35A911C0B9B; Wed,  1 Jun 2022 22:57:24 +0200 (CEST)
Date:   Wed, 1 Jun 2022 22:57:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
Message-ID: <20220601205723.GA10927@duo.ucw.cz>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
 <20220530070626.GD1363@bug>
 <DM4PR84MB19274FE59381E204CBCFE55888DF9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <DM4PR84MB19274FE59381E204CBCFE55888DF9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-06-01 14:14:33, Hawkins, Nick wrote:
> > > From: Nick Hawkins <nick.hawkins@hpe.com>
> > >=20
> > > The GXP is the HPE BMC SoC that is used in the majority of current=20
> > > generation HPE servers. Traditionally the asic will last multiple=20
> > > generations of server before being replaced.
> > >=20
> > > Info about SoC:
>=20
> > Normally, 1/7 goes into the same thread as 0/7 mail.
>=20
> Hello Pavel,
>=20
> Thank you for the feedback. I believe the code is already in the process =
of being merged upstream in version v8. For future reference can you elabor=
ate on what you mean?
>

You used separate email threads for 0/7 and the rest of the
patches. Normally, they should go to single email thread.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpfSswAKCRAw5/Bqldv6
8gkWAJ0YPqczN+Qa+zX28qAf0KvTwg7HvwCgprtfLyRCUtYDlDhejFp1+VWiENw=
=NR4r
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

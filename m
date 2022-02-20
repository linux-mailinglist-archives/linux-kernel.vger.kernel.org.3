Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C74BD23D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiBTWZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBTWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:24:59 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A11E4B420;
        Sun, 20 Feb 2022 14:24:37 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 11D3A1C0B77; Sun, 20 Feb 2022 23:24:35 +0100 (CET)
Date:   Sun, 20 Feb 2022 23:24:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: =?iso-8859-1?Q?Ad?=
 =?iso-8859-1?Q?d_Pali_Roh=E1r?= as mvebu-uart.c maintainer
Message-ID: <20220220222434.GA18143@duo.ucw.cz>
References: <20220214124808.31971-1-pali@kernel.org>
 <YgpVaR421wQYx9mt@kroah.com>
 <20220214140641.v2wlfr43lqgxvw7e@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20220214140641.v2wlfr43lqgxvw7e@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2022-02-14 15:06:41, Pali Roh=E1r wrote:
> On Monday 14 February 2022 14:13:13 Greg Kroah-Hartman wrote:
> > On Mon, Feb 14, 2022 at 01:48:08PM +0100, Pali Roh=E1r wrote:
> > > Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> >=20
> > I can not take patches without any changelog text, sorry.
>=20
> Well, I'm the only one who has been working on this driver recently and
> I have development boards with this UART HW.

Greg wants to say that you need to copy subject into changelog body,
so that it is non-empty.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYhK/ogAKCRAw5/Bqldv6
8lBpAKCaKh1tBvFkqgS8PFmECs4rIaOEqgCguGaq8H88u5b8qqWuD1q8FIamUgU=
=KTOC
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

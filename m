Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B14B36BD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiBLRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:03:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiBLRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:03:34 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EB240A4;
        Sat, 12 Feb 2022 09:03:30 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9CBBE1C0B7A; Sat, 12 Feb 2022 18:03:27 +0100 (CET)
Date:   Sat, 12 Feb 2022 18:03:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
Message-ID: <20220212170327.GA29488@duo.ucw.cz>
References: <20211117091405.7412-1-git@apitzsch.eu>
 <20220207230638.56730-1-git@apitzsch.eu>
 <20220207230638.56730-3-git@apitzsch.eu>
 <YgaQAwfYnt6E9buG@robh.at.kernel.org>
 <9a89a99872ff2fd67f097224584121e50b8a2f07.camel@apitzsch.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <9a89a99872ff2fd67f097224584121e50b8a2f07.camel@apitzsch.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2022-02-12 14:13:32, Andr=E9 Apitzsch wrote:
> Am Freitag, dem 11.02.2022 um 10:34 -0600 schrieb Rob Herring:
> > On Tue, Feb 08, 2022 at 12:06:37AM +0100, Andr=E9 Apitzsch wrote:
> > > Signed-off-by: Andr=E9 Apitzsch <git@apitzsch.eu>
> >=20
> > Commit msg? What's this h/w?
> >=20
> Thanks for the feedback.
>=20
> Would the following message be sufficient?
>=20
> """
> dt-bindings: leds: sgm3140: Document ocp8110 compatible
>=20
> Add devicetree binding for Orient Chip OCP8110 charge pump used for
> camera flash LEDs.
> """

Sounds good to me.
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgfoXwAKCRAw5/Bqldv6
8syWAJ4puUHUxTAucCpUsUpqlPzm+5nhGACgva2c+OUSx6mDeGGx4ztyVbDsfi4=
=E7z2
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

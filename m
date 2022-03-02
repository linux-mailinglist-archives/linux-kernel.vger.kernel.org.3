Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD84CA87C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiCBOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiCBOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:48:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CF10FF9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:47:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nPQGe-000055-LM; Wed, 02 Mar 2022 15:47:52 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-5c51-3418-45e9-21d0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5c51:3418:45e9:21d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EE38140DDC;
        Wed,  2 Mar 2022 14:47:48 +0000 (UTC)
Date:   Wed, 2 Mar 2022 15:47:48 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kernel test robot <yujie.liu@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arunachalam Santhanam <Arunachalam.Santhanam@in.bosch.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
Message-ID: <20220302144748.tidd2zq2xfdqvoyl@pengutronix.de>
References: <202203021333.mMJpWPzx-lkp@intel.com>
 <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
 <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de>
 <CAMZ6Rq+HR=j2mD97etTgSapOix96P=pK70bTr9HeJu2Mjkn3+g@mail.gmail.com>
 <20220302130423.ddd2ulldffpo5lb2@pengutronix.de>
 <CAMZ6Rq+J0CH_HvK1ax=VcWKqih+B_0Nfoc9jZMiq7OtuXL06hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="goiohfcs56kly6pg"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+J0CH_HvK1ax=VcWKqih+B_0Nfoc9jZMiq7OtuXL06hw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--goiohfcs56kly6pg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2022 23:42:53, Vincent MAILHOL wrote:
> On Wed. 2 Mar 2022 at 22:04, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > I was thinking of this:
> >
> > | void *foo =3D bar->baz;
> > |
> > | if (!bar)
> > |         return;
> > |
> > | printf("%p", foo);
> >
> > There were/are compilers that optimize the bar NULL pointer check away,
> > because bar has already been de-referenced.
>=20
> Sorry, I do not get your example. If bar is NULL,
> | void *foo =3D bar->baz;
> would segfault and thus the check is not reached.

ACK

> If bar is not NULL, the check succeeds.
>=20
> In both cases, the return statement of the if branch is never
> executed making this some dead code. So I do not see why this is
> an issue if the compiler removes it.

IIRC in some cases the code was shuffled around by the compiler and the
NULL pointer check was done....and with a new compiler version it
stopped working :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--goiohfcs56kly6pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIfg5IACgkQrX5LkNig
010y+Qf/f5JuMksYTwROvq+dWt29bgQ22vMgbkBu52JhjCv7Vfihplg8sqODqJBl
mYYesKRehXh2xUVDy8n+HEtXQvSsbNiA6CscidS1jHaG09yOPOm+/3ulylEz5vU6
VCnfbHb2I2zgYG7Bcoh82lz9VCGog8B4dRc+3IywXEv05P95MCt9ACl+lmOIB0p4
UiCQ9Vii0ohNBElAJ7X1TYLR7KDQGW80bMHsQCq9l6l+wCKU9iXxKwdPh9W7x0Nq
xTZBQEqigDHwJKI20U6CzOReGHEN+99KXSBSLF2iOzBSbR18bRihhiDSkILD0esf
dY2rB+NgzjysaST27/FGUKiGdg4DXA==
=MAE0
-----END PGP SIGNATURE-----

--goiohfcs56kly6pg--

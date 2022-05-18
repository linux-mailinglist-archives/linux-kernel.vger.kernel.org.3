Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857E52C448
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiERUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbiERUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:15:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128CF35852
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:15:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrQ4q-0007Bg-Ub; Wed, 18 May 2022 22:15:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E473B818A0;
        Wed, 18 May 2022 20:15:20 +0000 (UTC)
Date:   Wed, 18 May 2022 22:15:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access
 warning
Message-ID: <20220518201519.euo3jygzuk4nul2p@pengutronix.de>
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
 <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
 <YoUZLHIbxPu15/lN@dev-arch.thelio-3990X>
 <CAMZ6RqL2eKd-uqP-2vnt99_0RRE-8x7hxwYy6x1b0Oqes-HGgA@mail.gmail.com>
 <YoUcS2WMkyJYMHfG@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hg3ueutwh7avwyx"
Content-Disposition: inline
In-Reply-To: <YoUcS2WMkyJYMHfG@dev-arch.thelio-3990X>
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


--3hg3ueutwh7avwyx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.05.2022 09:18:19, Nathan Chancellor wrote:
> > > > Because this is a false positive, I did not add a Fixes tag, nor a
> > > > Reported-by: kernel test robot.
> > >
> > > I think that the Reported-by tag should always be included but I agree
> > > that a Fixes tag is not necessary for this warning, as we currently h=
ave
> > > it under W=3D1, so it should not be visible under normal circumstance=
s.
> >=20
> > ACK.
> > Marc, can you directly add below tags to the patch:
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Please use:
>=20
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
>=20
> To make it clear that I didn't perform anything more than a build test
> to see that the warning is fixed.

I've updated the tags!

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3hg3ueutwh7avwyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKFU9EACgkQrX5LkNig
011QFQf/TUOy2+UNnYLUPR+PrsBCz35GcXtNba1vH/GmLSi0Hnf6t7BHY5XXEXCE
FEIlAi/xX0kucczoQaKIS6g9e0XNA3dVAM8P8FLbhZpje/jiK4rc6tQPqkzjDFnn
q0bYU6BxRlTKqiedMFpDzyNizk2yCH1B2ey1YXZS6Ac4DIgnluhZx7nMjuUdFEIX
DMEYL40PHFFB7/rCsy5IvM/gNCqiqC8FGJB6a5dePSSX3bmCXZ7wOKLzEc2B5iDc
WyPu0WxRT3UTExEKwvktj0ODaimU8wQSmsjBIi7PPP8lLxJBabTafG7w7bW3JSuv
oi9jBO2/cSN7/ZbsBSRb4M3fr+L5jw==
=zpqy
-----END PGP SIGNATURE-----

--3hg3ueutwh7avwyx--

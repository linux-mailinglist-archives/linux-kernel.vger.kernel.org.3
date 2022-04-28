Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D4513418
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbiD1Mtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346616AbiD1Mti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:49:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA272AE0E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:46:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nk3XG-0002Ri-G9; Thu, 28 Apr 2022 14:46:18 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-6c64-eec7-9c08-9d9e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6c64:eec7:9c08:9d9e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9BB016FB14;
        Thu, 28 Apr 2022 12:46:17 +0000 (UTC)
Date:   Thu, 28 Apr 2022 14:46:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andreas Larsson <andreas@gaisler.com>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: Re: [PATCH 0/3] can: grcan: Bug fixes
Message-ID: <20220428124617.xj7fguwf3dg42wls@pengutronix.de>
References: <20220427134307.22981-1-andreas@gaisler.com>
 <20220428065058.mf76kmhamddsqsvk@pengutronix.de>
 <3ab60c35-a207-287d-32fc-a958d0e33230@gaisler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zpuylmscbbwpcxd"
Content-Disposition: inline
In-Reply-To: <3ab60c35-a207-287d-32fc-a958d0e33230@gaisler.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zpuylmscbbwpcxd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.04.2022 14:22:17, Andreas Larsson wrote:
> On 2022-04-28 08:50, Marc Kleine-Budde wrote:
> > On 27.04.2022 15:43:04, Andreas Larsson wrote:
> > > These patches
> > > * makes sure that DMA memory is allocated properly
> > > * avoids the tx errata workaround needlessly being applied
> > > * fixes a bug where the driver can be left hanging without interrupts=
 enabled
> > >=20
> > > Andreas Larsson (2):
> > >    can: grcan: Fix broken system id check for errata workaround needs
> > >    can: grcan: Only use the napi poll budget for rx
> > >=20
> > > Daniel Hellstrom (1):
> > >    can: grcan: use ofdev->dev when allocating DMA memory
> >=20
> > Thanks for the patches. Can you please add a "Fixes:" tag to each patch.
> >  From the description it seems they should be backported to the stable
> > kernels, correct?
>=20
> For patch 1 I can add a Fixes: that points to 53b7670e5735, which is the
> patch after which the patch is needed (even though that commit is not
> bad in itself, but merely exposes a wrongly used device pointer in the
> grcan driver).

The Fixes tag should point to the patch the introduced the problem, not
the patch the exposes the problem :)

| 53b7670e5735 sparc: factor the dma coherent mapping into helper

> For patch 2 though I am not sure. I don't think the problem has always
> been there, but I am not really sure what commit to point to.

Point the Fixes tag to the commit that introduced the problem, if it was
always there, use the commit where the patch was added.

> The fix is at least needed for 4.9 and onward and 4.9 is the oldest
> stable branch still under maintenance. Seems not to be worth the
> effort to find exactly from which commit the grcan driver's quirky use
> of the napi budget actually lead to problems just to make sure that it
> gets applied to all currently maintained stable branches. Suggestions?

See above.

> For patch 3 I can point to the driver's original commit for the grcan
> driver as the problem has been there all along.

Fine.

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6zpuylmscbbwpcxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJqjJYACgkQrX5LkNig
013digf/UJaIvBH4LP4Cg4DNBOYMwuZK0rNWnA2viAX93nkIRElKaINCVexNprRe
7PD12V62iDHhV9P+GoMC77NG+OMpIWVeCXy6FmFqccsl8slxctvunlibuPcfd/ev
kKsu8nB2mcGVeQtuC/q72Kfc/FjjG8e/bTXBbcegiskHPWXKrkohKYKUFWX4KbBk
ovbv0hmHwb+MidQxpc7p5vzVcVRSQh6WXx2AaPehLBNNL1JBYv7Ss3/OzE+/ArI3
QLVhXgn2QXT1+Rwb0w3Ly7xCvkKxoXe1ImprFBr8b878kUjq98CYIh7PSlYD3BDA
3vqQWlLYhU+lkkvFSUIpkLgbsl9LgA==
=pjF+
-----END PGP SIGNATURE-----

--6zpuylmscbbwpcxd--

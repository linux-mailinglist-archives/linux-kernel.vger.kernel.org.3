Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57387588769
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiHCGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:34:04 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D554C9B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:33:59 -0700 (PDT)
Received: from [192.168.192.146] (port=55826 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oJ7wm-0000Oz-EM; Wed, 03 Aug 2022 08:33:38 +0200
Date:   Wed, 3 Aug 2022 08:33:35 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: add firmware dependency
Message-ID: <YuoWvwUer1bF0BtQ@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YukkBu3TNODO3or9@nx64de-df6d00>
 <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
 <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
 <YulcdKfhA8dPQ78s@nx64de-df6d00>
 <YuoQ37PIKzWO1zIY@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BNbrgnEDe9bruiv0"
Content-Disposition: inline
In-Reply-To: <YuoQ37PIKzWO1zIY@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BNbrgnEDe9bruiv0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2022 at 08:08:31AM +0200, Greg KH wrote:
> This looks good, and I'll apply it after 5.20-rc1 is out,

I didn=E2=80=99t Cc stable since the =E2=80=9CSubmitting patches=E2=80=9D g=
uide says it=E2=80=99s for
=E2=80=9Csevere bugs=E2=80=9D, but would it be possible to backport the pat=
ch to the
older kernels?

> but you might want to send a follow-on patch that removes the hard-coded
> string in 2 places in the driver, and just puts it into a single define
> somewhere, to make it a bit easier over time.

Good idea, will do so. I didn=E2=80=99t check if the filename is already us=
ed.
Would something like =E2=80=9Cthis patch depends on patch=E2=80=A6=E2=80=9D=
 (again from the
guide) be enough (assuming I will send the new patch before this one
is applied)?

--=20
Grzegorz Szymaszek

--BNbrgnEDe9bruiv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZT55kPBhnB69hD4ZeE9lGUIcpz4FAmLqFr4ACgkQeE9lGUIc
pz4PAg/7B1xc/lVHAuVd9qvRqvKG3z4y6TEYCKM6hdm6sIphbPtuzE/Q6pIkYbBO
X8iw6++zOMfQtn1ioI3GeiuUpuJXRhuk6IqxVVbZDuMvY9wB5vL5Dv9tSGEgHs91
SqTPb2Ie4euU6p4eEdFZ/Yog2gAJ9+7n+ItfD0RtcaOKYKDlonjKEh+Zbfx4TQP/
0lq200J2HcigAJ4/R909bjWMHesnA7f2PgVUlkxZNKnWt6YebD0Pgg7/Vmyn0wYm
3iSxRpiB1MoovwI7uYzAXZWLk1SMkEIx5C/mLlqtVTeXNYbo1ZZV2z2QrxL7HCNy
JebbV5OOoDwnr+MjpjmtsTwDxOIREPviwZ7KNKzkUX9Lpw3yBLlFf4b2RF6j+Lp8
Q/D4wvbdS3nViH9TlPTGOsLpXuWa1FFOSzHbhjVsqZwrDESOSIg1/BT1bKsYuCMR
gveZq/+b1MYYUeKlpo9Px4ll+XYryusexLfvTI62uESf2LHmZBsaSqQXwYq/uSdG
mDELZUlb8TD/JUYbtx7CjdMeK7gLPjy3nvQ9SpapVWDkEkpa53xwWXnvRDglNalB
iuL2CEH6z6zY2MJvxSHGXg48pUjGZLPkB2aCh5PXSqhAddKv+0q52f1izU1vHFhH
Q03ymY5rDn4cYvYZ4BInU3Iahs7h7sV2ddCDKiGzu8YfTZ/RVJM=
=qW8y
-----END PGP SIGNATURE-----

--BNbrgnEDe9bruiv0--

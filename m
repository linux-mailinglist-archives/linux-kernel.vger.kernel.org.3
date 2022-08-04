Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1C58A33D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiHDWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiHDWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:23:30 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5FA268
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:23:28 -0700 (PDT)
Received: from [192.168.192.146] (port=40640 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oJjFK-0001KU-Aw; Fri, 05 Aug 2022 00:23:14 +0200
Date:   Fri, 5 Aug 2022 00:23:12 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: r8188eu: set firmware path in a macro
Message-ID: <YuxG0OImQ1i0EOFD@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YuoQ37PIKzWO1zIY@kroah.com>
 <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
 <c3b30433-7231-6ebb-b0ea-44e760c4af69@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdK8tUR/DAUq3A6F"
Content-Disposition: inline
In-Reply-To: <c3b30433-7231-6ebb-b0ea-44e760c4af69@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wdK8tUR/DAUq3A6F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2022 at 10:11:58PM +0200, Philipp Hortmann wrote:
> On 8/4/22 00:28, Grzegorz Szymaszek wrote:
> > diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/stagin=
g/r8188eu/os_dep/os_intfs.c
> > -%<-
> > -MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> > +MODULE_FIRMWARE(FW_RTL8188EU);
>=20
>=20
> It failed to apply your patch as the following line:
> MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
> is not in the repo. Inserted line in my repo to apply patch.

I=E2=80=99m sorry, I didn=E2=80=99t add the base tree reference. Right now,=
 git
format-patch generates the following:

    base-commit: 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
    prerequisite-patch-id: 79964bd0bcd260f1df53830a81e009c34993ee6f

The prerequisite patch is available at
<https://lore.kernel.org/lkml/YulcdKfhA8dPQ78s@nx64de-df6d00/>.

> Why is the coverletter missing?

I didn=E2=80=99t think it would be necessary, since the patches are quite
simple and there are just three of them. Again, I=E2=80=99m sorry, I don=E2=
=80=99t want
to make it harder for anyone to review my patches. Hopefully I will
learn more of the kernel development practises without wasting too much
time of patch reviewers.

Should I send an improved (with the base tree reference and with a short
cover letter) patch series?

> Tested all three patches.

Thanks!

--wdK8tUR/DAUq3A6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZT55kPBhnB69hD4ZeE9lGUIcpz4FAmLsRtAACgkQeE9lGUIc
pz4Peg//URhtbr9bi8fDPTiZ+Y5t5NcBgTyII86gtqFjvtQRDGXzq3MU3ErjxvzO
D1NJtIBiF0QPVTlruIqdlN8dM2bY2VD6uKEW/ytZa0mnVVFLjfOjpMyfavXWq8DS
aVUF/RCTUhEvhYjabVnXy81hEo3SoSEkSkg3cNyINQDCHy33csELlVEuX/lIHcHx
B33aXdqEJboZfNJ23KIjmiXc/TJbHdxquDS1mjYJYSN5OOsM22eHDx0i4je+CX9N
u7owII2TN3XLwqUTRINHXVVIZpJKdlCPtFdL9wFWM4bvlaTCNpGozDFk9Rka540J
7g8j/2scF6XuZRxQP+23CPEZieDGXEfD9KT+pDLTO3lD1GRIgQapBRVg41f0ZD97
DOARmeMQ91prmqqtm1eirs3BbruieZ0zTy4PGp3NzYg47wFpxpcMnydvubUADGb5
2Paqm5lmbKNBILPn0jEBJiDPMpT9a9qUGT3V3hNBZXbi3j344HD1Y6R2IVAX8/Kx
CUtJ+f4O6A5dXekrgJSKgahO77yG50fA9KsffO/7Z0VnRVZVgsq+DF6oF4/mXCyG
nar7bcfFBL2dSw2kdDNTjGwXCj91WE9sbi71qLruLv9DVWZV/sTKpza6AT9qJgc1
rQ8kCVdapDVtNW1jfJJnhhyi6YQkUXGQgzzPrtLxwHRad0mQMyY=
=XvEL
-----END PGP SIGNATURE-----

--wdK8tUR/DAUq3A6F--

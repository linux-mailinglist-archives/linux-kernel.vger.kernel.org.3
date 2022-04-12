Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A806C4FD916
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiDLInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357130AbiDLHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:39:48 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 3FCABE0E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:12:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649747551; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=NgB4J145WK0eAdmQZ6KKPhAtsa67dfOsSoag6jWRVUs=; b=WyZ1cjrgvT+a9SnTjRln3YU/+bW/OXnDRD/YbS/+C0sMhK9jRhu+HjOy14FiUROYdNetwI6k
 q8t8GyzU6wi9pEAohN6XPQbW/BkeHjJfwoJ+v3c4tZxq3UtsxD/2OzKroJdUypqdkVShPEQ5
 7EcjEcJfuPoDjGilvB33ll5Zo1Ef3CxF1QssEbVTFcC1U9PKaM7gUxefDalXhAA8EcI3JTO0
 lEIonQcWN3O7SIDVqiG49PeyLMjvi/olxX9EJnw7nkFcUM8wVVhL/s/JskK+gKItmf+QTCUi
 NcnZKr5f5wP0ikBSS+XudMnyR+5C55n1hdHNuf0EDZbZIDZOGPfn1A==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (186-250-90-1.mhnet.com.br [186.250.90.1]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6255265d77e17d301dacc649 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 12 Apr 2022 07:12:29 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 12 Apr 2022 04:12:19 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Cc:     Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 0/3] staging: vme: Restructuring menuconfig and tree
Message-ID: <20220412071219.rapvtaxvoz2yerr5@AN5Bruno>
References: <cover.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a4cxoghgp7wwa5tg"
Content-Disposition: inline
In-Reply-To: <cover.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4cxoghgp7wwa5tg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please, disconsider some small errors in the commit message. I have sent
the patch files generated befor updating some information, so two of the
patches will be updated

On Tue, Apr 12, 2022 at 03:53:46AM -0300, Bruno Moreira-Guedes wrote:
> This patch series modify the vme_user driver's place in
> menuconfig (1/3), fixes a missing `depends on` line in a Kconfig file
> (2/3), and rearrages the directory tree for the driver allowing a more
> straightforward comprehension of its contents (3/3).
>=20
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
>=20
> Bruno Moreira-Guedes (3):
>   staging: vme: Adjusted VME_USER in Kconfig
This is fine as far as I noticed.

>   staging: vme: Fix missing `depends on` at KConfig
This one refers to VME_BRIDGE somewhere, when it's actually VME_BUS.
I'll fix it.

>   staging: vme: "drivers/staging/vme" tree cleanup
Some changes aren't properly mentioned in the commit message here.

>=20
>  MAINTAINERS                                          | 2 +-
I missed to mention this update on MAINTAINERS, due to changes in the
directory structure.

>  drivers/staging/Kconfig                              | 2 ++
>  drivers/staging/Makefile                             | 2 +-
>  drivers/staging/vme/Makefile                         | 2 --
>  drivers/staging/{vme/devices =3D> vme_user}/Kconfig    | 2 +-
>  drivers/staging/{vme/devices =3D> vme_user}/Makefile   | 0
>  drivers/staging/{vme/devices =3D> vme_user}/vme_user.c | 0
>  drivers/staging/{vme/devices =3D> vme_user}/vme_user.h | 0
>  drivers/vme/Kconfig                                  | 2 --
>  9 files changed, 5 insertions(+), 7 deletions(-)
>  delete mode 100644 drivers/staging/vme/Makefile
>  rename drivers/staging/{vme/devices =3D> vme_user}/Kconfig (93%)
>  rename drivers/staging/{vme/devices =3D> vme_user}/Makefile (100%)
>  rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.c (100%)
>  rename drivers/staging/{vme/devices =3D> vme_user}/vme_user.h (100%)
>=20
> --=20
> 2.35.1
>=20


--a4cxoghgp7wwa5tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYlUmUwAKCRAZtd3tyEY2
kpYTAP4veEOxVUWkbDbgVB46nEao+xSYla9M8a2WC697U2jzeAEAsCrz3rvRG13O
Eg2WgitpLBPqjykBczHhrBWvpfEIVgo=
=iBz5
-----END PGP SIGNATURE-----

--a4cxoghgp7wwa5tg--

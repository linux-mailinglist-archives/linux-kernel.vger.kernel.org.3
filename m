Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07EE53D43E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349886AbiFDBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiFDBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:18:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41053E1B;
        Fri,  3 Jun 2022 18:18:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LFMMk34Q5z4xYV;
        Sat,  4 Jun 2022 11:18:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654305523;
        bh=mXuKRdKfijIzRzaEN4JNlry2c0zH5KlWPytNA/QXa7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iZPeY7q2FSZ8BM9BXes8lJV3gdXJEQs64jUkQ5L+VYdQciqm4bsU22AQZPNBtD0hy
         OGaqhs5TRr++9qwOKXFkQX4O4UHEMn7TIGhii2ITrfTynWfIWgELEvNO61byi0vM+x
         cdZmHNZM7H6xn8BeDgE/PHvKPBoKzKnO+IlsHhzwIta1r8lFw3lm+caRlSOSNN7t2d
         6Te7fhNYuf58+FLMegPSAnXLsmb2Wg0LC6FztOmoMQOLIOY0oH5QvkRU8GUUBUXwyO
         IJEE4R79XH6fMl0O7xTmJVCs+MdyCpsRTq8VNKIIp1RLjmC5ACxgyVyeB3n6QfGS1U
         lS1542SLI/9GQ==
Date:   Sat, 4 Jun 2022 11:18:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <20220604111841.3887bf65@canb.auug.org.au>
In-Reply-To: <20220523184254.4e657cd1@canb.auug.org.au>
References: <20220426152739.62f6836e@canb.auug.org.au>
        <20220523184254.4e657cd1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7HLKc5PN4H6iFgwkQ5KSmB+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7HLKc5PN4H6iFgwkQ5KSmB+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 May 2022 18:42:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 26 Apr 2022 15:27:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the extcon tree got a conflict in:
> >=20
> >   drivers/usb/dwc3/drd.c
> >=20
> > between commit:
> >=20
> >   0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present")
> >=20
> > from the usb tree and commit:
> >=20
> >   88490c7f43c4 ("extcon: Fix extcon_get_extcon_dev() error handling") =
=20
>=20
> This is now commit
>=20
>   58e4a2d27d32 ("extcon: Fix extcon_get_extcon_dev() error handling")
>=20
> > from the extcon tree.
> >=20
> > I fixed it up (the former moved the code modified by the latter, so I
> > used the former version of this files and added the following merge fix
> > patch) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be
> > mentioned to your upstream maintainer when your tree is submitted for
> > merging.  You may also want to consider cooperating with the maintainer
> > of the conflicting tree to minimise any particularly complex conflicts.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 26 Apr 2022 15:24:04 +1000
> > Subject: [PATCH] fixup for "usb: dwc3: Don't switch OTG -> peripheral i=
f extcon is present"
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/usb/dwc3/core.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 2345a54b848b..950e238c65bf 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1649,13 +1649,8 @@ static struct extcon_dev *dwc3_get_extcon(struct=
 dwc3 *dwc)
> >  	 * This device property is for kernel internal use only and
> >  	 * is expected to be set by the glue code.
> >  	 */
> > -	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=
=3D 0) {
> > -		edev =3D extcon_get_extcon_dev(name);
> > -		if (!edev)
> > -			return ERR_PTR(-EPROBE_DEFER);
> > -
> > -		return edev;
> > -	}
> > +	if (device_property_read_string(dev, "linux,extcon-name", &name) =3D=
=3D 0)
> > +		return extcon_get_extcon_dev(name);
> > =20
> >  	/*
> >  	 * Try to get an extcon device from the USB PHY controller's "port"
> > --=20
> > 2.35.1 =20
>=20
> This is now a conflict between the char-misc tree and the usb tree.

This merge resolution seems to have been lost somewhere along the way
:-(

--=20
Cheers,
Stephen Rothwell

--Sig_/7HLKc5PN4H6iFgwkQ5KSmB+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKasvEACgkQAVBC80lX
0Gzpkwf+Jb3vuFIlxfV6SflX4Oc3rPZJnUkvE0V+y/VlJVZxD0vQYkxR7FmQkHTB
y8yTApqaLJKqFsJoz8JYxXoDcfzobO47XGtFd1OHk5RUiiEl+nvTANSx9S3Hu9i1
9tf5sbA9S7Rb5g5HHQsTGftvQI7fKAcbEF71LUhsIoAJC0Tie9ZWh7+5IfaPWuac
9MpOAAMYw6dLR64EViM89QlxrV4/QFIuqPDAwsYevSKC7ETV0iBAGwFTKeykBmcQ
T5kcmMks+BrIvoB4q6/DRIDB6ZJjFdg6doGMkEkcssEijeEKMrbI6iQZfPCOmDQ0
Q3ZUcv4e7LjDJoxNxuzGS6dNsgXBAg==
=Gm3e
-----END PGP SIGNATURE-----

--Sig_/7HLKc5PN4H6iFgwkQ5KSmB+--

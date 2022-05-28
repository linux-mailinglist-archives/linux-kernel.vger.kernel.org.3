Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A2536969
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355277AbiE1A35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 20:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiE1A3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 20:29:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB02657D;
        Fri, 27 May 2022 17:29:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L92cX2tLZz4xYY;
        Sat, 28 May 2022 10:29:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653697790;
        bh=pRpgD/4/6Dx9KRI+YBfBGGJDpPSQXh8RoL5F36a6M4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6GZgudst7usRBgSMLQrPXpN4xdCxRS43v/euK55KzTUU/fnFJ8c4K5Nw1hHCps+O
         xs1DX+f5wL2qONYtyu/7zCXLaeZTVyquBOwpSV4Maky5yoYaD3dthSMPUHhJ84WV7D
         IB4o5lxG8rS4MTOn5qllgMB102bPXgNiydFyGsOmp7vNYHI5+M7EREiERE+S7ZK/eT
         aWQ+iCI8r650/xYwLbLNLF0KDldsB8ra54jxTBnwXRq/liFV3Ukceafo3espJBWLzX
         UOiDBB58NwLzff8xu+ZKaFO043Bt85rxFopv2Xsz+uELPmYMpNIR7uaN7kP7EJScXm
         ct2CkPVdE8+gw==
Date:   Sat, 28 May 2022 10:29:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20220528102946.341c3bbb@canb.auug.org.au>
In-Reply-To: <DM4PR84MB19271EE54D445DD8F1DB047988D89@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220527103916.52768f74@canb.auug.org.au>
        <DM4PR84MB19271EE54D445DD8F1DB047988D89@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r.w0xiWy.JxodZayFIJuOyq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r.w0xiWy.JxodZayFIJuOyq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Fri, 27 May 2022 15:38:56 +0000 "Hawkins, Nick" <nick.hawkins@hpe.com> w=
rote:
>
> > Today's linux-next merge of the arm-soc tree got a conflict in: =20
> >
> >   drivers/clocksource/Makefile =20
> >
> > between commit: =20
> >
> >   c92e7ef16400 ("clocksource/drivers: Add a goldfish-timer clocksource"=
) =20
> >
> > from Linus' tree and commit: =20
> >
> >   5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer") =20
> >
> > from the arm-soc tree. =20
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise
> > any particularly complex conflicts. =20
>=20
> Hi Stephen,
>=20
> Thank you for resolving the merge issue. I am relatively new to this
> process.. Can you provide a link to where you were notified of the
> merge conflict?

The purpose of linux-next (which is my project) is integration testing,
so I spend all day merging the branches that Linus will merge during
the merge window. The conflict appeared when I merged the arm-soc tree
yesterday.

--=20
Cheers,
Stephen Rothwell

--Sig_/r.w0xiWy.JxodZayFIJuOyq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKRbPoACgkQAVBC80lX
0GztrQf9EHJ6V/17kpTTtWpsyupFbpYQUIwepSgR2WwG9yYJn7c1c2QeNVG9sDDj
Cv+BPS2fDeWzARwjwkyAs6NzgF6OvYWYxwqGipMmrtCpXOlL51+6oEt+BA3v+qhI
mmf2tUlMj+1TGyetv0OpHSvtn/AkoEFb05L4pBQMG5jipn9VBg9T3UBtQJiWwZaV
D5ytgeHstGHdvcek2ipxFjcSOzeu3CWbTuYv2FfK4UY5c8X9ouDU8XV6c4ziatX6
WMs313CbJmXQJTbxERF7xIdsEu92rSEnR3Ub2xOUmAhFgRnSbx/gDoVGFEqD0VDL
ufPgp530f7DkFWuLd9imgJPfrsWaWQ==
=b5kA
-----END PGP SIGNATURE-----

--Sig_/r.w0xiWy.JxodZayFIJuOyq--

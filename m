Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84C4DD53C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiCRHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiCRHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:30:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716252BAE52;
        Fri, 18 Mar 2022 00:28:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKbGv6KwFz4xcj;
        Fri, 18 Mar 2022 18:28:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647588536;
        bh=3u1+m7ZgtZQn10YgN4bzgjMZhFt5PV60OvPyCDkmzmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ES0e7aif1Nsi7gAL8O5tZvmb7UCFAQ5uMIEFW/AKjET26GOf/uM6L7OrxARN9KXRD
         /pkYwvnJonEssBSbLfNTYSxzhjbuZhnQ1GwIaTZCld3tC0v04fFJ9knL05qxSVq+CR
         Pug0ZbaahYeLShSBfdllgd1mdARGujZoUSU9hGPoHKrxSTCvHTsyKd0nuScXbu0Oe+
         UN4DeO4GVkW1nOJTiWSnBF8FQpkGRhEYyy3fGaWOZhvHU8CqPYKWsTywJaj2NZU7Zm
         FXzxLPlHQtbE1qJqE+OaZ5EwS8Js4HqnFdBdRCYKJSWQhvqq5pxynf72OEKFagaC68
         l0/bFrE3FS8Qg==
Date:   Fri, 18 Mar 2022 18:28:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi-fixes tree
Message-ID: <20220318182855.301fd666@canb.auug.org.au>
In-Reply-To: <20220120142103.6a72ec62@canb.auug.org.au>
References: <20211015211423.2d8d3c0b@canb.auug.org.au>
        <20220120142103.6a72ec62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q_Oeag0ph=YSCgpLrzPoYn.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q_Oeag0ph=YSCgpLrzPoYn.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jan 2022 14:21:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> On Fri, 15 Oct 2021 21:14:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > After merging the spi-fixes tree, today's linux-next build (htmldocs)
> > produced this warning:
> >=20
> > include/linux/spi/spi.h:671: warning: Function parameter or member 'add=
_lock' not described in 'spi_controller'
> >=20
> > Introduced by commit
> >=20
> >   6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SPI b=
uses") =20
>=20
> I am still getting this warning.

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/q_Oeag0ph=YSCgpLrzPoYn.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI0NLcACgkQAVBC80lX
0Gzl3wf+JGaqndwVwoxDxBvXdnOK+IQzlDP3jEVO7G/fsJZYtOMAFpaWAg2901WN
13/EIWrgFue2muEVF5RbKlNtp8ivBLpMeXt4Vrr1K60JTbvfBaX0PA34/ReoGnBf
SNMobtAZE6Ec5D/I2hPpVDnRRVM4rcpHWjF5C2y4HRPVybwgc+8LLnj4UNzYawyu
LsASXK8ybd0s1IVA4x2svA9k3HQd7UeiAq5GoDlUU/dLpqufGnJo8R5nFFigZtYM
ec/Lxb91yH/V0dJnK3CfJ7OVGGILnsnjyLm2ib5LofXDVVsRYO/Ns0WkW62FI4fX
KhPCpIb+kuSuJM9gZXewUyWE3S0WAQ==
=4Omq
-----END PGP SIGNATURE-----

--Sig_/q_Oeag0ph=YSCgpLrzPoYn.--

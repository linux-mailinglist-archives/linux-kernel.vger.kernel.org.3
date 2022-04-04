Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3D4F0DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377008AbiDDDaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiDDDaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:30:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC137BFA;
        Sun,  3 Apr 2022 20:28:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWx7B1H1lz4xLQ;
        Mon,  4 Apr 2022 13:28:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649042886;
        bh=IU9VXgZhS6a57tjn9dGMAA5reHt/wqRjv2DuxlAsH6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+8bqtnkpldCMTZcLSqXg2VuNKEmXg/rYofO3pONSSNFeIOGo6ELeDABZ5Dbnxqtb
         fCzZrlv1Zn1KPc6tZ55e99jBDqgKPpjq/V3MX4ZD67unk9iBhRtoEI0E9DVBc23cKn
         ndrLnXTJ8mcpPgTBZ+0d9RXt3QZyauZtg/3YxbX5XOgWtdtstHIGrFJljfLkD43u21
         hfR8Tf1UrTV5brZKCC707a0EI6Tmg4/1niFSP35d6amHJLzDa4aBDpgUSiyTLnsFWU
         vrulsenDjt5qjJIGlLd9jIHb4t9DFMFFp4ITIeBx9E+S2yKab9x7ea0oyo3TfmjFm0
         aLZNBxGdPhyDg==
Date:   Mon, 4 Apr 2022 13:28:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi-fixes tree
Message-ID: <20220404132805.7c00d3e8@canb.auug.org.au>
In-Reply-To: <20220318182855.301fd666@canb.auug.org.au>
References: <20211015211423.2d8d3c0b@canb.auug.org.au>
        <20220120142103.6a72ec62@canb.auug.org.au>
        <20220318182855.301fd666@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DZgyKlHp7W0MfpaXXtNJqmM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DZgyKlHp7W0MfpaXXtNJqmM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 18 Mar 2022 18:28:55 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 20 Jan 2022 14:21:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Fri, 15 Oct 2021 21:14:23 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >=20
> > > After merging the spi-fixes tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > >=20
> > > include/linux/spi/spi.h:671: warning: Function parameter or member 'a=
dd_lock' not described in 'spi_controller'
> > >=20
> > > Introduced by commit
> > >=20
> > >   6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SPI=
 buses")   =20
> >=20
> > I am still getting this warning. =20
>=20
> I am still getting this warning.

Still there :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/DZgyKlHp7W0MfpaXXtNJqmM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKZcUACgkQAVBC80lX
0GxBBAf6A/v2eLXIO6JUgdkp+xS+XzYmCwSRLyNTKvEUsadDphxK8tWS6BwCk5Cw
+ud4T2ZeGSIovfBnL9rhgHiJ7Qq9AMn/6iELo21xotZr/HyBA/yn838mZcZeE6jE
a8AEN0jWE74cxL/qh3G3H7kRpW83WMYRp/Q4SHM+cQ1hf81pSA4XcJX7Fh8+dVRS
YxXBWQh5MxSoyNvj4nskWJSIZzq9L+TpMGcv+gomLD0028+KqHEt3fEoBqFKUxOv
N2xIlPcLXs2tmp69d4ze7YOJgwMdQMlPN483eg8TAtvO0tHis8m1J5oemlDZd87L
kYl/2vXT/3zUG9eXS0+I4Cb/v608Bw==
=HR45
-----END PGP SIGNATURE-----

--Sig_/DZgyKlHp7W0MfpaXXtNJqmM--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48687506499
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348879AbiDSGiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiDSGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:38:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53026102;
        Mon, 18 Apr 2022 23:35:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjDZW0YyVz4xL4;
        Tue, 19 Apr 2022 16:35:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650350131;
        bh=2zXchq3Iadr40nqLp4y+pqrHVMUGLqlr9RfOa1Sl3TM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i3mvc6PJhDqqjUk+mKQ4mN3oKUnUBR0rzeqaeiaukXmup/B6bDwZ0OwEbzN+13ju4
         sOYdYIs7Yb4ONU9FjSV4PKShseKk2ez/2IfCk4gHld30GzdcsPtB2iNLFT7/usgcvm
         k4vLjdCU04zJQvglCQL3eJcITV+8DXr/A92XQ2vhXOmEkCRO8Wa5DWD7qfmLU7pbcB
         ZXLaENY10PYQG2Q+Me9ftmD767fRvBgekjcfKKNJvLCRJ6PCF7mz2DsOzrAmfA7fuC
         bi+eFATLGZo3GwaU1/CBf64VdppGyo2Q6jxNW2BTHZRoq8+P9sQwrKyfbUAxE8k9F2
         051LPRe9kOhHw==
Date:   Tue, 19 Apr 2022 16:35:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tty tree
Message-ID: <20220419163530.616d1a7e@canb.auug.org.au>
In-Reply-To: <20220419163318.0682ffb8@canb.auug.org.au>
References: <20220419163318.0682ffb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6vauLnBhW0o0i/xOCoPqzbA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6vauLnBhW0o0i/xOCoPqzbA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 19 Apr 2022 16:33:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the tty tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> Documentation/driver-api/index.rst:14: WARNING: toctree contains referenc=
e to nonexisting document 'driver-api/tty'
>=20
> Introduced by commit
>=20
>   b96cd8b05ead ("Documentation: move tty to driver-api")

Also, this:

Documentation/driver-api/tty/index.rst: WARNING: document isn't included in=
 any toctree

--=20
Cheers,
Stephen Rothwell

--Sig_/6vauLnBhW0o0i/xOCoPqzbA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJeWDIACgkQAVBC80lX
0Gz76wf/SeNvHIHUg48cWyk8VCm6OMVaxi/m/rVwEav4W4lGkHbGTDwaSv/I6MXk
4xMU/IzdXMug5q5pdegzE9qfWNjTc8s2KJji7uiCi+V8y+MoJwaFiEKt81ctm833
pPieOAOR5nVn2kLtKj7m7qACnsI5KsXQspfhZkC8pNY7ONNfEQV1cCk5c3y5roHQ
FzuiPTDps5BBGlyaD8kQXg7+BV4S0J7umHo5yvzv7IKPn2vOyM49rM1MSMjuE9lG
XISG+XUwVibKAnepSee5PkF90fK6PkN/7mwIO09FohuvTA4adYzChi14fRi2kDQp
pQ6TcYqFC9+detIlS/EuEez36RZhDQ==
=bjIe
-----END PGP SIGNATURE-----

--Sig_/6vauLnBhW0o0i/xOCoPqzbA--

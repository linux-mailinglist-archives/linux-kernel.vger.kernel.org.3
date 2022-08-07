Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3A58BAC1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiHGMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiHGMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 08:03:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE4BF4B;
        Sun,  7 Aug 2022 05:02:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0ydT1Mp0z4x1J;
        Sun,  7 Aug 2022 22:02:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659873773;
        bh=Q1lRgU4YZaTZwaMMtMZs3R16yzS3InZ4D3mBFloYCW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D4zlPiwrX1ONKunBbnD2L2+kekAT4ouRWWTJnN0yRk9PbJD3tXqmKu3wugVmNSpQo
         0QIlmF4O9aTO/8NTgvzwWpJVhvpwWn0N94C6mdOEnrD1Ol1RFytIj39CT/oBlSKqIJ
         csrvt0NPiaMkhRUyj4223bqT/lH2jRfz3929ZM9yKxh3/Q9WViLX2Xyz8bZIxQUuTv
         vwJkBhutPzas5bYlBotSpDyDI03DCVyCQAmPy7m/TUCxAx6zcb/7/9VuACULd4b2ea
         AdkrhDylowrWBS02fNEH4yoVAgj5bYGtXXP/z72R/khNDP97tABTQCe0HzwNxxTUg5
         ub+/Unv7eyuEg==
Date:   Sun, 7 Aug 2022 22:02:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 28
Message-ID: <20220807220240.7ccec5de@canb.auug.org.au>
In-Reply-To: <YugAzWWl++ArhhPS@sirena.org.uk>
References: <20220728210236.76654a0e@canb.auug.org.au>
        <YugAzWWl++ArhhPS@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bTzDA883p2=0b2fGhwAZ6yF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bTzDA883p2=0b2fGhwAZ6yF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 1 Aug 2022 17:35:25 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 28, 2022 at 09:02:36PM +1000, Stephen Rothwell wrote:
>=20
> > News: the next linux-next release will be on Monday Aug 8th. =20
>=20
> I didn't notice this last week, I'll try to provide coverage for the
> remainder of this week, hopefully the merge window should help this go
> smoothly but no guarantees.

Thanks for throwing yourself on the grenade again :-)  I hope it wasn't
too onerous.  I was supposed to be absent in the second half of the
merge window.

I will be back on board tomorrow.
--=20
Cheers,
Stephen Rothwell

--Sig_/bTzDA883p2=0b2fGhwAZ6yF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLvqeEACgkQAVBC80lX
0Gzslwf/Tr8tNna7kN5ZPxAUzclXGjJPBzUO/jNKWVZSJYaIrItenosyi1TH+sXD
0sHIxOCL5MW1tlu+LHeAY9fAMfk9JsXpODmvLvxflOikRQvHW7uxJlS5SBbyf37N
DbpcnmDcmNRxb+gomOFMPupLgivN39nfZRjnPjB1mnluL2Z+rVF+2ouNF+lus5si
w9tglT/bz9rP6dZHA98wGpfDShigiQkPLXTRTk+tz15Fe6ba9HsrVDjJ43vmVGnD
p8GHmt+RkSDGiydUu6xd5NrcLqHGRJZa6qf48dxk3xdHKXgSGv0LfeNRAF/pLQc/
ioCUIQ/BazUe/05f8U0aLsFJp/9/ow==
=zbG1
-----END PGP SIGNATURE-----

--Sig_/bTzDA883p2=0b2fGhwAZ6yF--

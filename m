Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250DB46BC33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhLGNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhLGNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:14:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60109C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:11:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB174CE1AB3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5BC341C1;
        Tue,  7 Dec 2021 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638882666;
        bh=uv22WAK4++8AgdeRR8r3o5bfpFmLmJdCJoSGQg801rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEl7p5l/1EPmMPx0doRX4NaAnsWWOEWq9b69OMHfQaEq7YaLNMsZRxKbTBxtKeA+A
         o66lBeAomYI6oHP4viDMYbm5c5G726UqUtt3MaWKdtI6EOSOvuFFCVrpVDUhEimJ0+
         glhNAmqu+sykWBjBQcKBG8UT88DTPgsJfZffnRGtTjZvvQV6/xJMVa2nEPw1UHPnd4
         5U4UwCHo6mDdoqvbS3mdERJ8/Yv4o/JZDrpBBd2AyPzZFS0a8bCkbsX1MtGYRUn9bz
         eaVCwfGCGpaRSpufT7Opox+aAJBdjEJZqGTT1yeHmgLWzg/O6iIHlOzoLsprZCSkpP
         jAQ2FhTr6T3zQ==
Date:   Tue, 7 Dec 2021 13:11:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: rockchip_i2s_tdm.c:undefined reference to `clk_set_parent'
Message-ID: <Ya9dZiqbSPODo74p@sirena.org.uk>
References: <202112070621.TnLPiADU-lkp@intel.com>
 <13326272.At7iLaMNiz@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu7aYMSE//vud9rI"
Content-Disposition: inline
In-Reply-To: <13326272.At7iLaMNiz@archbook>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu7aYMSE//vud9rI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2021 at 12:32:52PM +0100, Nicolas Frattaroli wrote:

> So my question is: do I need to care about this? This hardware
> will never be used on MIPS, and a lot of other drivers (as seen in
> the errors snippet from the test robot) have the same issue, and
> the problem is most likely not in my driver but in that specific
> configuration's clock API implementation.

It's fine, in theory you should care and add suitable dependencies but
in practice it's not bothering anyone and at this point I'd rather see
this sorted on the MIPS side, supporting things like this is just
ongoing hassle.

--Bu7aYMSE//vud9rI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvXWUACgkQJNaLcl1U
h9DDtQf/QZ2O0UkGXzLJfaag+pGtz/017d0AGj7BA0ugsyy0dB8xIlUUzPZdCCsY
ugIVwiX0znypgeZ236g4K4X+YIstYIFVjAKxQ9WftgTGS8JJfw3I0E2ZI0N8SHHm
sPoS6TismjwwcSg0YtYB2bXzgq/Ld3xqfVzvLqwY+KHHqOX8EomVXJ12XqDIyQc+
nUaNnHWO+++ueuqtdumGG6oi1sleixFujOFwySkM/fno1iXWNH3M1ONHepaikfjG
0fI1VpbBYBABWz5sTEeekLGM6T9Od24O83G7Nnth1FN6bhWuD41iqjgdVtrb1TfD
ZN7qK1WrUp+cczm4Gutn8Jl6FMUuAw==
=08a9
-----END PGP SIGNATURE-----

--Bu7aYMSE//vud9rI--

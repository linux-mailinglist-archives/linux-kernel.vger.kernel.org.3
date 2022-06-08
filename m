Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3B542D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiFHKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiFHKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:18:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70C176D4A;
        Wed,  8 Jun 2022 03:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01750B823D3;
        Wed,  8 Jun 2022 10:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B527FC34116;
        Wed,  8 Jun 2022 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654682758;
        bh=FwNZvl9ZO6UuIFAaASxZNzGjXDaKqZpcWqC6b/SCHbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3Kmgk/eAS9sOq3xzOlXZpAlmncmYgIskrBMc49UsSadUAdUB4aMUdIpmlvgAUbna
         gJIK7x0GiPQu/ATgDQ1KnKnxAi1TG1oIOn7p7riniF9mj8xe98II5eHWFAfJmojeVS
         unCZzIefG2jegmFhhMbMH6w8cU4SSoQksXSIEcJV9TcKtagHBoBuV0wTuNSqlYyb79
         kHcNUopRdZaoeFaMHV/d/4EYwAxHgPfLGjmW34+vYGzPn9qs2vQSKv8lOjcgrgV8O2
         K168o/lr3KJogjNFTM0mn/WjgETjCd6jW7BM/zDPpIm9YQaiQZfXfWbBhMKzgkT3TY
         I/YFkNK1kKIHg==
Date:   Wed, 8 Jun 2022 11:05:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Message-ID: <YqB0gg6YIYmgCK7A@sirena.org.uk>
References: <20220608143038.0ef8365b@canb.auug.org.au>
 <20220608093052.34e919e3@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="seqhKQrdRmr5rLQD"
Content-Disposition: inline
In-Reply-To: <20220608093052.34e919e3@erd992>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--seqhKQrdRmr5rLQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 09:30:52AM +0200, David Jander wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> >=20
> > include/linux/spi/spi.h:82: warning: Function parameter or member 'sync=
p' not described in 'spi_statistics'
> > include/linux/spi/spi.h:213: warning: Function parameter or member 'pcp=
u_statistics' not described in 'spi_device'
> > include/linux/spi/spi.h:676: warning: Function parameter or member 'pcp=
u_statistics' not described in 'spi_controller'

> > Introduced by commit

> >   6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")

> This is my fault. @Mark: Should/must I do something about this now that it
> already hit the next tree? How to proceed?

It'd be great if you could send an incremental fix adding the
appropriate documentation.

--seqhKQrdRmr5rLQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKgdIEACgkQJNaLcl1U
h9ACdAf/QfRQTu4Ovpx7p9ruUDNrBS5vF0tUmJeLChIHg927bDSRMbaeXVP1Tyyf
Atag7XRBFj9/Kd6aIfrbGEeA2ZU4VIY5kVsYOetyWaJVRav14M1rdRupZpodBIng
pd4Yu4xThdqKgDJXiarCGHv8cBgK+2FqT02cg0gwJ2ARbHjwbGhOYtZBLvBSeH1F
/Uje4vH2pTYVauktm5/OLWsdblZ0B1lKJOYY9jZipbXy2AfcbVeM+SfKN1jr57rB
SpR/pDpUJMr+cTW4dkZOpDeMMUxgARg+6UxCfxAWuqHDRboYVau2uN/1jf65HLZ7
apyA9zuCRkTcAqUknO7yFOIDC/V0CA==
=SD82
-----END PGP SIGNATURE-----

--seqhKQrdRmr5rLQD--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4C576150
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiGOM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiGOM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:28:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6187D10BB;
        Fri, 15 Jul 2022 05:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01048B82BE8;
        Fri, 15 Jul 2022 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD41C34115;
        Fri, 15 Jul 2022 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657888112;
        bh=1WQoyyAkCDerK4uyFTm/h5bbBttlBNT3gkioRS+yT4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtQSWdXWimjAGo9or4zJmG2+2tsw4HN0iHXYVpGNl89aAImmBwL64ArkXHldkKw/I
         bcGKV1BefgjFF++jixQWnTgaMAnTUx8lGwKv3eYOFFrIY+GqVy/tGdfDlatSjypDVc
         +vNamPpzPcODKA8y0sUT7EAT3OscJ3cLneHRmJW1uRzXNbqIsz+QM4pHW49ed/CAIc
         OzrC8zBQmDWAwzBwC+DVCMcnKnbGza6fopTQEAf2C671TLy8PZ8J/rxRHDMRNvH8XG
         MAs5rUAFiO6gPN0z/i+rNACDwsqCh+Rd5zXlYGkjChseWipB5euOtoGEXkSYm3sJNc
         QA2OvVZlCct8g==
Date:   Fri, 15 Jul 2022 13:28:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <YtFdarmJKQbV2Wz8@sirena.org.uk>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1g8PH4M2W7Z50U@sirena.org.uk>
 <CA+G9fYu7mJ6X3_xhboODP_cjABE4QTJCON_NMduQ60x4Z7N78Q@mail.gmail.com>
 <Ys/9TSV5muvKXN6W@FVFF77S0Q05N>
 <YtABEDylGJkYLXrJ@sirena.org.uk>
 <YtASzuHo1MXe5LJH@FVFF77S0Q05N.cambridge.arm.com>
 <YtAU1AHLLgK/v7RP@FVFF77S0Q05N.cambridge.arm.com>
 <YtAcW9DRrdun/pW9@FVFF77S0Q05N.cambridge.arm.com>
 <CA+G9fYvmrraS7ANdRA0XDoM-u-oVvcHFWsrFuBya9Es_WN3fkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1Sr8Wku87tqrIFD"
Content-Disposition: inline
In-Reply-To: <CA+G9fYvmrraS7ANdRA0XDoM-u-oVvcHFWsrFuBya9Es_WN3fkw@mail.gmail.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1Sr8Wku87tqrIFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 07:35:50PM +0530, Naresh Kamboju wrote:
> On Thu, 14 Jul 2022 at 19:09, Mark Rutland <mark.rutland@arm.com> wrote:

> > When *only* using the initial loading into memory, that blows up in sta=
ckdepot
> > and with a subsequent bogus pointer dereference (full log below), and w=
hen
> > loaded via semihosting that just works. Note that my kernel is based on=
 the
> > arm64 for-next/core branch, which itself is based on v5.19-rc3.

> > Naresh, please can you fix your boot flow before reporting any further =
issues?
>=20
> Yes.

If you don't *need* to use u-boot for any reason then it might be worth
looking into using EDK2 instead, it will dynamically place loaded images
so you don't need to worry about size issues unless you actually run out
of memory which is a whole other problem.

--H1Sr8Wku87tqrIFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRXWkACgkQJNaLcl1U
h9Dsggf8CuVIwr2J6sCd8w1lFG4bdwpcsGZVeZQTGRFo7mhscUcQA/DVbERphMa5
rm/R+juwkEXldiHj1CHQvCBsNsW3a8WuDVVx5BWgiSuwFmKUmr95T4Sj2mNsCXPb
T3qKNT9Ub1TA/h1zIpo53co/2p4kl+BaQO9cQm64TTuP4ACX+X8wH7q8oSp/kC2n
/Xux0I+gA/BX2U6ppSGaIdBvck/hl5kF4NSaMx6kcojedaX/lpQjdZxUTOsz6rVj
DfJ7E2nB38IVH+QJor1+274rd+zPrUNaHJRhKmuEtLMQb+iiSvRBq7se5lHVHFen
JxJtedtwJe2QJQkEjSvrSoH6dM3/6Q==
=hWus
-----END PGP SIGNATURE-----

--H1Sr8Wku87tqrIFD--

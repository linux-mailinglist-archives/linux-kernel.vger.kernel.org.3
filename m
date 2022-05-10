Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42065215B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiEJMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiEJMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E976B53A66
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CE860F9F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB194C385A6;
        Tue, 10 May 2022 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652186616;
        bh=s/mAEt/fNJuYBi9PxLxEPoLoE9Kn71fL3QmsQoGyaQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pytcRY2yAffoocZIQaIkcuQEyxYJ71aAbnQy3cA3Hw7qdmCFuhc7LrBNVbXa+3AFO
         dUhGQgOT6ujliD70obiDthtkD/eLQAfG+TMbpU8FpyZXll7YP9doaJoQCL0Xh7eay0
         GDpzbJqB7xygmERsrrN00DmFHcyJUzNL3IwIbnRIXQ9liRAPRMkS5jX1sfbsvhIola
         DfQKdUiliP2W5yi/M+TVCozpU4+AR3XpkLyXg9x/g+oZ6I/hThxNCObdCFCNRn0xo1
         NU43UytQKi7qibCAenYFQ1ENzfwVV6iAMewMtwLQDwBLG7NGNSaP8nWkeQ9zpBPCXP
         kCLeAKBM1IJXA==
Date:   Tue, 10 May 2022 13:43:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
Message-ID: <Ynpd9DJ2SyC1Fi+a@sirena.org.uk>
References: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
 <20220510091502.GA27219@willie-the-truck>
 <CAMuHMdVyjZzuNTrinRddt=nRDU-=tb+vgweemaOpG6QWsKC=JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1KgG4KnrE+73JjdD"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVyjZzuNTrinRddt=nRDU-=tb+vgweemaOpG6QWsKC=JQ@mail.gmail.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1KgG4KnrE+73JjdD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2022 at 11:20:40AM +0200, Geert Uytterhoeven wrote:
> On Tue, May 10, 2022 at 11:15 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, May 09, 2022 at 03:40:30PM +0200, Geert Uytterhoeven wrote:

> > > +       The Scalable Matrix Extension (SME) is an ARMv9-A extension to the
> > > +       AArch64 execution state which utilises a substantial subset of the
> > > +       SVE instruction set, together with the addition of new architectural

> > Why is this useful information? The v9 vs v8 distinction is purely a

> Because I tend to disable support for extensions that are not present
> in Renesas SoCs in the (local) renesas_defconfig.
> If it's ARMv9, I know it's not present in e.g. Cortex-A57 or A-76.

Like Will says the versioning information is a shaky way of figuring
that out, especially with a feature like SME which is intended to be
totally optional.  Even once you have v9 systems you're still going to
need to look at the specific systems to figure out what's implemented in
your specific silicon.

> > marketing thing, so I'd be _very_ wary of drawing any technical conclusions
> > based on that, especially as Arm have a track record for "backporting"
> > features into older CPUs if there is demand for it. Do you know what the
> > toolchains have done here? (i.e. is there march=armv9-a or can you do
> > march=armv8-a+sme or something else?).

> I have no idea.  This option doesn't seem to control any compiler
> flags?

GCC does have armv9-a, not cheked clang.

--1KgG4KnrE+73JjdD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6XfMACgkQJNaLcl1U
h9Dt1gf+LDle+kxer7rZr20WqZ37pszk/ADamzmFdn2/06/XQmxjYt/dU5qo35mT
DxMNpXxMWoVm4fcpEIsq0lhmyACZxn1DN17jBS3XZm17IIy/2YmOAHGH1kxPdK7Z
kgeadTb3odAlF6fjLyPW23qQZ0/rFF+VFDUFhGW9bl85uHsqVDw4VfCfjAqPQFwN
bs4HalMOw4PQIiem2pvxs21M1j1ynRw1Zl+oRJ7/JongqMcwDkJS0Hd/3DkyHK0N
zlA4Pb/XCq2bwO5PPP7DSrsss7WffEOYL+UpzXI63sPyUOJ8om+0929peDXEQhsD
G6BA05UwUW+KZ2LvD8Vtv3Jw1rFDmw==
=UWjT
-----END PGP SIGNATURE-----

--1KgG4KnrE+73JjdD--

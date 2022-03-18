Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4C4DDD2B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiCRPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbiCRPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:43:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882572261E1;
        Fri, 18 Mar 2022 08:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B02B82475;
        Fri, 18 Mar 2022 15:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD0FC340E8;
        Fri, 18 Mar 2022 15:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647618098;
        bh=y7pnJNbFCISqDtvibqXgoROt9qimMw/fpAcyD/5DS0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoifjaqeSa0nd9QsqzAbP2GUAew9/ZN+TkGuSFrxCMVuw9E34BArB3I+gKEs1SgfL
         TfSL3PJgIloY9ADerEFQFsryqdVfr6QQH44C72OndtONtXm1/ohI9KJaxSYTXfABw+
         CZA5OGULoyfDz5rMjyKKtuTRfpPwdLlpJGhkOxaEYzLwojqcIDaAYJxI+JfVuejrYK
         O6FJqzw+PR24+C1MkCiHiqnFLdNfQW6+TD9FDM1cuwxJeWeo/b0Wb5U31QvNaNa3dI
         WJ+jDBQ2TxbJT1wILhTUkMiKtJmy+j/7AF2ZpyFDKl/N5BQcVrP3pepxk+f/GuQMUk
         9Mm5m2tX3GMkg==
Date:   Fri, 18 Mar 2022 15:41:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [broonie-misc:arm64-sysreg-gen 6/9]
 arch/arm64/include/asm/sysreg.h:125:10: fatal error:
 'generated/asm/sysreg.h' file not found
Message-ID: <YjSoLTbVBZTNS0tL@sirena.org.uk>
References: <202203160508.k7vz4ZxC-lkp@intel.com>
 <YjIYxWkVzT0/XYf+@sirena.org.uk>
 <CAK7LNASsiYHK3QW5aOg016_XwD-MmOOcJ6UA=f95BxEZ-p+gSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Na26+gSFr2zhmOGw"
Content-Disposition: inline
In-Reply-To: <CAK7LNASsiYHK3QW5aOg016_XwD-MmOOcJ6UA=f95BxEZ-p+gSw@mail.gmail.com>
X-Cookie: laser, n.:
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Na26+gSFr2zhmOGw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 18, 2022 at 02:15:07PM +0900, Masahiro Yamada wrote:
> On Thu, Mar 17, 2022 at 2:05 AM Mark Brown <broonie@kernel.org> wrote:

> > but that's only passed to CC (at least for bounds.s) via an
> > -I./arch/arm64/include/generated so won't be found with the generated/
> > prefix.  While this can be avoided by renaming the header and not
> > referencing it with the prefix I do see a bunch of other headers
> > throughout the tree being included with an explicit generated/ prefix so
> > I'm not sure this is what's supposed to be happening, it does seem like
> > a landmine somehow.

> Do not add 'generated/' prefix.

If that's something you don't want to support there's a bunch of
existing explicit usage of generated/ in include statements that need
fixing up.

> Let's think about this scenario.
> First foo.h was hard-coded, but sometime later,
> somebody noticed it is better to generate it by scripting.
> Why do we need to fix up #include <foo.h>  to #include <generated/foo.h>
> in all the call sites?
> Or do we need to have foo.h to wrap <generaged/foo.h> ?

I'm not sure I see a conflict from having both ways to reach the header
here and allowing people to do either as appropriate TBH, and indeed we
have other cases like uapi where we have both include/ and include/uapi
in the search path.

> No, users of foo.h do not need to know if it is
> a checked-in header of a generated one.

The use case I had was for partial conversion where some of the header
is pulled out into a generated file with the generated file wrapping
things.  The users are unaffected, and if the file is completely
converted to be generated would continue to be unaffected.

--Na26+gSFr2zhmOGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI0qCwACgkQJNaLcl1U
h9DbOQf9Gc8eysVy5G2QmwYYFBMmlT4Ox5jWxccwmsdTgJfCAvrNbnwdlWzK4dNE
ifOfVaHe6e8tzZ2KzznwB6vWHwo1re8vZ3VcDeENHbo4LkTBGlX4FuSDA2M0bU19
PaTL8mcuFUCrOTNWhPs2M9PpBhAs/sg77zi9RKEwNxIVyz7VccImEQU6mD2fMfdM
xxlFSI4hVRV6rcSID5Vu9BlnZhTMOp9Kbl3Dp8msyTEUmGPsLaS/TGXw7wXH48nW
BEH72GIn6SdThUzO0Kd3jzWq9PgAowieLdSci6TGptVMOyeFzAalK9HFlfhfnvgo
ZoEoiuJvUSVWziwM5Q23is7WHlRRtw==
=Uo0H
-----END PGP SIGNATURE-----

--Na26+gSFr2zhmOGw--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDFA588B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiHCLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiHCLwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04603205E3;
        Wed,  3 Aug 2022 04:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C2561226;
        Wed,  3 Aug 2022 11:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174A8C433C1;
        Wed,  3 Aug 2022 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659527521;
        bh=SkQ8uBrmL3zyHryQ8RNaHRKITkAnNBPeCIkPX7+WCHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGUR/O3gxvOv9XIoMN0aGttCgsdILYpipPLpWwkIeZb7/kvPwXdC7V0GPTW1crQ59
         /jQG2H/ryIdU9q7CA0NyITT82tGIZRIJTVDsOenI88c3jh7PmCmCEFBSoLjHmo6Ne/
         yrRBfWo+E+t+x0ziJqk6GiE7xs3C36ntq2zOGJvCVSgjyfNGJ2ELOBi1EfQQW92vvd
         hi48N0M1VgHmAW89fleBS5KCl5b3yxOiUat63GRbWNT55veeNG2kH0qx1StcL+Oyyi
         Vh0i9d3zUkInqf/oDta8FjZS3/I4dHhcXBXnEgeMfRzyvINfH6HhFHRoXet4HIGCjM
         jn9pO9/r9qUoQ==
Date:   Wed, 3 Aug 2022 12:51:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 2
Message-ID: <YuphXWlnKgTgnE6U@sirena.org.uk>
References: <20220803010326.2814276-1-broonie@kernel.org>
 <d1f90d44-a1e9-7490-f789-f928b85a1d26@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hO9CDiCpsVXVES1L"
Content-Disposition: inline
In-Reply-To: <d1f90d44-a1e9-7490-f789-f928b85a1d26@gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hO9CDiCpsVXVES1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2022 at 08:48:58AM +0700, Bagas Sanjaya wrote:

> What is missing here is powerpc build (ppc64_defconfig), since the
> architecture is often used for cross-compile test.

No, it's not missing.  Stephen's native PowerPC build has been
deliberately replaced with a native arm64 defconfig build since that's
the system I have access to and that's who's paying the bills here.

> And I think since we're at merge window for 6.0, we need to say
> "Please do not add material for 6.1 until 6.0-rc1 have been
> released".

Right, I didn't add a note about that.  Hopefully people are sensible
enough to figure it out without the explicit statement in the -next
mails.

--hO9CDiCpsVXVES1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqYVwACgkQJNaLcl1U
h9DJsgf/fx+sZB2Jz3BHGilY3tBeZvtVlkjfS2nKYbaMG+g59RUbV5IBEgRXxVTB
ZaL/UkzG51ovTvPE8Mr0RP9lanRQvfpmIc6cDjHofP9IYa4n8IBhgtmF9nRcx3ju
1yzg/DjHN6HWk0Psf2Y5BWcdt8nXFhv2CtnY+RLfNupInkJqhe34ybv7OEcEtU2q
rmuM0P3FS/l1fADTGH7e0XCcHq7ibZ7YmAYt0xpjK1PWiQiYgpjcWW6nfA3l7dGc
DPCzwtnBc3HxHRW8WzVNxqIU8Ks6BGB/JIn3fvaYHhZvTI5bjtmZwakAX/HfC+kc
CohjqFgLDZJK8M/mMTH4clKkU9RqtA==
=AUXC
-----END PGP SIGNATURE-----

--hO9CDiCpsVXVES1L--

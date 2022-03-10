Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD634D4734
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiCJMsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiCJMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:48:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123CE52;
        Thu, 10 Mar 2022 04:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E0A56197E;
        Thu, 10 Mar 2022 12:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E42C340E8;
        Thu, 10 Mar 2022 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646916447;
        bh=YjluHKe/VlmYL7LO8vuUhASnh8qy66JiJ9LVWRRDBfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKh6HftIRL2ZYJbppccTiuIXmAPsIjsbtFq/wvXWLtQmHK/BCoCP0PN7pXRDYFhy7
         BeInyKv/S4eqRJKSF55/02xkqCprGu1f/qmRqZP4lYVbusLFs/X2vXqvIee8UpmJuv
         ddiNWH1yz4HzRG4ASBiK04+ummr3bsKVSyeaj/b2PhnYhegGKXTqHknBnKG6njVj//
         PXO5IHk/4zcXZQN6AKzX8Oy8M95wWcWyx69pWaxjfMCXvQeNc7EEmcc20LjtDrX6cM
         o0g8wVBQWB8VYk6Wb0Ahb35ZSjTYZVNzkL4LRoTkHMl22baD6zWTQYWDx+UyzpNNe2
         iXja3DKnpMqhA==
Date:   Thu, 10 Mar 2022 12:47:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
Message-ID: <YinzW413m6p0H/i1@sirena.org.uk>
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
 <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UT7KHhFxpAGqiQLx"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
X-Cookie: Package sold by weight, not volume.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UT7KHhFxpAGqiQLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 04:25:34AM -0800, Linus Torvalds wrote:
> On Thu, Mar 10, 2022 at 4:13 AM Mark Brown <broonie@kernel.org> wrote:

> > One fix for type conversion issues when working out maximum
> > scatter/gather segment sizes which caused problems for some systems
> > which where the limits overflow due to the type conversion.

> Side note: 'ctrl->max_dma_len' is a 'size_t', so even 'unsigned int'
> isn't necessarily a sufficient type.

Hrm, yes - thanks for spotting that.

--UT7KHhFxpAGqiQLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIp81oACgkQJNaLcl1U
h9B2NAf9HMvGIuVmqBvHTwRyF9U9T3nKgkUNNlNpXQ9cKNq1zGdNhKDQ86d7bt9B
NDSri1SDqqcUwJX1xm4Zf9DgzuNPesmD9PLaY/kz4iRz+RzyVSEsJ1fepnai0IgO
o/KnTCPFMhMaTmtIRwliiR1T7VZ37n2wwoQ/eCKVsAy+DGfWNR3kDRDjRceHDobn
6v12rrcxzfnES74HAq91lwuYE9sXPpwsHzog8ZkfH1B1UPwgT25I4DXcumrTs733
u2zigRiuee+MongN9/my9n5O1knX+LJ7FDjtOrs6695tTmB8GQxWRL18h7anOeCg
pgVIAv8yKRUmMPqhD2EiLsuJJBTrjQ==
=tDjp
-----END PGP SIGNATURE-----

--UT7KHhFxpAGqiQLx--

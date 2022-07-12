Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E8571A87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiGLMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGLMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A88B3D5C;
        Tue, 12 Jul 2022 05:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0506171A;
        Tue, 12 Jul 2022 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC3AC3411C;
        Tue, 12 Jul 2022 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657630381;
        bh=jJin7lOWMTaJyTA//FjzideMNMuqj8Mr/pLMpaUWtcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khWAjOj6JT+x/wK40kEyMmNV61m7fqDMoi6FBMkE326WiBbCn5y+sxfj1QdUPpRgd
         DGCCduZxJPMqD4sOushQAxkz+pNNaxwzE+5JzQ2cTTyVI24CCuxsPAGrFxbN9SOS5d
         2CPr5bZ0vU91CfUrdNQ7ryIhA5vRqDVTwf6s7KmoLLab83pBZypaoArma8fGsMftlH
         TPxo8kCfi9dFW8f7BRxK55v5JCNOY9xSDu5N3AnFm+J4FzlYWWhXVyebQ/9OL3dlrx
         8E/HJ2NCj9r9UG+OYZtIadr46E6k+AkaTijwGLdZs4NhJexcFyzwbFztRJC0nICegd
         2kiwt646wHQ/w==
Date:   Tue, 12 Jul 2022 13:52:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Message-ID: <Ys1up5DBGV5c2MG0@sirena.org.uk>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
 <Ys1t8win0pVPPuig@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VloPA9NQFi1jxZ57"
Content-Disposition: inline
In-Reply-To: <Ys1t8win0pVPPuig@FVFF77S0Q05N.cambridge.arm.com>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VloPA9NQFi1jxZ57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 12, 2022 at 01:49:55PM +0100, Mark Rutland wrote:

> ...  and it boots perfectly fine under:

> * An FVP Base RevC model using the latest boot-wrapper

Also with TF-A and u-boot (both some random recentish tip of tree
whenever I last built them).

--VloPA9NQFi1jxZ57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNbqYACgkQJNaLcl1U
h9A3uAf+MhpLUtT4NKLJxPxbuc1ffEyWrJ9PDg3u2fRg6AJxuaFvZajeSMQBpgF4
M+M71of0EFqD/nJxyjFBfm/tcbUFm5Z77JJvJCx4FipGd3WFy75u6ML2hJcz7APH
bDvyMVdIRsnlwO2jaieYvD7difM25+nE5g0SBg+KDGAJkLWll/7ENLPa1aBFKyJy
8GJeznsuVpEc89xdJJm8LzmJ0+1h4osh9GQ0q0FBFbnbGng6lgMDTVTGqgOCrDPb
hxN7qwzxn8KwTYW934IFNUlV7p/Ac48g+WHhfWJIwhrZQihp5yIMxUjMdhcYqc14
12/TSOkBZQEMkaSqgYD744YXmHyG3A==
=Pl6k
-----END PGP SIGNATURE-----

--VloPA9NQFi1jxZ57--

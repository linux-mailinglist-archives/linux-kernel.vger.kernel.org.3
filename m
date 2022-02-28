Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BFD4C6DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiB1NVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiB1NVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:21:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB879C45
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FDEAB80E46
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B67C340F0;
        Mon, 28 Feb 2022 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646054463;
        bh=KeGJTMJNqRcQCKpg0+iOp8H0LglmDHJQZv2HgM+qwwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxviUN5EHwgMhvzV7tqR1qtOBnNk5vrbm84rTER0CIWF1VmIkto59cVi/BgGA1szW
         AgnSWUzyQO4gTTcFzLESGOzNOKpXGmBbeg2te2S/6bGyFj094q6zIROHH6zq+DPg3S
         gQCqRsw3SraX7+pDmpXJqQJQvyS6a+f8AZoJ9yMYDbCDvhQ0AgNbFWx9HXk+AkjZf6
         22TULpk5fGuxAGQpIc07ZDeuPwa5+Pj9XnM756eR7Qy6JAddPS2GtPjvRCn0AABmIZ
         nYzoBT/c3q7u6P2g8KlevkM9In47QCUHelWqjxcDQubWKgBavwtrPZIFasIhMW6BsJ
         1VXqFN3ozDjnw==
Date:   Mon, 28 Feb 2022 13:20:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com, elver@google.com, ebiederm@xmission.com,
        seanjc@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: signal: nofpsimd: Do not allocate fp/simd context
 when not available
Message-ID: <YhzMOSXJZbApYUmE@sirena.org.uk>
References: <20220225104008.820289-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aWi5TuiGes20Vavu"
Content-Disposition: inline
In-Reply-To: <20220225104008.820289-1-david.engraf@sysgo.com>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aWi5TuiGes20Vavu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 25, 2022 at 11:40:08AM +0100, David Engraf wrote:
> Commit 6d502b6ba1b2 ("arm64: signal: nofpsimd: Handle fp/simd context for
> signal frames") introduced saving the fp/simd context for signal handling
> only when support is available. But setup_sigframe_layout() always
> reserves memory for fp/simd context. The additional memory is not touched
> because preserve_fpsimd_context() is not called and thus the magic is
> invalid.

Reviwed-by: Mark Brown <broonie@kernel.org>

--aWi5TuiGes20Vavu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIczDkACgkQJNaLcl1U
h9B8wgf4nCn5QRzwuOVFmXGSoeGx2MbGTxp0GO4WZbq2rD4NSZksLKOjakcgAah1
TFeRu26s9ZDgKVIJvz9bipIRB7UVjV5q+uxnAu/qgpxrd+EM4esh38p2qmjjxp27
IBQBqUts+t9Zu+/pOVgsNsmR2RhDt8C81CwL0sg/r8UP/bfro8/UY5TBH56kNSmO
GuLOjXhiFk4xu9qzqFRXurL/SO6Dra8anF8nN4O5+3xuitbIaWM9sUghxwZNcHdA
4Xvehg69DDPWX3+eo+otzzMTcSVJ/eeSPCgBrsrXloisSZqbCxWNhzPpsNKgcGAz
UOrnkt39iK9zDsTZ3HvxUDYpbI+b
=bNmK
-----END PGP SIGNATURE-----

--aWi5TuiGes20Vavu--

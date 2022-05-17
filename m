Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231152A908
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbiEQRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiEQRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4BFD2C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44838B81AFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80498C385B8;
        Tue, 17 May 2022 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652807751;
        bh=YCqr29DGIzLKGdYpWx96N7U0D7DZT0IVKkPelFjdVxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXScft69fxnXfHqmz8SZPkewcaN4+mk8DMbHLAOrSaGuKoGAGVdMzhycRYXrR6WPR
         69yOO2+nw8B4bDNwT03Tj8DeUlZBHeVLBnpvLkMdZNOw3NPETxiRcHzAi8qmuNOKWD
         Q6YbMX2hMOqqyi7DaK+Cve8+9QKMIo8cwGk6DxJmAzCLgW/EGgw9VsHGEuEcSl459i
         JCXCwVpomr4wnldKCNS6Zbt9jmLYLX3QBgt6XF/VUGZDSmowM6sAY9i2FZY10M3+Va
         kpinndq0ro0XLIXCcveMaQeox6FtNP9tunTWnWOi6eA5lwrVoQzLJGJP4nYGLMH+ym
         rLhvtPJ941bVg==
Date:   Tue, 17 May 2022 18:15:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Move sve_free() into SVE code section
Message-ID: <YoPYQY4Srrmna68L@sirena.org.uk>
References: <cd633284683c24cb9469f8ff429915aedf67f868.1652798894.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JTz08IXAvI7tvBGD"
Content-Disposition: inline
In-Reply-To: <cd633284683c24cb9469f8ff429915aedf67f868.1652798894.git.geert+renesas@glider.be>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JTz08IXAvI7tvBGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 04:52:03PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_ARM64_SVE is not set:
>=20
>     arch/arm64/kernel/fpsimd.c:294:13: warning: =E2=80=98sve_free=E2=80=
=99 defined but not used [-Wunused-function]
>=20
> Fix this by moving sve_free() and __sve_free() into the existing section
> protected by "#ifdef CONFIG_ARM64_SVE", now the last user outside that
> section has been removed.

Reviewed-by: Mark Brown <broonie@kernel.org>

--JTz08IXAvI7tvBGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKD2EEACgkQJNaLcl1U
h9AmSgf9FDSM0WXbYA+Lvl91FO8eqT5dGF6xomSKKJYaTaQScfzN8Fo841mmDs1z
Qge+XrohK3txtoiHduXWy/DrU92Lg2RXo0eZM/qNsR0bwCKz3+lmhzPwMazeJRFi
01OOZiBraDfLIpeARDxTgeOcBdUXCxUemcLjrvmenimKnRbF7KKrxNPTmK//YM5J
+4dEc9xieMHNfIla2s0EvGHhuL4iZme9hDaSlfhLGkO9Mx7g04nOTwplhPdmbGuS
DTD5AncNkhu8gOTiq6WEvf/l5Yev9Y6XMG76dcyIzcbe9zfsK1yC/2EwY6LYChxg
h8noGDK8XMDriKaWAnWEnoErSi6XYg==
=W1V8
-----END PGP SIGNATURE-----

--JTz08IXAvI7tvBGD--

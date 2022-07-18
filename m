Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BFF57826A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiGRMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiGRMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D3965C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99733614E0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08244C341C0;
        Mon, 18 Jul 2022 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658147791;
        bh=MLTmj3Ke3Z/3vM8iYacOreNpyGWrCnTR3+ZyKEIgWnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4z4OICx4HS9nvx7xARZvlMqDztERfCcgXm+6ZcEAdguGb+L3j5d8IaTfcuzw6BM/
         hmCboJS2BwX1m16yUPjwqO4tyCcb88f9FYM4q6w19keTj7db+KD5d/BWut07W5xCAm
         YWnC7sQGhu7iEkx3m4VOmx8U7uaB2ArjbbD/c1f2LkTD3itJOeyuyEB4rPRKJqhdmj
         zVkIqW02EpmRhqrjdsVqRn7WX8xrTnoTEQKA9LwwPMS4L1mOVrmq246u34OEffQ5Zl
         8IaSDXTBEZPD2n7lpphGPnW/vVGr0w8mfBpNINFJCQ8QzbD+bMVR4n4ezF8TBr+J0p
         YIZ51iFgVUboA==
Date:   Mon, 18 Jul 2022 13:36:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Kohlschuetter <christian@kohlschuetter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Message-ID: <YtVTyzLREdkzYiKS@sirena.org.uk>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rd0hcaxFx6zIWIQc"
Content-Disposition: inline
In-Reply-To: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
X-Cookie: System checkpoint complete.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rd0hcaxFx6zIWIQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 17, 2022 at 01:30:36PM +0200, Christian Kohlschuetter wrote:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.

This doesn't apply against current code, please check and resend.

--Rd0hcaxFx6zIWIQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLVU8oACgkQJNaLcl1U
h9Clrgf/XyGHMgkck1t++00V1/G5LvJt18wBTkGiINR/lCta78T4+gJ+NlfO5v8t
1lqIuXne1k/twVU8jmTl4RfqdnbEscnEr7ZAIDIHHZ3eFYvxLRmKMQTwQWMXOvAZ
zK/fzP4E4U36L3tTK+X1HcoodFmyjL7LYFOlO3UKEpmoe3Hs5CeqYOP1PLpBkTIo
H34VqCG5RQ5gYkqwHc/UAjfVZcRPlXHhKbWX9hfEsej6V0vy+/8PgTxc4euAzUK1
12k3HV5uIPgzUzRNv/uu5usvICqvhmOhxMSZfkEClQAnBHbcJ7+3jaZsv+Z5+BH7
G6ZpQavs0h8XKY7P7pW0fEMYJHxjhw==
=/Smk
-----END PGP SIGNATURE-----

--Rd0hcaxFx6zIWIQc--

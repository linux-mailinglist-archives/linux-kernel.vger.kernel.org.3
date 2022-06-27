Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E1455C169
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiF0NYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiF0NX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:23:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75C3630D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D0CFB801BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CD8C3411D;
        Mon, 27 Jun 2022 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656336236;
        bh=JZtRNbKRSnXdu8246O2Zh/waviRpngCjFGfB/SCDurY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbqUrPAEaRX4jCY/G58o+pwL3e/9rYcVhyI1P3ILSMZ3/CkdKwmnzm3h+WEPALZUx
         Eu3bC72hxJQriy5R+dhxh8IWfypvQD0Q1ZKOEBAPrxHn73DOjizUlpWTPla1zCVBGA
         JHW3YQeb5OBdlGUmdnwIchPuT/J99TYqVtSPopAJhtM3N5ukAV84RTfsFN7bqlP4qD
         LQLCqYMxTyD+NhXcAuFtgN9N4tdjECsm0hp1zfJUMLiPzDW8hJYBtqY84Yf1YVUJ+d
         9atYA3I5GeC3bHg33kVUz55fIPm6CSbeW7CZdwfUQNF63sS0bsepSmF9qdA/vRIcgg
         PVJr3eZSMxpsA==
Date:   Mon, 27 Jun 2022 14:23:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        s.nawrocki@samsung.com, jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-ID: <YrmvZonpB5GhLGbG@sirena.org.uk>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apPYr//3R46wZGJT"
Content-Disposition: inline
In-Reply-To: <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
X-Cookie: Your supervisor is thinking about you.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apPYr//3R46wZGJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2022 at 02:11:13PM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 13:45, Mark Brown wrote:
> > On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:

> > 0b491c7c1b2555ef08285fd49a8567f2f9f34ff8 - if you can't find something
> > search for the subject, people often get things wrong.

> Finding it by subject does not solve problem with Fixes tag, that it
> might be pointing to incorrect commit (e.g. rebased).

Sure, but that's an incorrect SHA rather than not being able to find the
commit which is what you said.

> >> This way you would get build coverage... because it seems the build was
> >> missing in your case.

> > That coverage has apparently also been missing in -next for several
> > weeks.

> Eh, it seems defconfigs for this old platform do not select sound, so we
> rely on randconfig. :(

It's not even turning up in an allmodconfig?

--apPYr//3R46wZGJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK5r2YACgkQJNaLcl1U
h9AIiQf+J4cKSrpie5fzCfZatw/Ms70JQ8wIwrUTA2mYCajSa1hWQYOaJjUniiwU
syfJFKnG1f4/rEmA7jppNanOYh2kfp8XlkZMsoIENwVV6gYeGbA8kLMKgMOxJJ5o
FUEnOYWyFMkkinvcLtcCY99r9R/DKcp+ixgSLsgMFKrgUNPARfTD5pXL/DFnr4mw
1YTLGIGvTCuxspMXzqkNDWBMH3XmdBan+akJ0tZoqvOIKB9XDvXmmKoPeV1r7I8D
TwGsPvsCSpmVuNeFuPYKiBK638ylmFMzojREXfKM96ha4K9QBa+Eo+euEGJX+n/4
GxD/EvRCuId+N5NjJCf6TVfLHoUNQA==
=W0Bl
-----END PGP SIGNATURE-----

--apPYr//3R46wZGJT--

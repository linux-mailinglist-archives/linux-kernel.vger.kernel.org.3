Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0857A750
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiGSTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:38:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535343315
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CFCDB81CE7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21779C341C6;
        Tue, 19 Jul 2022 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658259494;
        bh=rGgOW++6Z/HQIhZG8Yc1nSzysdlCSnRW1K4rZlLDsZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkzAkSgdiAR4Ux/5dnucPUlz9LItGNMJXgLu2bZVPoipA6yaay0LO7oM7NYWW3Abz
         7X07UWjBSbkZNj6IkyRXai03CirvPcAV+AK/n90bcLskaBv8qezsNk0BfExt/Etqcf
         ozD74O/ifomc1olwSIsO2NVWAJg6zpPQmiPu3aeCOkxAw/JL7yje38oXpnGtv9jH+2
         z35gJg0exhrjh2lkepaDXFWrQCGoA+HhfOGlL6e9+ErOMANAGgHi9EP1uYfQIpzNeY
         uYYCfxFkvcV9M3v5GG7+4JIEfqa5+kgVGK5ucdVTU7ELhs5pS99y8osyOMYliDuRcd
         gsqJRZPGMKaBA==
Date:   Tue, 19 Jul 2022 20:38:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?utf-8?Q?Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Message-ID: <YtcIIaFeVIzor/jD@sirena.org.uk>
References: <Yta/zrJxQOfYmN4C@sirena.org.uk>
 <20220719184943.1566-1-christian@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XryecoVwR/YSURWc"
Content-Disposition: inline
In-Reply-To: <20220719184943.1566-1-christian@kohlschutter.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XryecoVwR/YSURWc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 06:49:44PM +0000, Christian Kohlschu=CC=88tter wrot=
e:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.

I think this already got applied, I had another go at persuading things
to cope which seemed to work - not 100% sure what was going on, git
seemed less forgiving than raw patch here.  It didn't look like a
rebasing issue, it looked like the umlaut was upsetting git.  Should be
commit 218320fec29430438016f88dd4fbebfa1b95ad8d in my tree.

--XryecoVwR/YSURWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLXCCEACgkQJNaLcl1U
h9C3Ygf9GPu7d8iKXOil/obbkcxcxqzdEuc+miDHvZXSA6Bt6Qoz+yX114xx9uJK
aAVcYpC+XJmcX8MtwguzR5tfGDQKeqsXahzInmGZ6ZEuIlie3nT487mUcZAPj64q
3GtMlc8An5CCS8nDV48opfP9BBpi/cDIY/DkVcAGPUIsi1Vm+W1juyaIS9Kz86wA
OGlX3S0b9alY3q//sSzurRXUwCdrPyAZ++0ig/roCdJiZHyfyugxbrEmiKbY+1jG
S78HzVTL7gPQx4ZiaJ/Cd+qJYeGMQAr8LpLiup8HJmWA94M3QyfzBMpupjGTOAnT
xMxNTkpWtOxCQ9uDT+AoZPax9prtOA==
=/iaL
-----END PGP SIGNATURE-----

--XryecoVwR/YSURWc--

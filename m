Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8652571925
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGLLzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGLLyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:54:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDBB5D18;
        Tue, 12 Jul 2022 04:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 970D0B817D2;
        Tue, 12 Jul 2022 11:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB074C3411C;
        Tue, 12 Jul 2022 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657626870;
        bh=mk7BOWgJ4VH6FbDt+8GjApCsRZME6QDb/DCvbxMCmwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geVNNb8SiNl6yby+AGrDRCjyNKcAxb1vEly3F4x6k8b1XjNvyszk995dC1oegUkEO
         5Gm3hN0Zi0LiL3K3Uc+PbIn/prQqMZw9rE9b9iAc5QRS4zowQiaQJz+CnDdJUR0TL1
         qtLQ/CiRCGnHUkmFBfi4MchtxkcMaC37xwjRoKmefJ5MKfAzv5hS7xXw9VljvA0T9a
         gsMJnWbk9HP5UaDpzOWYx03FhAw8N18EO8L0vcAX0sB60Ch2AbbvRdvo7y92gPjeRc
         fhPbs8WMu+sG/HTqdgbrSZkQGp4oktVcc28r3kLcELb9qAHfUuSswhHg+1ZeP9p4ar
         TD31Y6jhV8fAg==
Date:   Tue, 12 Jul 2022 12:54:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <Ys1g8PH4M2W7Z50U@sirena.org.uk>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Svukf3kgPdM45YjX"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
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


--Svukf3kgPdM45YjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2022 at 03:27:09PM +0530, Naresh Kamboju wrote:

> FVP boot failed with linux next 20220712.

I can't reproduce this, including with your kernel binary, which
suggests that this an issue with your FVP usage and firmware.

> Boot log:
> Starting kernel ...
>=20
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
> [    0.000000] Linux version 5.19.0-rc6-next-20220711

How are you invoking the FVP, what firmware are you using and how is it
configured?

> [    0.500709] kernel BUG at arch/arm64/kernel/traps.c:497!

This is an undefined instruction, my first thought there would be that
you have some feature enabled for the kernel which requires enablement
at EL3 but your EL3 firmware is not configured to enable it.

> [    0.503562]  el1_undef+0x30/0x60
> [    0.503709]  el1h_64_sync_handler+0x84/0xd0
> [    0.503811]  el1h_64_sync+0x64/0x68
> [    0.503909]  net_sysctl_init+0x8/0x7c

This is where the undef came from.

--Svukf3kgPdM45YjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNYO8ACgkQJNaLcl1U
h9A6fAf/QTcF4jp1qJO2RoVPJc4OP7G1PJumqwmdm6mricWR87xdE7cbOZyK6pc7
G35LXMALDibQRhBd+tGJUQjAtka3IMIe0STZGVpbNp4H+1PyZASk3vLfgwtWVTMP
WQZt3HXC4ryTH/91yWSjDvJjoJkGRZlEStyqEgMUueBDUa6Cq5YuVlaKzFZW9VZ/
xbrs8tDLaFeI2uc6b1WkjldvDY8D3cahLxlkQ9myBuR2iDnr2ZvCmBiGzcpAAKAd
+/HYI0Z9mlXz/dlcwxeoSkYqB8Cny7EevAQSCNMzhl3rUKVJ29RsqmChXLiIWtWd
xOxOo0Nf1KT9hsIwn2GdAr3G/VSCGQ==
=/ii2
-----END PGP SIGNATURE-----

--Svukf3kgPdM45YjX--

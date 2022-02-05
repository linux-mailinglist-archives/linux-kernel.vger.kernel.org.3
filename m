Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F344AAADE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380889AbiBESZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBESZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:25:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A966C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 10:25:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6FAD61194
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87804C340E8;
        Sat,  5 Feb 2022 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644085543;
        bh=DnP6o6vCH+ISNqb/qwd0A+0Dc+FgwDGwqXi/wvYmCVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiS6/8LU0O1ruHuPYg83WkC5gudVQVA3ZgRtxlbisGDW1d9hGHCrIKeK0AlRHqWvJ
         b/6pt+RVH7FPgNBS9opV+oCkhTqT5uHSrHLQAuQZXuvdwyR4p1k0Wg2cxr0Iw47flF
         XqPsXGXiiByIEO5015N7jul3SA1i3jUvhunkLni162cshv/HTYKVdi5uctI6zZ3fPY
         pKJ/VjrNbnv3FQ1kio/JNRk3chk/qM/GLU3K+VWhvp44NSQQl0HXWk8DF2vjNWD2gh
         IMoyc1lCk7E/RyjSDynpd1T3M4s6rOSY9mXAK0pHlpb0MS7fZhgDz1BMh72fjHT1N/
         PxWnGpROGNHLg==
Date:   Sat, 5 Feb 2022 18:25:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
Message-ID: <Yf7BI9Cei5H2S1ry@sirena.org.uk>
References: <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
 <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk>
 <Ye87P19+JOjPEGTY@google.com>
 <Yf14RJbM10O3RdA+@sirena.org.uk>
 <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
 <Yf2BTelNlqplv06/@sirena.org.uk>
 <CA+ASDXMJB4Egohc_V=su-tE=pU76=6zbmXSoptwwwbype1F7sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agmc4mI7WA28dIr6"
Content-Disposition: inline
In-Reply-To: <CA+ASDXMJB4Egohc_V=su-tE=pU76=6zbmXSoptwwwbype1F7sw@mail.gmail.com>
X-Cookie: -- Owen Meredith
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--agmc4mI7WA28dIr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2022 at 11:53:01AM -0800, Brian Norris wrote:
> On Fri, Feb 4, 2022 at 11:41 AM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Feb 04, 2022 at 11:21:51AM -0800, Brian Norris wrote:

> > > We do actually have a cache for the case I care about, but there's
> > > also a debugfs file for bypassing that and...for some reason I'm
> > > dealing with some diagnostic scripts that purposely toggle that. I'm

> > Are you sure this extra thing that bypasses the cache isn't an out of
> > tree patch?  It really doesn't sound like a good idea to have that, and
> > if people think they need it they probably have drivers doing something
> > quite unfortunate.  Or are you just looking at the upstream debugfs with
> > some volatile registers?

> Again, I didn't claim the *use* of that bypass in the aforementioned
> diagnostic script was a good idea...but it's at least possible. I've
> already carved out more exceptions so that script doesn't do bad
> things on some systems, but maybe I'll poke the authors even more, to
> see if they have a good reason for using the bypass.

So it's fiddling about with bypass mode by hand rather than
something that specifically shows you the underlying device.
That is also a terrible idea for routine use, if it's telling you
anything different from what the cache says the driver is buggy
and if the script causes that to happen then it itself is likely
to be the bug.

--agmc4mI7WA28dIr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH+wSIACgkQJNaLcl1U
h9Chcwf+K6VUMscow9oAM92wB4RgKnD24v37trafem63/4vRih/0LPy+NXSJs8xD
J7oJKycRg18st3lcvE8jsi2hR4dVkGNc17HzfQOvBMs4xTVQJDYNeCcaaQOiVBqK
vsuy0F3ln6+tlVDSrOF2c3I46t8wpnlG1/tRMb3Gg/Vyj8HSACXdEGHaNhYkUebS
dTr5w2qnjZdGmg0vmsf9oiT8i6+wqp2z83eugVdptYzUme9fKVfodFfoBWX0CK9L
pmsInnN1GMzoCwtFJfnFayo3V3J7nhFTg5Qim/V2FkyrTZgGIs8rKOD/92wpIMFE
9IJBCv14e3rbiuPdpxpLxJ5TTCYwQg==
=/6dQ
-----END PGP SIGNATURE-----

--agmc4mI7WA28dIr6--

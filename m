Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620D250E23D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiDYNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiDYNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406C13DF7;
        Mon, 25 Apr 2022 06:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D67615BA;
        Mon, 25 Apr 2022 13:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35886C385A4;
        Mon, 25 Apr 2022 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650894415;
        bh=cnaPGcH4wGvOkYGwNrD3V8c2ZplgPQyr3KVOqiR+sJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA1s0kuSSuLQE2bT8lYq2PPV04y02D7wZ8T7PdJUl0+pIvcQzNQnEkHrKO/VLIdgb
         2m1RDD1iU6fclgB2yt1Cje9fNi0pxMXo9Afs/v7KguWBId5ui/5gXhFdyMHHH8XIRQ
         bOftIFstCxWmSjJHS3lBhWNxeu4gXmX0XXBJbCx4vqu2bqlpY3wW9SyWSPVIMDLzeT
         BX2eE8JH6eajiA+UVHxwl22jmU3zQixvCowQ3xKibegjrsmrkShuAPa1Y4rNBOa55o
         S2JjJmmeYwllM2K1/vcfweK03kM9wQnTiueeD9g3slFnmadjGloilFczuOGhiju7TU
         mzZXT8lv+7Cdw==
Date:   Mon, 25 Apr 2022 14:46:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Message-ID: <YmamSZKNtNai7KyM@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
 <YmaTHTKWAfM7FCcY@sirena.org.uk>
 <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
 <YmaaPa8A03rWV7HE@sirena.org.uk>
 <4CF6B0A7-F218-4798-BB21-18D563309D5C@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V5YMDCcjWGsw/lIg"
Content-Disposition: inline
In-Reply-To: <4CF6B0A7-F218-4798-BB21-18D563309D5C@cutebit.org>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V5YMDCcjWGsw/lIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 03:11:14PM +0200, Martin Povi=C5=A1er wrote:
> > On 25. 4. 2022, at 14:55, Mark Brown <broonie@kernel.org> wrote:

> > I am surprised that doesn't otherwise explode TBH - at the very least
> > I'd expect it to show two PCMs to userspace which if I'm understanding
> > your description correctly isn't really what's going on.

> I fill in a single snd_soc_dai_link, it exposes a single PCM and works
> like a charm. That is as long as I patch the playback/capture check in
> question.

> I read that to be the clear intention of ASoC code: a DAI link becomes
> one snd_soc_pcm_runtime.

Yes, so long as you boil it down to a single link it works fine but the
bit on top of the binding where you tie the two CPU DAIs to what is
actually exposed is all in code.  The reason this stuff isn't filled in
is that connecting the thing that applications see to the physical links
isn't at all obvious and needs at least some driver sitting in the
middle to make the links - I'd imagine there's a DSP sitting there which
probably has quite a bit of flexability about how the various hardware
components available are actually related.  This makes figuring out what
to do with the relationship between the multiple CPU DAIs hard.

--V5YMDCcjWGsw/lIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmpkkACgkQJNaLcl1U
h9C/GQf+OjJGWvlH5dhjAe5s8YfzoSM40Z2KmKGWDIcK8eWx0PFyUNUbga/WyQfu
/DZp541i+iDNis3n38axj/4MJkr6Fv79zkvqkXcDoJRwvHPN4pUnWuayW4R9dzOD
RCziMyqgTtA4L9aCBI3OW6j6iDy5giYhk1ZGom2XGghdavCGptkPmXnWebvjTP1u
86P8dTNBR5iyhFdxG6ZQXgGOoj+HDKc7wd8GeKmUErNfgDPJhLKe4+2CPyX/l8cp
7yO9I0+h4S/GIOyCjybXqlEfCKLSYk6S7rf+grBcXOfQlb+AUo27WCSS1E2AvH/P
/5nrS6m379X9QqI4rhcsEJOfwZo+1w==
=/H/Q
-----END PGP SIGNATURE-----

--V5YMDCcjWGsw/lIg--

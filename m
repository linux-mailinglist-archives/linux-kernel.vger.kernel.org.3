Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153DD4F863B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiDGRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346362AbiDGRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:30:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA928E25
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00BC9B82865
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4FAC385A0;
        Thu,  7 Apr 2022 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649352464;
        bh=7jEWQBatP4qMkllGYiCARw7scemPqLCpGQ4Sm2/XdwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+24MmDd6m6A0atgn6EHNkZdE441HSmZ47SaWHIhZMUqgayvMTrP+gQiGpbmZDs1R
         3haw9SNoQpbIwrDR6qwQq2DKKq9rx0ETiVWYeqsWvbqm5K2YusiLGxBLrmwo1++PP8
         DXwWE4sX/715P+oddIJ9nBZ7Bea9naeA+L6nfuDxCcSL95gnbGNpIrXaROS1utiCJe
         30qSaK6f5PJsZo9sGMW2SchSySvv0mH8oW91FXQGwSvgibvSqWTeX7H8SkJDtHSNrd
         LWTsigjXBtArDgAJQJEYA3wMJGxAySFNDA9QgCZ/mhtjDDklMfG9+c1kATn12lFYB3
         639ottZGUgz2g==
Date:   Thu, 7 Apr 2022 18:27:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Message-ID: <Yk8fCoA7W2nX261U@sirena.org.uk>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
 <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
 <96dae189-c0ff-4054-3d00-41c3b44c2cd6@gmail.com>
 <Yk8Ktyyt0veW4g+j@sirena.org.uk>
 <f86a10e1-b5a7-5c59-8e53-cec65d97234b@gmail.com>
 <Yk8TLUnEHRKstyxq@sirena.org.uk>
 <57747e9a-10e0-e4f6-0644-5225396802f9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNzrJ3fuz+E/xXQQ"
Content-Disposition: inline
In-Reply-To: <57747e9a-10e0-e4f6-0644-5225396802f9@gmail.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNzrJ3fuz+E/xXQQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 08, 2022 at 02:16:41AM +0900, Akihiko Odaki wrote:
> On 2022/04/08 1:37, Mark Brown wrote:

> > Look at how other devices with jack detection hardware handle this and
> > follow a similar pattern.

> The situation actually seems quite a mess. You can find many drivers not
> using DAPM pins by searching for snd_soc_card_jack_new() calls with num_pins
> argument is 0. ams-delta-audio is exceptional as it adds DAPM pins later
> with snd_soc_jack_add_pins().

Sure, I'm not surprised there's some buggy drivers.

> They do not have kcontrols for the jacks. The only exception is
> skl_hda_dsp_generic which calls snd_jack_add_new_kctl() as my patch does.
> Looking at other devices is probably not helpful to find an alternative in
> this case.

The first driver I randomly picked when searching was
sound/soc/intel/boards/skl_rt286.c which seems to DTRT here, you can
also see sound/soc/samsung/speyside.c for another example.

--PNzrJ3fuz+E/xXQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJPHwkACgkQJNaLcl1U
h9AKpgf+PmAjxKxErqduPaAaLQiWMGfcHxz4FSuc77R0RvDkTX0DUQHA7Y24wFL1
GjjVgyNSSEV7k6Eko0b1g/CK5KSZMiC0ZnaKsB/kBgHsN2xfuvqXNI7hBHWi27SB
KmcrURD8hWHhp2wz/lMAoAK7V61gFpkhUfBzWLpfdEdqUY9/Xz3ilI9fAy0qFQoO
yOky8dyASa69oTiMgNQJOW9PZ9N6B0RiaM8ZrbHbP/WQXYRlUP6qssJXJ0IgMYBf
MgEURslJFPyeuxjoWxnAPMaNtqDQCsAEfEHlcCYfEUwHfqxc76g9WThiM46NqzVn
IBV7CSMjfEKJD0vV2yD+sV2Ko3RfQg==
=p8iA
-----END PGP SIGNATURE-----

--PNzrJ3fuz+E/xXQQ--

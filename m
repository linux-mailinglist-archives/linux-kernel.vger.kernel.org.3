Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675D50B60E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447059AbiDVLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447071AbiDVLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:22:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A35523C;
        Fri, 22 Apr 2022 04:19:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91427B82C2E;
        Fri, 22 Apr 2022 11:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C96AC385A0;
        Fri, 22 Apr 2022 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650626378;
        bh=zru8/UW9zmtAG0/PK5iDxBFRfJ8xYdeBvwTmA9VEK8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFFN+sPTXdnJk+Sp2znrcBOGnDhEq/ShO1v6/yJkZyAMaRVVOMgL8Y/sxkmuDq0/y
         NDfUXGw+porWAGWdY+2rRSYyvUukVuMEpW7ZA/6eMQ2mhk74CwKBR3n13ub1wF/imm
         nJb9mf1iV/h1dvfahX0RHBpSlpRgfuxbXYoAr19tQAWQka94k0bKFC8/ifhv0ymalX
         4Bmq23wGE5nBm+5lh6rSeoTh1OK5Bt02nNUIiEYEZoetl5lz31D9THVwSO3tvvRRzG
         P0tEg7JEiLu0E5zAtbKtRaYjQOPIvLw+QZWmi5e5vQ2YBdECTTT2BlNDy+PF5wwXvj
         07YN3tRQ0kdkQ==
Date:   Fri, 22 Apr 2022 12:19:31 +0100
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
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-ID: <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8nVJ3HZ/2fzKiGhv"
Content-Disposition: inline
In-Reply-To: <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8nVJ3HZ/2fzKiGhv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 12:43:30PM +0200, Martin Povi=C5=A1er wrote:

> I looked in the TAS2770 and TAS2764 drivers/datasheets, and to answer
> the questions we had:

>  * VSENSE/ISENSE output slots are configured independently of audio sampl=
es
>    routing. Kernel drivers configure the slots based on the 'ti,imon-slot=
-no'
>    and 'ti,vmon-slot-no' properties of devicetree.

>  * By default codecs transmit Hi-Z for duration of unused slots.

> So once we supply the devicetree props it should be electrically sound
> under any configuration of userspace knobs.

Great, that's a relief.

> One final thought on the playback routing controls: On systems with >2
> speakers, the codecs need to be assigned slots through set_tdm_slot.
> The macaudio driver RFCed here assigns a single slot to each speaker,
> making the effect of each speaker's routing control this:

>   'I2C offset' -- uses a random slot

>   'Left' 'Right' 'LeftRight' -- uses the single slot we configured

> I suppose I better assign two slots to speakers in each left-right pair
> of the same kind (e.g. woofer 1, woofer 2, tweeter). This way the
> routing control will mimic its behavior from simple stereo systems but
> replicated within each left-right pair.  (I would prefer to hide the
> controls altogether, but as I learned that hiding things unless proven
> dangerous is an ASoC non-goal, this way I can make the controls do
> something interesting.)

I don't quite grasp the difference between the arrangement you're
proposing and assigning a single slot to each speaker?  Possibly it's
just a reordering of the slots?

--8nVJ3HZ/2fzKiGhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJij0MACgkQJNaLcl1U
h9BqUwf/QG0XzaX2s8b8WvT2Muxmu2J/H8wKfS7X/M+RzZh+hf9jkcmuXNvf6y+x
szSnDY6wVDj8SHavGkPVPalUX3PogMNjOds6SJOIuEcKyDgenL9Rq0GluoyIKytF
DrRr20N0WM7w4kPKuH/IdpkMjy3Oh+Afqiqp+FX11DmVGkvATcH6qTRlLqB78p2y
VBnW5KrSXnkIc77pXVf4lYNb9Y+0f6ey4MIkEdq+/UO7dzzqNMUbLiIbvpkm9WxP
AXVjwSl0RxhabUPZPYh1UpMW6V+DgfDim/4poEkvrX64cqUMtS3wLIzumNV3Xg6K
G5V+FiiYQCyqYup6Z/ozRckIakyeBg==
=0ea9
-----END PGP SIGNATURE-----

--8nVJ3HZ/2fzKiGhv--

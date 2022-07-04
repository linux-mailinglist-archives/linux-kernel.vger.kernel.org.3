Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41656527B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiGDKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiGDKg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D1E0CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C686157B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DA5C341CA;
        Mon,  4 Jul 2022 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656931015;
        bh=Qq1JrTSyeyHN7jB4kr9gC8LUi3N7kme7MIzEtdrfGOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9EO4dsX7kHM5vq2KL1tkT50/dQLRYttAzLWj+H6q6h22dyqvRYD6/rHdqkLwgsza
         UXv91gBFepnyXLr1cxQ1v4IIIADh2001ld0rnwoukgUCBytPfLP7qAv6qZgFFLQiP2
         IO9JcDVk7yQB1J3GXTkzP9FMfXQsgXNFpbR8r+ho8U2FIdS1gxj1CrfCW83NZ6/99w
         7eUuGkrhT4kufCwF9mrX02KknO1pp2IEpWgLNQ0u3YS5YseVU/6fAecsshNU8+5g5c
         PsLg8qfyvhQ9l6iRGPVYjdXDb+4sOxt+ut5qKo20wfeVAHY2ohOriXF5dXftpVb36g
         CjFlDLhnfldWQ==
Date:   Mon, 4 Jul 2022 11:36:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <YsLCwQM0gbhFhSke@sirena.org.uk>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
 <YsG3kKwmoqF2MxU2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3hlYmSpRpSU1SsL"
Content-Disposition: inline
In-Reply-To: <YsG3kKwmoqF2MxU2@smile.fi.intel.com>
X-Cookie: MERYL STREEP is my obstetrician!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3hlYmSpRpSU1SsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 03, 2022 at 06:36:48PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 06, 2022 at 10:29:59AM +0100, Richard Fitzgerald wrote:
> > On 03/06/2022 18:07, Andy Shevchenko wrote:

> > > When kernel.h is used in the headers it adds a lot into dependency he=
ll,
> > > especially when there are circular dependencies are involved.

> > > Replace kernel.h inclusion with the list of what is really being used.

> > Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

> Thanks!

> It's a month passed without any other news about this patch.
> Is this a problem in the MAINTAINERS database?

> Who should take this?

> +Cc: Liam, Mark

If you needed to add me to the CC I've not seen the patch...

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--c3hlYmSpRpSU1SsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLCwsEACgkQJNaLcl1U
h9BsAQf+Iv3swaQi4a4ah1bIH55nv4+CwJnivwhKG5PjzrP08QJbqkXUWXLI/6xK
NErjMQNu+dHhQgRMRleMNxnGpcOi9PPz8v5cV5e0Dvn6ZWhEtSFcKXbdR/mXU0/Y
DJ5gGardEiZOUGwLqFsso8qn90xhuVw+gdWUaUzDL5lzcceN9yVxLO7HEGX52NBK
DLN7LdqgyA2r7URJffUsJkvatDTHfG2S8J5rkl+eUFa/Kj+cujGbO22N7qkkAh72
CuKEGMlos5V58rwsuevxjgOeFRsPdOeqRD+z2JQDpfZWqJMi7cq23mXFfcFg4Uwd
be3jwUK6iNYHfmLFhYUfH3ijLBGiqw==
=4nSa
-----END PGP SIGNATURE-----

--c3hlYmSpRpSU1SsL--

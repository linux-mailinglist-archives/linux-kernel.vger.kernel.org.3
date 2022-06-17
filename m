Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9B54F2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380882AbiFQIXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiFQIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71464BD2;
        Fri, 17 Jun 2022 01:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAFC61FA7;
        Fri, 17 Jun 2022 08:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20996C3411F;
        Fri, 17 Jun 2022 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655454198;
        bh=ZG1PRw5VnASc89o/sYJOq7OiWVJgsMuC9yddKS4CDrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lT4Ro3kc+A+y+QX6qf1iKCZL6VGsTamd7TWyXJxZ2TgoTwfV5oSwsiZ05/Bq3z9IC
         2uNbFIfQvVNRYjJkhVFsY2BWsYBvW3xuP9vMO9+85A0paewaFf0eXvtE+dLv59lF/i
         KU3d1/XThv0zX0yeZ0/g47Y7eAIgVru13ITMzQYfhXy45s0giDW8i8MvMj8LAtTck+
         cd3I++eF16H73f81p1ss27mLF6cf1fcCqRGxSsVhFVR/qZSO4fWgnjJsdhv0DVrOnE
         iUIlBWlrsurY4mh7jG3/giMqgCMcoDTIoUsfJKtC9I7e0yzq2Cv+NACt0wYW3+LrpB
         Fv6MAEBlZtZjA==
Date:   Fri, 17 Jun 2022 09:23:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Owens <daowens01@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-ID: <Yqw58Jt9Pky/mYdc@sirena.org.uk>
References: <20220616202645.1645972-1-dowens@precisionplanting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xbvFMKB/P2J9t+zG"
Content-Disposition: inline
In-Reply-To: <20220616202645.1645972-1-dowens@precisionplanting.com>
X-Cookie: 98% lean.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xbvFMKB/P2J9t+zG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2022 at 03:26:45PM -0500, David Owens wrote:

> sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/4=
9022000.mcbsp/max_tx_thres'
>=20
> Signed-off-by: David Owens <dowens@precisionplanting.com>
> ---

Please carry forward tags like acks unless you make changes to the patch
which would invalidate them.  No need to resend for this alone.

--xbvFMKB/P2J9t+zG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKsOfAACgkQJNaLcl1U
h9AURwf/f6I/e2bDkIEEwNwEPBB1bwhn2Ume/aTTU7/TGFfAbhYa83++IgU/cF7B
AQHpwlpoktSXH+1RkSCKAcyEyGUPqTZ1eCkvQKz+jWwY/SkVBkBCfDyol1nwkemY
lLjSMOqiHyD3f1APtYct9T394Ds92LRQoobqwxB8cQoOjbjIIEpODoUCvexMGRMC
YnQLl4E0CLydjipC3buAjqYF3oR7z2E4ntVVhYUGUID5pDgCqE+ELWluwwUf+tL1
jCtSMlGORLrIojhA8G8+eYzFy6X0niIbWBRfHaD5XC1wkX1S5BqsbXLgoaSvOHpX
hkIjUyYdMzPeGTUy3TNzBlGZ5hFqdA==
=rwQu
-----END PGP SIGNATURE-----

--xbvFMKB/P2J9t+zG--

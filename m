Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2251BF29
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376651AbiEEMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376547AbiEEMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:22:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23953B49
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4EC8B82B98
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6C6C385A4;
        Thu,  5 May 2022 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651753153;
        bh=XIEIo8vB6+bdwynrUci6u8jhVuAbLP0G/E6z0wFUGvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYNULHU7SgtHwYK+OIty9bp/HYvtDJ+ZysnctLCnmhRdpygjnsd4HTKqL2ik4D7mw
         /KfIaWWZGZy3MKHdPXpOOMC7XF+s0Ri1FkhZOqGFtv6Yw0Cw+hv0nDaw/B9ATxH5pD
         29q55fwdhBnLrIHzsqIwDQHT6uATvmv3UXGK0O0HSjpeH1Vb2l8uGPXvJq3UI9zu25
         Zsokqu5L/YoixW3RJkvZ2eBCO5ezI8bMnmyLbpBYDgujOGmo+HGbdZXrOOQLlWdflu
         +SCHR12MwPH1iVjGNB1Zbby1zfbxtSo7M8UIAWv7nLryy54jm/QLaMsv5NYNICUlzE
         xbWpJUk/Oeasw==
Date:   Thu, 5 May 2022 13:19:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 1/3] ASoC: cs42l42: Move CS42L42 register descriptions
 to general include
Message-ID: <YnPAvXKWtQsF2PG9@sirena.org.uk>
References: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
 <20220504161236.2490532-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A49oNdcvS3T/SemI"
Content-Disposition: inline
In-Reply-To: <20220504161236.2490532-2-sbinding@opensource.cirrus.com>
X-Cookie: Real programs don't eat cache.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A49oNdcvS3T/SemI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 05:12:34PM +0100, Stefan Binding wrote:
> This is to allow the hda driver to have access to the register names,
> for improved maintainability.
> Also ensure new header is aligned to 100 columns.
>=20
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  include/sound/cs42l42.h    | 810 ++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs42l42.h | 826 +------------------------------------
>  2 files changed, 812 insertions(+), 824 deletions(-)
>  create mode 100644 include/sound/cs42l42.h

You should use git format-patch -M for things like this, it makes the
diff more legible though in this case the fact that you've mixed content
changes in with the rename will not help - those are separate changes
and it's hard to verify things as they are.  Still, seems to be OK

Acked-by: Mark Brown <broonie@kernel.org>

--A49oNdcvS3T/SemI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJzwLwACgkQJNaLcl1U
h9BkLAf+OrsVZZEPmUrcKrQLRqlrVd/1go4OcsbERWqbpsQ2yNYSvmqoIhBiQzaD
66NmRTKs/bPVqTpHcoGJwRYojKjs82/47E8ouFV13AhAsFyYvzuHqrPtNr3EO4RV
zBaWwQ9uwjolqJ/FaPOe5oUyDByhkwAWLXyUK5E9jBv9X/7fgyt/B4Xd90PB9xS4
r+i3HoHL/OTWM8XTyOrMMCQj+vQYtGaWbSES9D2UiK97b4gIUtV2LxmX1s0Ab1+T
mBAZnHxUnHxdc4XkWEJXSLlcqPu4NUd2UzS46SsqQ8efk9pqTAlaj9ztLqOtH+tA
XGHI3MjAAcZ84SgKNbfHqGnJNPDgMw==
=CS0+
-----END PGP SIGNATURE-----

--A49oNdcvS3T/SemI--

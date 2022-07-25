Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BCF57FEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiGYMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiGYMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2017A8F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6371A61024
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6374CC341C6;
        Mon, 25 Jul 2022 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658750561;
        bh=GwbjS3c13lg8fZPA7wDzaCJ7BO5g1uJau5vPd/VCIMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw/15TdpwY/XY9VymvbWBN+R50Q+Ox6qLxjQmrvp2bCmODZDfNNehi83cm+eE0Xwc
         QRL5jwGQYNEyoX3OgztWnaNhhuLNIUPiZX0HlVRCkfyHNTgkJFAZ364iJtfgWHUgo3
         WWCo1mYwDZWi3sF/6DDaTk+jtdb94kQQzAXj/+kI9y6HWt36GRLsrse1Gmt34uAIKh
         +v23Ri6I2IQFnM0B1QRAvnhjSpmE9P3AjvSADdWs0z8C6lt6wUXxEb5irNCPKeAH/W
         oRLTlCrCtemLXqTBWzB3EcF0P3jfixV0HuY3k9oGMeOP+L5rl5BNYTuKOqWdrU7KOJ
         ANeYXmryr4fjQ==
Date:   Mon, 25 Jul 2022 13:02:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Prasad, Prasad" <venkataprasad.potturu@amd.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Reddy, V sujith kumar" <Vsujithkumar.Reddy@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Modify dai_id macros to be more generic
Message-ID: <Yt6GW/29wJ9081rh@sirena.org.uk>
References: <20220722141705.3340440-1-venkataprasad.potturu@amd.com>
 <Ytq5rlr/er0wDTae@sirena.org.uk>
 <PH7PR12MB595106BC93458F31B2D8C5A9E9959@PH7PR12MB5951.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PIF0Y6NPkJF5WZtF"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB595106BC93458F31B2D8C5A9E9959@PH7PR12MB5951.namprd12.prod.outlook.com>
X-Cookie: Replace with same type.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PIF0Y6NPkJF5WZtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2022 at 10:27:19AM +0000, Prasad, Prasad wrote:

> This looks like it's just an indentation/formatting change which isn't
>=20
> what the changelog said?

> We are changing dai_id macro numbers, as renoir platform has 2 I2S instan=
ces and Rembrandt platform has 3 I2S instances.
>=20
> To make I2S instances as order, change DMIC_INSTANCE to 0x00, I2S_SP_INST=
ANCE to 0x01 and I2S_BT_INSTANCE to 0x02.
> I2S_HS_INSTANCE is already 0x03.

Please write a better changelog which makes this clear.

Please fix your e-mail client to clearly distinguish between quoted and
non-quoted text, it's very hard to find your new text in your mail.

--PIF0Y6NPkJF5WZtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLehlsACgkQJNaLcl1U
h9CgKwf/fMKV9x3binr3akdQUf2tCBjy5NssqkTHNgnFmlRZR16apmsVym3vFcBm
alf/DJPe6ulDvdyWpaE0pFRby0SMno2QcMAtVBFGqQND6RJj6DIpgCZNkn1ArAH0
oAK9+7qnpyDEvtBjW5DP1T64t1ODNThOtPqtvRGmNDXZsJzhFq+/Xf/YMd4bsQCK
Dah7YpjggjmlNcYMV6aFJcrUIOArSRtEtkUb1aeoFPGSFV2FhHiNp7/KXLSCha6F
kOfTQgoGKrsJ8y0DSMY2j6y49GMK6k8A9H5i7f4lvYIxGpbRspvxjiC+Ch0YF17L
wA3NhWAIDUvz/EwTQLJUeqbnY2X9Uw==
=Q0Fq
-----END PGP SIGNATURE-----

--PIF0Y6NPkJF5WZtF--

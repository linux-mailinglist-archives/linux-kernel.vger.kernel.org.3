Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B050B730
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447400AbiDVMZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447391AbiDVMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:25:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA856C06;
        Fri, 22 Apr 2022 05:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D73BB82A87;
        Fri, 22 Apr 2022 12:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AB0C385A0;
        Fri, 22 Apr 2022 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650630166;
        bh=iCGB4TF5qBLZDg/1yVeV2QNlYwKFEsbtcYSzZa2hO3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ok+krcNUAAxIjJsBFpLfy4IXMdkanB+c8oHqQ5WTmn4wD01hVAbib0mJM3lpAImFr
         Dmcm0f54ODUCWaO06evAVQ0qyntH8QiZi18I+D7t74277t6ydRMZsLDwL/u1AuXe15
         PO1xu4f5+khZoq4n0rIKe5Rdk17FzM7YWeIdf7NTYsNadYHHsJPrHVlJGy/EYIKVx/
         wGv1Glq4N6AQz+HljAtETxyNir+SCAdaywelSlFMojCEDyohfwTpA0ZoWWLtllejCy
         Jm2agrPXEm8tft7w/y4hHtyXSZzK/95sRu42/+mmD2bsVvPKL0Zr7gfCzizVG213P6
         QcWvxydQB54BA==
Date:   Fri, 22 Apr 2022 13:22:40 +0100
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
Message-ID: <YmKeEKa0w2xLM9cL@sirena.org.uk>
References: <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KPJ5+qW8JIi0iDUi"
Content-Disposition: inline
In-Reply-To: <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KPJ5+qW8JIi0iDUi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 01:44:06PM +0200, Martin Povi=C5=A1er wrote:

> > So previously each speaker would get two slots but now it just gets one?

> No the other way around. Previously (with the driver as it is RFCed),
> each speaker gets a single slot, and 'Left', 'Right' and =E2=80=98LeftRig=
ht'
> values of the routing control don't do anything different from each
> other (well except maybe 'LeftRight' lessens the volume due to how
> the chip handles the edge case of mixing down two channels from the
> same slot).

> With the new arrangement I am proposing, the two speakers in a left-right
> pair get both the same two slots, meaning they get to choose one of the
> two slots based on the 'Left' 'Right' value of their routing control.

Ah, I think the confusion here is that I'm using slot and channel
interchangably whereas you're saying that previously the driver would
allocate two channels to each speaker with duplicate data?

--KPJ5+qW8JIi0iDUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJing8ACgkQJNaLcl1U
h9C1pQf+K5jkDiccmgDspVoLOWNStF3GXYYVGVeGCeNBLrBlVHruIotK+Oes//0M
d3xPOdmw2MlkOFWqxkxCtXP/vdtNGN0KRW7S/wi5eiXi+nu9RPAs9JuwchD/kFtT
WA82ks3wiTyh84U6jSBtYeZL0z9sSJQtQBzP3GDH+Sr83wkmVPOdosQlcGsVHLIs
XeZc1fxDkfJI5xfDdO4r+8aX/CzRx0/om2kUOzqmHFascH3EPBrNXklZSu3GVINB
l9K41beGVew4X1hujYBp+ibm3Y8Cn9KGT5ftwtJQYlgfIf0YzKyQ57leN//faEmq
PdLUKYKMpYE6QynL5hi4tG0Fg/9cGg==
=EDd9
-----END PGP SIGNATURE-----

--KPJ5+qW8JIi0iDUi--

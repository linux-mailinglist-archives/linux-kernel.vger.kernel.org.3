Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE86058C7B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiHHLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiHHLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090BDED8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E6576105C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8480C433D6;
        Mon,  8 Aug 2022 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659958853;
        bh=ZTJIjiTBCyo5151EdtrsWqedhkYLw628G+bVuY7sHp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWAoCSmteTw95hEAq/qECXjivbV+MCkQ6I7Ort93Ec0SKckC+4bpYyJRuoQF550c/
         ckZyTRaEe5hY0pB7ffmcM9uWy4kbm6FFk2/RHAKNnBTZdmo30POU+GSf5Fc3vOOHVV
         vAfrKRBKA2mnrLsingVQfi2YymQh2EWqaB5z/UXg017W8yUjR9tqeG74OXrpdHlQ13
         Ivd2/2oKvzzEIYfKxH/xntIcsMhxuYnIK8Rs+m+3Kyx6wWKV+q6TBGBHCMtNGqkyRu
         iQI6PZ/yMjNtfDSrlqlK9p/pyNFT40xPNEazmEGUKSxCrDL/mFfq0DUT2DQMy2DwJu
         KrGXNR4QvzHjw==
Date:   Mon, 8 Aug 2022 12:40:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH v1 1/1] drivers: Modify some parts
Message-ID: <YvD2QThICnW4873L@sirena.org.uk>
References: <20220807034052.2314-1-luminlong@139.com>
 <20220807034052.2314-2-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BM0yNN4hPVklAiUl"
Content-Disposition: inline
In-Reply-To: <20220807034052.2314-2-luminlong@139.com>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BM0yNN4hPVklAiUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2022 at 11:40:52AM +0800, Kevin Lu wrote:

> Add a new kcontrol for phase calib, remove unnecessary header file,
> make code more comply with linux coding style
>=20
> Signed-off-by: Kevin Lu <luminlong@139.com>
> ---
>  tlv320adcx140.c | 114 ++++++++++++++++++++++++++++++++++++------------
>  tlv320adcx140.h |   7 +--
>  2 files changed, 90 insertions(+), 31 deletions(-)

As covered in submitting-patches.rst your diff should be against the
root of the kernel tree rather than files in a subdirectory, look at how
other patches on the list are being formatted for examples of how things
look.  If you use git format-patch to generate patches it should do the
right thing for you.

The fact that you're describing three different changes changes here
suggests that this should be a patch series rather than a single patch,
as covered in submitting-patches.rst this is the general style for Linux
as it makes things much easier to review.  Each logical change should be
a separate patch.

> -// Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.co=
m/
> +// Copyright (C) 2020 - 2022 Texas Instruments Incorporated
> +// - https://www.ti.com/
> +/*
> + * Author: Kevin Lu <kevin-lu@ti.com>
> + *
> + *  Features:-

Please add the new bits to the header as C++ comments as well, this
makes things look more intentional.

> +static const char * const phase_calib_text[] =3D {
> +	"Disable",
> +	"Enable"
> +};
> +
> +static const struct soc_enum phase_calib_enum[] =3D {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(phase_calib_text), phase_calib_text),
> +};

This is an on/off switch, it should be a normal boolean control ending
in Switch and taking 0 and 1 as valid values.

> +static int adcx140_phase_calib_put(struct snd_kcontrol *pKcontrol,
> +	struct snd_ctl_elem_value *pValue)
> +{
> +	struct snd_soc_component *codec
> +		=3D snd_soc_kcontrol_component(pKcontrol);
> +	struct adcx140_priv *adcx140 =3D snd_soc_component_get_drvdata(codec);
> +
> +	adcx140->phase_calib_on =3D pValue->value.integer.value[0];
> +
> +	return 0;

The issues with use of hungarian notation and not generating events that
were present previously remain.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--BM0yNN4hPVklAiUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLw9kAACgkQJNaLcl1U
h9B3Iwf/Ze6SxEpjZi4bvFh+aPIm+ikx9nidgd+Gx8zo3pasn3M3+JMbe7RyXJaz
M8QZ8xZhRjxtJ2Q50XZCUuhm3ovmD/WBqSUTqW/QL17m4PTqCJWBlqBoTsiuIVQM
c7w9ZXbCGcTFNP7FMkm0ylHhvAQXCYsShxedPTAkoimZbNXzHNetU3ThMsZlc0gA
Z/aYqwFptnaJGxfqUOvncV+UMsZymOF1UMe8cDToZkN1LblTqONwmc0AQON2B0wr
RmWvZZ0YR0bNkoh1T2S/r2i5E8GkaFS3ZvdEeIjv2hdxxeaD8FhWxTnzrEfQA3Mz
y6f7BpVfBGU17Bg1M0PE5G4ux5V/yA==
=TJhU
-----END PGP SIGNATURE-----

--BM0yNN4hPVklAiUl--

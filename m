Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55B851C33A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380356AbiEEPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiEEPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0F622280;
        Thu,  5 May 2022 08:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99E5DB82B7A;
        Thu,  5 May 2022 15:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14047C385A4;
        Thu,  5 May 2022 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651762894;
        bh=UUh4IAYvnUeRl0+FGz9aUqMk1V1C/5Mv1s6gce1m4PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8Y4NKxoe5tibidDLQ1YsIqidmaB/VrEldK+Y9cbMH5jS/+MM5rgrPY10yHnZuKpA
         Vx9PHYyx0ctjGVYN0AW2U+dj9sQF9nYeW19rmlBAaro91ZcvrnCEvQGSa4AOhWe4F+
         AORKwgkynESpVtUsLkKVDuj91k0fG9nqnFkW+X74VADC85jI/SoExoUCj45dBUkPpw
         Xi936/6T6rBsBBkB/rBLDpE8NcvgzDUFSfZGqCKN4nIruGHpACikgCGzflWOu6DwGI
         kpfzOf2U/DAZwBv3TrR1gbINOSQxTB6NUvESyu3p4jsN3Y180ej0joxdrI7Y7frWDd
         SCwA7xo4UFLIw==
Date:   Thu, 5 May 2022 16:01:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lars@metafoo.de,
        perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 6/6] ARM: configs: at91: sama7_defconfig: add MCHP
 PDMC and DMIC drivers
Message-ID: <YnPmyEujwByeFDdp@sirena.org.uk>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-7-codrin.ciubotariu@microchip.com>
 <d84e0e48-cf35-ae1a-e384-067d361457ba@microchip.com>
 <77c2b348-b7a6-458d-21b6-68c54efc317f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V6OcCftqYTAkRMmU"
Content-Disposition: inline
In-Reply-To: <77c2b348-b7a6-458d-21b6-68c54efc317f@microchip.com>
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


--V6OcCftqYTAkRMmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2022 at 02:47:04PM +0000, Codrin.Ciubotariu@microchip.com w=
rote:
> On 05.05.2022 16:58, Nicolas Ferre wrote:

> > I'm fine with that, but I see that some Kconfig entries "select" this=
=20
> > SND_SOC_DMIC directly (amd, intel, mediatek, stm).
> > If it's absolutely needed for PDMC to work, what about doing the same a=
s=20
> > it would prevent some broken configurations?

> The only way it makes sense to me to have this driver selected somewhere=
=20
> is in a sound card driver, used for a specific board, which we know it=20
> has PDM microphones. Since, for now, we use the simple sound card for=20
> our audio interfaces, we have no place to add this select.
> The reason I do not like to add this select under the controller driver,=
=20
> as some of the vendors did, is because, in the future, we might have=20
> different PDM microphones that might not work with SND_SOC_DMIC and=20
> might need a different driver.
> I don't have a strong opinion on this. If you think I am overthinking,=20
> please let me know and I will change this.

It's unlikely but possible that there could be some other device
connected (eg, you could have a DSP or something that generates PDM
output).  If the driver doesn't directly instantiate the DMIC itself
then it's probably reasonable for it to be user controllable if the DMIC
driver is there.

--V6OcCftqYTAkRMmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJz5scACgkQJNaLcl1U
h9BoAQf/RxATTm9oBfzFYiQDmMZnY6nSvVtROk9XiCIp4BRvt4ezstNodFEGlLKQ
fWhTWfMmr7rGF9Syj1Zb6W/2Fahc/R04bml6dXcDHBKeW5a9Tnslg4U0brWHd2oT
SeE9ZVLQzoFgUcCh6DrwxpYIkfbPrZwrBS0YNHHgjw3LAc2voYJiNm8njcOXop9i
+kpz1RZs60mULxSPGoNOr/9HNfNc2H3lZcSG6ZkdjkiXMJ4TjedzB5YpaOFGrYLN
hCy9jHw/mzCFq9EnV8ubaTI05RFwIusQd0doLtRxlgrrS94+mwNqHggZLnFK95Z/
BnnQHFiY+49FUwRU4NPZhfcFayakzQ==
=TVpY
-----END PGP SIGNATURE-----

--V6OcCftqYTAkRMmU--

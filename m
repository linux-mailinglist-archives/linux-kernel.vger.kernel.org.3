Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6DB59E62B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiHWPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbiHWPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E46C6966;
        Tue, 23 Aug 2022 04:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EAE3613C5;
        Tue, 23 Aug 2022 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BC2C433D6;
        Tue, 23 Aug 2022 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254298;
        bh=HMMDK4yYSV9hm8Y33k5jiYF0HqGibjiYVN4UI5136Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSG6RpwdXQVjXqGGUGSzBgYYSjjWgqK6gbvzkYRyVINwqKx29HDxHMkUtsepj0ygb
         3yft+3n5uIaY8Y5eeUicqzMTKjtQcK7bRHoIPBupQLfMnxrnPiIyBu9OX/UlhF8PUk
         JEHGI4X+MfTcUjKGsdVdfhdBsWhqH2LFtgIHK+5AO7nO3ShU043O+AGhLEFMhf6Aru
         4LB2YHR6z3H4fpx5j1KJY81JhWuBMDNIviXWyyOi/ZsWvjBFECr0Z81DeqkdBmajhF
         KqGRo+AqloYIYMiEjXdSP9F2ovz5OC1MFpuf1v+Rss1/N6/WeaIQ2PesRpejZ0gcTa
         ouQUX241mStIQ==
Date:   Tue, 23 Aug 2022 12:31:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: apple: mca: Start new platform driver
Message-ID: <YwS6lHeGH0BZKHeB@sirena.org.uk>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-4-povik+lin@cutebit.org>
 <YwO/aqs7eqZx07kS@sirena.org.uk>
 <24C0ABFA-BF71-4492-8A6A-E9BE1462B403@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NBQO/q/cbDr7E10q"
Content-Disposition: inline
In-Reply-To: <24C0ABFA-BF71-4492-8A6A-E9BE1462B403@cutebit.org>
X-Cookie: You can't take damsel here now.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NBQO/q/cbDr7E10q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 09:33:36AM +0200, Martin Povi=C5=A1er wrote:
> > On 22. 8. 2022, at 19:39, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Aug 19, 2022 at 02:54:29PM +0200, Martin Povi=C5=A1er wrote:

> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Apple SoCs MCA driver
> >> + *
> >> + * Copyright (C) The Asahi Linux Contributors
> >> + *
> >> + * The MCA peripheral is made up of a number of identical units calle=
d clusters.

> > Please make the entire comment block a C++ one so things look more
> > intentional.

> Is this so that it does not look like the SPDX header was added
> mechanically? I will do it, just curious what the reasoning is.

Yes, broadly.

> >> +	/*
> >> +	 * We can't power up the device earlier than this because
> >> +	 * the power state driver would error out on seeing the device
> >> +	 * as clock-gated.
> >> +	 */
> >> +	cl->pd_link =3D device_link_add(mca->dev, cl->pd_dev,
> >> +				      DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
> >> +					      DL_FLAG_RPM_ACTIVE);

> > I'm not clear on this dynamically adding and removing device links stuff
> > - it looks like the main (only?) purpose is to take a runtime PM
> > reference to the target device which is fine but it's not clear why
> > device links are involved given that the links are created and destroyed
> > every time the DAI is used, AFAICT always in the same fixed
> > relationship.  It's not a problem, it's just unclear.

> Indeed the only purpose is powering up the cluster=E2=80=99s power domain=
 (there=E2=80=99s
> one domain for each cluster). Adding the links is the only way I know to
> do it. They need to be added dynamically (as opposed to statically linkin=
g,
> say, the DAI=E2=80=99s ->dev to the cluster=E2=80=99s ->pd_dev, which I g=
uess may do
> something similar), because we need to sequence the power-up/power-down
> with the enablement of the clocks.

You could also just do the underlying runtime power management
operations directly couldn't you?  It's not clear what the device link
stuff is adding.

--NBQO/q/cbDr7E10q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMEupQACgkQJNaLcl1U
h9DK1wf+JNGwnyOsdkMz+Zc28n5YvfvcyoQByI5EreszsWd//Rg/MxJpVjsrCXpo
JkHBVOL9QMhZ8SBrmK3cZ80OpwHBZ1HnME6vXezsk0QzgH7jWXLvYZmEMcXSP/zJ
8rGk+8LdxeZMvYEbi4xL1/gOSRgOEKO8GOtIQuRsGAiit8bCFL2ukdG+PUji4pim
ZuNY1Hsh+hSHSG4jJDA0QaYqRBMcbMgZW8RTNkWIr02A12ZEDDs4ESd4ckDoYumX
tdl+LCIGBJDYc9A0RIvRUfCTgEqKqyWHQvGtlN1Ia5Nyg7BCynhMJx9oGt2HDxVk
Uvg0e3pz0L9taZVPcOrYU5p07Q8omQ==
=8Yqm
-----END PGP SIGNATURE-----

--NBQO/q/cbDr7E10q--

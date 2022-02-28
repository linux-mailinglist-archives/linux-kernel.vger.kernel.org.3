Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1A4C718A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiB1QPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:15:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79C45069;
        Mon, 28 Feb 2022 08:15:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B447CE12EF;
        Mon, 28 Feb 2022 16:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0095C340F4;
        Mon, 28 Feb 2022 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646064900;
        bh=TioH1JdfWBEgp389V5StL5ui/CGuwFI3oojMLNWN5Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcYm0Jujc1Xme3NtHFlZ+zOqR7Csh2pJrQkKGfDO9LUbTQnnaLUB2Fc5v6DvmptLU
         fVPvAxGXiMLQFyb2p6JLs5Ue0bO8bpf2YGgGOOsekpTzJnsLrKyRSVZm8sWgX4ndr7
         R4oMMssu5oimyANTyskfCIDx0wXNjO2UYRu203yj2IcXGJlHoOrTgnR+Yx3fObDrKT
         Y8Uq0KcgRYc6Cdth6WyHqHzDEd+l/EG5cktoDo86f0lKymqqe4X22MefN9T7EOYH4d
         l7ySKE/4jEwCtJcuxcUqG7zTdtqY6p3Ha+5KZ125NA2X5VV2svFyvTwgFK7qcCMxzH
         wKXom+YeHdwPg==
Date:   Mon, 28 Feb 2022 16:14:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qKdT2bTM8goibbBn"
Content-Disposition: inline
In-Reply-To: <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qKdT2bTM8goibbBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 04:02:30PM +0000, Christophe Leroy wrote:
> Le 28/02/2022 =E0 16:29, Mark Brown a =E9crit=A0:

> > The binding looks good now but this is still driver specific code when
> > it looks like it could easily be implemented in the core - like I said
> > on the previous version you'd need to update drivers to advertise less
> > than 8 bits but there's basically nothing driver specific I can see here
> > so any driver using transfer_one() would get support that way.

> Argh ! Sorry your comment to the previous version ended up in Junk=20
> mails. I see it now.

No problem.

> We discussed that back in 2016 in=20
> https://lore.kernel.org/linux-spi/20160824112701.GE22076@sirena.org.uk/=
=20
> and my understanding at that time was that it was not something that=20
> could be done at core level.

> But maybe things have changed since then ?

What I said then was "it would need a new core feature" which is what
the binding does, I'm suggesting that you also do that for the handling
of the implementation as well.

Actually now I think about it perhaps this shouldn't be a binding at all
but rather something specified by the client driver - presumably any
system using an affected device is going to need these extra clock
cycles so they'll all need to add the same property.

> By the way, fsl-spi driver doesn't implement transfer_one() but=20
> transfer_one_message() so it takes care of the chipselect changes and=20
> therefore the final dummy transfer with CS off is to be done there as=20
> far as I understand.

> Would it mean changing fsl-spi driver to implement transfer_one() first ?

Well, if it can implement transfer_one() without any negative
consequences whichh

--qKdT2bTM8goibbBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc9P4ACgkQJNaLcl1U
h9Chawf/TUDMKYhNk4LqWy00lFQyjXSbd2nVuiSqHE1a7qLCPUZ5qc+Qcq2Zy31F
f1yxIifKq1ExltTrXwtIJoGErlmulDj7xvczXST+meVERa+5b34YLIJ8X8cdM3ty
EXicTql4bTeuMsYQXsTSyyey9vMk62j9/HNHuQMKYP7swYt7RFGwl6YmVfVRX0o7
fSCsGh4NqPyObpUreZB0A3JdJ+u8MstILHo0ywn4b26ch1h1FdOAzYrl8SvSceF+
3p3LdXkmzyRm0qAXu2T8kW68BIF8/0fC1BoK74+rEi8tgQfqQMPc/pBmJajuvWiT
Jvz6AqRGfSt3xgDAQSOpaXc4HQ4DVA==
=GKPt
-----END PGP SIGNATURE-----

--qKdT2bTM8goibbBn--

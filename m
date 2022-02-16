Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03BF4B8D48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiBPQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:08:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiBPQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:07:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8AB9D72;
        Wed, 16 Feb 2022 08:07:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DABFD61AC0;
        Wed, 16 Feb 2022 16:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F219C004E1;
        Wed, 16 Feb 2022 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027666;
        bh=NFkfbdOAbPVQan1POI4dMNk5eBImxr+9OGABQJj8KqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5ox1mAQXw5JkoWxJlHhoidcPBAfC65ZPmCHHu83jVRssyUxirECwi5s93HZ7MZRT
         LRxrQ8JA/fTPdYbY+y4o5TZv6QFMZxhlvbOVX/ZShyWhAuk7tIi7ZhaEntAjdCuKcY
         GfgEqEVZ0Wp1Yz9xhrJYV1ijypxpcxiyM2dAzZaVSJIj1TfLs+cb5iQkVSQT4eDqV0
         Zd790p6HyMEgrRbG77Xclxjk4T6P42PbYY0Dni0t/51iyl1/tmjnwqKEI0cVzPneeP
         Myok8RR0yN8oxf7KiTN53L+X4/fEe+7+4SoBcli5peS2t/cfYGXyTf2IIwThyVl5dS
         ShtDgvPPdnY9g==
Date:   Wed, 16 Feb 2022 16:07:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the spi tree
Message-ID: <Yg0hTRF6HsMoVG0Z@sirena.org.uk>
References: <20220216161718.2c094b08@canb.auug.org.au>
 <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kFuz3fSSNOvX773v"
Content-Disposition: inline
In-Reply-To: <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kFuz3fSSNOvX773v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 09:20:38AM -0300, Andr=E9 Almeida wrote:

> Thanks for input. I'll send a new series with a patch to make this
> driver depends on ACPI then. My patch touched this line, but this
> variable was there before, so I think this build breakage is happening
> for some time.

No, don't do that - just compile out the ACPI support when not in use
like other drivers do.  A dependency on ACPI || COMPILE_TEST could be
useful but you still need to fix the driver.

--kFuz3fSSNOvX773v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINIU0ACgkQJNaLcl1U
h9C+swf/fDU6Dr7pzTsEKLmiksLRgowukAYRIIWxekj6swzwA+nz5DOsTmTvaAfs
DejqbdEl/sEWqCNG2EB5hNGVHrgQP2aMqPGu5zGsdai9zP76drKi/NSlUv1LJtWf
q02gWypC61HwBwR/B6Y5YnzhIBSgCMk3a5JcbLuU/7lMkeWaQtk+D57ZRsECvjSe
vI+mFOgwwRHq2A/ezPI03KUMxaKy5+gPSYj+1l6qSPVexOCvSJMJEQcq5VL3Bnak
m32DLkNJzJNYziuCo4bM8pM2shoX+0B2Il97avJicGT8JAvUcpNdAurcYJtIz3m2
rxlu1e/TzeGToRFBa+GeVTo5Oh3RXg==
=h2Gb
-----END PGP SIGNATURE-----

--kFuz3fSSNOvX773v--

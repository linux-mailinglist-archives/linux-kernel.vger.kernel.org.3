Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655884843AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiADOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:49:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41658 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiADOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F0B61489;
        Tue,  4 Jan 2022 14:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD67C36AEF;
        Tue,  4 Jan 2022 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307793;
        bh=Nx+aXvis9beYgdXneQILOITXSY7FqT1/pc3RR74vhqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vnh7g8wrIV0CSnj0bQgpx5Iu0D7tWvE5D6ZUGDmalHEwxZFC9l0I4uHf1Gw/YbjAH
         9cW+dkg/toMzX576s28KW12ll2Z9pxSV0icQql7quGFJ6ZEw/JupDp61s49dnXhO3M
         6v4hCeo69d/poVCTjUDMF5ekDy32tnUOQSpOCUXf8LX7Hedz8ial/ZIQW76DbIX5re
         KToc1k4z8sbZrMnFN54cHqRn9yOipLksExX5gbPnN4a7WtxC5toBJJDiA79/uRM5Py
         tTdJcyFMQNTVauQOi0kAcW7jvukuCZzC/GDaiy0AOHs2n2FyJZAm4NBj8Q9Lu5SmXe
         A/i0fGOEu2SIQ==
Date:   Tue, 4 Jan 2022 14:49:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulators: Add bindings for Maxim
 MAX20086-MAX20089
Message-ID: <YdRejDRYwoQbNY4f@sirena.org.uk>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-2-laurent.pinchart+renesas@ideasonboard.com>
 <YdRZJWbOxkgkVgje@sirena.org.uk>
 <YdRdAI4S0+85CuDy@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzCKNYUZHdCqopj5"
Content-Disposition: inline
In-Reply-To: <YdRdAI4S0+85CuDy@pendragon.ideasonboard.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lzCKNYUZHdCqopj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 04, 2022 at 04:43:12PM +0200, Laurent Pinchart wrote:
> On Tue, Jan 04, 2022 at 02:26:45PM +0000, Mark Brown wrote:
> > On Sun, Jan 02, 2022 at 11:11:23PM +0200, Laurent Pinchart wrote:

> > > +    required:
> > > +      - OUT1
> > > +      - OUT2

> > Why are we requiring that there be machine constraints for the
> > individual regulators?  There's already a problem with people just
> > using the maximum possible control a regulator has as the default for
> > devices without regard to what the specific system can support.

> Could you elaborate a bit, keeping in mind that I'm a newbie when it
> comes to the regulator framework ? :-)

Not really...  the question is why we are marking these as required
rather than just letting them be omitted as we normally do for
individual regulators on a device.  What purpose does it serve?

> How should I modify the DT bindings to match that correctly ?

Remove the required:.

--lzCKNYUZHdCqopj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUXosACgkQJNaLcl1U
h9Btmwf/TbOyRsEBxx9EdXqzXS3y16H45c0LjP0BvkqdzsZQ/TyOCFsPf9bW8MUP
fqj5Hbng/1+3tB/ovSc1wJVLMbf/8dTCISUihqSK4nzVcrFfYvJwa5lnMLtci0lP
dvroR/FrJdcopR0qHvHudkR2TAKAC7yswrw4BvFDUVr9GoFsQX9tU43CyRPOmzWd
v9Vm5C1VQD1kssHh7/18U8GJ4dce0JLFtkwV9pYzoZxfN0BKeJrHNlhZslzYmDRD
wcMRfr76DTWK0yl9xRiuz46VnAEXMJFwcM9aE4EIeEKXK54SWH6oorFI0FWo36Bh
eeqpSLsuzJXz6t2KZWMEZCwOeY0Y/A==
=ByAE
-----END PGP SIGNATURE-----

--lzCKNYUZHdCqopj5--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A16484354
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiADO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiADO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:26:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D437C061761;
        Tue,  4 Jan 2022 06:26:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC264B81125;
        Tue,  4 Jan 2022 14:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18811C36AE9;
        Tue,  4 Jan 2022 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641306410;
        bh=X8hfCnlKcXSP7jlUKyOd8BT38Wiu6hcHLS1itUSClQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+xbZT4BvJzM6T7SLMTJiSYQzAvVGFmIhPfgUMOC9e0f81Q2DnVeoUhzLrmUqBWms
         4byiKRWAgfvbFzJASar+F0Eu4j33JIlx/hjtwZPJg1Yimcbl1PHuqlSRLyKI2/9oU4
         x8EpcqD0b3ncjkmbwlVM7OQZAFZtPwUSvULzyYGds4qh94wLQBgf1JV1Qn2CkBhr7f
         vi39JWoYgvoXD26m0wo1E/3Bdf6XYbyGsrDnYvKxNGQTilC7XiuEUkDc6AAJJqC4S3
         fY0jeOHCssvquve4bd6nVAldaj8ms3xz5w4xqjRMLe2tB8hH1V72yAw6vQszdiuuXN
         UvyOFpPEjva+Q==
Date:   Tue, 4 Jan 2022 14:26:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulators: Add bindings for Maxim
 MAX20086-MAX20089
Message-ID: <YdRZJWbOxkgkVgje@sirena.org.uk>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DP6Y9xDUindtk8FT"
Content-Disposition: inline
In-Reply-To: <20220102211124.18435-2-laurent.pinchart+renesas@ideasonboard.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DP6Y9xDUindtk8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 02, 2022 at 11:11:23PM +0200, Laurent Pinchart wrote:

> +    patternProperties:
> +      "^OUT[1-4]$":
> +        type: object
> +        $ref: regulator.yaml#
> +
> +    required:
> +      - OUT1
> +      - OUT2

Why are we requiring that there be machine constraints for the
individual regulators?  There's already a problem with people just
using the maximum possible control a regulator has as the default for
devices without regard to what the specific system can support.

--DP6Y9xDUindtk8FT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUWSUACgkQJNaLcl1U
h9DE0Af+NW+3fomMcin9UkbShUanRiQagYntvzJziog+03988nkqpMYyChCUrgg5
2FuW7lFZkyzxjNnYPKRO5MptkqN4GUmDbbdKx0952nwcGTzttnkFi5RAcLGJU98W
5MoP5houz1Xb3yzKOZSIMBv+Or0ZolWBS+rLvy2rANTkKE06WMi8IU4PwvMz8PuH
HBjeGaesEoL2STxmNr/F0Z6SfoizrFjHHdj6mxKIG7jhuhciAoYek0FTVMWSL2yq
pJ+rfx21WPw6oZeKFnqMWUnapz/yc64G110a+9/Pp1gObWfgvRP+bcY8AaMF+2c8
IAXO9mZfCOqn4aml7E8/vHtDtJ3sxA==
=U7QD
-----END PGP SIGNATURE-----

--DP6Y9xDUindtk8FT--
